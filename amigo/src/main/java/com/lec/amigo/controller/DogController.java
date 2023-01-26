package com.lec.amigo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.lec.amigo.service.DogService;
import com.lec.amigo.vo.DogVO;

@Controller
public class DogController {

	@Autowired
	DogService dogService;
	
	// home.jsp에서 들어오는 test
	@RequestMapping("/dog.do")
	public String dog() {
		
	System.out.println("도그입");
		return "view/mypage/amigo_profile_insert.jsp";
	}
	
	

	@RequestMapping("getDogList.do")
	public String getDogList(Model model,DogVO dog) {
	
	List<DogVO> dogList = dogService.getDogList(dog);
	model.addAttribute("dogList", dogList);
	return null;
	}
	
	
	@RequestMapping(value="view/mypage/insertDog.do", method=RequestMethod.POST)
	public String insertDog(DogVO dog) {
		System.out.println("dsad");
		
		System.out.println(dog.toString());
		dogService.insertDog(dog);
		
		
		return "amigo_profile.jsp";
	}
	
	
}
