package service.face;

import java.util.List;

import dto.DiscoverBoard;
import dto.FindBoard;
import dto.Notice;
import dto.ReviewUserJoin;

public interface MainService {

	public List<FindBoard> getFindBoard();

	public List<DiscoverBoard> getDiscoverBoard();

	public List<ReviewUserJoin> getReviewBoard();

	public List<Notice> getNoticeBoard();

}
