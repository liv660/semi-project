package dao.face;

import java.sql.Connection;

import dto.Usertb;

public interface FindUserDao {

	public String selectUserId(Connection conn, Usertb param);

	public Usertb selectUserPw(Connection conn, Usertb param);

	public int insertNewPassword(Connection conn, String newPw, Usertb info);

}
