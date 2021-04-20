package dao.face;

import java.sql.Connection;
import java.util.List;

import dto.NoticeFile;

public interface NoticeFileDao {

	public int insertFile(Connection conn, List<NoticeFile> filelist, int noticeno);

	public List<NoticeFile> selectFile(Connection conn, int noticeno);

	public int deleteFile(Connection conn, int noticeno);

	public int deleteChoiceFile(Connection conn, String[] fileArr, int noticeno);


}
