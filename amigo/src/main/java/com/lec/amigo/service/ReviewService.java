package com.lec.amigo.service;

import java.util.List;

import com.lec.amigo.vo.ReviewVO;

public interface ReviewService {

	// 게시글 리스트
	List<ReviewVO> getReviewList(ReviewVO review);
	
	// 게시글 등록
	ReviewVO insertReview(ReviewVO review);
	
	// 게시글 삭제
	int deleteReview(int rev_no);
	
	// 별점순 리스트
	//List<ReviewVO> getReviewListStar(ReviewVO review);
	
	// 별점갯수
	//void starCnt(int star_cnt);
	
	// 강아지 마릿수
	int dogRowCount();

	// 별점 총평균
	double starsAverage();
	
	// 별점 1점일때
	int ssrc1();
	
	// 별점 2점일때
	int ssrc2();
	
	// 별점 3점일때
	int ssrc3();
	
	// 별점 4점일때
	int ssrc4();
	
	// 별점 5점일때
	int ssrc5();
	
	// 총 리뷰갯수
	int starsTotalCount();

}
