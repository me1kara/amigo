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
	
	// 시터가입 화면->컨트롤러->서비스->다오
	/*@RequestMapping(value = "getSitterList.do")
	public String SitApply (SitterVO sittervo, UserVO uservo, Model model) {
		   
		
		@RequestParam(defaultValue="1") int p,
		@RequestParam(defaultValue="4") int perPage) {

			SitPageInfo sitpageInfo = SitterService.getSitPageInfo(p, perPage);
			model.addAttribute("pageInfo", sitpageInfo);
			model.addAttribute("userList", SitterService.getSitterList(p, perPage));
			
		   
		   
		System.out.println(sittervo.toString());
		
		System.out.println("gggggggggggggggggggggggggggggggggggg");
		
		
		return null;
		}
	
	}*/

}
