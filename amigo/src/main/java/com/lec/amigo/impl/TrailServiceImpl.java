package com.lec.amigo.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lec.amigo.common.PagingVO;
import com.lec.amigo.dao.TrailDAO;
import com.lec.amigo.service.TrailService;
import com.lec.amigo.vo.TrailVO;

@Service("trailService")
public class TrailServiceImpl implements TrailService {

	@Autowired
	TrailDAO trailDAO;

	@Override
	public List<TrailVO> getTrailReviewList(int route_no,PagingVO pagingVO) {
		return trailDAO.getTrailReviewList(route_no,pagingVO);
	}

	@Override
	public int getTotalRowCount(int route_no) {
		return trailDAO.getTotalRowCount(route_no);
	}

	@Override
	public TrailVO insertTrailReview(TrailVO trail) {
		return trailDAO.insertTrailReview(trail);
	}

	@Override
	public int updateTrailReview(TrailVO trail) {
		return trailDAO.updateTraiReview(trail);
	}

	@Override
	public int deleteTrailReview(int walk_review_no) {
		return trailDAO.deleteTrailReview(walk_review_no);
	}

	@Override
	public TrailVO getTrailReview(int walk_review_no) {
		return trailDAO.selectTrailReview(walk_review_no);
	}

}
