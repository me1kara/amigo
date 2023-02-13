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
	public int deleteReview(int rev_no) {
		return reviewDAO.deleteReview(rev_no);
	}

	@Override
	public int dogRowCount() {
		return reviewDAO.dogRowCount();
	}

	@Override
	public double starsAverage() {
		// TODO Auto-generated method stub
		return reviewDAO.starsAverage();
	}

	@Override
	public int ssrc1() {
		// TODO Auto-generated method stub
		return reviewDAO.ssrc1();
	}

	@Override
	public int ssrc2() {
		// TODO Auto-generated method stub
		return reviewDAO.ssrc2();
	}

	@Override
	public int ssrc3() {
		// TODO Auto-generated method stub
		return reviewDAO.ssrc3();
	}

	@Override
	public int ssrc4() {
		// TODO Auto-generated method stub
		return reviewDAO.ssrc4();
	}

	@Override
	public int ssrc5() {
		// TODO Auto-generated method stub
		return reviewDAO.ssrc5();
	}

	@Override
	public int starsTotalCount() {
		// TODO Auto-generated method stub
		return reviewDAO.starsTotalCount();
	}

	@Override
	public List<ReviewVO> getReviewListBySitNo(int sit_no) {
		// TODO Auto-generated method stub
		return reviewDAO.getReviewListBySitNo(sit_no);
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
