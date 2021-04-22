package service.impl;

import java.sql.Connection;
import java.util.Date;
import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import common.JDBCTemplate;
import dao.face.FindUserDao;
import dao.impl.FindUserDaoImpl;
import dto.Usertb;
import service.face.FindUserService;
import util.HashNMacUtil;

public class FindUserServiceImpl implements FindUserService {
	
	class MyAuthentication extends Authenticator {
	    
		//id, pw 저장 객체 생성
	    PasswordAuthentication pa;
	 
	    public MyAuthentication(){
	        
	        String id = "";       //  ID
	        String pw = "";          //  비밀번호
	 
	        pa = new PasswordAuthentication(id, pw);
	      
	    }
	 
	    public PasswordAuthentication getPasswordAuthentication() {
	        return pa;
	    }
	}
	
	private FindUserDao findUserDao = new FindUserDaoImpl();
	Connection conn = null;
	
	@Override
	public Usertb getIdParam(HttpServletRequest req) {

		Usertb res = new Usertb();
		
		//name, email 파라미터값 저장
		res.setName(req.getParameter("name"));
		res.setEmail(req.getParameter("email"));

		return res;
	}
	
	@Override
	public String findUserId(Usertb param) {

		conn = JDBCTemplate.getConnection();
		
		//아이디 찾기 결과처리
		String id = findUserDao.selectUserId(conn, param);
		
		return id;
	}
	
	@Override
	public Usertb getPwParam(HttpServletRequest req) {

		Usertb res = new Usertb();
		
		//id, name, email 파라미터값 저장
		res.setUserId(req.getParameter("id"));
		res.setName(req.getParameter("name"));
		res.setEmail(req.getParameter("email"));

		return res;
	}
	
	@Override
	public Usertb findUserPw(Usertb param) {

		conn = JDBCTemplate.getConnection();
		
		//비밀번호 찾기 결과처리
		Usertb info = findUserDao.selectUserPw(conn, param);
		
		return info;
	}
	
	@Override
	public void sendNewPassward(String newPw, Usertb info) {

		// 메일 보내기 정보
	    Properties p = System.getProperties();
	    p.put("mail.smtp.starttls.enable", "true");    
	    p.put("mail.smtp.host", "smtp.naver.com");      // smtp 서버 주소
	    p.put("mail.smtp.auth","true");                 
	    p.put("mail.smtp.port", "587");                 //  포트
	       
	    Authenticator auth = new MyAuthentication();
	     
	    //session 생성 및  MimeMessage생성
	    Session session = Session.getDefaultInstance(p, auth);
	    MimeMessage msg = new MimeMessage(session);
	     
	    try{
	        //편지보낸시간
	        msg.setSentDate(new Date());
	        InternetAddress from = new InternetAddress() ;
	         
	        //발신자
	        from = new InternetAddress("zimmyrabbit@naver.com");
	         
	        // 이메일 발신자
	        msg.setFrom(from);
	        
	        //보낸사람 이름
	        msg.setFrom(new InternetAddress("zimmyrabbit@naver.com", "비밀번호 찾기"));
	         
	        // 이메일 수신자
	        InternetAddress to = new InternetAddress(info.getEmail());
	        msg.setRecipient(Message.RecipientType.TO, to);
	         
	        // 이메일 제목  ( 제목 / 타입 )
	        msg.setSubject("TEST5", "UTF-8");
	        
	        // 이메일 내용  ( 내용 / 타입 )
	        msg.setText("새로운 비밀번호 <br>" + newPw, "UTF-8");
	         
	        // 이메일 헤더
	        msg.setHeader("content-Type", "text/html");
	         
	        //메일보내기
	        javax.mail.Transport.send(msg, msg.getAllRecipients());
	        
	        System.out.println("Mail Sending Success");
	         
	    }catch (AddressException addr_e) {
	        addr_e.printStackTrace();
	    }catch (MessagingException msg_e) {
	        msg_e.printStackTrace();
	    }catch (Exception msg_e) {
	        msg_e.printStackTrace();
	    }
		
	}
	
	@Override
	public void changePw(String newPw, Usertb info) {

		conn = JDBCTemplate.getConnection();
		
		//비밀번호 Sha256 해쉬코드 암호화처리
		try {
			newPw = HashNMacUtil.EncBySha256(newPw);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//새 비밀번호 DB에 저장
		int res = findUserDao.insertNewPassword(conn, newPw, info);
		if(res > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		
		
	}
	


}
