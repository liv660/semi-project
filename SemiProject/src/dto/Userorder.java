package dto;

public class Userorder {
	
	private int userorder_no;
	private int user_no;
	private int product_id;
	private int total_pay;
	
	@Override
	public String toString() {
		return "Userorder [userorder_no=" + userorder_no + ", user_no=" + user_no + ", product_id=" + product_id
				+ ", total_pay=" + total_pay + "]";
	}

	public int getUserorder_no() {
		return userorder_no;
	}

	public void setUserorder_no(int userorder_no) {
		this.userorder_no = userorder_no;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public int getTotal_pay() {
		return total_pay;
	}

	public void setTotal_pay(int total_pay) {
		this.total_pay = total_pay;
	}
	
	
	
	
	
}
