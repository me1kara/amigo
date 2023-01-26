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
	
	@RequestMapping("sitter_profile.do")
	
	public String sitterInfo(@PathVariable int sit_no, Model model) {
		SitterVO svo = sitterService.sitterInfo(sit_no);
		model.addAttribute("svo", svo);
		return null;
	}
	
	@RequestMapping("/view/mypage/getSitterList.do")
	
	public String getSitList (HttpSession sess, Model model, SitterVO sittervo) {
		   
		int user_no = 4; //임시
		List<SitterVO> sitList = sitterService.getSitList(user_no);
		model.addAttribute("sitList", sitList); 
		   
		System.out.println(sittervo.toString());
		System.out.println("gggggggggggggggggggggggggggggggggggg");
			
		return "my_page_list.jsp";
	}
	
	@RequestMapping(value="view/sitter_apply_form.do", method=RequestMethod.GET) 
	public String insertSitter() {
		return "apply/sitter_apply_form.jsp";
	}
	
	
	@RequestMapping(value="view/apply/sitter_apply_form2.do", method=RequestMethod.GET) 
	public String insertSitter(HttpSession sess, Model model, SitterVO sittervo) {
		System.out.println("시터등록");
		System.out.println(sittervo.toString());
		sitterService.insertSitter(sittervo);
		
		int user_no = 4;   // 임시
		List<SitterVO> sitList = sitterService.getSitList(user_no);
		model.addAttribute("sitList", sitList);
		
		return "my_page_list.jsp";
	}
	

}
	
/*	int sit_smoking = request.getParameter("sit_smoking").equals("true") ? 1 : 0;
		int sit_exp = request.getParameter("sit_exp").equals("true") ? 1 : 0;
		int sit_auth_is = request.getParameter("sit_auth_is").equals("true") ? 1 : 0;
		 sittervo.setSit_smoking(sit_smoking);
		 sittervo.setSit_exp(sit_exp);
		 sittervo.setSit_auth_is(sit_auth_is);*/