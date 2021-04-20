package dto;

import java.util.Date;

public class NoticeFile {
	
	private int noticeFileNo;
	private int notice_No;
	private String originName;
	private String storedName;
	private int filesize;
	private Date createDate;
	@Override
	public String toString() {
		return "NoticeFile [noticeFileNo=" + noticeFileNo + ", notice_No=" + notice_No + ", originName=" + originName
				+ ", storedName=" + storedName + ", filesize=" + filesize + ", createDate=" + createDate + "]";
	}
	public int getNoticeFileNo() {
		return noticeFileNo;
	}
	public void setNoticeFileNo(int noticeFileNo) {
		this.noticeFileNo = noticeFileNo;
	}
	public int getNotice_No() {
		return notice_No;
	}
	public void setNotice_No(int notice_No) {
		this.notice_No = notice_No;
	}
	public String getOriginName() {
		return originName;
	}
	public void setOriginName(String originName) {
		this.originName = originName;
	}
	public String getStoredName() {
		return storedName;
	}
	public void setStoredName(String storedName) {
		this.storedName = storedName;
	}
	public int getFilesize() {
		return filesize;
	}
	public void setFilesize(int filesize) {
		this.filesize = filesize;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	

	
}
