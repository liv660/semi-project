package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.MyBoard;
import dto.UserImg;
import service.face.ProFileService;
import service.impl.ProFileServiceImpl;

@WebServlet("/mypage")
public class MyPageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ProFileService proFileService = new ProFileServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		if( req.getSession().getAttribute("login") == null ) {
			resp.sendRedirect("/main");
			
			return;
		}
		
		UserImg userimg = proFileService.getuserno(req);
		
		userimg = proFileService.viewimg(userimg);
		
		
		List<MyBoard> myBoard = proFileService.myboradlist();
		
		req.setAttribute("myBoard", myBoard);
		
		req.setAttribute("userimg", userimg);
		
		req.getRequestDispatcher("/WEB-INF/views/mypage/mypage.jsp")
			.forward(req, resp);
	
	}

}
