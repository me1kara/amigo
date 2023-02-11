package com.lec.amigo.service;

import java.util.List;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.vo.CsBoardVO;

public interface CsBoardService {

	// 상담게시판 게시글 리스트
	List<CsBoardVO> getCsBoardList(SearchVO searchVO);
	
	// 상담게시판 게시글 상세조회
	CsBoardVO getCsBoard(CsBoardVO csboard);
	
	// 상담게시판 게시글 등록
	CsBoardVO insertCsBoard(CsBoardVO csboard);
	
	// 상담게시판 게시글 수정
	int updateCsBoard(CsBoardVO csboard);
	
	// 상담게시판 게시글 삭제
	int deleteCsBoard(CsBoardVO csboard);
	
	// 조회수
	void updateHbdCount(int hbd_no);

	// 페이징 관련
	int getTotalRowCount(SearchVO searchVO);
	
}



