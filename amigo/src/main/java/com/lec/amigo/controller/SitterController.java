package com.lec.amigo.controller;

import java.util.List;

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
import com.lec.amigo.impl.SitterServiceImpl;
import com.lec.amigo.service.SitterService;
import com.lec.amigo.vo.SitPageInfo;
import com.lec.amigo.vo.SitterVO;
import com.lec.amigo.vo.UserVO;



@Controller
public class SitterController {
	
	@Autowired
	private SitterServiceImpl sitterService;
	
	
	@RequestMapping("getSitterList.do")
	
	public String getSitList (SitterVO sittervo, Model model) {
		   
		List<SitterVO> sitList = sitterService.getSitList(sittervo);
		   
		   
		System.out.println(sittervo.toString());
		
		System.out.println("gggggggggggggggggggggggggggggggggggg");
		
		
		return null;
	}
	@RequestMapping(value="view/apply/sitter_apply_form.do", method=RequestMethod.POST) 
	
	public String insertSitter(SitterVO sittervo) {
	
		System.out.println("시터등록");
		
		System.out.println(sittervo.toString());
		sitterService.insertSitter(sittervo);
		
		return "my_page_list.jsp";
	}
	

}
	
	



