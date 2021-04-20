package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.face.SignUpService;
import service.impl.SignUpServiceImpl;

/**
 * Servlet implementation class SignUpNickCheckController
 */
@WebServlet("/login/nickcheck")
public class SignUpNickCheckController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private SignUpService signUpService = new SignUpServiceImpl();
	
	@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.getRequestDispatcher("/WEB-INF/views/login/signup").forward(req, resp);
	
	}
	
	@Override
		protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String nick = req.getParameter("nick");
		
		int res = signUpService.signUpNickCheck(nick);
		
		PrintWriter out = resp.getWriter();
		
		out.print(res);
	
	
	}

}
