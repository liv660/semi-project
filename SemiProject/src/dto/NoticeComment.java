package dto;

import java.util.Date;

public class NoticeComment {
	
	private int commentNo;
	private int noticeNo;
	private int userNo;
	private String nick;
	private String commentText;
	private Date commentDate;
	@Override
	public String toString() {
		return "NoticeComment [commentNo=" + commentNo + ", noticeNo=" + noticeNo + ", userNo=" + userNo + ", nick="
				+ nick + ", commentText=" + commentText + ", commentDate=" + commentDate + "]";
	}
	public int getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}
	public int getNoticeNo() {
		return noticeNo;
	}
	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getCommentText() {
		return commentText;
	}
	public void setCommentText(String commentText) {
		this.commentText = commentText;
	}
	public Date getCommentDate() {
		return commentDate;
	}
	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}
	
	
}
