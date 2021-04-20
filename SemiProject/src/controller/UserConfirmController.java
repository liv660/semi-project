package controller;

import java.io.IOException;

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
		
		String Pw = proFileService.getPw(req);
		
		req.setAttribute("Pw", Pw);
		
		req.getRequestDispatcher("/WEB-INF/views/mypage/uconfirm.jsp")
		 	.forward(req, resp);
	}

	
		
		
	
	
}
