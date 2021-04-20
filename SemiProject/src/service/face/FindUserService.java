package service.face;

import javax.servlet.http.HttpServletRequest;

import dto.Usertb;

public interface FindUserService {

	public Usertb getIdParam(HttpServletRequest req);

	public String findUserId(Usertb param);

	public Usertb getPwParam(HttpServletRequest req);

	public Usertb findUserPw(Usertb param);

	public void sendNewPassward(String newPw, Usertb info);

	public void changePw(String newPw, Usertb info);

}
