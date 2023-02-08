package com.lec.amigo.service;

import java.util.List;

import com.lec.amigo.vo.ReviewVO;

public interface ReviewService {

	// 게시글 리스트
	List<ReviewVO> getReviewList(ReviewVO review);
	
	// 게시글 등록
	ReviewVO insertReview(ReviewVO review);
	
	// 게시글 삭제
	int deleteReview(int user_no);
	
	// 별점순 리스트
	//List<ReviewVO> getReviewListStar(ReviewVO review);
	
	// 별점갯수
	//void starCnt(int star_cnt);
	
	


}
