package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.DiscoverBoard;
import dto.FindBoard;
import dto.Notice;
import dto.ReviewUserJoin;
import dto.Usertb;
import service.face.LoginService;
import service.face.MainService;
import service.impl.LoginServiceImpl;
import service.impl.MainServiceImpl;

@WebServlet("/main")
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private LoginService loginService = new LoginServiceImpl();
	private MainService mainService = new MainServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		
		//자동 로그인 쿠키 저장
		if("on".equals(req.getParameter("autologin"))) {
			
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
		
		//아이디 저장 쿠키 저장
		if("on".equals(req.getParameter("rememberid"))) {
			
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

		//자동로그인 쿠키있을시 로그인 해줌
		if(req.getCookies() != null) {
			
			Cookie[] cookies = req.getCookies();
			String value = "";
			String id = "";
			
			for(Cookie c : cookies) {
				
				if("autologin".equals(c.getName())) {
					value = c.getValue();
				}
				if("userid".equals(c.getName())) {
					id = c.getValue();
				}
			}
			
			if("autologin".equals(value)) {
				
				Usertb info = new Usertb();
				info.setUserId(id);
				
				Usertb res = loginService.loginUser(info);
				
				if(res != null) {
					session.setAttribute("login", true);
					session.setAttribute("userid", res.getUserId());
					session.setAttribute("userno", res.getUserNo());
					session.setAttribute("nick", res.getNick());
				}
			}
		}
		
		List<FindBoard> findboard = mainService.getFindBoard();
		List<DiscoverBoard> discoverboard = mainService.getDiscoverBoard();
		List<ReviewUserJoin> reviewboard = mainService.getReviewBoard();
		List<Notice> noticeboard = mainService.getNoticeBoard();
		
		
		req.setAttribute("findboard", findboard);
		req.setAttribute("discoverboard", discoverboard);
		req.setAttribute("reviewboard", reviewboard);
		req.setAttribute("noticeboard", noticeboard);

		req.getRequestDispatcher("/WEB-INF/views/main.jsp").forward(req, resp);
	
	}

}
