package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.face.ProFileService;
import service.impl.ProFileServiceImpl;

@WebServlet("/mypage/basket")
public class MyShoppingBasketController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ProFileService proFileService = new ProFileServiceImpl();
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
//		int res = proFileService.insertmypocket(req);
		
		
		req.getRequestDispatcher("/WEB-INF/views/basket/basket.jsp")
			.forward(req, resp);
	
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	
	}
}
