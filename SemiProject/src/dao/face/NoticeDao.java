package dao.face;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import dto.Notice;
import util.Paging;

public interface NoticeDao {

	public int selectCntAll(Connection conn);

	public List<Notice> selectList(Connection conn, Paging paging, Map<String, String> map);

	public int updateViews(Connection conn, int noticeno);

	public Notice selectText(Connection conn, int noticeno);

	public int insertText(Connection conn, Notice notice);

	public int selectNoticeNo(Connection conn);

	public int deleteText(Connection conn, int noticeno);

	public int update(Connection conn, Notice notice);

	public Map<String, Integer> selectByPostdate(Connection conn);

	public Map<String, Integer> selectByFindTextCnt(Connection conn);

}
