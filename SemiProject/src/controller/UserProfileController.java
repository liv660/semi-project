package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.UserImg;
import service.face.ProFileService;
import service.impl.ProFileServiceImpl;

@WebServlet("/mypage/profile")
public class UserProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private	ProFileService proFileService = new ProFileServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		if( req.getSession().getAttribute("login") == null ) {
			resp.sendRedirect("/main");

			return;
		}

		UserImg userimg = proFileService.getuserno(req);

		userimg = proFileService.viewimg(userimg);

		req.setAttribute("userimg", userimg);

		req.getRequestDispatcher("/WEB-INF/views/mypage/userinfo.jsp")
		.forward(req, resp);

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		boolean flag = proFileService.upDatebynickbyImg(req);
		
		String nick = proFileService.getNick(req);
//		System.out.println( flag );
//		System.out.println( nick );
		
		if( flag ) {
			
			req.getSession().removeAttribute("nick");
			req.getSession().setAttribute("nick", nick);
		}
		
		resp.sendRedirect("/mypage");
	}

}
