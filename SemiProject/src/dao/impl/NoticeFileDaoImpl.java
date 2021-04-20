package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.JDBCTemplate;
import dao.face.NoticeFileDao;
import dto.NoticeFile;

public class NoticeFileDaoImpl implements NoticeFileDao {
	
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	@Override
	public int insertFile(Connection conn, List<NoticeFile> filelist, int noticeno) {

		int res = 0;
		for(int i=0; i<filelist.size(); i++) {
			
			//파일 삽입
			String sql = "";
			sql += "INSERT INTO notice_file (notice_fileno, notice_no, origin_name, stored_name, filesize)";
			sql += " VALUES(notice_file_seq.nextval, ?, ?, ?, ?)";
			
			
			try {
				ps = conn.prepareStatement(sql);
	
				ps.setInt(1, noticeno);
				ps.setString(2, filelist.get(i).getOriginName());
				ps.setString(3, filelist.get(i).getStoredName());
				ps.setInt(4, filelist.get(i).getFilesize());
				
				res = ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				JDBCTemplate.close(rs);
				JDBCTemplate.close(ps);
			}
		}
		
		return res;
	}
	
	@Override
	public List<NoticeFile> selectFile(Connection conn, int noticeno) {
		
		//파일 조회
		String sql = "";
		sql += "SELECT * FROM notice_file";
		sql += " WHERE notice_no = ?";
		
		List<NoticeFile> filelist = new ArrayList<>();
		
		try {
			ps = conn.prepareStatement(sql);

			ps.setInt(1, noticeno);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				NoticeFile file = new NoticeFile();
				
				file.setOriginName(rs.getString("origin_name"));
				file.setStoredName(rs.getString("stored_name"));
				
				filelist.add(file);
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return filelist;
	}
	
	@Override
	public int deleteFile(Connection conn, int noticeno) {
		
		//파일 전체 삭제
		String sql = "";
		sql += "DELETE notice_file";
		sql += " WHERE notice_no = ?";
		
		int res = 0;
		
		try {
			ps = conn.prepareStatement(sql);

			ps.setInt(1, noticeno);
			
			res = ps.executeUpdate();
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return res;
	}
	
	@Override
	public int deleteChoiceFile(Connection conn, String[] fileArr, int noticeno) {

		
		
		int res = 0;
		
		for(int i=0; i<fileArr.length; i++) {
			//선택 파일 삭제
			String sql = "";
			sql += "DELETE notice_file";
			sql += " WHERE notice_no = ?";
			sql += " AND origin_name = ?";
			
			try {
				ps = conn.prepareStatement(sql);
				
				ps.setInt(1, noticeno);
				ps.setString(2, fileArr[i]);
				
				res = ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				JDBCTemplate.close(ps);
			}
		}
		
		return res;
	}

}
