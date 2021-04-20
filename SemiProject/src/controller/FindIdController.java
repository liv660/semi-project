package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Usertb;
import service.face.FindUserService;
import service.impl.FindUserServiceImpl;

@WebServlet("/login/findid")
public class FindIdController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//FindUserService 객체 생성
	private FindUserService findUserService = new FindUserServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//VIEW 지정 및 응답 - forward
		req.getRequestDispatcher("/WEB-INF/views/login/Findid.jsp").forward(req, resp);
	
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//요청 데이터의 한글 인코딩 설정
		req.setCharacterEncoding("UTF-8");
		
		//입력정보 받아오기
		Usertb param = findUserService.getIdParam(req);
		
		//입력정보로 아이디 찾기
		String id = findUserService.findUserId(param);
		
		//입력정보와 일치하는 아이디 MODEL값으로 전달
		req.setAttribute("id", id);
		
		//VIEW 지정 및 응답 - forward
		req.getRequestDispatcher("/WEB-INF/views/login/Viewfindid.jsp").forward(req,resp);
	
	
	}
}
