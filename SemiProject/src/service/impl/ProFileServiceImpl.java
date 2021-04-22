package service.impl;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import common.JDBCTemplate;
import dao.face.ProFileDao;
import dao.impl.ProFileDaoImpl;
import dto.MyBoard;
import dto.UserAddress;
import dto.UserImg;
import dto.UserLeave;
import dto.Usertb;
import service.face.ProFileService;
import util.HashNMacUtil;
import util.MyPaging;

public class ProFileServiceImpl implements ProFileService {

	ProFileDao proFileDao = new ProFileDaoImpl();

	@Override
	public boolean upDatebynickbyImg(HttpServletRequest req) {
		Usertb usertb = null;
		UserImg userimg = null;

		boolean isMultipart = ServletFileUpload.isMultipartContent(req);

		if(!isMultipart) {

			usertb = new Usertb();
			usertb.setUserId( (String)req.getSession().getAttribute("userid") );
		} else {
			//파일 업로드를 사용 하고있을 경우
			usertb = new Usertb();

			//디스크팩토리
			DiskFileItemFactory factory = new DiskFileItemFactory();

			//메모리처리 사이즈
			factory.setSizeThreshold(1*1024*1024);// 1MB

			//컨텍스트 생성
			ServletContext context = req.getServletContext();

			//임시저장소
			File repository = new File( context.getRealPath("tmp") );
			repository.mkdir();

			factory.setRepository(repository);

			//업로드 객체 생성
			ServletFileUpload upload = new ServletFileUpload(factory);

			//용량 제한 설정:10MB
			upload.setFileSizeMax(10*1024*1024);

			//form-data 추출
			List<FileItem> items = null;

			try {
				items = upload.parseRequest(req);
			} catch (FileUploadException e) {
				e.printStackTrace();
			}

			//파싱된 데이터 처리 반복자
			Iterator<FileItem> iter = items.iterator();

			//요청정보 처리
			while( iter.hasNext() ) {
				FileItem item = iter.next();

				//빈 파일 처리
				if(item.getSize() <=0 ) continue;

				//빈 파일이 아닌경우
				if(item.isFormField() ) {
					try {

						if("nick".equals(item.getFieldName() ) ) {
							usertb.setNick(item.getString("utf-8"));
						}

						usertb.setUserNo((int)req.getSession().getAttribute("userno"));
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				} else {

					UUID uuid = UUID.randomUUID();
					String u = uuid.toString().split("-")[3];

					//로컬 저장소 파일
					String stored = u + "_" + item.getName();

					//파일 객체 생성
					File upFolder = new File(context.getRealPath("userimgup")); // 업로드될 폴더 경로
					upFolder.mkdir();

					File up = new File(upFolder, stored);


					userimg = new UserImg();
					userimg.setOriginName(item.getName());
					userimg.setStroedName(stored);
					userimg.setFilesize((int)item.getSize());


					try {
						//실제 업로드
						item.write(up);

						//임시 파일 삭제
						item.delete();
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} //try end
				} //if(item.isFormField() ) end
			}// while( iter.hasNext() ) end 


		}//if(!isMultipart) end

		//		System.out.println(usertb);
		//		System.out.println(userimg);

		Connection conn = JDBCTemplate.getConnection();
		boolean flag = false;
		if( usertb != null || !"".equals(usertb.getNick())) {
			if( proFileDao.updatebynick(conn, usertb) > 0 ) {
				JDBCTemplate.commit(conn);
				flag = true;
			} else {
				JDBCTemplate.rollback(conn);
				flag = false;
			}
		}

		if( userimg != null ) {
			userimg.setUserNo( (int)req.getSession().getAttribute("userno") );

			if( proFileDao.deletebyimg(conn, userimg) > 0) {
				JDBCTemplate.commit(conn);
			} else {
				JDBCTemplate.rollback(conn);
			}


			if( proFileDao.insertbyimg(conn, userimg) > 0 ) {
				JDBCTemplate.commit(conn);
			} else {
				JDBCTemplate.rollback(conn);
			}
		}

		return flag;
	}// public void upDatebynickbyImg(HttpServletRequest req) end


	@Override
	public UserImg getuserno(HttpServletRequest req) {
		UserImg userimg = new UserImg();

		userimg.setUserNo( (int) req.getSession().getAttribute("userno") );

		return userimg;
	}


	@Override
	public UserImg viewimg(UserImg userimg) {
		Connection conn = JDBCTemplate.getConnection();

		return proFileDao.selectUserimg(conn, userimg);
	}


	@Override
	public void basicimg(HttpServletRequest req) {

		Connection conn = JDBCTemplate.getConnection();

		UserImg userimg = new UserImg();

		userimg.setUserNo( (int)req.getSession().getAttribute("userno") );

		if( proFileDao.deletebyimg(conn, userimg) > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}

		if( proFileDao.basicinsert(conn, userimg) > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}


	}


	@Override
	public boolean getPw(HttpServletRequest req) {

		int userno = (int)req.getSession().getAttribute("userno");

		Connection conn = JDBCTemplate.getConnection();

		String Pw = proFileDao.selectPw(conn, userno);

		boolean ipwcon = false;

		try {
			//비밀번호 Sha256 해쉬코드 암호화처리
			String iPw = (HashNMacUtil.EncBySha256(req.getParameter("ipw"))); //pw

			if ( Pw.equals(iPw) ) {

				ipwcon = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println(ipwcon);

		return ipwcon;
	}


	@Override
	public int getUserUpdate(HttpServletRequest req) {

		Connection conn = JDBCTemplate.getConnection();
		Usertb usertb = new Usertb();


		String postnum = req.getParameter("uAddress_zoneCode");
		int pn = 0;
		if( null != postnum && !"".equals(postnum)) {
			pn = Integer.parseInt(postnum);
		}

		usertb.setPostnum( pn ); 
		usertb.setAddr( req.getParameter("uAddress_addr"));
		usertb.setAddrDetail(req.getParameter("uAddress_detail"));


		int res = 0;

		usertb.setUserNo( (int)req.getSession().getAttribute("userno") );
		if ( req.getParameter("userpw_up") != null && req.getParameter("userpw_up") != "" ) {

			usertb.setUserPw( req.getParameter("userpw_up") );

			res = proFileDao.updatebypw(conn, usertb);

			if ( res > 0 ) {

				JDBCTemplate.commit(conn);
			} else {

				JDBCTemplate.rollback(conn);
			}

		}

		res = 0;
		if ( req.getParameter("email") != null && req.getParameter("email") != "" ) {

			usertb.setEmail( req.getParameter("email") );

			res = proFileDao.updatebyemail(conn, usertb);

			if ( res > 0 ) {

				JDBCTemplate.commit(conn);
			} else {

				JDBCTemplate.rollback(conn);
			}
		}

		res = 0;
		if ( req.getParameter("tel") != null && req.getParameter("tel") != "" ) {

			usertb.setPhone( req.getParameter("tel") );

			res = proFileDao.updatebyPhone(conn, usertb);

			if ( res > 0 ) {

				JDBCTemplate.commit(conn);
			} else {

				JDBCTemplate.rollback(conn);
			}
		}

		//postcode update
		if ( !"".equals( req.getParameter("uAddress_zoneCode") ) ) {

			res = proFileDao.updatepost(conn, usertb);

			if ( res > 0 ) {

				JDBCTemplate.commit(conn);
			} else {

				JDBCTemplate.rollback(conn);
			}

		}

		res = 0;

		//roadAddress update
		if ( !"".equals( req.getParameter("uAddress_addr") ) ) {

			res = proFileDao.updateaddr(conn, usertb);

			if ( res > 0 ) {

				JDBCTemplate.commit(conn);
			} else {

				JDBCTemplate.rollback(conn);
			}

		}

		res = 0;
		//ditail update
		if ( !"".equals( req.getParameter("uAddress_detail") ) ) {

			res = proFileDao.updatedetail(conn, usertb);

			if ( res > 0 ) {

				JDBCTemplate.commit(conn);
			} else {

				JDBCTemplate.rollback(conn);
			}
		}





		return res;
	}



	@Override
	public int getuserleave(HttpServletRequest req) {

		Connection conn = JDBCTemplate.getConnection();

		int userno = (int) req.getSession().getAttribute("userno");

		int res = 0;

		res = proFileDao.deleteuser(conn, userno);

		if ( res > 0 ) {

			JDBCTemplate.commit(conn);
		} else {

			JDBCTemplate.rollback(conn);
		}

		res = 0;

		UserLeave userLeave = new UserLeave();
		userLeave.setContent( req.getParameter("content") );

		res = proFileDao.insertleave(conn, userLeave);

		if ( res > 0 ) {

			JDBCTemplate.commit(conn);
		} else {

			JDBCTemplate.rollback(conn);
		}

		return res;
	}


	@Override
	public List<MyBoard> myboradlist(HttpServletRequest req) {

		Connection conn = JDBCTemplate.getConnection();

		int userno = (int) req.getSession().getAttribute("userno");

		List<MyBoard> myBoard = proFileDao.selectMyList(conn, userno);



		return myBoard;
	}


	@Override
	public String getNick(HttpServletRequest req) {

		int userno = (int) req.getSession().getAttribute("userno");



		return proFileDao.selectByNick(JDBCTemplate.getConnection(), userno );
	}


	@Override
	public MyPaging getPageing(HttpServletRequest req) {

		//DB연결 객체
		Connection conn = JDBCTemplate.getConnection();

		//전달파라미터 curPage 파싱
		String param = req.getParameter("curPage");
		int curPage = 0;
		if(param != null && !"".equals(param)) {

			curPage = Integer.parseInt(param);
		}


		//myBoard 테이블의 총 게시글 수를 조회한다
		int totalCount = proFileDao.selectCntAll(conn);

		MyPaging myPaging = new MyPaging(totalCount, curPage);

		return myPaging;
	}


	@Override
	public List<MyBoard> myboradlist(HttpServletRequest req, MyPaging myPaging) {

		Connection conn = JDBCTemplate.getConnection();

		int userno = (int) req.getSession().getAttribute("userno");

		List<MyBoard> myBoard = proFileDao.selectMyList(conn, myPaging, userno);

		return myBoard;
	}


	@Override
	public int deleteMyBoard(HttpServletRequest req) {

		Connection conn = JDBCTemplate.getConnection();

		List<MyBoard> listMyBoard = new ArrayList<MyBoard>();

		int cnt = Integer.parseInt((String) req.getParameter("CNT"));

		String noDiv = (String)req.getParameter("no_div");

		String [] noDivArr = noDiv.split(",");

		int res = 0;

		for(int i=0; i<cnt; i++) {

			MyBoard myBoard = new MyBoard();
			String [] noDivAr = noDivArr[i].split("_");

			myBoard.setUser_no( (int) req.getSession().getAttribute("userno") );
			myBoard.setBorad_no( Integer.parseInt( noDivAr[0] ));
			myBoard.setBoard_div( noDivAr[1] );

			listMyBoard.add(myBoard);
		}
		for(int i=0; i<listMyBoard.size(); i++)	 {
			if( listMyBoard.get(i).getBoard_div().equals("찾기 게시판") ) {
				res = proFileDao.deleteFindBoard(conn, listMyBoard.get(i));
				if ( res > 0 ) {

					JDBCTemplate.commit(conn);
				} else {

					JDBCTemplate.rollback(conn);
				}

			} else if ( listMyBoard.get(i).getBoard_div().equals("발견 게시판") ) {
				res = 0;
				res = proFileDao.deleteDiscoveryBoard(conn, listMyBoard.get(i));

				if ( res > 0 ) {

					JDBCTemplate.commit(conn);
				} else {

					JDBCTemplate.rollback(conn);
				}

			} else if ( listMyBoard.get(i).getBoard_div().equals("후기 게시판") ) {

				res = 0;
				String storedName = proFileDao.selectByReviewStroed(conn, listMyBoard.get(i));

				if( null != storedName && !"".equals(storedName)) {

					res = proFileDao.deleteReviewImg(conn, listMyBoard.get(i));

					if ( res > 0 ) {

						JDBCTemplate.commit(conn);
					} else {

						JDBCTemplate.rollback(conn);
					}
				}

				res = 0;
				res = proFileDao.deleteReviewBoard(conn, listMyBoard.get(i));
				if ( res > 0 ) {

					JDBCTemplate.commit(conn);
				} else {

					JDBCTemplate.rollback(conn);
				}
			}

		}

		return res;

	}



}
