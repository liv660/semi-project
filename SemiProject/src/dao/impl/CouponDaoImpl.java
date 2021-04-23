package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import common.JDBCTemplate;
import dao.face.CouponDao;
import dto.Coupon;

public class CouponDaoImpl implements CouponDao {
	
	private PreparedStatement ps;
	private ResultSet rs;
	
	@Override
	public int existInfo(Connection conn, int userno) {

		String sql = "";
		sql += "SELECT count(*) FROM coupon";
		sql += " WHERE user_no = ?";
		
		int res = -1;
		
		try {
			ps = conn.prepareStatement(sql);

			ps.setInt(1, userno);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				res = rs.getInt("count(*)"); 
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		return res;
	}
	
	@Override
	public Coupon selectUserno(Connection conn, int userno) {
	
		String sql = "";
		sql += "SELECT * FROM coupon";
		sql += " WHERE user_no = ?";
		
		Coupon res = null;
		
		try {
			ps = conn.prepareStatement(sql);

			ps.setInt(1, userno);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				res = new Coupon();
				
				res.setUserNo(rs.getInt("user_no"));
				res.setUserId(rs.getString("user_id"));
				res.setCouponNo(rs.getString("coupon_no"));
				res.setCouponUse(rs.getString("coupon_use"));
				res.setGameSuccess(rs.getString("game_success"));
				res.setPartDate(rs.getDate("part_date"));
				res.setDiscount(rs.getInt("discount"));
				
			}
 		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return res;
	}
	
	@Override
	public Date selectSysdate(Connection conn) {

		String sql = "";
		sql += "SELECT sysdate FROM dual";
		
		Date sysdate = null;
		
		try {
			ps = conn.prepareStatement(sql);

			rs = ps.executeQuery();
			
			while(rs.next()) {
				sysdate = rs.getDate("sysdate");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return sysdate;
	}
	
	@Override
	public int NewUser(Connection conn, Coupon coupon) { 

		String sql = "";
		
		int res = 0;
		
		if(coupon.getDiscount() == 0) {
			sql += "INSERT INTO coupon (user_no, user_id)";
			sql += " VALUES(?,?)";
			
			try {
				ps = conn.prepareStatement(sql);

				ps.setInt(1, coupon.getUserNo());
				ps.setString(2, coupon.getUserId());
				
				res = ps.executeUpdate();
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				JDBCTemplate.close(ps);
			}
			
		} else {
			sql += "INSERT INTO coupon (user_no, user_id, coupon_no, coupon_use, game_success, discount)";
			sql += " VALUES(?, ?, ?, 'N', 'Y', ?)";
			
			try {
				ps = conn.prepareStatement(sql);

				ps.setInt(1, coupon.getUserNo());
				ps.setString(2, coupon.getUserId());
				ps.setString(3, coupon.getCouponNo());
				ps.setInt(4, coupon.getDiscount());
			
				res = ps.executeUpdate();
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				JDBCTemplate.close(ps);
			}
		}
		
		return res;
		
	}
	
	@Override
	public int existingUser(Connection conn, Coupon coupon) {

		String sql = "";
		int res = 0;
		
		if(coupon.getDiscount() == 0) {
			sql += "UPDATE coupon";
			sql += " SET part_date = sysdate";
			sql += " WHERE user_no = ?";
		
			try {
				ps = conn.prepareStatement(sql);
			
				ps.setInt(1, coupon.getUserNo());

				res = ps.executeUpdate();
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				JDBCTemplate.close(ps);
			}
		
		} else {
			sql += "UPDATE coupon";
			sql += " SET coupon_no = ?, coupon_use = 'N', game_success = 'Y', part_date = sysdate, discount = ?";
			sql += " WHERE user_no = ?";
			
			try {
				ps = conn.prepareStatement(sql);
				
				ps.setString(1, coupon.getCouponNo());
				ps.setInt(2, coupon.getDiscount());
				ps.setInt(3, coupon.getUserNo());
				
				res = ps.executeUpdate();
			
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				JDBCTemplate.close(ps);
			}
			
		}
		
		return res;
	}

}
