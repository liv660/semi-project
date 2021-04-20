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

	public int getinsertaddress(Connection conn, UserAddress userAddress);

	public int updatejibun(Connection conn, UserAddress userAddress);

	public int updatedetail(Connection conn, UserAddress userAddress);

	public String selectbyPost(Connection conn, UserAddress userAddress);

	public int updatepost(Connection conn, UserAddress userAddress);

	public int updateroad(Connection conn, UserAddress userAddress);

	public int updateExtra(Connection conn, UserAddress userAddress);

	public int deleteuser(Connection conn, int userno);

	public int insertleave(Connection conn, UserLeave userLeave);




}
