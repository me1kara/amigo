package com.lec.amigo.service;

import java.util.List;

import com.lec.amigo.common.PagingVO;
import com.lec.amigo.vo.DogVO;
import com.lec.amigo.vo.TrailVO;

public interface TrailService {
	
	// 게시글 리스트
	List<TrailVO> getTrailReviewList(int route_no,PagingVO pagingVO);
	
	// 페이징 관련
	int getTotalRowCount(int route_no);
	
	// 게시글 선택
	TrailVO getTrailReview(int walk_review_no);
	
	// 게시글 등록
	TrailVO insertTrailReview(TrailVO trail);
	
	// 게시글 수정
	int updateTrailReview(TrailVO trail);
		
	// 게시글 삭제
	int deleteTrailReview(int walk_review_no);
	
	
}
