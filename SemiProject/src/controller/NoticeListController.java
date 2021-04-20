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

import dto.Notice;
import service.face.NoticeService;
import service.impl.NoticeServiceImpl;
import util.Paging;



@WebServlet("/notice/list")
public class NoticeListController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//NoticeService 객체 생성
	private NoticeService noticeService = new NoticeServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		
		// TAB-1
		//키워드 검색시 키워드와 검색어 전달파라미터값 받아오기
		String title = req.getParameter("title");
		String search = req.getParameter("search");
		
		//Map에 전달파라미터값 저장
		Map<String, String> map = new HashMap<>();
		
		map.put("title", title);
		map.put("search", search);
		
		
		//요청파라미터 전달해 페이징객체 생성
		Paging paging = noticeService.getPaging(req);
		
		//페이징객체, 키워드 검색 값 전달해 List 조회
		List<Notice> list = noticeService.viewList(paging, map);
		
		
		
		//TAB-2
		//요일별 작성글 수 조회
		Map<String, Integer> chart = noticeService.postByDate();
		
		
		
		//페이징 객체 전달
		req.setAttribute("paging", paging);
		
		//글 리스트 전달
		req.setAttribute("list", list);
		
		//요일별 작성글 수 전달
		req.setAttribute("map", chart);
		
		req.getRequestDispatcher("/WEB-INF/views/notice/list.jsp").forward(req, resp);
	
	
	
	}
}
