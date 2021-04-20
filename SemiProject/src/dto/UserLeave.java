package dto;

public class UserLeave {
	
	private int leaveNo;
	private String content;
	
	@Override
	public String toString() {
		return "UserLeave [leaveNo=" + leaveNo + ", content=" + content + "]";
	}
	
	public int getLeaveNo() {
		return leaveNo;
	}
	public void setLeaveNo(int leaveNo) {
		this.leaveNo = leaveNo;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	

}
