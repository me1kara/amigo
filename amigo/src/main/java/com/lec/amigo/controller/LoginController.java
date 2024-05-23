package com.lec.amigo.controller;


import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.lec.amigo.dao.UserDAO;
import com.lec.amigo.impl.BoardServiceImpl;
import com.lec.amigo.impl.ChatServiceImpl;
import com.lec.amigo.impl.DogServiceImpl;
import com.lec.amigo.impl.ReviewServiceImpl;
import com.lec.amigo.impl.SitterServiceImpl;
import com.lec.amigo.impl.UserServiceImpl;
import com.lec.amigo.vo.BoardVO;
import com.lec.amigo.vo.ChatRoom;
import com.lec.amigo.vo.ReviewVO;
import com.lec.amigo.vo.UserVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@PropertySource("classpath:config/uploadpath.properties")
@Slf4j
@RequiredArgsConstructor
public class LoginController {
	
	private final UserServiceImpl userService;
	private final BoardServiceImpl boardService;
	private final ChatServiceImpl chatService;
	private final ReviewServiceImpl reviewService;

	private String uploadFolder = "";
	private final Environment environment;
	
	@PostConstruct
	public void getUploadPathPropeties() {
		uploadFolder = environment.getProperty("uploadFolderUser");
	}

	// 로그인 화면 
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String login() {	
		return "view/login/login_form.jsp"; 
	}
	
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String login(UserVO userVO, HttpSession sess, BoardVO boardVO, ReviewVO review, Model model) {
		UserVO user = userService.getUser(userVO.getUser_email()); // 사용자가 입력한 이메일을 getUser메서드로 DB 있는지 찾기
		if(user == null || !user.getUser_pw().equals(userVO.getUser_pw())) {
			model.addAttribute("isLoginSuccess", false);
			return "view/login/login_form.jsp";
		}
		
		sess.setAttribute("user", user);
		// 메인페이지 실시간리뷰 현황판
		
		model.addAttribute("dogCount", reviewService.dogRowCount());
		model.addAttribute("starsAverage", reviewService.starsAverage());
		model.addAttribute("starsTotalCount", reviewService.starsTotalCount());
		model.addAttribute("board", boardService.getBoard(boardVO));
		model.addAttribute("revList",reviewService.getReviewList(review));	
		
		//실챗방
		List<ChatRoom> room_list = chatService.getRoomList(user.getUser_no());
		if(!room_list.isEmpty()) {
			sess.setAttribute("chat_room_list", room_list);
		}else {
			sess.removeAttribute("chat_room_list");
		}
//		usertype
//		if(user.getUser_type().equals("A")) {
//			sess.setAttribute("isAdmin", true);
//		} else {
//			sess.setAttribute("isAdmin", false);
//		}

		return "view/main.jsp";
		
	}
	
	// 로그아웃
	@RequestMapping(value ="/logout.do", method = RequestMethod.GET)
	public String logout(HttpSession sess) {
		sess.invalidate();
		return "home.jsp";
	}
	
	// 회원탈퇴
	@RequestMapping(value="/revoke.do", method = RequestMethod.GET)
	public String revoke(UserVO userVO) {
		if(userVO.getUser_photo() != "" || userVO.getUser_photo() != null) {
		String filename = userVO.getUser_photo();
		new File(uploadFolder+filename).delete();
		}
		userService.revokeUser(userVO.getUser_no());
		
		return "home.jsp";
	}
	
	// 이메일로 인증하기
	@PostMapping("/emailAuth.do")
	@ResponseBody
	public String emailAuth(String user_email) {	
		return userService.emailAuth(user_email);
	}
	
	// 비밀번호 찾기
	@RequestMapping(value = "/search_pwd.do", method = RequestMethod.GET)
	public String search_pwd() {
		return "view/login/search_pwd_form.jsp";
	}
	
