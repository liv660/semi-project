package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import common.JDBCTemplate;
import dao.face.NoticeCommentDao;
import dto.NoticeComment;

public class NoticeCommentDaoImpl implements NoticeCommentDao {

	private PreparedStatement ps;
	private ResultSet rs;
	
	@Override
	public List<NoticeComment> selectComment(Connection conn, int noticeno) {

		String sql = "";
		sql += "SELECT comment_no, notice_no, NC.user_no, nick, comment_text, comment_date, UI.storedname,(";
		sql += " SELECT count(*) FROM notice_comment WHERE notice_no = ?) count";
		sql += " FROM notice_comment NC, userimg UI";
		sql += " WHERE NC.user_no = UI.user_no";
		sql += " AND notice_no = ?";
		sql += " ORDER BY comment_no DESC";
		
		List<NoticeComment> list = new ArrayList<>();
		
		try {
			ps = conn.prepareStatement(sql);

			ps.setInt(1, noticeno);
			ps.setInt(2, noticeno);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				NoticeComment res = new NoticeComment();
				
				res.setNick(rs.getString("nick"));
				res.setCommentText(rs.getString("comment_text"));
				res.setCommentDate(rs.getDate("comment_date"));
				res.setCommentNo(rs.getInt("comment_no"));
				res.setCommentCnt(rs.getInt("count"));
				res.setStoredName(rs.getString("storedname"));
				
				list.add(res);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return list;
	}
	
	@Override
	public int insertComment(Connection conn, NoticeComment param) {

		String sql = "";
		sql += "INSERT INTO notice_comment (comment_no, notice_no, user_no, nick, comment_text)";
		sql += " VALUES (notice_comment_seq.nextval, ?, ?, ?, ?)";
		
		int res = 0;
		
		try {
			ps = conn.prepareStatement(sql);

			ps.setInt(1, param.getNoticeNo());
			ps.setInt(2, param.getUserNo());
			ps.setString(3, param.getNick());
			ps.setString(4, param.getCommentText());
		
			res = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return res;
	}
	
	@Override
	public int deleteComment(Connection conn, NoticeComment param) {

		String sql = "";
		sql += "DELETE notice_comment";
		sql += " WHERE comment_no = ?";
		
		int res = 0;
		
		try {
			ps = conn.prepareStatement(sql);

			ps.setInt(1, param.getCommentNo());
			
			res = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return res;
	}
	
	@Override
	public int updateComment(Connection conn, NoticeComment param) {

		String sql = "";
		sql += "UPDATE notice_comment";
		sql += " SET comment_text = ?, comment_date = sysdate";
		sql += " WHERE comment_no = ?";
		
		int res = 0;
		
		try {
			ps=conn.prepareStatement(sql);

			ps.setString(1, param.getCommentText());
			ps.setInt(2, param.getCommentNo());
			
			res = ps.executeUpdate();
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return res;
	}
}
