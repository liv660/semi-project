package dto;

import java.util.Date;

public class Coupon {

	private int userNo;
	private String userId;
	private String couponNo;
	private String couponUse;
	private String gameSuccess;
	private Date partDate;
	private int discount;
	
	
	private int dateCompare;
	private int firstPart;
	
	
	@Override
	public String toString() {
		return "Coupon [userNo=" + userNo + ", userId=" + userId + ", couponNo=" + couponNo + ", couponUse=" + couponUse
				+ ", gameSuccess=" + gameSuccess + ", partDate=" + partDate + ", discount=" + discount
				+ ", dateCompare=" + dateCompare + ", firstPart=" + firstPart + "]";
	}


	public int getUserNo() {
		return userNo;
	}


	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getCouponNo() {
		return couponNo;
	}


	public void setCouponNo(String couponNo) {
		this.couponNo = couponNo;
	}


	public String getCouponUse() {
		return couponUse;
	}


	public void setCouponUse(String couponUse) {
		this.couponUse = couponUse;
	}


	public String getGameSuccess() {
		return gameSuccess;
	}


	public void setGameSuccess(String gameSuccess) {
		this.gameSuccess = gameSuccess;
	}


	public Date getPartDate() {
		return partDate;
	}


	public void setPartDate(Date partDate) {
		this.partDate = partDate;
	}


	public int getDiscount() {
		return discount;
	}


	public void setDiscount(int discount) {
		this.discount = discount;
	}


	public int getDateCompare() {
		return dateCompare;
	}


	public void setDateCompare(int dateCompare) {
		this.dateCompare = dateCompare;
	}


	public int getFirstPart() {
		return firstPart;
	}


	public void setFirstPart(int firstPart) {
		this.firstPart = firstPart;
	}
	

	
	
	


}
