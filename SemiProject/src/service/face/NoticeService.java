package service.face;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import dto.Notice;
import dto.NoticeComment;
import dto.NoticeFile;
import util.Paging;

public interface NoticeService {

	public Paging getPaging(HttpServletRequest req);

	public List<Notice> viewList(Paging paging, Map<String, String> map);

	public Notice viewText(int noticeno);

	public void writeText(HttpServletRequest req);

	public List<NoticeFile> viewFile(int noticeno);

	public void removeText(int noticeno);

	public Notice getText(int noticeno);

	public int update(HttpServletRequest req);

	public Map<String, Integer> postByDate();

	public List<NoticeComment> viewCommnet(int noticeno);

	public NoticeComment getCommentParam(HttpServletRequest req);

	public void writeCommnet(NoticeComment param);

	public void removeComment(NoticeComment param);

	public void reviceComment(NoticeComment param);


}
