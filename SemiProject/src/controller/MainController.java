package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Usertb;
import service.face.LoginService;
import service.impl.LoginServiceImpl;

@WebServlet("/main")
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private LoginService loginService = new LoginServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		
		System.out.println(req.getParameter("autologin"));
		
		String auto = "";
		
		//자동 로그인 쿠키 저장
		if(!"null".equals(req.getParameter("autologin"))) {
			
			auto = (String) session.getAttribute("userid");
			
			Cookie autologin = new Cookie("autologin", "autologin");
			Cookie userid = new Cookie("userid", auto);
			
			autologin.setMaxAge(30*24*60*60);
			userid.setMaxAge(30*24*60*60);
			
			autologin.setPath("/");
			userid.setPath("/");
			
			resp.addCookie(autologin);
			resp.addCookie(userid);
		}
		
		if(!"null".equals(req.getParameter("rememberid"))) {

			auto = (String) session.getAttribute("userid");
			
			Cookie rememberid = new Cookie("rememberid", "rememberid");
			Cookie userid = new Cookie("userid", auto);
			
			rememberid.setMaxAge(30*24*60*60);
			userid.setMaxAge(30*24*60*60);
			
			rememberid.setPath("/");
			userid.setPath("/");
			
			resp.addCookie(rememberid);
			resp.addCookie(userid);
		}


		if(req.getCookies() != null) {
			
			Cookie[] cookies = req.getCookies();
			String value = "";
			
			for(Cookie c : cookies) {
				
				if("autologin".equals(c.getName())) {
					value = c.getValue();
				}
			}
			
			if(value != null) {
				
				Usertb info = new Usertb();
				info.setUserId(auto);
				
				Usertb res = loginService.loginUser(info);
				
				if(res != null) {
					session.setAttribute("login", true);
					session.setAttribute("userid", res.getUserId());
					session.setAttribute("userno", res.getUserNo());
					session.setAttribute("nick", res.getNick());
				}
			}
		}

		req.getRequestDispatcher("/WEB-INF/views/main.jsp").forward(req, resp);
	
	}

}
