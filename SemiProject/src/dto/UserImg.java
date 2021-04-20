package dto;

import java.util.Date;

public class UserImg {
	
	private int userNo;
	private String originName;
	private String stroedName;
	private int filesize;
	private Date updateDate;
	@Override
	public String toString() {
		return "UserImg [userNo=" + userNo + ", originName=" + originName + ", stroedName=" + stroedName + ", filesize="
				+ filesize + ", updateDate=" + updateDate + "]";
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getOriginName() {
		return originName;
	}
	public void setOriginName(String originName) {
		this.originName = originName;
	}
	public String getStroedName() {
		return stroedName;
	}
	public void setStroedName(String stroedName) {
		this.stroedName = stroedName;
	}
	public int getFilesize() {
		return filesize;
	}
	public void setFilesize(int filesize) {
		this.filesize = filesize;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	
	
	

}
