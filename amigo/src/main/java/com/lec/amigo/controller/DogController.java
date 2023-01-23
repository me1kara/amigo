package com.lec.amigo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.lec.amigo.impl.DogServiceImpl;
import com.lec.amigo.vo.DogVO;
import com.lec.amigo.vo.UserVO;

@Controller
//@RequestMapping("/view/mypage")
//@ComponentScan(basePackages = {"com.lec.amigo", "com.lec.amigo.controller"})
public class DogController {

	@Autowired
	DogServiceImpl dogService;
	
	//
	@RequestMapping("/view/mypage/getDogList.do")
	public String getDogList(HttpSession sess, Model model,DogVO dog) {
	//UserVO user = (UserVO)sess.getAttribute("user");
	//int user_no = user.getUser_no();
	int user_no = 3;   // 일단 임의로 넣음.
	List<DogVO> dogList = dogService.getDogList(user_no);
	model.addAttribute("dogList", dogList);
	return "amigo_profile.jsp";
	}
		
	@RequestMapping(value="/view/mypage/insertDog.do", method = RequestMethod.POST)
	public String insertDog(HttpSession sess,Model model,DogVO dog) {	
	dogService.insertDog(dog);
	//UserVO user = (UserVO)sess.getAttribute("user");
	//int user_no = user.getUser_no();
	int user_no = 3;   // 일단 임의로 넣음.
	List<DogVO> dogList = dogService.getDogList(user_no);
	model.addAttribute("dogList", dogList);
	return "amigo_profile.jsp";
	}
	
	@RequestMapping(value="/view/mypage/updateDog.do", method = RequestMethod.GET)
	public String updateDog(HttpServletRequest req,Model model,DogVO dog) {
	int dog_no = Integer.parseInt(req.getParameter("dog_no"));
	model.addAttribute("dog", dogService.getDog(dog_no));
	return "amigo_profile_update.jsp";
	}
	
	@RequestMapping(value="/view/mypage/updateDog.do", method = RequestMethod.POST)
	public String updateDog(HttpSession sess,Model model,DogVO dog) {
	dogService.updateDog(dog);
	//UserVO user = (UserVO)sess.getAttribute("user");
	//int user_no = user.getUser_no();
	int user_no = 3;   // 일단 임의로 넣음.
	List<DogVO> dogList = dogService.getDogList(user_no);
	model.addAttribute("dogList", dogList);
	return "amigo_profile.jsp";
	}
	
	@RequestMapping(value="/view/mypage/deleteDog.do", method = RequestMethod.GET)
	public String deleteDog(HttpServletRequest req,HttpSession sess,Model model) {
	int dog_no = Integer.parseInt(req.getParameter("dog_no"));
	dogService.deleteDog(dog_no);
	//UserVO user = (UserVO)sess.getAttribute("user");
	//int user_no = user.getUser_no();
	int user_no = 3;   // 일단 임의로 넣음.
	List<DogVO> dogList = dogService.getDogList(user_no);
	model.addAttribute("dogList", dogList);
	return "amigo_profile.jsp";
	}
}
