package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.ReviewUserJoin;
import service.face.ReviewService;
import service.impl.ReviewServiceImpl;
import util.Paging;

@WebServlet("/review/list")
public class ReviewListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ReviewService reviewService = new ReviewServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		System.out.println("review/list [GET]");
		
		//요청파라미터를 전달하여 Paging객체 생성하기
		Paging paging = reviewService.getPaging(req);
//		System.out.println("[TEST] ReviewListController - " + paging);
		
		String sort = req.getParameter("sort");
		if("".equals(sort) || sort == null) {
			sort = "0";
		}
		int num = Integer.parseInt(sort);
		System.out.println("후기분류번호" + num);
		
		Map<String, Integer> map = new HashMap<>();
		map.put("sort", num);
		
		//게시글 조회 (페이징 적용)
//		List<ReviewUserJoin> reviewList = reviewService.getList(paging);
//		System.out.println("[TEST] reviewBoardList " + reviewList);
		List<ReviewUserJoin> reviewSortList = reviewService.getList(paging, map); //고치는중
		
		//페이징 객체를 MODEL 값으로 전달
		req.setAttribute("paging", paging);
		
		//게시글 조회 결과 MODEL 값 전달
		req.setAttribute("reviewList", reviewSortList);
		
		req.getRequestDispatcher("/WEB-INF/views/review/list.jsp").forward(req, resp);
	}
	
}
