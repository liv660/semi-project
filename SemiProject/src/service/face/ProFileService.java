package service.face;

import javax.servlet.http.HttpServletRequest;

import dto.UserImg;

public interface ProFileService {

	public void upDatebynickbyImg(HttpServletRequest req);

	public UserImg getuserno(HttpServletRequest req);

	public UserImg viewimg(UserImg userimg);

	public void basicimg(HttpServletRequest req);

	public boolean getPw(HttpServletRequest req);

	public int getUserUpdate(HttpServletRequest req);

	public int getuserleave(HttpServletRequest req);

	

}
