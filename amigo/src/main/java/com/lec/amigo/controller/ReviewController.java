package com.lec.amigo.controller;

import java.io.File;
import java.util.Date;
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
	public String getReviewList (Model model, ReviewVO review) {  // 메인페이지에서 총리뷰리스트를 보기 위함
		
		System.out.println("리뷰리스트");						  // 구동 확인
		int dogCount = reviewService.dogRowCount();               // n 마리의 amigo 가 함께합니다(강아지마릿수)
		double starsAverage = reviewService.starsAverage();
		int ssrc1 = reviewService.ssrc1();		                  // 각각 별이 n개일 때 리뷰 갯수
		int ssrc2 = reviewService.ssrc2();
		int ssrc3 = reviewService.ssrc3();
		int ssrc4 = reviewService.ssrc4();
		int ssrc5 = reviewService.ssrc5();
		int starsTotalCount = reviewService.starsTotalCount();    // 리뷰 자체의 총 갯수
		model.addAttribute("dogCount", dogCount);
		model.addAttribute("starsAverage", starsAverage);
		model.addAttribute("ssrc1", ssrc1);
		model.addAttribute("ssrc2", ssrc2);
		model.addAttribute("ssrc3", ssrc3);
		model.addAttribute("ssrc4", ssrc4);
		model.addAttribute("ssrc5", ssrc5);
		model.addAttribute("starsTotalCount", starsTotalCount);
		
		List<ReviewVO> revList = reviewService.getReviewList(review);	// 리뷰 리스트에
		model.addAttribute("revList", revList);							// 모델에 담아서 해당 리뷰리스트 페이지를 리턴한다.
		return "view/review/review_list.jsp";
	}
	
	
	
	// 특정 펫시터의 리뷰리스트
	@RequestMapping("/sit_review_list.do")
	public String getReviewList (HttpServletRequest req, ReviewVO review, Model model) {
		
		int sit_no = Integer.parseInt(req.getParameter("sit_no"));             // 도메인에서 리퀘스트객체를 통해 파라미터 가져오기
		String user_name = (req.getParameter("user_name"));                    // 여기서 'user_name' 은 대상 펫시터의 이름
		
		List<ReviewVO> rev = reviewService.getReviewListBySitNo(sit_no);
		System.out.println("리뷰리스트진입");
		model.addAttribute("rev", rev);
		
		req.setAttribute("user_name", user_name);
		req.setAttribute("sit_no", sit_no);
		
		return "view/review/sit_review_list.jsp";
		
	}
	
	// (예약하거나 이용한) 펫시터의 리뷰리스트
//	@RequestMapping("/reviewList.do")
//	public String getReviewList (HttpServletRequest req, ReviewVO review, Model model) {
//		
//		int sit_no = Integer.parseInt(req.getParameter("sit_no"));             // 도메인에서 리퀘스트객체를 통해 파라미터 가져오기
//		String user_name = (req.getParameter("user_name"));                    // 여기서 'user_name' 은 대상 펫시터의 이름
//		
//		List<ReviewVO> rev = reviewService.getReviewListBySitNo(sit_no);
//		System.out.println("리뷰리스트진입");
//		model.addAttribute("rev", rev);
//		
//		req.setAttribute("user_name", user_name);
//		req.setAttribute("sit_no", sit_no);
//		
//		return "view/sitter/sitter_profile.jsp";
//		
//	}
	
	
		

	// 리뷰 작성하는 페이지로 들어가기
	@RequestMapping(value="/view/review/user_review_insert.do", method=RequestMethod.GET)     // 펫시터 예약하면 상세 펫시터 정보에서 리뷰작성 버튼을 클릭 -> 펫시터 페이지로 들어감.
	public String insertReview(HttpServletRequest req) {
		
		System.out.println("리뷰 작성창");								
		
		int sit_no = Integer.parseInt(req.getParameter("sit_no"));	// 주소창에 파라미터 받기(String타입을을 Int로)
		String user_name = (req.getParameter("user_name"));         // 주소창에서 대상 펫시터이름도 같이 받아온다.
		
		
		req.setAttribute("user_name", user_name);
		req.setAttribute("sit_no", sit_no);
		
		// return "view/review/review_insert.jsp";
		return "review_insert.jsp";
	}
	
	// 리뷰 작성해서 Submit 하기.
	@RequestMapping(value="/view/review/user_review_insert.do", method=RequestMethod.POST)   
	public String insertReview(ReviewVO review) {
		
		
		System.out.println("리뷰를 등록합니다.");
		System.out.println(review.toString());						// 리뷰 VO 객체에 제대로 담겼는지 콘솔에서 toString로 확인해보기
		reviewService.insertReview(review);// Properties의 sql문을 실행
		
		return "/user_review_list.do";
		
	}
	
	// 리뷰 삭제하기
	@RequestMapping(value="/user_review_delete.do", method=RequestMethod.GET)
	public String user_review_delete(Model model, int user_no, ReviewVO review) {
		
		System.out.println("리뷰삭제");
		reviewService.deleteReview(user_no);
		return "/view/review/review_list.jsp";
	}

	
	
}




