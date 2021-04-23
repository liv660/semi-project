package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dto.ReviewComment;
import service.face.ReviewService;
import service.impl.ReviewServiceImpl;

@WebServlet("/review/commentList")
public class ReviewCommentListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ReviewService reviewService = new ReviewServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		Gson gson = new Gson();
		
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("application/json; charset=utf-8");
		
		String param = req.getParameter("reviewNo");
		
		int reviewNo = 0;
		if(param != null && !"".equals(param)) {
			reviewNo = Integer.parseInt(param);
		}
		
		//조회한 글의 댓글 조회
		List<ReviewComment> commentlist = reviewService.viewComment(reviewNo);
		
		PrintWriter out = resp.getWriter();
		out.print(gson.toJson(commentlist));
	}

}
