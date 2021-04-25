package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.JDBCTemplate;
import dao.face.NoticeDao;
import dto.Notice;
import util.Paging;

public class NoticeDaoImpl implements NoticeDao {

	PreparedStatement ps = null;
	ResultSet rs = null;
	
	
	@Override
	public int selectCntAll(Connection conn) {
		
		//총 게시물 수 조회
		String sql = "";
		sql += "SELECT count(*) cnt FROM board";
		sql += " WHERE 1=1";
		
		int cnt = 0;
		
		try {
			ps = conn.prepareStatement(sql);

			rs = ps.executeQuery();
			
			while(rs.next()) {
				cnt = rs.getInt("cnt");
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return cnt;
	}
	
	@Override
	public List<Notice> selectList(Connection conn, Paging paging, Map<String, String> map) {
		
		//1페이지에 표시할 게시글수만큼 게시글 조회
		//검색한 키워드에 맞게 게시글 조회
		
		String sql = "";
		sql += "SELECT * FROM (";
		sql += " 	SELECT rownum rnum, N.* FROM(";
		sql += " 		SELECT notice_no,title, manager_id, create_date, views, notice_imp" ;
		sql += " 		,(SELECT count(*) FROM notice_comment";
		sql += " 		WHERE NB.notice_no = notice_comment.notice_no ) as count";
		sql += " 	FROM notice_board NB";
		if("writer".equals(map.get("title"))) {
			sql += " WHERE manager_id LIKE '%' || ? || '%' ";
		} else if ("title".equals(map.get("title"))) {
			sql += " WHERE title LIKE '%' || ? || '%'";
		} else if ("content".equals(map.get("title"))) {
			sql += " WHERE content LIKE '%' || ? || '%'";
		}
		sql += " 	ORDER BY notice_imp ASC, notice_no DESC";
		sql += " 	) N";
		sql += " ) NOTICE";
		sql += " WHERE rnum BETWEEN ? AND ?";
		
		List<Notice> list = new ArrayList<>();
		
		try {
			ps = conn.prepareStatement(sql);
			
			if(map.get("title") == null) {
				ps.setInt(1, paging.getStartNo());
				ps.setInt(2, paging.getEndNo());
			} else if(map.get("title") != null) {
				ps.setString(1, map.get("search"));
				ps.setInt(2, paging.getStartNo());
				ps.setInt(3, paging.getEndNo());
			}
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				Notice res = new Notice();
				
				res.setNoticeNo(rs.getInt("notice_no"));
				res.setTitle(rs.getString("title"));
				res.setManagerId(rs.getString("manager_id"));
				res.setCreateDate(rs.getDate("create_date"));
				res.setViews(rs.getInt("views"));
				res.setNoticeImp(rs.getString("notice_imp"));
				res.setCommentCnt(rs.getInt("count"));
				
				list.add(res);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return list;
	}
	
	@Override
	public int updateViews(Connection conn, int noticeno) {
		
		//조회수 증가
		String sql = "";
		sql += "Update notice_board";
		sql += " SET views = views + 1";
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
	public Notice selectText(Connection conn, int noticeno) {
		
		//게시글 내용 조회
		String sql = "";
		sql += "SELECT * FROM notice_board";
		sql += " WHERE notice_no = ?";
		
		Notice notice = null;
		
		try {
			ps = conn.prepareStatement(sql);

			ps.setInt(1, noticeno);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				notice = new Notice();
				
				notice.setNoticeNo(rs.getInt("notice_no"));
				notice.setTitle(rs.getString("title"));
				notice.setContent(rs.getString("content"));
				notice.setManagerId(rs.getString("manager_id"));
				notice.setCreateDate(rs.getDate("create_date"));
				notice.setViews(rs.getInt("views"));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return notice;
	}
	
	@Override
	public int insertText(Connection conn, Notice notice) {
		
		//글쓰기
		String sql = "";
		sql += "INSERT INTO notice_board( notice_no, title, content, manager_id, notice_imp)";
		sql += " VALUES(notice_seq.nextval, ?, ?, ?, ?)";
		
		int res = 0;
		
		try {
			ps = conn.prepareStatement(sql);

			ps.setString(1, notice.getTitle());
			ps.setString(2, notice.getContent());
			ps.setString(3, notice.getManagerId());
			ps.setString(4, notice.getNoticeImp());
			
			res = ps.executeUpdate();
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}

		return res;
	}
	
	@Override
	public int selectNoticeNo(Connection conn) {
		
		//현재 게시글 번호 구하기
		String sql = "";
		sql += "SELECT notice_seq.currval noticeno from dual";
		
		int res = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				res = rs.getInt("noticeno");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
			JDBCTemplate.close(rs);
		}
		return res;
	}
	
	@Override
	public int deleteText(Connection conn, int noticeno) {
		
		//게시글 삭제
		String sql = "";
		sql += "DELETE notice_board";
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
	public int update(Connection conn, Notice notice) {
		
		//게시글 수정
		String sql = "";
		sql += "UPDATE notice_board";
		sql += " SET title = ?, content = ?, notice_imp = ?";
		sql += " WHERE notice_no = ?";
		
		int res = 0;
		
		try {
			ps = conn.prepareStatement(sql);

			ps.setString(1, notice.getTitle());
			ps.setString(2, notice.getContent());
			ps.setString(3, notice.getNoticeImp());
			ps.setInt(4, notice.getNoticeNo());
			
			res = ps.executeUpdate();
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return res;
	}
	
	@Override
	public Map<String, Integer> selectByPostdate(Connection conn) {
		
		//요일별 게시글 수 조회
		String sql = "";
		sql += "select";
		sql += " (select count(to_char(create_date, 'DY')) from discoverboard where to_char(create_date, 'DY')='월'";
		sql += " and to_char(create_date, 'YYYYMMDD') between to_char(sysdate-6, 'YYYYMMDD') and to_char(sysdate, 'YYYYMMDD')) as MON,";
		sql += " (select count(to_char(create_date, 'DY')) from discoverboard where to_char(create_date, 'DY')='화'";
		sql += " and to_char(create_date, 'YYYYMMDD') between to_char(sysdate-6, 'YYYYMMDD') and to_char(sysdate, 'YYYYMMDD')) as TUE,";
		sql += " (select count(to_char(create_date, 'DY')) from discoverboard where to_char(create_date, 'DY')='수'";
		sql += " and to_char(create_date, 'YYYYMMDD') between to_char(sysdate-6, 'YYYYMMDD') and to_char(sysdate, 'YYYYMMDD')) as WEN,";
		sql += " (select count(to_char(create_date, 'DY')) from discoverboard where to_char(create_date, 'DY')='목' ";
		sql += " and to_char(create_date, 'YYYYMMDD') between to_char(sysdate-6, 'YYYYMMDD') and to_char(sysdate, 'YYYYMMDD')) as TUR,";
		sql += " (select count(to_char(create_date, 'DY')) from discoverboard where to_char(create_date, 'DY')='금'";
		sql += " and to_char(create_date, 'YYYYMMDD') between to_char(sysdate-6, 'YYYYMMDD') and to_char(sysdate, 'YYYYMMDD')) as FRI,";
		sql += " (select count(to_char(create_date, 'DY')) from discoverboard where to_char(create_date, 'DY')='토'";
		sql += " and to_char(create_date, 'YYYYMMDD') between to_char(sysdate-6, 'YYYYMMDD') and to_char(sysdate, 'YYYYMMDD')) as SAT,";
		sql += " (select count(to_char(create_date, 'DY')) from discoverboard where to_char(create_date, 'DY')='일'";
		sql += " and to_char(create_date, 'YYYYMMDD') between to_char(sysdate-6, 'YYYYMMDD') and to_char(sysdate, 'YYYYMMDD')) as SUN";
		sql += " from findboard";
		sql += " where rownum=1";
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		try {
			ps = conn.prepareStatement(sql); 
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				map.put("mon", rs.getInt("mon"));
				map.put("tue", rs.getInt("tue"));
				map.put("wen", rs.getInt("wen"));
				map.put("tur", rs.getInt("tur"));
				map.put("fri", rs.getInt("fri"));
				map.put("sat", rs.getInt("sat"));
				map.put("sun", rs.getInt("sun"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return map;
	}
	
	@Override
	public Map<String, Integer> selectByFindTextCnt(Connection conn) {

		String sql = "";
		sql += "SELECT count(*) count, count(find_complete) comCnt FROM findboard";
		
		Map<String, Integer> map = new HashMap<>();
		
		try {
			ps = conn.prepareStatement(sql);

			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				map.put("totalCnt", rs.getInt("count"));
				map.put("completeCnt", rs.getInt("comCnt"));
				
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return map;
	}
	
}
