package com.lec.amigo.impl;


import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lec.amigo.dao.UserDAO;
import com.lec.amigo.service.UserService;
import com.lec.amigo.vo.UserVO;

@Service("userService")
public class UserServiceImpl implements UserService{
	
	@Autowired
	UserDAO userDAO;
	
	@Override
	public UserVO getUser(String email) {
		return userDAO.getUser(email);
	}

	@Override
	public void sendEmail(UserVO vo, String div) {
		
		UserVO user = userDAO.getUser(vo.getUser_email());
		
		// mail server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.naver.com";
		String hostSMTPid = "amigo931224";
		String hostSMTPpwd = "tjdgud!2";
	
		// 보내는 사람 Email, 제목, 내용
		String fromEmail = "amigo931224@naver.com";
		String fromName = "Amigo";
		String subject = "";
		String msg = "";
		
		if(div.equals("searchpw")) {
			subject = "Amigo 임시 비밀번호";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += user.getUser_name() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
			msg += "<p>임시 비밀번호 : ";
			msg += vo.getUser_pw() + "</p></div>";
		}
		
		// 받는 사람 E-Mail 주소
		String mail = vo.getUser_email();
		
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSL(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(465); //네이버 이용시 587

			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setTLS(true);
			email.addTo(mail, user.getUser_name());
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
			
		} catch (Exception e) {
			System.out.println("메일 발송 실패! " + e.getMessage());
		}
		
	}

	@Override
	   public void searchPw(HttpServletResponse res, UserVO vo) throws Exception {
	      res.setContentType("text/html;charset=utf-8");
	      UserVO user = userDAO.getUser(vo.getUser_email());
	      PrintWriter out = res.getWriter();
	      // 가입된 이메일이 아니면
	      if(!vo.getUser_email().equals(user.getUser_email())) {
	         out.print("등록되지 않은 이메일입니다.");
	         out.close();
	      }else {
	         // 임시 비밀번호 생성
	         String pw = "";
	         for (int i = 0; i < 12; i++) {
	            pw += (char) ((Math.random() * 26) + 97);
	         }
	         vo.setUser_pw(pw);
	         // 비밀번호 변경
	         
	         userDAO.updatePw(vo);
	         // 비밀번호 변경 메일 발송
	         sendEmail(vo, "searchpw");

	         out.print("이메일로 임시 비밀번호를 발송하였습니다.");
	         out.close();
	      }

	   }

	public UserVO insertUser(UserVO userVO) {
		return userDAO.insertUser(userVO);
		
	}

	public int emailCheck(String user_email) {
		return userDAO.emailCheck(user_email);
	}

}
