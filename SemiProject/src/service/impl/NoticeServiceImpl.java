package service.impl;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import common.JDBCTemplate;
import dao.face.NoticeCommentDao;
import dao.face.NoticeDao;
import dao.face.NoticeFileDao;
import dao.impl.NoticeCommentDaoImpl;
import dao.impl.NoticeDaoImpl;
import dao.impl.NoticeFileDaoImpl;
import dto.Notice;
import dto.NoticeComment;
import dto.NoticeFile;
import service.face.NoticeService;
import util.Paging;

public class NoticeServiceImpl implements NoticeService {
	
	private Connection conn = null;
	private NoticeDao noticeDao = new NoticeDaoImpl();
	private NoticeFileDao noticeFileDao = new NoticeFileDaoImpl();
	private NoticeCommentDao noticeCommentDao = new NoticeCommentDaoImpl();

	@Override
	public Paging getPaging(HttpServletRequest req) {

		conn = JDBCTemplate.getConnection();
		
		//현재 페이징 파라미터값 저장  
		String param = req.getParameter("curPage");
		int curPage = 0;
		if(param != null && !"".equals(param)) {
			curPage = Integer.parseInt(param);
		}
		
		//총 게시물 수 조회
		int totalCount = noticeDao.selectCntAll(conn);
		
		//페이징 객체에 총 게시물 수와 현재 페이징값 전달
		Paging paging = new Paging(totalCount, curPage);
		
		return paging;
	}
	
	@Override
	public List<Notice> viewList(Paging paging, Map<String, String> map) {

		conn = JDBCTemplate.getConnection();
		
		//게시글 리스트 조회
		List<Notice> list = noticeDao.selectList(conn, paging, map);
		
		return list;
	}
	
