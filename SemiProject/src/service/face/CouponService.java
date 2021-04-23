package service.face;

import dto.Coupon;

public interface CouponService {

	public Coupon getUserInfo(int userno);

	public void saveCouponInfo(Coupon coupon);

}
