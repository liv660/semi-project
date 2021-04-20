package dao.face;

import java.sql.Connection;
import java.util.List;

import dto.NoticeComment;

public interface NoticeCommentDao {

	public List<NoticeComment> selectComment(Connection conn, int noticeno);

	public int insertComment(Connection conn, NoticeComment param);

	public int deleteComment(Connection conn, NoticeComment param);

	public int updateComment(Connection conn, NoticeComment param);

}
