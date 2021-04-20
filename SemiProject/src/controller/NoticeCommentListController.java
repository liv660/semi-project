package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dto.NoticeComment;
import service.face.NoticeService;
import service.impl.NoticeServiceImpl;

@WebServlet("/notice/commentlist")
public class NoticeCommentListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private NoticeService noticeService = new NoticeServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Gson gson = new Gson();
		
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("application/json; charset=utf-8");
		
		String param = req.getParameter("noticeno");
		
		int noticeno = 0;
		if(param != null && !"".equals(param)) {
			noticeno = Integer.parseInt(param);
		}
		
		//조회할 글의 댓글 조회
		List<NoticeComment> commentlist = noticeService.viewCommnet(noticeno);

		PrintWriter out = resp.getWriter();
		
		out.print(gson.toJson(commentlist));
	}

}
