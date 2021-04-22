package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.ReviewBoard;
import service.face.ReviewService;
import service.impl.ReviewServiceImpl;

@WebServlet("/review/delete")
public class ReviewDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ReviewService reviewService = new ReviewServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		System.out.println("리뷰 삭제 GET");
		
		//삭제할 reviewNo 구하기
		ReviewBoard reviewNo = reviewService.getReviewNo(req);
//		System.out.println(reviewNo);
		
		//삭제하기
		reviewService.delete(reviewNo);
		
		resp.sendRedirect("/review/list");
	}

}
