package dto;

import java.util.Date;

public class DiscoverComment {
	
	private int commentNo;
	private int discoverNo;
	private int userNo;
	private String nick;
	private String commentText;
	private Date commentDate;
	private Date commentUpdate;
	
	//userimg JOIN
	private String storedName;
	
	//total comment count
	private int commentCnt;

	@Override
	public String toString() {
		return "DiscoverComment [commentNo=" + commentNo + ", discoverNo=" + discoverNo + ", userNo=" + userNo
				+ ", nick=" + nick + ", commentText=" + commentText + ", commentDate=" + commentDate
				+ ", commentUpdate=" + commentUpdate + ", storedName=" + storedName + ", commentCnt=" + commentCnt
				+ "]";
	}

	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

	public int getDiscoverNo() {
		return discoverNo;
	}

	public void setDiscoverNo(int discoverNo) {
		this.discoverNo = discoverNo;
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

	public Date getCommentUpdate() {
		return commentUpdate;
	}

	public void setCommentUpdate(Date commentUpdate) {
		this.commentUpdate = commentUpdate;
	}

	public String getStoredName() {
		return storedName;
	}

	public void setStoredName(String storedName) {
		this.storedName = storedName;
	}

	public int getCommentCnt() {
		return commentCnt;
	}

	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}
	
	

	
	

}
