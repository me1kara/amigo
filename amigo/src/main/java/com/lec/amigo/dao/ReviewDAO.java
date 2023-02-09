package com.lec.amigo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.mapper.DogRowMapper;
import com.lec.amigo.mapper.ReviewRowMapper;
import com.lec.amigo.vo.ReviewVO;
import com.lec.amigo.vo.DogVO;
import com.lec.amigo.vo.HeartVO;



@Repository("reviewDAO")
@PropertySource("classpath:config/reviewsql.properties")
public class ReviewDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	Environment environment;
	
	private String sql = "";
	private String selectReviewList = "";                      // 펫시터 개인의 리뷰 전체 리스트
	private String selectReviewListByUserAddr = "";            // 상세주소 가까운순             
	private String selectStarCount = "";                       // 리뷰쓴 인원수  (별점 n개당)
	private String insertReview = "";                          // 리뷰 작성하기
	private String deleteReview = "";                          // 리뷰 삭제하기
	

	@PostConstruct
	public void getSqlPropeties() {
		selectReviewList                  = environment.getProperty("selectReviewList");
		selectReviewListByUserAddr        = environment.getProperty("selectReviewListByUserAddr");
		selectStarCount                   = environment.getProperty("selectStarCount");
		insertReview                      = environment.getProperty("insertReview ");
		deleteReview                      = environment.getProperty("deleteReview");
	}
	
	// 총 리뷰 다뜨게하기
	public List<ReviewVO> getReviewList(ReviewVO review) {
		
		System.out.println(selectReviewList);
		return jdbcTemplate.query(selectReviewList, new ReviewRowMapper());
	}

	//  리뷰 쓰기 아래는 별점 매기기???
	public ReviewVO insertReview(ReviewVO review) {
		
//		Map stars = new HashMap();
//
//		stars.put(1, "★☆☆☆☆");
//		ratingOptions.put(2, "★★☆☆☆");
//		ratingOptions.put(3, "★★★☆☆");
//		ratingOptions.put(4, "★★★★☆");
//		ratingOptions.put(5, "★★★★★");
//		model.addAttribute("ratingOptions", ratingOptions);
		
		
		jdbcTemplate.update(insertReview, review.getSit_no(), review.getUser_no(), 
				review.getStar_cnt(), review.getRev_content(), review.getUser_addr(), 
				review.getUser_nick(), review.getUser_name(), review.getUser_photo());
		return review;	
	}
	
	//  리뷰 삭제하기
	public int deleteReview(int rev_no) {
		System.out.println(deleteReview + "번 삭제");
		int delRev = jdbcTemplate.update(deleteReview, rev_no);
		return delRev;	
	}
	
//	public void starCat(int star_cnt) {
//		
//		
//	}
	

	
}
