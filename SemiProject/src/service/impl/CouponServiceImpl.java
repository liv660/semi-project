package service.impl;

import java.sql.Connection;
import java.util.Date;

import common.JDBCTemplate;
import dao.face.CouponDao;
import dao.impl.CouponDaoImpl;
import dto.Coupon;
import service.face.CouponService;

public class CouponServiceImpl implements CouponService {
	
	private Connection conn;
	private CouponDao couponDao = new CouponDaoImpl();
	
	@Override
	public Coupon getUserInfo(int userno) {

		conn = JDBCTemplate.getConnection();
		
		int res = couponDao.existInfo(conn, userno); 
		
		Coupon coupon = new Coupon();
		
		if(res > 0) {
			
		coupon = couponDao.selectUserno(conn, userno);
		
		Date sysdate = couponDao.selectSysdate(conn);
		
			if(coupon.getPartDate().equals(sysdate)) {
				//당일 참여 한사람
				coupon.setDateCompare(1);
			} else { 									
				//당일 참여 안한사람
				coupon.setDateCompare(2);
			}
			
		coupon.setFirstPart(res);
			
		} else {
			//한번도 참여 안한사람
			coupon.setFirstPart(2);
			
		}
		
		return coupon;
	}
	
	@Override
	public void saveCouponInfo(Coupon coupon) {

		conn = JDBCTemplate.getConnection();
		
		int res = 0;
		
		if(coupon.getFirstPart() == 2) {
			res = couponDao.NewUser(conn, coupon);
		} else if (coupon.getFirstPart() == 1) {
			res = couponDao.existingUser(conn, coupon); 
		}
		
		if(res > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		
		
		
		
	}
	

}