	@RequestMapping(value = "/search_pwd.do", method = RequestMethod.POST)
	   public String search_pwq(UserVO vo, Model model) {
	     int cnt = userService.searchPw(vo);
	     if (cnt != 0) {
	 		model.addAttribute("msg", "이메일로 임시 비밀번호가 전송되었습니다.");
			model.addAttribute("url", "login.do");
			return "view/login/search_pwd_alert.jsp";
	     } else {
	    	model.addAttribute("msg", "등록된 이메일이 없습니다. 다시 입력해주세요.");
			model.addAttribute("url", "search_pwd.do");
			return "view/login/search_pwd_alert.jsp";
	     }
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
	public String signup(UserVO userVO, HttpServletRequest req, Model model) {
		
		userVO.setUser_addr(userVO.getUser_addr()+" "+req.getParameter("user_addr2"));		
		userService.insertUser(userVO);
		model.addAttribute("msg", "회원가입이 완료되었습니다. 로그인 해주세요.");
		model.addAttribute("url", "login.do");
		return "view/signup/sign_up_alert.jsp";
	}
	
	// 이메일 중복체크
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
	
	// 닉네임 중복체크
	@PostMapping("nickCheck.do")
	@ResponseBody
	public String nickCheck(@RequestParam("user_nick") String user_nick){
		int cnt = userService.nickCheck(user_nick);
		if (cnt != 0) {
			return "fail";
		} else {
			return "success";
		}
	}
	
	// 둘러보기
	@RequestMapping(value="/main_tour.do", method = RequestMethod.GET) 
	public String main_tour(BoardVO boardVO, Model model, ReviewVO review) {
		model.addAttribute("board", boardService.getBoard(boardVO));
		model.addAttribute("dogCount", reviewService.dogRowCount());
		model.addAttribute("starsAverage", reviewService.starsAverage());
		model.addAttribute("starsTotalCount", reviewService.starsTotalCount());
		model.addAttribute("revList", reviewService.getReviewList(review));	
		return "view/main_tour.jsp"; 
	}
	
	// 로고 클릭시 메인가기
	@RequestMapping(value="/main_home.do", method = RequestMethod.GET) 
	public String main_home(BoardVO boardVO, Model model, ReviewVO review) {
		model.addAttribute("board", boardService.getBoard(boardVO));
		model.addAttribute("dogCount", reviewService.dogRowCount());
		model.addAttribute("starsAverage", reviewService.starsAverage());
		model.addAttribute("starsTotalCount", reviewService.starsTotalCount());
		model.addAttribute("revList", reviewService.getReviewList(review));	
		return "view/main.jsp"; 
	}
	
	// 내 프로필
	@RequestMapping(value="/my_profile.do",  method = RequestMethod.GET)
	public String myProfile() {
		return "view/mypage/my_profile.jsp";
	}
	
	// 회원 정보 수정
	@RequestMapping(value="/updateUser.do", method = RequestMethod.POST)
	public String updateUser(Model model, UserVO userVO, HttpSession sess) throws IOException {
		
		MultipartFile uploadFile = userVO.getUploadFile();
		
		if (!uploadFile.isEmpty()) {
			new File(uploadFolder+userVO.getUser_photo()).delete();
			String fileName = uploadFile.getOriginalFilename();
			String fileExtension = fileName.substring(fileName.lastIndexOf("."),fileName.length());
			UUID uuid = UUID.randomUUID();
			String[] uuids = uuid.toString().split("-");
			String uniqueName = uuids[0] + fileExtension; // 랜덤 글자 생성
			uploadFile.transferTo(new File(uploadFolder + uniqueName));
			userVO.setUser_photo(uniqueName);
		} 
		
		// 바뀐 정보로 세션 정보 업데이트!
		sess.setAttribute("user", userService.updateUser(userVO));
		model.addAttribute("msg","정보가 정상적으로 수정되었습니다.");
		model.addAttribute("url","my_profile.do");
		
		return "view/comunity/alert.jsp";
	}
	

}
