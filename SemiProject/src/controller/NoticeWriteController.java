package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.face.NoticeService;
import service.impl.NoticeServiceImpl;

@WebServlet("/notice/write")
public class NoticeWriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//NoticeService 객체 생성
	private NoticeService noticeService = new NoticeServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//세션객체 생성
		HttpSession session = req.getSession();
		
		//관리자가 아닌데 글 작성 페이지에 들어올시 메인으로 리다이렉트
//		if(session.getAttribute("managerlogin") == null) {
//			resp.sendRedirect("/main");
//			return;
//		} else {
			req.getRequestDispatcher("/WEB-INF/views/notice/write.jsp").forward(req, resp);
//		}
	
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//요청파라미터값 전달
		noticeService.writeText(req);
		
		resp.sendRedirect("/notice/list");
		
		
	
	
	}
}
