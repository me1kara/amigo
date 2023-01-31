package com.lec.amigo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.lec.amigo.dao.SitterDAO;
import com.lec.amigo.impl.SitterServiceImpl;
import com.lec.amigo.service.SitterService;
import com.lec.amigo.vo.SitPageInfo;
import com.lec.amigo.vo.SitterVO;
import com.lec.amigo.vo.UserVO;



@Controller
public class SitterController {
	
	@Autowired
	private SitterServiceImpl sitterService;
	
	@RequestMapping("/view/apply/getSitter.do")                    // 유저가 보는 시터정보(승인된시터만 get)
	public String getSitter(HttpSession sess, Model model, int sit_no) {
		System.out.println("시터의 상세 프로필");
		sitterService.getSitter(sit_no);
		return "sitter_profile.jsp";
		
	}
	

	@RequestMapping(value="/view/mypage/apply/sitter_join.do", method=RequestMethod.GET) 
	public String insertSitter() {
		
		System.out.println("1........................");
		
		return "/view/apply/sitter_join.jsp";
	}
	
	@PostMapping("/view/apply/sitter_join.do") //펫시터 개인정보가 있어 패킷을 숨겨 전송하고 싶어 post씀
	public String insertSitter(HttpSession sess, Model model, SitterVO svo) {				// 도메인에 데이터 등을 노출시키지 않으려고.
		System.out.println("시터등록");
		System.out.println(svo.toString());													// VO 에 데이터가 제대로 담겼는지 테스트 해봄
		sitterService.insertSitter(svo);
//		UserVO user = (UserVO)sess.getAttribute("user");
//		
//		int user_no = user.getUser_no();
//		List<SitterVO> sitList = sitterService.getSitList();
//		System.out.println("시터 리스트를 가져옵니다");                                 // 기능확인콘솔
//		model.addAttribute("sitList", sitList);
		return "/view/main.jsp";
	}
/*
    230127부터 사진업로드 구현하고, 로그인한 회원의 세션을 지원 페이지에 받아서 값은 admin에게 넘겨주고 유저의 페이지는 마이페이지 리스트로 리다이렉트 시키기.
    admin 이 승인하게 되면 유저에게 알림이 오고, 다시 로그인하면 파트너로 접속할 수 있도록 해주기
    시터를 누르면 시터에 대한 상세 프로필정보가 뜨도록 한다.
 */
	
	
	
	
	
	
	
/*	
  	230127 : 아래 코드는 펫시터 삭제 또는 수정이 필요하다면 이용할 예정.
 
	@RequestMapping(value="/view/apply/sitter_apply_form.do", method=RequestMethod.POST) 
	public String updateSitter(HttpSession sess, Model model, SitterVO svo) {
		System.out.println("시터수정");
		System.out.println(svo.toString());
		sitterService.updateSitter(svo);
		
		int user_no = 4;   // 임시
		List<SitterVO> sitList = sitterService.getSitList(user_no);
		model.addAttribute("sitList", sitList);
		return "my_page_list.jsp";
	}
	
	@RequestMapping(value="/view/apply/sitter_apply_form.do", method=RequestMethod.GET) 
	public String deleteSitter(HttpServletRequest req, HttpSession sess, Model model) {
		//int sit_no = Integer.parseInt(sit_no);
		int sit_no = Integer.parseInt(req.getParameter("sit_no"));
		System.out.println("시터삭제");
		
		sitterService.deleteSitter(sit_no);
		
		int user_no = 4;   // 임시
		List<SitterVO> sitList = sitterService.getSitList(user_no);
		model.addAttribute("sitList", sitList);
		return "my_page_list.jsp";
	}
*/	
	
	

}
	
/*	int sit_smoking = request.getParameter("sit_smoking").equals("true") ? 1 : 0;
		int sit_exp = request.getParameter("sit_exp").equals("true") ? 1 : 0;
		int sit_auth_is = request.getParameter("sit_auth_is").equals("true") ? 1 : 0;
		 sittervo.setSit_smoking(sit_smoking);
		 sittervo.setSit_exp(sit_exp);
		 sittervo.setSit_auth_is(sit_auth_is);*/
/*@RequestMapping("/view/mypage/getSitterList.do")
	
	public String getSitList (HttpSession sess, Model model, SitterVO sittervo) {
		   
		int user_no = 4; //임시
		List<SitterVO> sitList = sitterService.getSitList(user_no);
		model.addAttribute("sitList", sitList); 
		   
		System.out.println(sittervo.toString());
		System.out.println("gggggggggggggggggggggggggggggggggggg");
			
		return "my_page_list.jsp";
	}*/