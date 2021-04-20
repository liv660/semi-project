package service.impl;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import common.JDBCTemplate;
import dao.face.ReviewDao;
import dao.impl.ReviewDaoImpl;
import dto.ReviewBoard;
import dto.ReviewDetailView;
import dto.ReviewImgFile;
import dto.ReviewUserJoin;
import service.face.ReviewService;
import util.Paging;

public class ReviewServiceImpl implements ReviewService {
	
	private ReviewDao reviewDao = new ReviewDaoImpl();
	
	@Override
	public Paging getPaging(HttpServletRequest req) {
		
		//전달파라미터 curPage 파싱
		String param = req.getParameter("curPage");
		int curPage = 0;
		
		if(param != null && !"".equals(param)) {
			curPage = Integer.parseInt(param);
		}
		
		int totalCount = reviewDao.selectCntAll(JDBCTemplate.getConnection());
		
		//페이징 객체 생성
		Paging paging = new Paging(totalCount, curPage);
		
		return paging;
	} // getPaging(HttpServletRequest req) end
	
	
	@Override
	public List<ReviewUserJoin> getList(Paging paging) {
		
		return reviewDao.selectAll(JDBCTemplate.getConnection(), paging);
	} //getPaging() end
	
	@Override
	public void reviewWrite(HttpServletRequest req) {

		//게시글 정보 저장할 객체
		ReviewBoard reviewBoard = null;
		
		//첨부파일 정보 저장할 객체
		ReviewImgFile reviewImgFile = null;
		
		List<ReviewImgFile> reviewImgs = new ArrayList<>(); //
		
		//파일업로드 형태의 데이터가 맞는지 검사
		boolean isMultipart = false;
		isMultipart = ServletFileUpload.isMultipartContent(req);
		
		//multipart/form-data 인코딩으로 전송되지 않았을 경우
		if( !isMultipart ) {
			System.out.println("[ERROR] multipart/form-data 형식이 아닙니다.");
			
			return;
		}
		
		//multipart/form-data일 때
		
		//게시글 정보 저장할 객체 생성
		reviewBoard = new  ReviewBoard();
		
		
		//디스크 기반 아이템 팩토리
		DiskFileItemFactory factory = new DiskFileItemFactory();
		
		//메모리 처리 사이즈 지정
		factory.setSizeThreshold(1 * 1024 * 1024); // 1MB
		
		//임시 저장소 설정
		File repository = new File(req.getServletContext().getRealPath("tmp"));
		repository.mkdir();
		
		factory.setRepository(repository);
		
		//파일업로드 객체 생성
		ServletFileUpload upload = new ServletFileUpload(factory);
		
		//업로드 용량 제한
		upload.setFileSizeMax(10 * 1024 * 1024); // 10MB
		
		//전달 데이터 파싱
		List<FileItem> items = null;
		
		try {
			items = upload.parseRequest(req);
		} catch (FileUploadException e) {
			e.printStackTrace();
		}
		
		//추출된 전달파라미터 처리 반복자
		Iterator<FileItem> iter = items.iterator();
		
		//모든 요청 정보 처리하기
		while(iter.hasNext()) {
			FileItem item = iter.next();
			
			//1) 빈 파일 처리
			if(item.getSize() <= 0) continue;
			
			//2) 일반적인 요청 데이터 처리
			if(item.isFormField()) {
				
				String key = item.getFieldName(); //키 추출
				if("title".equals(key)) { //전달파라미터 name이 "title"
					try {
						reviewBoard.setTitle(item.getString("UTF-8"));
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
					
				} else if ("content".equals(key)) { //전달파라미터 name이 "content"
					try {
						reviewBoard.setContent(item.getString("UTF-8"));
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
					
				} else if ("review".equals(key)) { //전달파라미터 name이 "review"
//					int reviewSort = Integer.parseInt(item.getString());
					reviewBoard.setReviewSort(Integer.parseInt(item.getString()));
				}
			} // if( item.isFormField() ) end - 폼필드 확인
			
			//3) 파일처리
			if(!item.isFormField()) {
				
				// UUID 생성
				UUID uuid = UUID.randomUUID();
				String u = uuid.toString().split("-")[0]; //8자리 
				

				//파일이 저장될 이름을 설정(originName_xxxxxxxx)
				int lastDot = item.getName().lastIndexOf('.');
				String originName = item.getName().substring(0, lastDot);
				String storedName = originName + "_" + u;
				
				// 로컬 저장소의 파일 객체 생성
				File upFolder = new File(req.getServletContext().getRealPath("reviewImgFile")); //업로드될 파일 경로
				upFolder.mkdir();
				
				File up = new File(upFolder, storedName);
				
				//첨부파일 정보 객체
				reviewImgFile = new ReviewImgFile(); //객체 생성
				reviewImgFile.setOriginImg(item.getName()); //원본파일 명
				reviewImgFile.setStoredImg(item.getName()+"_"+u); //저장파일명
				
				//처리 완료된 파일 업로드하기
				try {
					item.write(up); //실제 업로드
					item.delete(); //임시파일 삭제
				} catch (Exception e) {
					e.printStackTrace();
				} 
			} //파일 처리 end
		}
		
		//DB 데이터 입력
		Connection conn = JDBCTemplate.getConnection();
		
		//게시글 작성자 user_no 입력
		reviewBoard.setUserNo((int) req.getSession().getAttribute("userno"));
		
		//게시글 번호 생성 - DAO 이용
		int reviewNo = reviewDao.selectReviewNo(conn);
		
		//게시글 정보가 있는 경우
		if(reviewBoard != null) {
			
			//게시글 번호 입력
			reviewBoard.setReviewNo(reviewNo);
			
			//게시글 제목이 작성되지 않으면 변경
			if(reviewBoard.getTitle() == null || "".equals(reviewBoard.getTitle())) {
				reviewBoard.setTitle("(제목없음)");
			}
			
			//게시글 삽입
			if(reviewDao.insert(conn, reviewBoard) > 0) {
				JDBCTemplate.commit(conn);
			} else {
				JDBCTemplate.rollback(conn);
			}
		}
		
		//첨부파일 정보가 있을 경우
		if(reviewImgFile != null) {
			
			//게시글 번호 입력
			reviewImgFile.setReviewNo(reviewNo);
			
			//첨부파일 삽입
			if(reviewDao.insertImgFile(conn, reviewImgFile) > 0) {
				JDBCTemplate.commit(conn);
			} else {
				JDBCTemplate.rollback(conn);
			}
		}
		
	}
	
	@Override
	public ReviewBoard getReviewNo(HttpServletRequest req) {
		
		//reviewNo를 저장할 객체 생성
		ReviewBoard reviewBoard = new ReviewBoard();
		
		//reviewNo 전달파라미터 검증 
		String param = req.getParameter("reviewNo");
		if(param!=null && !"".equals(param)) {
			
			//reviewNo 전달파라미터 추출
			reviewBoard.setReviewNo(Integer.parseInt(param));
		}

		//객체 반환
		return reviewBoard;
	}
	
	@Override
	public ReviewDetailView view(ReviewBoard reviewNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		//조회수 증가
		if(reviewDao.updateViews(conn, reviewNo) >= 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		
		//게시글 조회
		ReviewDetailView reviewBoard = reviewDao.selectReviewBoardByReviewNo(conn, reviewNo);

		return reviewBoard;
	}

}
