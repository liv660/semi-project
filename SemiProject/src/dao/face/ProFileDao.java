package dao.face;

import java.sql.Connection;
import java.util.Date;

import dto.UserAddress;
import dto.UserImg;
import dto.UserLeave;
import dto.Usertb;

public interface ProFileDao {

	public int updatebynick(Connection conn, Usertb usertb);

	public int insertbyimg(Connection conn, UserImg userimg);

	public int deletebyimg(Connection conn, UserImg userimg);

	public UserImg selectUserimg(Connection conn, UserImg userimg);

	public int basicinsert(Connection conn, UserImg userimg);

	public String selectPw(Connection conn, int userno);

	public int updatebypw(Connection conn, Usertb usertb);

	public int updatebyemail(Connection conn, Usertb usertb);

	public int updatebyPhone(Connection conn, Usertb usertb);

	public int updatepost(Connection conn, Usertb usertb);

	public int updateaddr(Connection conn, Usertb usertb);

	public int updatedetail(Connection conn, Usertb usertb);
	
	public int deleteuser(Connection conn, int userno);

	public int insertleave(Connection conn, UserLeave userLeave);




}
