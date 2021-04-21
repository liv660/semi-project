package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.face.ProFileService;
import service.impl.ProFileServiceImpl;

@WebServlet("/mypage/confirm")
public class UserConfirmController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ProFileService proFileService = new ProFileServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		if( req.getSession().getAttribute("login") == null ) {
			resp.sendRedirect("/main");

			return;
		}
		
		
		
		req.getRequestDispatcher("/WEB-INF/views/mypage/uconfirm.jsp")
		 	.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		boolean confirm = proFileService.getPw(req);
		
		PrintWriter out = resp.getWriter();
		
		out.print( confirm );
		
	}
		
		
	
	
}
