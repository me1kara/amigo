package com.lec.amigo.service;

import java.util.List;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.vo.HeartVO;
import com.lec.amigo.vo.SitterBoardVO;

public interface SitterBoardService {

	// 시터 게시글 리스트
	List<SitterBoardVO> getSitterBoardList(SearchVO searchVO);
	
	// 시터 게시글 상세조회
	SitterBoardVO getSitterBoard(SitterBoardVO sboard);
	
	// 시터 게시글 등록
	SitterBoardVO insertSitterBoard(SitterBoardVO sboard);
	
	// 시터 게시글 수정
	int updateSitterBoard(SitterBoardVO sboard);
	
	// 시터 게시글 삭제
	int deleteSitterBoard(SitterBoardVO sboard);
	
	// 좋아요 했는지 찾기
	int findHeart(int user_no, int ubd_no);

	// 좋아요 등록
	int insertHeart(HeartVO heart);
	
	// 조회수
	void updateCount(int ubd_no);

	// 페이징 관련
	int getTotalRowCount(SearchVO searchVO);
	
}



