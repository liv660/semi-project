package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.PurchaseList;
import service.face.ProFileService;
import service.impl.ProFileServiceImpl;

@WebServlet("/purchase/list")
public class MypurchaseListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ProFileService proFileService = new ProFileServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	List<PurchaseList> purchaseList = proFileService.myorderList(req);
	
	System.out.println( purchaseList );
	req.setAttribute("purchaseList", purchaseList);	
	
	
		req.getRequestDispatcher("/WEB-INF/views/basket/purchaslist.jsp")
		 	.forward(req, resp);
	
	}
}
