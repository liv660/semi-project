package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.JDBCTemplate;
import dao.face.FindUserDao;
import dto.Usertb;
import util.HashNMacUtil;

public class FindUserDaoImpl implements FindUserDao {

	PreparedStatement ps = null;
	ResultSet rs = null;
	
	@Override
	public String selectUserId(Connection conn, Usertb param) {
		
		//아이디 찾기
		//name, email로 id 조회
		String sql = "";
		sql += "SELECT user_id FROM usertb";
		sql += " WHERE name=? AND email=?";
		
		String id = null;
		
		try {
			ps = conn.prepareStatement(sql);
		
			ps.setString(1, param.getName());
			ps.setString(2, param.getEmail());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				id = rs.getString("user_id");
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}

		return id;
	}
	
	@Override
	public Usertb selectUserPw(Connection conn, Usertb param) {
		
		//비밀번호 찾기
		//id, name, email이 일치하는 정보가 있는지 조회
		String sql = "";
		sql += "SELECT * FROM usertb";
		sql += " WHERE user_id=? AND name=? AND email=?";
		
		Usertb info = null;
		
		try {
			ps = conn.prepareStatement(sql);
		
			ps.setString(1, param.getUserId());
			ps.setString(2, param.getName());
			ps.setString(3, param.getEmail());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				info = new Usertb();
				
				 info.setUserId(rs.getString("user_id"));
				 info.setName(rs.getString("name"));
				 info.setEmail(rs.getString("email"));
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return info;
	}
	
	@Override
	public int insertNewPassword(Connection conn, String newPw, Usertb info) {

		//새 비밀번호 저장
		String sql = "";
		sql += "UPDATE usertb";
		sql += " SET user_pw = ?";
		sql += " WHERE user_id = ?";
		sql += " AND name = ?";
		sql += " AND email = ?";
		
		int res = 0;
		
		try {
			ps = conn.prepareStatement(sql);

			ps.setString(1, newPw);
			ps.setString(2, info.getUserId());
			ps.setString(3, info.getName());
			ps.setString(4, info.getEmail());

			res = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
}
