package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.JDBCTemplate;
import dao.face.MainDao;
import dto.DiscoverBoard;
import dto.FindBoard;
import dto.Notice;
import dto.ReviewUserJoin;

public class MainDaoImpl implements MainDao {
	
	private PreparedStatement ps;
	private ResultSet rs;
	
	@Override
	public List<FindBoard> selectFindBoard(Connection conn) {

		String sql = "";
		sql += "SELECT * FROM (";
		sql += " 	SELECT rownum rnum, F.* FROM (";
		sql += " 		SELECT";
		sql += " 			FB.find_no, FB.title, FB.pet_kinds, FB.loc, FB.find_complete, FI.stored_img";
		sql += " 		FROM findboard FB, (";
		sql += "        	SELECT FIND_IMG.* FROM (";
		sql += " 				SELECT";
		sql += " 					row_number() over( partition by find_no order by image_no) rnum";
		sql += " 					,find_no, stored_img";
		sql += " 				FROM findimg";
		sql += " 			) FIND_IMG";
		sql += "			WHERE rnum = 1";
		sql += " 		)FI";
		sql += " 		WHERE FB.find_no = FI.find_no(+)";		
		sql += " 		ORDER BY find_no DESC";
		sql += "	) F";
		sql += " ) findboard";
		sql += " WHERE rnum BETWEEN 1 AND 2";
		
		List<FindBoard> findboard = new ArrayList<>();
		
		try {
			ps = conn.prepareStatement(sql);
		
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				FindBoard res = new FindBoard();
				
				res.setFindNo(rs.getInt("find_no"));
				res.setTitle(rs.getString("title"));
				res.setPetKinds(rs.getString("pet_Kinds"));
				res.setLoc(rs.getString("loc"));
				res.setFind_complete(rs.getString("find_complete"));
				res.setStroed_img(rs.getString("stored_img"));
				
				findboard.add(res);
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		return findboard;
	}
	
	@Override
	public List<DiscoverBoard> selectDiscoverBoard(Connection conn) {

		String sql = "";
		sql += "SELECT * FROM (";
		sql += " 	SELECT rownum rnum, D.* FROM (";
		sql += " 		SELECT";
		sql += " 			DB.discover_no, DB.title, DB.pet_kinds, DB.loc, DB.discover_complete, DI.stored_img";
		sql += " 		FROM discoverboard DB, (";
		sql += "        	SELECT DISCOVER_IMG.* FROM (";
		sql += " 				SELECT";
		sql += " 					row_number() over( partition by discover_no order by image_no) rnum";
		sql += " 					,discover_no, stored_img";
		sql += " 				FROM discoverimg";
		sql += " 			) DISCOVER_IMG";
		sql += "			WHERE rnum = 1";
		sql += " 		)DI";
		sql += " 		WHERE DB.discover_no = DI.discover_no(+)";		
		sql += " 		ORDER BY discover_no DESC";
		sql += "	) D";
		sql += " ) discoverboard";
		sql += " WHERE rnum BETWEEN 1 AND 2";
		
		List<DiscoverBoard> discoverboard = new ArrayList<>();
		
		try {
			ps = conn.prepareStatement(sql);

			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				DiscoverBoard res = new DiscoverBoard();
				
				res.setDiscoverNo(rs.getInt("discover_no"));
				res.setTitle(rs.getString("title"));
				res.setPetKinds(rs.getString("pet_kinds"));
				res.setLoc(rs.getString("loc"));
				res.setDiscover_complete(rs.getString("discover_complete"));
				res.setStroed_img(rs.getString("stored_img"));
				
				discoverboard.add(res);
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return discoverboard;
	}
	
	@Override
	public List<ReviewUserJoin> selectReviewBoard(Connection conn) {

		String sql = "";
		sql += " SELECT * FROM (";
		sql += "	    SELECT rownum rnum, R.* FROM (";
		sql += "	           SELECT";
		sql += "	               review_no, s.review_sort_detail, title";
		sql += "	           FROM review_board b, review_board_sort s, usertb u";
		sql += "	           WHERE b.review_sort = s.review_sort AND b.user_no = u.user_no";
		sql += "	           ORDER BY review_no DESC";
		sql += "	       ) R";
		sql += "	   ) REVIEW";
		sql += "	   WHERE rnum BETWEEN 1 AND 6";
		
		List<ReviewUserJoin> reviewboard = new ArrayList<>();
		
		try {
			ps = conn.prepareStatement(sql);

			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				ReviewUserJoin res = new ReviewUserJoin();
				
				res.setReviewNo(rs.getInt("review_no"));
				res.setReviewSortDetail(rs.getString("review_sort_detail"));
				res.setTitle(rs.getString("title"));
				
				reviewboard.add(res);
			}
					
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		return reviewboard;
	}
	
	@Override
	public List<Notice> selectNoticeBoard(Connection conn) {
		
		String sql = "";
		sql += "SELECT * FROM (";
		sql += " 	SELECT rownum rnum, N.* FROM(";
		sql += " 		SELECT notice_no, title, notice_imp" ;
		sql += " 		FROM notice_board NB";
		sql += " 		ORDER BY notice_imp ASC, notice_no DESC";
		sql += " 	) N";
		sql += " ) NOTICE";
		sql += " WHERE rnum BETWEEN 1 AND 6";
		
		List<Notice> noticeboard = new ArrayList<>();
		
		try {
			ps = conn.prepareStatement(sql);

			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				Notice res = new Notice();
				
				res.setNoticeNo(rs.getInt("notice_no"));
				res.setTitle(rs.getString("title"));
				res.setNoticeImp(rs.getString("notice_imp"));
				
				noticeboard.add(res);
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return noticeboard;
	}

}
