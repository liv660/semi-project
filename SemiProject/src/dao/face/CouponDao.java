package dao.face;

import java.sql.Connection;
import java.util.Date;

import dto.Coupon;

public interface CouponDao {
	
	public int existInfo(Connection conn, int userno);

	public Coupon selectUserno(Connection conn, int userno);

	public Date selectSysdate(Connection conn);

	public int NewUser(Connection conn, Coupon coupon);

	public int existingUser(Connection conn, Coupon coupon);


}
