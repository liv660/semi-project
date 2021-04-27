package service.impl;

import java.sql.Connection;
import java.util.List;

import common.JDBCTemplate;
import dao.face.MainDao;
import dao.impl.MainDaoImpl;
import dto.DiscoverBoard;
import dto.FindBoard;
import dto.Notice;
import dto.Product;
import dto.ReviewUserJoin;
import service.face.MainService;

public class MainServiceImpl implements MainService {
	
	private Connection conn;
	private MainDao mainDao = new MainDaoImpl();
	
	@Override
	public List<FindBoard> getFindBoard() {

		conn = JDBCTemplate.getConnection();
		
		List<FindBoard> findboard = mainDao.selectFindBoard(conn);
		
		return findboard;
	}
	
	@Override
	public List<DiscoverBoard> getDiscoverBoard() {

		conn = JDBCTemplate.getConnection();
		
		List<DiscoverBoard> discoverBoard = mainDao.selectDiscoverBoard(conn);
		
		return discoverBoard;
	}
	
	@Override
	public List<ReviewUserJoin> getReviewBoard() {

		conn = JDBCTemplate.getConnection();
		
		List<ReviewUserJoin> reviewboard = mainDao.selectReviewBoard(conn);
		
		return reviewboard;
	}
	
	@Override
	public List<Notice> getNoticeBoard() {

		conn = JDBCTemplate.getConnection();
		
		List<Notice> noticeboard = mainDao.selectNoticeBoard(conn);
		
		return noticeboard;
	}
	
	@Override
	public List<Product> getProductBoard() {

		conn = JDBCTemplate.getConnection();
		
		List<Product> productboard = mainDao.selectProductBoard(conn);
		
		return productboard;
	}

}
