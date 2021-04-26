package dto;

import java.util.Date;

public class PurchaseList {
	
	private int productId;
	private int userNo;
	private String productName;
	private int price;
	private String storedImg;
	private Date purchaseDate;
	@Override
	public String toString() {
		return "PurchaseList [productId=" + productId + ", userNo=" + userNo + ", productName=" + productName
				+ ", price=" + price + ", storedImg=" + storedImg + ", purchaseDate=" + purchaseDate + "]";
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getStoredImg() {
		return storedImg;
	}
	public void setStoredImg(String storedImg) {
		this.storedImg = storedImg;
	}
	public Date getPurchaseDate() {
		return purchaseDate;
	}
	public void setPurchaseDate(Date purchaseDate) {
		this.purchaseDate = purchaseDate;
	}
	

}
