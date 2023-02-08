package com.lec.amigo.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.dao.BoardDAO;
import com.lec.amigo.dao.ReviewDAO;
import com.lec.amigo.service.BoardService;
import com.lec.amigo.service.ReviewService;
import com.lec.amigo.vo.BoardVO;
import com.lec.amigo.vo.HeartVO;
import com.lec.amigo.vo.ReviewVO;


@Service("reviewService")
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	ReviewDAO reviewDAO;

	@Override
	public List<ReviewVO> getReviewList(ReviewVO review) {
		return reviewDAO.getReviewList(review);
	}
	
	@Override
	public ReviewVO insertReview(ReviewVO review) {
		return reviewDAO.insertReview(review);
	}
	
	@Override
	public int deleteReview(int user_no) {
		return reviewDAO.deleteReview(user_no);
	}


//	@Override
//	public List<ReviewVO> getReviewListStar(ReviewVO review) {
//		return reviewDAO.getReviewListStar(review);
//	}


//	@Override
//	public void starCnt(int star_cnt) {
//		reviewDAO.getStarCnt(star_cnt)
//		
//	}


//	@Override
//	public List<ReviewVO> getReviewListStar(ReviewVO review) {
//		// TODO Auto-generated method stub
//		return null;
//	}


//	@Override
//	public void starCnt(int star_cnt) {
//		
//		
//	}

	
}
