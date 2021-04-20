package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Notice;
import dto.NoticeFile;
import service.face.NoticeService;
import service.impl.NoticeServiceImpl;

@WebServlet("/notice/update")
public class NoticeUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//NoticeService 객체 생성
	private NoticeService noticeService = new NoticeServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//수정할 글번호 전달파라미터값 받아오기
		String param = req.getParameter("noticeno");
		
		int noticeno = 0;
		if(param != null && !"".equals(param)) {
			noticeno = Integer.parseInt(param);
		}
		
		//수정할 글의 내용 조회
		Notice notice = noticeService.getText(noticeno);
		//수정할 글의 파일 조회
		List<NoticeFile> list = noticeService.viewFile(noticeno); 
		
		//수정할 글의 내용, 파일 정보 전달
		req.setAttribute("notice", notice);
		req.setAttribute("list", list);
		
		req.getRequestDispatcher("/WEB-INF/views/notice/update.jsp").forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//요청파라미터값 전달
		int noticeno = noticeService.update(req);
		
		//수정한 글의 상세보기 페이지로 리다이렉트
		if(noticeno != 0) {
			resp.sendRedirect("/notice/view?noticeno=" + noticeno);
		}
	}
	
}
