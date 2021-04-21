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
		System.out.println(req.getParameter("rememberid"));
		
		//자동 로그인 쿠키 저장
		if("on".equals(req.getParameter("autologin"))) {
			
			System.out.println("자동로그인");
			
			String auto = req.getParameter("userid");
			
			Cookie autologin = new Cookie("autologin", "autologin");
			Cookie userid = new Cookie("userid", auto);
			
			autologin.setMaxAge(30*24*60*60);
			userid.setMaxAge(30*24*60*60);
			
			autologin.setPath("/");
			userid.setPath("/");
			
			resp.addCookie(autologin);
			resp.addCookie(userid);
		}
		
		if("on".equals(req.getParameter("rememberid"))) {
			
			System.out.println("아이디저장");
			
			String remuserid = req.getParameter("userid");
			
			Cookie rememberid = new Cookie("rememberid", "rememberid");
			Cookie userid = new Cookie("remuserid", remuserid);
			
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
			String id = "";
			
			for(Cookie c : cookies) {
				
				System.out.println("for문 도는지 검사");
				
				if("autologin".equals(c.getName())) {
					value = c.getValue();
				}
				if("userid".equals(c.getName())) {
					id = c.getValue();
				}
			}
			
			System.out.println("value : " + value);
			
			if("autologin".equals(value)) {
				
				System.out.println("ds");
				
				Usertb info = new Usertb();
				info.setUserId(id);
				
				Usertb res = loginService.loginUser(info);
				
				if(res != null) {
					System.out.println("aaa");
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