	@Override
	public Notice viewText(int noticeno) {

		conn = JDBCTemplate.getConnection();
		
		//조회수 증가
		int res = noticeDao.updateViews(conn, noticeno);
		
		if(res > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		
		//게시글 상세내용 조회
		Notice notice = noticeDao.selectText(conn, noticeno);
		
		return notice;
	}
	
	@Override
	public void writeText(HttpServletRequest req) {
		
		//Multipart/form-data인지 확인
		boolean isMultipart = false;
		isMultipart = ServletFileUpload.isMultipartContent(req);
		
		//Multipart/form-data가 아닐시 중단
		if(!isMultipart) {
			return;
		}
		
		Notice notice = new Notice();
		NoticeFile noticeFile = null;
		
		//임시 저장소 생성
		File repository = new File(req.getServletContext().getRealPath("tmp")); 
		repository.mkdir();
		
		//디스크 기반 아이템 팩토리
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(1 * 1024 * 1024); //1MB 이하 메모리에서 처리
		factory.setRepository(repository); //임시파일 저장폴더 설정
		
		//파일 업로드 객체 
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setFileSizeMax(10*1024*1024); //10MB 최대 허용 사이즈
		
		//여러개의 파일처리를 위한 List객체
		List<NoticeFile> filelist = new ArrayList<>();
		
		//업로드된 데이터 파싱
		List<FileItem> items = null;
		try {
			items = upload.parseRequest(req);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Iterator<FileItem> iter = items.iterator();
		
		while(iter.hasNext()) {
			FileItem item = iter.next();
			
			//빈파일 처리
			if(item.getSize() <= 0) continue;
			
			//form-data 처리
			if(item.isFormField()) {
				String key = item.getFieldName();
				if("title".equals(key)) { //title
					try {
						notice.setTitle(item.getString("UTF-8"));
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				} else if("content".equals(key)) { //content
					try {
						notice.setContent(item.getString("UTF-8"));
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				} else if("check".equals(key)) { //NoticeImp
					try {
						notice.setNoticeImp(item.getString("UTF-8"));
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				}
				
			} //if(item.isFormField) end
			
			//파일 처리
			if(!item.isFormField()) {
				
				//랜덤 UID 생성
				UUID uuid = UUID.randomUUID();
				String uid = uuid.toString().split("-")[0];
				
				//로컬저장소의 파일객체 생성
				File uploadFolder = new File(req.getServletContext().getRealPath("upload"));
				uploadFolder.mkdir();
				
				//원본이름_uid 형태로 저장
				File up = new File(uploadFolder, item.getName()+"_"+uid);
				
				//파일의 원본이름, 저장된이름, 사이즈 저장
				noticeFile = new NoticeFile();
				noticeFile.setOriginName(item.getName());
				noticeFile.setStoredName(item.getName()+"_"+uid);
				noticeFile.setFilesize((int)item.getSize());
				
				//List객체에 추가
				filelist.add(noticeFile);
				
				try {
					item.write(up); //실제 업로드
					item.delete(); //임시 파일 삭제
				} catch (Exception e) {
					e.printStackTrace();
				}
			} //if(!item.isFormField) end
		} //while(iter.hasNext()) end
		
		conn = JDBCTemplate.getConnection();
		
		//세션에 저장된 관리자 아이디 값 저장
		notice.setManagerId((String)req.getSession().getAttribute("userid"));
		
		//게시글 등록
		int res1 = 0;
		res1 = noticeDao.insertText(conn, notice); 
		if(res1 > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		
		//게시글 번호 조회
		int noticeno = noticeDao.selectNoticeNo(conn);
		
		//파일 등록
		int res2 = 0;
		res2 = noticeFileDao.insertFile(conn, filelist, noticeno);
		if(res2 > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		
	}
	
	@Override
	public List<NoticeFile> viewFile(int noticeno) {

		conn = JDBCTemplate.getConnection();
		
		//파일 조회
		List<NoticeFile> filelist = noticeFileDao.selectFile(conn, noticeno);
		
		return filelist;
	}
	
	@Override
	public void removeText(int noticeno) {

		conn = JDBCTemplate.getConnection();
		
		//파일 삭제
		int res1 = noticeFileDao.deleteFile(conn, noticeno);
		
		if(res1 > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		
		//게시글 삭제
		int res2 = noticeDao.deleteText(conn, noticeno);
		
		if(res2 > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		
	}
	
	@Override
	public Notice getText(int noticeno) {

		conn = JDBCTemplate.getConnection();
		
		//게시글 정보 조회
		Notice notice = noticeDao.selectText(conn, noticeno);
		
		return notice;
	}
	
	@Override
	public int update(HttpServletRequest req) {

		//Multipart/form-data 인지 확인
		boolean isMultipart = ServletFileUpload.isMultipartContent(req);
		
		//Multipart/form-data가 아닐시 중단
		if(!isMultipart) {
			return 0;
		}

		Notice notice = new Notice();
		NoticeFile noticeFile = null;
		
		//임시 저장소 생성
		File repository = new File(req.getServletContext().getRealPath("tmp")); 
		repository.mkdir();
		
		//디스크기반 아이템 팩토리
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(1 * 1024 * 1024);
		factory.setRepository(repository);
		
		//파일업로드 객체 생성
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setFileSizeMax(10*1024*1024);
		
		//여러개의 파일처리 위한 List 객체
		List<NoticeFile> filelist = new ArrayList<>();
		//삭제할 파일목록을 받을 배열
		String[] fileArr = null;
		//게시글번호 저장
		int noticeno = 0;
		
		//전달 데이터 파싱
		List<FileItem> items = null;
		try {
			items = upload.parseRequest(req);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Iterator<FileItem> iter = items.iterator();
		
		while( iter.hasNext()) {
			FileItem item = iter.next();
			
			if(item.getSize() <= 0) continue;
			
			if(item.isFormField()) {
				try {
					if("noticeno".contentEquals(item.getFieldName())) { //noticeNo
						notice.setNoticeNo(Integer.parseInt(item.getString()));
						noticeno = Integer.parseInt(item.getString());
					}
					
					if("title".equals(item.getFieldName())) { //title
						notice.setTitle(item.getString("UTF-8"));
					}
					
					if("content".equals(item.getFieldName())) { //content
						notice.setContent(item.getString("UTF-8"));
					}
					
					if("check".equals(item.getFieldName())) { //NoticeImp
						notice.setNoticeImp(item.getString("UTF-8"));
					}
					
					if("filelist".equals(item.getFieldName())) { //originName
						//삭제한 파일 리스트 , 로 구분해 배열에 저장
						fileArr = item.getString().split(",");
 					}
					
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
			}
			
			if(!item.isFormField()) {
				
				//랜덤 UID 생성
				UUID uuid = UUID.randomUUID();
				String uid = uuid.toString().split("-")[0];
				
				//로컬 저장소의 파일 객체 생성
				File uploadFolder = new File(req.getServletContext().getRealPath("upload"));
				uploadFolder.mkdir();
				
				//원본이름_uid 형태로 저장
				File up = new File(uploadFolder, item.getName()+"_"+uid);
				
				//파일의 원본이름, 저장된이름, 사이즈 저장
				noticeFile = new NoticeFile();
				noticeFile.setOriginName(item.getName());
				noticeFile.setStoredName(item.getName()+"_"+uid);
				noticeFile.setFilesize((int)item.getSize());
				
				//List에 객체 추가
				filelist.add(noticeFile);
				
				try {
					item.write(up);
					item.delete();
				} catch (Exception e) {
					e.printStackTrace();
				}
			} //if(!item.isFormField) end
			
		}// while(iter.hasNext()) end;
		
		conn = JDBCTemplate.getConnection();
		
		//게시글 업데이트
		if(notice != null) {
			int res = noticeDao.update(conn, notice);
			if(res > 0) {
				JDBCTemplate.commit(conn);
			} else {
				JDBCTemplate.rollback(conn);
			}
		}
		
		//파일 삭제
		if(fileArr != null) {
			int res = noticeFileDao.deleteChoiceFile(conn, fileArr, noticeno);
			if(res > 0) {
				JDBCTemplate.commit(conn);
			} else {
				JDBCTemplate.rollback(conn);
			}			
		}
		
		//파일 삽입
		if(noticeFile != null) {
			int res = noticeFileDao.insertFile(conn, filelist, noticeno);
			if(res > 0) {
				JDBCTemplate.commit(conn);
			} else {
				JDBCTemplate.rollback(conn);
			}				
		}
		
		return notice.getNoticeNo();
		
	}
	
	@Override
	public Map<String, Integer> postByDate() {

		conn = JDBCTemplate.getConnection();
		
		//요일별 게시글 수 조회
		Map<String, Integer> map = noticeDao.selectByPostdate(conn);
		
		return map;
	}
	
	@Override
	public List<NoticeComment> viewCommnet(int noticeno) {
		
		conn = JDBCTemplate.getConnection();
		
		List<NoticeComment> list = noticeCommentDao.selectComment(conn, noticeno);
		
		return list; 
	}
	
	@Override
	public NoticeComment getCommentParam(HttpServletRequest req) {

		NoticeComment noticeComment = new NoticeComment();
		
		String param1 = req.getParameter("noticeno");
		
		int noticeno = 0;
		if(param1 != null && !"".equals(param1)) {
			noticeno = Integer.parseInt(param1);
		}
		
		String param2 = req.getParameter("userno");
		
		int userno = 0;
		if(param2 != null && !"".equals(param2)) {
			userno = Integer.parseInt(param2);
		}
		
		noticeComment.setNoticeNo(noticeno);
		
		if(req.getParameter("comment") != null) {
			noticeComment.setCommentText(req.getParameter("comment"));
		}
		
		noticeComment.setNick(req.getParameter("nick"));
		noticeComment.setUserNo(userno);
		
		if(req.getParameter("commentno") != null && !"".equals(req.getParameter("commentno"))) {
			noticeComment.setCommentNo(Integer.parseInt(req.getParameter("commentno")));
		}
		
		return noticeComment;
	}
	
	@Override
	public void writeCommnet(NoticeComment param) {

		conn = JDBCTemplate.getConnection();
		
		int res = noticeCommentDao.insertComment(conn, param);
		
		if(res > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		
	}
	
	@Override
	public void removeComment(NoticeComment param) {

		conn = JDBCTemplate.getConnection();
		
		int res = noticeCommentDao.deleteComment(conn, param);
		
		if(res > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		
	}
	
	@Override
	public void reviceComment(NoticeComment param) {

		conn = JDBCTemplate.getConnection();
		
		int res = noticeCommentDao.updateComment(conn, param); 
		
		if(res > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
	}
	
	@Override
	public Map<String, Integer> percentByText() {

		conn = JDBCTemplate.getConnection();
		
		Map<String, Integer> chart2 = noticeDao.selectByFindTextCnt(conn);
		
		return chart2;
	}
	
}
