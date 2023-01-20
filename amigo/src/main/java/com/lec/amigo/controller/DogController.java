package com.lec.amigo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.lec.amigo.impl.DogServiceImpl;
import com.lec.amigo.vo.DogVO;

@Controller
//@RequestMapping("/view/mypage")
//@ComponentScan(basePackages = {"com.lec.amigo", "com.lec.amigo.controller"})
public class DogController {

	@Autowired
	DogServiceImpl dogService;
	

	@RequestMapping("getDogList.do")
	public String getDogList(Model model,DogVO dog) {
	int user_no = dog.getUser_no();
	List<DogVO> dogList = dogService.getDogList(user_no);
	model.addAttribute("dogList", dogList);
	return null;
	}
	
	
	@RequestMapping(value="/view/mypage/insertDog.do", method = RequestMethod.POST)
	public String insertDog(DogVO dog) {	
		System.out.println(dog.toString());
		dogService.insertDog(dog);
		return "amigo_profile.jsp";
	}
	
	
	
}
