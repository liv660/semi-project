package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.face.NoticeService;
import service.impl.NoticeServiceImpl;

@WebServlet("/notice/delete")
public class NoticeDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//NoticeService 객체 생성
	private NoticeService noticeService = new NoticeServiceImpl();
	
	@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//삭제할 글번호 전달파라미터값 받아오기
		String param = req.getParameter("noticeno");
	
		int noticeno = 0;
		if(param != null && !"".equals(param)) {
			noticeno = Integer.parseInt(param);
		}
		
		//글삭제
		noticeService.removeText(noticeno);
		
		//삭제 후 리스트로 리다이렉트
		resp.sendRedirect("/notice/list");
		
	}

}
