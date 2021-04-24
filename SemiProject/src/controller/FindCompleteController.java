package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.face.FindBoardService;
import service.impl.FindBoardServiceImpl;

/**
 * Servlet implementation class FindCompleteController
 */
@WebServlet("/find/complete")
public class FindCompleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private FindBoardService findBoardService = new FindBoardServiceImpl();
	
	@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String param = req.getParameter("findno");
		
		int findno = 0;
		if(param != null && !"".equals(param)) {
			findno = Integer.parseInt(param);
		}
		
		findBoardService.completeFind(findno);
	
	}

}
