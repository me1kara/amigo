package com.lec.amigo.impl;

import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.lec.amigo.dao.UserDAO;
import com.lec.amigo.service.UserService;
import com.lec.amigo.vo.UserVO;

@Service("userService")
public class UserServiceImpl implements UserService{
	
	@Autowired
	UserDAO userDAO;
	
	@Autowired
	JavaMailSenderImpl mailSender;
	
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
		String hostSMTPpwd = "7SP15RPSLE9Q";
	
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
	   public int searchPw(UserVO vo) {
	      int cnt = userDAO.emailCheck(vo.getUser_email());
	      // 가입된 이메일이 아니면
	      if(cnt != 1) {
	    	  return 0;
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
	         return 1;
	      }

	   }

	public UserVO insertUser(UserVO userVO) {
		return userDAO.insertUser(userVO);
		
	}

	public int emailCheck(String user_email) {
		return userDAO.emailCheck(user_email);
	}
	

	public String emailAuth(String email) {
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;

		/* 이메일 보내기 */
        String setFrom = "amigo931224@naver.com";
        String toMail = email;
        String title = "회원가입 인증 이메일 입니다.";
        String content = 
                "Amigo 홈페이지를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + checkNum + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        
        try {
			MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            System.out.println("========================> 인증메일 발송 실패! " + e.getMessage());
        }
        
        return Integer.toString(checkNum);
 
	}

	public int nickCheck(String user_nick) {
		return userDAO.nickCheck(user_nick);
	}

	public void revokeUser(int user_no) {
		userDAO.revokeUser(user_no);
		
	}

	public UserVO updateUser(UserVO userVO) {
		return userDAO.updateUser(userVO);
		
	}

	public List<UserVO> getUserList() {
		// TODO Auto-generated method stub
		return userDAO.getUserList();
	}

	
}
