package controller;

import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Usertb;
import service.face.FindUserService;
import service.impl.FindUserServiceImpl;

@WebServlet("/login/findpw")
public class FindPwController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//FindUserService 객체 생성
	private FindUserService findUserService = new FindUserServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.getRequestDispatcher("/WEB-INF/views/login/Findpw.jsp").forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//요청 데이터의 한글 인코딩 설정 : UTF-8
		req.setCharacterEncoding("UTF-8");
		
		//입력정보 받아오기
		Usertb param = findUserService.getPwParam(req);
		
		//입력정보와 일치하는 유저정보있는지 조회
		Usertb info = findUserService.findUserPw(param);
		
		//일치하는 정보가 있다면
		if(info != null) {
			
			//새 비밀번호 생성
			String newPw = "";
	        Random ran = new Random();
	        for(int i=0;i<11;i++){
	            if(ran.nextBoolean()){
	                newPw += ((char)((int)(ran.nextInt(26))+97));
	            }else{
	                newPw += ((ran.nextInt(10)));
	            }
	        }

	        //새 비밀번호 이메일로 전송
	        findUserService.sendNewPassward(newPw, info);
	        
	        //새 비밀번호 DB에 저장
	        findUserService.changePw(newPw, info);
	        
	        req.setAttribute("flag", info );
		}
		
		//VIEW지정 및 응답 - forward
		req.getRequestDispatcher("/WEB-INF/views/login/Viewfindpw.jsp").forward(req, resp);
	
	}

}
