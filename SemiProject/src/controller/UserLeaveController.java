package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.face.ProFileService;
import service.impl.ProFileServiceImpl;

@WebServlet("/mypage/leave")
public class UserLeaveController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ProFileService proFileService = new ProFileServiceImpl(); 
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		if( req.getSession().getAttribute("login") == null ) {
			resp.sendRedirect("/main");
			
			return;
		}
		
		req.getRequestDispatcher("/WEB-INF/views/mypage/userleave.jsp")
			.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		int res = 0;
		res = proFileService.getuserleave(req);
		
		
		req.getRequestDispatcher("/WEB-INF/views/mypage/userbye.jsp")
			.forward(req, resp);
	
	}
}
