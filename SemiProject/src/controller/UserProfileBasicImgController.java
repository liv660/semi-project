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

@WebServlet("/mypage/profile/basicimg")
public class UserProfileBasicImgController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ProFileService proFileService = new ProFileServiceImpl();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		proFileService.basicimg(req);
		
	}

}
