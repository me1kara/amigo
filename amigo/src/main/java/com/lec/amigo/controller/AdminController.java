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


import com.lec.amigo.impl.SitterServiceImpl;
import com.lec.amigo.impl.UserServiceImpl;
import com.lec.amigo.vo.SitterVO;
import com.lec.amigo.vo.UserVO;



@Controller
public class AdminController {
	
	@Autowired
	private UserServiceImpl userService;
	
	@Autowired
	private SitterServiceImpl sitterService;
	
	// 펫시터 신청인 전체 리스트
	@RequestMapping(value="/view/admin/getSitList.do", method=RequestMethod.GET) //
	public String getSitList(Model model, SitterVO svo) {			
		
		
		System.out.println("펫시터 신청리스트 조회");
		List<SitterVO> sitList = sitterService.getSitList(svo);
		model.addAttribute("sitList", sitList);
		return "/view/admin/admin_sitList.jsp";
		
	}

	// 카테고리별 리스트
//	@RequestMapping("/view/admin/getSitListCate.do")
//	Public String GetSitListCate(Model model, SearchVO searchVO, SitterVO svo
//			@RequestParam(defaultValue="1") int curPage,
//			@RequestParam(defaultValue="10") int rowSizePerPage,
//			@RequestParam(defaultValue="") String searchCategory,
//			@RequestParam(defaultValue="") String searchType,
//			@RequestParam(defaultValue="") String searchWord)
//			{
//		
//		
//		
//		
//		
//			}
	
	
	@RequestMapping(value="/view/admin/updateSitter.do", method=RequestMethod.GET)
	public String updateSitter(Model model, SitterVO svo, boolean sit_auth_is) {
		System.out.println("승인합니다");//승인확인
		System.out.println(svo.toString()); // 투스트링
		sitterService.updateSitter(svo, true);  // 객체, 불리언(true)
		sitterService.updateTypeS(svo);         //  회원 테이블에서 타입이 S로 바뀜
		// 사용자수정로직.수정메서드(사용자번호)
				
		return "/view/admin/getSitList.do";  // 실제로 DAO의 매서드가 먹힘.
	}
	
	//@RequestMapping(value="")
	
 
//	@RequestMapping(value="/view/admin/updateSitter.do", method=RequestMethod.POST) 
//	public String updateSitter(Model model, SitterVO svo, boolean sit_auth_is) {

//		System.out.println(svo.toString());
//		sitterService.updateSitter(svo, svo.isSit_auth_is());
		
//		UserVO user = (UserVO)sess.getAttribute("user");        대상이 로그인한 상태가 아니어도 상관x
//		int user_no = user.getUser_no();
//		List<SitterVO> sitList = sitterService.getSitList();
//		model.addAttribute("sitList", sitList);
		
//		return "/view/admin/admin_sitList.jsp";
//	}
	
	@RequestMapping(value="/view/admin/deleteSitter.do", method=RequestMethod.GET) 
	public String deleteSitter(Model model, int user_no, SitterVO svo) {

		
		System.out.println("삭제합니다");
		sitterService.deleteSitter(user_no);
		sitterService.updateTypeU(svo);
		

		return "/view/admin/getSitList.do"; 
	}

	
	

}
	
/*	int sit_smoking = request.getParameter("sit_smoking").equals("true") ? 1 : 0;
		int sit_exp = request.getParameter("sit_exp").equals("true") ? 1 : 0;
		int sit_auth_is = request.getParameter("sit_auth_is").equals("true") ? 1 : 0;
		 sittervo.setSit_smoking(sit_smoking);
		 sittervo.setSit_exp(sit_exp);
		 sittervo.setSit_auth_is(sit_auth_is);*/
/*@RequestMapping("/view/mypage/getSitterList.do")
	
	public String getSitList (HttpSession sess, Model model, SitterVO sittervo) {
		   
		int user_no = 4; //?��?��
		List<SitterVO> sitList = sitterService.getSitList(user_no);
		model.addAttribute("sitList", sitList); 
		   
		System.out.println(sittervo.toString());
		System.out.println("gggggggggggggggggggggggggggggggggggg");
			
		return "my_page_list.jsp";
	}*/