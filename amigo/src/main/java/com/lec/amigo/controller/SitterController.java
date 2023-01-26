package com.lec.amigo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.lec.amigo.dao.SitterDAO;
import com.lec.amigo.service.SitterService;
import com.lec.amigo.vo.SitPageInfo;
import com.lec.amigo.vo.SitterVO;
import com.lec.amigo.vo.UserVO;



@Controller
public class SitterController {
	
	@Autowired
	private SitterService sitterService;
	
	
	// myPage에서 펫시터지원 의 a태그 주소 타고 들어오면 여기서 매핑.
	@RequestMapping("/sit_apply.do") // myPage에서 "펫시터 지원" a태그에있는 .do로끝나는 요청을 받아옴!
	public String sitter () {
		
		System.out.println("시터를 등록하나요~?"); //콘솔 확인용.
		    return "view/apply/sitter_apply_form.jsp"; //시터 지원폼으로
	}
	
	// 시터가입 화면->컨트롤러->서비스->다오
	@RequestMapping(value = "/sitter_apply_form.do", method = RequestMethod.POST)
	public String insertSitter (SitterVO svo){
		   
		System.out.println("추가해봐?");
		
		System.out.println(svo.toString());
		sitterService.insertSitter(svo);
	
		
		
		return "amigo_profile.jsp";  // 제출하면 다시 메인페이지로 가도록.
		}
	
	}


