package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.MyBoard;
import service.face.ProFileService;
import service.impl.ProFileServiceImpl;
import util.MyPaging;

@WebServlet("/mypage/written")
public class UserWrittenViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ProFileService proFileService = new ProFileServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//요청파라미터를 전달하여 Paging객체 생성
		MyPaging myPaging = proFileService.getPageing(req);
		
		//페이징을 적용한 게시글 조회
		List<MyBoard> myBoardList = proFileService.myboradlist(req, myPaging);
		
		
		req.setAttribute("myPaging", myPaging);
		
		req.setAttribute("myBoardList", myBoardList);
		
		
		
		
		req.getRequestDispatcher("/WEB-INF/views/mypage/written.jsp")
			.forward(req, resp);
	}

}
