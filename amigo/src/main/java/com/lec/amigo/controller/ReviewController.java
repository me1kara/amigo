package com.lec.amigo.controller;

import java.io.File;


import java.util.List;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.lec.amigo.impl.ReviewServiceImpl;
import com.lec.amigo.vo.ReviewVO;



@Controller
@PropertySource("classpath:config/reviewsql.properties")
public class ReviewController {
	
	@Autowired
	private ReviewServiceImpl reviewService;
	
	@Autowired
	Environment environment;
	
	private String uploadFolder = "";
	
	@PostConstruct
	public void getUploadPathPropeties() {
		uploadFolder = environment.getProperty("uploadFolder");
	}
	
	// 전체글 목록
	@RequestMapping("/user_review_list.do")
	public String getReviewList (Model model, ReviewVO review) {
		
		System.out.println("리뷰리스트");
		List<ReviewVO> revList = reviewService.getReviewList(review);	
		model.addAttribute("revList", revList);
		return "view/review/review_list.jsp";
	}
	
	// 전체글  목록 (별점 또는 가까운순)
//	@RequestMapping("/user_review_list.do")
//	public String getReviewList (Model model, ReviewVO review) {
//		
//		System.out.println("리뷰리스트");
//		List<ReviewVO> revList = reviewService.getReviewList(review);	
//		model.addAttribute("revList", revList);
//		return "view/review/review_list.jsp";
//	}
	
	@RequestMapping(value="/view/review/user_review_insert.do", method=RequestMethod.GET) 
	public String insertReview() {
		
		System.out.println("리뷰 작성창");
		return "view/review/review_insert.jsp";
	}
	
	
	@RequestMapping(value="/view/review/user_review_insert.do", method=RequestMethod.POST) 
	public String insertReview(ReviewVO review) {
		
		System.out.println("리뷰를 등록합니다.");
		reviewService.insertReview(review);
		return "view/review/review_list.jsp";
	}
	

	@RequestMapping(value="/user_review_delete.do", method=RequestMethod.GET)
	public String user_review_delete(Model model, int user_no, ReviewVO review) {
		
		System.out.println("리뷰삭제");
		reviewService.deleteReview(user_no);
		return "view/review/review_list.jsp";
	}

	
	
}




