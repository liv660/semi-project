package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Userorder;
import service.face.ProductService;
import service.impl.ProductServiceImpl;


@WebServlet("/product/paycomplete")
public class ProductPaymentCompleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ProductService productService = new ProductServiceImpl();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		System.out.println("/product/paycomplete - [POST] 넘어옴");
		
		Userorder param = productService.getOrderParam(req);
		
		System.out.println("/product/paycomlete param = " + param);
		
		productService.insertOrder(param);
		
//		req.getRequestDispatcher("/")
//			.forward(req, resp);
		

	}
	

}
