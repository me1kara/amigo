package com.lec.amigo.controller;

import java.io.File;


import java.util.List;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
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
import com.lec.amigo.service.DogService;
import com.lec.amigo.vo.DogVO;
import com.lec.amigo.vo.ReviewVO;
import com.lec.amigo.vo.UserVO;



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
		int dogCount = reviewService.dogRowCount();
		double starsAverage = reviewService.starsAverage();
		int ssrc1 = reviewService.ssrc1();
		int ssrc2 = reviewService.ssrc2();
		int ssrc3 = reviewService.ssrc3();
		int ssrc4 = reviewService.ssrc4();
		int ssrc5 = reviewService.ssrc5();
		int starsTotalCount = reviewService.starsTotalCount();
		model.addAttribute("dogCount", dogCount);
		model.addAttribute("starsAverage", starsAverage);
		model.addAttribute("ssrc1", ssrc1);
		model.addAttribute("ssrc2", ssrc2);
		model.addAttribute("ssrc3", ssrc3);
		model.addAttribute("ssrc4", ssrc4);
		model.addAttribute("ssrc5", ssrc5);
		model.addAttribute("starsTotalCount", starsTotalCount);
		
		List<ReviewVO> revList = reviewService.getReviewList(review);	
		model.addAttribute("revList", revList);
		return "view/review/review_list.jsp";
	}
	
	// 특정 펫시터의 리뷰리스트
	@RequestMapping("/sit_review_list.do")
	public String getReviewList (HttpServletRequest req, ReviewVO review, Model model) {
		
		int sit_no = Integer.parseInt(req.getParameter("sit_no"));
		String user_name = (req.getParameter("user_name"));
		
		List<ReviewVO> rev = reviewService.getReviewListBySitNo(sit_no);
		model.addAttribute("rev", rev);
		
		req.setAttribute("user_name", user_name);
		req.setAttribute("sit_no", sit_no);
		
		return "view/sitter/sitter_profile.jsp";
		
	}
	
	
		

	// 리뷰 작성하는 페이지로 들어가기
	@RequestMapping(value="/view/review/user_review_insert.do", method=RequestMethod.GET) 
	public String insertReview(HttpServletRequest req) {
		
		System.out.println("리뷰 작성창");
		
		
		int sit_no = Integer.parseInt(req.getParameter("sit_no"));
		String user_name = (req.getParameter("user_name"));
		
		
		req.setAttribute("user_name", user_name);
		req.setAttribute("sit_no", sit_no);
		
		// return "view/review/review_insert.jsp";
		return "review_insert.jsp";
	}
	
	// 리뷰 작성해서 Submit 하기.
	@RequestMapping(value="/view/review/user_review_insert.do", method=RequestMethod.POST) 
	public String insertReview(ReviewVO review) {
		
		
		System.out.println("리뷰를 등록합니다.");
		System.out.println(review.toString());
		reviewService.insertReview(review);
		return "view/review/review_list.jsp";
		
	}
	
	// 리뷰 삭제하기
	@RequestMapping(value="/user_review_delete.do", method=RequestMethod.GET)
	public String user_review_delete(Model model, int user_no, ReviewVO review) {
		
		System.out.println("리뷰삭제");
		reviewService.deleteReview(user_no);
		return "view/review/review_list.jsp";
	}

	
	
}




