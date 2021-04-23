package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dto.Coupon;
import service.face.CouponService;
import service.impl.CouponServiceImpl;

@WebServlet("/coupon/lookup")
public class CouponLookupController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private CouponService couponService = new CouponServiceImpl();
	
	@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String param = req.getParameter("userno");
		
		int userno = 0;
		if(param != null && !"".equals(param)) {
			userno = Integer.parseInt(param);
		}
		
		System.out.println(userno);
		
		Coupon coupon = couponService.getUserInfo(userno);
		
		Gson gson = new Gson();
		
		PrintWriter out = resp.getWriter();
		
		out.println(gson.toJson(coupon));

	}

}
