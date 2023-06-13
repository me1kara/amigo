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
	private String starsTotalCount ="";
	private String selectReviewListByUserNo = "";
	private String selectReviewListBySitNo ="";
	

	@PostConstruct
	public void getSqlPropeties() {
		selectReviewList                  = environment.getProperty("selectReviewList");
		selectReviewListByUserAddr        = environment.getProperty("selectReviewListByUserAddr");
		selectStarCount                   = environment.getProperty("selectStarCount");
		insertReview                      = environment.getProperty("insertReview");
		deleteReview                      = environment.getProperty("deleteReview");
		starsTotalCount                   = environment.getProperty("starsTotalCount");
		selectReviewListByUserNo          = environment.getProperty("selectReviewListByUserNo");
		selectReviewListBySitNo           = environment.getProperty("selectReviewListBySitNo");
	}
	
	// 총 리뷰 다뜨게하기
	public List<ReviewVO> getReviewList(ReviewVO review) {
		
		System.out.println(selectReviewList);
		return jdbcTemplate.query(selectReviewList, new ReviewRowMapper());
	}
	
	// 펫시터 한명당 총리뷰 02/13
	public List<ReviewVO> getReviewListBySitNo(int sit_no) {
		System.out.println(selectReviewListBySitNo);
		Object[] args = { sit_no };
		return jdbcTemplate.query(selectReviewListBySitNo, args, new ReviewRowMapper());
	}

	//  리뷰 쓰기 아래는 별점 매기기???
	public ReviewVO insertReview(ReviewVO review) {
		
		System.out.println(insertReview);
		
		jdbcTemplate.update(insertReview, review.getSit_no(), review.getUser_no(), 
				review.getStar_cnt(), review.getRev_content());
		return review;	
	}
	
	//  리뷰 삭제하기
	public int deleteReview(int rev_no) {
		System.out.println(deleteReview + "번 삭제");
		int delRev = jdbcTemplate.update(deleteReview, rev_no);
		return delRev;	
	}
	
	//  강아지 마릿수, 총리뷰수, 별점당 리뷰갯수 세기
	
	
	public int dogRowCount() {
		
		try {
			return jdbcTemplate.queryForObject("SELECT COUNT(*) FROM dog", Integer.class);
		} catch (Exception e) {
			return 0;
		}
		
		
		}
	
	public double starsAverage() {
		return jdbcTemplate.queryForObject("select round(AVG(star_cnt),2) from sit_review", Double.class);
	}
	
	public double starsAveragePerSit(int sit_no) {
		
		Object[] args = {sit_no};
		return jdbcTemplate.queryForObject("select round(AVG(star_cnt),2) from sit_review where sit_no = ?", args, Double.class);
	}
	
	public int starsTotalCount() {
		return jdbcTemplate.queryForObject("select count(*) from sit_review", Integer.class);
	}
	
	public int starsTotalCountBySit(int sit_no) {
		
		Object[] args = {sit_no};
		return jdbcTemplate.queryForObject("select count(*) from sit_review where sit_no = ?", args, Integer.class);
	}
	
	public int ssrc1() { 
		return jdbcTemplate.queryForObject("select count(*) from sit_review where star_cnt = ?", Integer.class, 1);
	}
	
	public int ssrc2() {
		return jdbcTemplate.queryForObject("select count(*) from sit_review where star_cnt = ?", Integer.class, 2);
	}
	
	public int ssrc3() {
		return jdbcTemplate.queryForObject("select count(*) from sit_review where star_cnt = ?", Integer.class, 3);
	}
	
	public int ssrc4() {
		return jdbcTemplate.queryForObject("select count(*) from sit_review where star_cnt = ?", Integer.class, 4);
	}
	
	public int ssrc5() {
		return jdbcTemplate.queryForObject("select count(*) from sit_review where star_cnt = ?", Integer.class, 5);
	}
	
	public int selectReviewListByUserNo() {
		return jdbcTemplate.queryForObject("select sit_review.*, user.user_nick, user.user_photo, petsitter.sit_photo from sit_review inner join petsitter on sit_review.user_no = petsitter.user_no inner join user on petsitter.user_no = user.user_no where petsitter.user_no = ? order by sit_review.rev_date desc", Integer.class);
		
	}

	
	
//	public void starCat(int star_cnt) {
//		
//		
//	}
	

	
}
