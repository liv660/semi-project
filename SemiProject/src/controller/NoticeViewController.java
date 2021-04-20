package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Notice;
import dto.NoticeComment;
import dto.NoticeFile;
import service.face.NoticeService;
import service.impl.NoticeServiceImpl;

@WebServlet("/notice/view")
public class NoticeViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//NoticeService 객체 생성
	private NoticeService noticeService = new NoticeServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//세션 객체 생성
		HttpSession session = req.getSession();
		
		//로그인 상태가 아닐시 로그인창으로 리다이렉트
		if(session.getAttribute("login") == null) {

			resp.sendRedirect("/login/login");
			
		} else {
			
			//조회할 글번호 전달파라미터값 받아오기
			String param = req.getParameter("noticeno");
			
			int noticeno = 0;
			if(param != null && !"".equals(param)) {
				noticeno = Integer.parseInt(param);
			}
			
			//조회할 글의 내용 조회
			Notice view = noticeService.viewText(noticeno);
			//조회할 글의 파일 조회
			List<NoticeFile> filelist = noticeService.viewFile(noticeno);
			
			
			//조회할 글의 내용, 파일 정보 전달
			req.setAttribute("view", view);
			req.setAttribute("filelist", filelist);
			
			req.getRequestDispatcher("/WEB-INF/views/notice/view.jsp").forward(req, resp);
	
		}
	}
	
}
