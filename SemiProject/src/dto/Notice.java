package dto;

import java.util.Date;

public class Notice {
	
	private int noticeNo;
	private String title;
	private String content;
	private String managerId;
	private Date createDate;
	private int views;
	private String noticeImp;
	
	//Notice Comment Join data
	private int commentCnt;

	@Override
	public String toString() {
		return "Notice [noticeNo=" + noticeNo + ", title=" + title + ", content=" + content + ", managerId=" + managerId
				+ ", createDate=" + createDate + ", views=" + views + ", noticeImp=" + noticeImp + ", commentCnt="
				+ commentCnt + "]";
	}

	public int getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getManagerId() {
		return managerId;
	}

	public void setManagerId(String managerId) {
		this.managerId = managerId;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public String getNoticeImp() {
		return noticeImp;
	}

	public void setNoticeImp(String noticeImp) {
		this.noticeImp = noticeImp;
	}

	public int getCommentCnt() {
		return commentCnt;
	}

	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}
	
	

	
	
}