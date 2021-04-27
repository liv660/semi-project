package dao.face;

import java.sql.Connection;
import java.util.List;

import dto.DiscoverBoard;
import dto.FindBoard;
import dto.Notice;
import dto.Product;
import dto.ReviewUserJoin;

public interface MainDao {

	public List<FindBoard> selectFindBoard(Connection conn);

	public List<DiscoverBoard> selectDiscoverBoard(Connection conn);

	public List<ReviewUserJoin> selectReviewBoard(Connection conn);

	public List<Notice> selectNoticeBoard(Connection conn);

	public List<Product> selectProductBoard(Connection conn);

}
