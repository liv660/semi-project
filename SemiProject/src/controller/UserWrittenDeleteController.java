package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.MyBoard;
import service.face.ProFileService;
import service.impl.ProFileServiceImpl;

@WebServlet("/written/delete")
public class UserWrittenDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ProFileService proFileService = new ProFileServiceImpl();
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int res = proFileService.deleteMyBoard(req);
		
	}
}
