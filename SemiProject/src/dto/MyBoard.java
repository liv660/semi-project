package dto;

import java.util.Date;

public class MyBoard {
	
	private int borad_no;
	private String board_div;
	private String title;
	private Date create_date;
	
	@Override
	public String toString() {
		return "MyBoard [borad_no=" + borad_no + ", board_div=" + board_div + ", title=" + title + ", create_date="
				+ create_date + "]";
	}
	public int getBorad_no() {
		return borad_no;
	}
	public void setBorad_no(int borad_no) {
		this.borad_no = borad_no;
	}
	public String getBoard_div() {
		return board_div;
	}
	public void setBoard_div(String board_div) {
		this.board_div = board_div;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	
	
}
