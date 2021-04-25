package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.face.DiscoverBoardService;
import service.impl.DiscoverBoardServiceImpl;

@WebServlet("/discover/complete")
public class DiscoverCompleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private DiscoverBoardService discoverBoardServoce = new DiscoverBoardServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String param = req.getParameter("discoverno");
		
		int discoverno = 0;
		if(param != null && !"".equals(param)) {
			discoverno = Integer.parseInt(param);
		}
		
		discoverBoardServoce.completeDiscover(discoverno); 
		
	
	}
	
	
}
