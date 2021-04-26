package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import common.JDBCTemplate;
import dao.face.ProFileDao;
import dto.Usertb;
import util.MyPaging;
import dto.MyBoard;
import dto.PurchaseList;
import dto.UserImg;
import dto.UserLeave;
import dto.Usertb;

public class ProFileDaoImpl implements ProFileDao {

	PreparedStatement ps = null;
	ResultSet rs = null;

	@Override
	public int updatebynick(Connection conn, Usertb usertb) {

		String sql ="";
		sql += "UPDATE usertb";
		sql += " SET nick = ?";
		sql += " WHERE 1 = 1";
		sql += " AND user_no = ?";

		int res = 0;

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, usertb.getNick());
			ps.setInt(2, usertb.getUserNo());

			res = ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}

		return res;
	}

	@Override
	public int insertbyimg(Connection conn, UserImg userimg)  {

		String sql ="";
		sql += "INSERT INTO userimg ( user_no, originname , storedname, filesize)";
		sql += " VALUES ( ?, ?, ?, ?)";
		int res = 0;

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userimg.getUserNo() );
			ps.setString(2, userimg.getOriginName() );
			ps.setString(3, userimg.getStroedName() );
			ps.setInt(4, userimg.getFilesize() );

			res = ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}

		return res;
	}

	@Override
	public int deletebyimg(Connection conn, UserImg userimg) {

		String sql = "";
		sql += "DELETE userimg";
		sql += " WHERE user_no = ?";

		int res = -1;

		try {
			//DB작업
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userimg.getUserNo());

			res = ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();

		} finally {
			JDBCTemplate.close(ps);
		}

		return res;
	}

	@Override
	public UserImg selectUserimg(Connection conn, UserImg userimg) {
		
		String sql = "SELECT * FROM userimg ";
		sql += " WHERE 1 = 1";
		sql += " AND user_no = ?";
		//객체생성
		UserImg useri = new UserImg();
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userimg.getUserNo() );
			rs = ps.executeQuery();
			
			while( rs.next() ) {
				
				useri.setUserNo( rs.getInt("user_no"));
				useri.setOriginName( rs.getString("originname"));
				useri.setStroedName( rs.getString("storedname"));
				useri.setFilesize( rs.getInt("filesize"));
				useri.setUpdateDate( rs.getDate("update_date"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return useri;
	}

	@Override
	public int basicinsert(Connection conn, UserImg userimg) {
		
		String sql = "";
		sql += "INSERT INTO userimg ( user_no )";
		sql += " VALUES ( ? ) ";
		
		int res = -1;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userimg.getUserNo() );
			
			res = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
			
		}
		
		return res;
	}

	

	@Override
	public String selectPw(Connection conn, int userno) {
		
		String sql = "";
		sql += "SELECT user_pw FROM usertb";
		sql += " WHERE user_no = ?";
		String Pw = new String();
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userno);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Pw = rs.getString("user_pw");
			}
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return Pw;
	}

	@Override
	public int updatebypw(Connection conn, Usertb usertb) {
		String sql ="";
		sql += "UPDATE usertb";
		sql += " SET user_pw = ?";
		sql += " WHERE 1 = 1";
		sql += " AND user_no = ?";

		int res = 0;

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, usertb.getUserPw());
			ps.setInt(2, usertb.getUserNo());

			res = ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}

		return res;
	}

	@Override
	public int updatebyemail(Connection conn, Usertb usertb) {
		String sql ="";
		sql += "UPDATE usertb";
		sql += " SET email = ?";
		sql += " WHERE 1 = 1";
		sql += " AND user_no = ?";

		int res = 0;

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, usertb.getEmail());
			ps.setInt(2, usertb.getUserNo());

			res = ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}

		return res;
	}

	@Override
	public int updatebyPhone(Connection conn, Usertb usertb) {
		String sql ="";
		sql += "UPDATE usertb";
		sql += " SET phone = ?";
		sql += " WHERE 1 = 1";
		sql += " AND user_no = ?";

		int res = 0;

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, usertb.getPhone());
			ps.setInt(2, usertb.getUserNo());

			res = ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}

		return res;
	}

	


	@Override
	public int updatepost(Connection conn, Usertb usertb) {
		String sql ="";
		sql += "UPDATE usertb";
		sql += " SET postnum = ?";
		sql += " WHERE 1 = 1";
		sql += " AND user_no = ?";

		int res = 0;

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, usertb.getPostnum());
			ps.setInt(2, usertb.getUserNo());

			res = ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}

		return res;
	}

	@Override
	public int updateaddr(Connection conn, Usertb usertb) {
		String sql ="";
		sql += "UPDATE usertb";
		sql += " SET addr = ?";
		sql += " WHERE 1 = 1";
		sql += " AND user_no = ?";

		int res = 0;

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, usertb.getAddr());
			ps.setInt(2, usertb.getUserNo());

			res = ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}

		return res;
	}


	@Override
	public int updatedetail(Connection conn, Usertb usertb) {
		
		String sql ="";
		sql += "UPDATE usertb";
		sql += " SET addr_detail = ?";
		sql += " WHERE 1 = 1";
		sql += " AND user_no = ?";

		int res = 0;

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, usertb.getAddrDetail());
			ps.setInt(2, usertb.getUserNo());

			res = ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}

		return res;
	}



	@Override
	public int deleteuser(Connection conn, int userno) {
		String sql ="";
		sql += "DELETE usertb";
		sql += " WHERE 1 = 1";
		sql += " AND user_no = ?";

		int res = 0;

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userno);

			res = ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}

		return res;
	}

	@Override
	public int insertleave(Connection conn, UserLeave userLeave) {
		
		String sql = "";
		sql += "INSERT INTO userleave ( leave_no, content)";
		sql += " VALUES ( userleave_seq.nextval, ? ) ";
		
		int res = -1;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, userLeave.getContent() );
			
			res = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
			
		}
		
		return res;
	}

	@Override
	public List<MyBoard> selectMyList(Connection conn, int userno) {
		
		String sql = "";
		sql += "SELECT * FROM (";
		sql += "    SELECT";
		sql += "        find_no, board_div, title, create_date";
		sql += "    FROM findboard";
		sql += "    UNION";
		sql += "    SELECT";
		sql += "        review_no, board_div, title, create_date";
		sql += "    FROM review_board";
		sql += "    UNION";
		sql += "    SELECT";
		sql += "        discover_no, board_div, title, create_date";
		sql += "    FROM discoverboard";
		sql += "    WHERE user_no = ?)";
		sql += " ORDER BY create_date desc";
		
		List<MyBoard> myBoard = new ArrayList<MyBoard>();
		
		String divone = "찾기 게시판";
		String divtwo = "발견 게시판";
		String divthree = "후기 게시판";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userno);
			
			rs = ps.executeQuery();
			
			while( rs.next() ) {
				
				MyBoard myb = new MyBoard();
				
				myb.setBorad_no( rs.getInt("find_no"));
				
				
				if ( rs.getInt("board_div") == 1) {
					myb.setBoard_div(divone);
					
				} else if(rs.getInt("board_div") == 2) {
					myb.setBoard_div(divtwo);
					
				} else if(rs.getInt("board_div") == 3) {
					myb.setBoard_div(divthree);
				}
				
				myb.setTitle( rs.getString("title"));
				myb.setCreate_date(rs.getDate("create_date"));
				
				myBoard.add(myb);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		
		return myBoard;
	}

	@Override
	public String selectByNick(Connection conn, int userno) {
		
		String sql = "";
		sql += "SELECT nick FROM usertb";
		sql += " WHERE user_no = ?";
		
		String nick = null;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userno);
			rs = ps.executeQuery();
			
			while( rs.next() ) {
				
				nick = rs.getString("nick");
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return nick;
	}

	@Override
	public int selectCntAll(Connection conn, int userno) {
		
		String sql = "";
		sql += "SELECT count(*) cnt FROM (";
		sql += "    SELECT";
		sql += "        find_no, board_div, title, create_date";
		sql += "    FROM findboard";
		sql += "    UNION";
		sql += "    SELECT";
		sql += "        review_no, board_div, title, create_date";
		sql += "    FROM review_board";
		sql += "    UNION";
		sql += "    SELECT";
		sql += "        discover_no, board_div, title, create_date";
		sql += "    FROM discoverboard";
		sql += "    WHERE user_no = ?)";
		//총 게시글 수
		int cnt = 0;
		
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userno);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				cnt = rs.getInt(1);
				
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
	public List<MyBoard> selectMyList(Connection conn, MyPaging myPaging, int userno) {
		
		String sql = "";
		sql += "SELECT * FROM (";
		sql += "    SELECT rownum rnum, B.* FROM (";
		sql += "        SELECT";
		sql += "            find_no, board_div, title, create_date";
		sql += "        FROM findboard";
		sql += "        UNION";
		sql += "        SELECT";
		sql += "            review_no, board_div, title, create_date";
		sql += "        FROM review_board";
		sql += "        UNION";
		sql += "        SELECT";
		sql += "            discover_no, board_div, title, create_date";
		sql += "        FROM discoverboard";
		sql += "        WHERE user_no = ?";
		sql += "    ) B";
		sql += "    ORDER BY create_date desc";
		sql += " ) BOARD";
		sql += " WHERE rnum BETWEEN ? AND ?";
		
		List<MyBoard> myBoard = new ArrayList<MyBoard>();
		
		String divone = "찾기 게시판";
		String divtwo = "발견 게시판";
		String divthree = "후기 게시판";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userno);
			ps.setInt(2, myPaging.getStartNo());
			ps.setInt(3, myPaging.getEndNo());
			
			rs = ps.executeQuery();
			
			while( rs.next() ) {
				
				MyBoard myb = new MyBoard();
				
				myb.setBorad_no( rs.getInt("find_no"));
				
				
				if ( rs.getInt("board_div") == 1) {
					myb.setBoard_div(divone);
					
				} else if(rs.getInt("board_div") == 2) {
					myb.setBoard_div(divtwo);
					
				} else if(rs.getInt("board_div") == 3) {
					myb.setBoard_div(divthree);
				}
				
				myb.setTitle( rs.getString("title"));
				myb.setCreate_date(rs.getDate("create_date"));
				
				myBoard.add(myb);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		
		return myBoard;
	}

	@Override
	public int deleteReviewImg(Connection conn, MyBoard myBoard) {
		String sql = "";
		sql += "DELETE review_img";
		sql += " WHERE 1 = 1";
		sql += " AND review_no = ?";
		int res = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, myBoard.getBorad_no());
			res = ps.executeUpdate();
		
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return res;
	}
	@Override
	public int deleteReviewBoard(Connection conn, MyBoard myBoard) {
		String sql = "";
		sql += "DELETE review_board";
		sql += " WHERE 1 = 1";
		sql += " 	AND user_no = ?";
		sql += " 		AND review_no = ?";
		int res = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, myBoard.getUser_no());
			ps.setInt(2, myBoard.getBorad_no());
			res = ps.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return res;
	}

	@Override
	public int deleteFindImg(Connection conn, MyBoard myBoard) {
		String sql = "";
		sql += "DELETE findimg";
		sql += " WHERE 1 = 1";
		sql += " AND find_no = ?";
		int res = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, myBoard.getBorad_no());
			res = ps.executeUpdate();
		
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return res;
	}

	@Override
	public int deleteFindBoard(Connection conn, MyBoard myBoard) {
		String sql = "";
		sql += "DELETE findboard";
		sql += " WHERE 1 = 1";
		sql += " 	AND user_no = ?";
		sql += " 		AND find_no = ?";
		int res = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, myBoard.getUser_no());
			ps.setInt(2, myBoard.getBorad_no());
			res = ps.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return res;
	}

	@Override
	public int deleteDiscoveryImg(Connection conn, MyBoard myBoard) {
		
		String sql = "";
		sql += "DELETE discoverimg";
		sql += " WHERE 1 = 1";
		sql += " AND find_no = ?";
		int res = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, myBoard.getBorad_no());
			res = ps.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return res;
	}

	@Override
	public int deleteDiscoveryBoard(Connection conn, MyBoard myBoard) {
		String sql = "";
		sql += "DELETE discoverboard";
		sql += " WHERE 1 = 1";
		sql += " 	AND user_no = ?";
		sql += " 		AND discover_no = ?";
		int res = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, myBoard.getUser_no());
			ps.setInt(2, myBoard.getBorad_no());
			res = ps.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		return res;
	}

	@Override
	public String selectByReviewStroed(Connection conn, MyBoard myBoard) {
		
		String sql = "";
		sql += "SELECT stored_img FROM review_img";
		sql += " WHERE review_no = ?";
		
		String StoredName = new String();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, myBoard.getBorad_no());
			rs = ps.executeQuery();
			
			
			while ( rs.next() ) {
				StoredName = rs.getString("stored_img");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return StoredName;
	}

	@Override
	public String selectByFindStroed(Connection conn, MyBoard myBoard) {
		String sql = "";
		sql += "SELECT stored_img FROM findimg";
		sql += " WHERE find_no = ?";
		
		String StoredName = new String();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, myBoard.getBorad_no());
			rs = ps.executeQuery();
			
			
			while ( rs.next() ) {
				StoredName = rs.getString("stored_img");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		return StoredName;
	}

	@Override
	public int insertmybasket(Connection conn, int userno, int productId) {
		
		String sql = "";
		sql += "INSERT INTO mypocket (mypocket_no, user_no, product_id)";
		sql += " VALUES ( mypoc_seq.nextval, ?, ? )";
		int res = 0;
			
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userno);
			ps.setInt(2, productId);
			
			res = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(ps);
		}
		
		
		return res;
	}

	@Override
	public List<PurchaseList> selectPurList(Connection conn, int userno) {

		String sql = "";
		sql += "SELECT";
		sql += "    U.product_id,U.user_no, product.product_name,product.price, product.stored_img, U.purchase_date";
		sql += " FROM userorder U,";
		sql += "    (SELECT";
		sql += "        PB.product_id, PB.product_name, PB.price, PI.stored_img";
		sql += "    FROM product PB,";
		sql += "        (SELECT PRODUCT_IMG.* FROM";
		sql += "            (SELECT";
		sql += "                row_number() over( partition by product_id order by image_no) rnum";
		sql += "                ,product_id , stored_img";
		sql += "            FROM product_img";
		sql += "        ) PRODUCT_IMG";
		sql += "        WHERE rnum = 1";
		sql += "    )PI";
		sql += "    WHERE PB.product_id = PI.product_id(+)";
		sql += "    ) product";
		sql += " WHERE U.product_id = product.product_id(+)";
		sql += "     AND user_no = ?";
		sql += " ORDER BY product_id DESC";
		
		List<PurchaseList> pl = new ArrayList<>();
		
		try {
			
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, userno);
			
			rs = ps.executeQuery();
			
			
			while( rs.next() ) {
				
				PurchaseList p = new PurchaseList();
				
				p.setProductId( rs.getInt("product_id") );
				p.setUserNo( rs.getInt("user_no") );
				p.setProductName( rs.getString("product_name") );
				p.setPrice( rs.getInt("price") );
				p.setStoredImg( rs.getString("stored_img") );
				p.setPurchaseDate(rs.getDate("purchase_date") );
				
				pl.add(p);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(ps);
		}
		
		
		return pl;
	}
		
		
		



	
}


