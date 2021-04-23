package controller;

import java.io.IOException;

import javax.mail.Session;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Coupon;
import service.face.CouponService;
import service.impl.CouponServiceImpl;

@WebServlet("/coupon/save")
public class CouponSaveController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private CouponService couponService = new CouponServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Coupon coupon = new Coupon();
		
		String usernoString = req.getParameter("userno");
		int userno = 0;
		if(usernoString != null && !"".equals(usernoString)) {
			userno = Integer.parseInt(usernoString);
			coupon.setUserNo(userno);
		}
		
		String firstPartString = req.getParameter("firstPart");
		int firstPart = 0;
		if(firstPartString != null && !"".equals(firstPartString)) {
			firstPart = Integer.parseInt(firstPartString);
			coupon.setFirstPart(firstPart);
		}
		
		String discountString = req.getParameter("discount");
		int discount = 0;
		if(discountString != null && !"".equals(discountString)) {
			discount = Integer.parseInt(discountString);
			coupon.setDiscount(discount);
		}
		
		if(req.getParameter("couponNo") != null && !"".equals(req.getParameter("couponNo"))) {
			coupon.setCouponNo(req.getParameter("couponNo"));
		}
		
		HttpSession session = req.getSession();
		coupon.setUserId((String) session.getAttribute("userid"));
		
		couponService.saveCouponInfo(coupon);
		
		
		
	
	}
	
}
