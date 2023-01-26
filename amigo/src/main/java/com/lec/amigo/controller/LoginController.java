package com.lec.amigo.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lec.amigo.dao.UserDAO;
import com.lec.amigo.impl.UserServiceImpl;
import com.lec.amigo.vo.UserVO;

@Controller
public class LoginController {
	
	@Autowired
	UserServiceImpl userService;
	
	
	// 로그인 화면 
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String login() {	
		return "view/login/login_form.jsp"; 
	}
	
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String login(UserVO userVO, UserDAO userDAO, HttpSession sess) {
				
		UserVO user = userDAO.getUser(userVO.getUser_email());

		if(user == null) {
			sess.setAttribute("isLoginSuccess", false);
			return "view/login/login_form.jsp";
		}
		
		if(!user.getUser_pw().equals(userVO.getUser_pw())) {
			sess.setAttribute("matchedPassword", false);
			return "view/login/login_form.jsp";
		} else {
			sess.setAttribute("matchedPassword", true);
		}
		
		if(user.getUser_email().equals(userVO.getUser_email())) {
			sess.setAttribute("user", user);
			if(user.getUser_type().equals("A")) {
				sess.setAttribute("isAdmin", true);
			} else {
				sess.setAttribute("isAdmin", false);
			}
			return "view/main.jsp";
		} else {
			sess.setAttribute("isLoginSuccess", false);
			return "view/login/login_form.jsp";
		}
		
	}
	
	// 로그아웃
	@RequestMapping(value = "/logout.do", method = RequestMethod.GET)
	public String logout(HttpSession sess) {
		sess.invalidate();
		return "home.jsp";
	}
	
	
	// 비밀번호 찾기
	@RequestMapping(value = "/search_pwd.do", method = RequestMethod.GET)
	public String search_pwd() {
		return "view/login/search_pwd_form.jsp";
	}
	
	@RequestMapping(value = "/search_pwd.do", method = RequestMethod.POST)
	public void search_pwq(@ModelAttribute UserVO vo, HttpServletResponse res) throws Exception {
		userService.searchPw(res, vo);
	}
	
	// 약관동의
	@RequestMapping(value="/terms.do", method = RequestMethod.GET)
	public String terms() {	
		return "view/login/terms.jsp"; 
	} 
	
	// 회원가입
	@RequestMapping(value="/signup.do", method = RequestMethod.GET)
	public String signup() {
		return "view/signup/sign_up_form.jsp";
	}
	
	@RequestMapping(value="/signup.do", method = RequestMethod.POST)
	public String signup(UserVO userVO) {
		userService.insertUser(userVO);
		return "view/login/login_form.jsp";
	}
	
	// 아이디중복체크
	@PostMapping("emailCheck.do")
	@ResponseBody
	public String emailCheck(@RequestParam("user_email") String user_email){
		int cnt = userService.emailCheck(user_email);
		if (cnt != 0) {
			return "fail";
		} else {
			return "success";
		}
	}
	
}
