package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.ReviewBoard;
import dto.ReviewDetailView;
import dto.ReviewImgFile;
import service.face.ReviewService;
import service.impl.ReviewServiceImpl;

@WebServlet("/review/update")
public class ReviewUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ReviewService reviewService = new ReviewServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		System.out.println("리뷰 수정");
		
		//전달파라미터 얻기 - reviewNo
		ReviewBoard reviewNo = reviewService.getReviewNo(req);
//		System.out.println(reviewNo);
		
		//상세보기 결과
		ReviewDetailView reviewDetail = reviewService.view(reviewNo);
//		System.out.println(reviewDetail);
		
		req.setAttribute("reviewDetail", reviewDetail);
		
		//첨부파일 정보 VIEW에 전달
		List<ReviewImgFile> reviewImgs = reviewService.viewFile(reviewNo);
		req.setAttribute("reviewImgs", reviewImgs);
//		System.out.println(reviewImgs);
		
		req.setAttribute("reviewNo", reviewNo);
		
		req.getRequestDispatcher("/WEB-INF/views/review/update.jsp").forward(req, resp);
	}

}
