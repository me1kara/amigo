package com.lec.amigo.service;

import java.util.List;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.vo.BoardVO;
import com.lec.amigo.vo.HeartVO;

public interface BoardService {

	// 게시글 리스트
	List<BoardVO> getBoardList(SearchVO searchVO);
	
	// 인기글 리스트
	List<BoardVO> getBoardListLike(SearchVO searchVO);
	
	// 페이징 관련
	int getTotalRowCount(SearchVO searchVO);
	int getCateRowCount(SearchVO searchVO, BoardVO board);
	
	// 조회수
	void updateCount(int ubd_no);
	
	// 게시글 조회
	BoardVO getBoard(BoardVO board);
	
	// 게시글 수정
	int updateBoard(BoardVO board);
	
	// 게시글 삭제
	int deleteBoard(BoardVO board);
	
	// 게시글 등록
	BoardVO insertBoard(BoardVO board);
	
	// 카테고리별 리스트
	List<BoardVO> selectCate(BoardVO board, SearchVO searchVO);
	
	// 좋아요 했는지 찾기
	int findHeart(int user_no, int ubd_no);

	// 좋아요 등록
	int insertHeart(HeartVO heart);


	

}
