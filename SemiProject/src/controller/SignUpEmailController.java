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

@WebServlet("/login/email")
public class SignUpEmailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private SignUpService signUpService = new SignUpServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String email = req.getParameter("email");
		
		String atnum = null;
		
		atnum = signUpService.sendEmail(email);
		
		System.out.println(atnum);
		
		PrintWriter out = resp.getWriter();
		
		out.print(atnum);
	}
}
