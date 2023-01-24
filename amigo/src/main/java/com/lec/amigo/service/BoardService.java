package com.lec.amigo.service;

import java.util.List;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.vo.BoardVO;

public interface BoardService {

	List<BoardVO> getBoardList(SearchVO searchVO);
	int getTotalRowCount(SearchVO searchVO);
	BoardVO getBoard(BoardVO board);
	void updateCount(int ubd_no);
	int updateBoard(BoardVO board);
	int deleteBoard(BoardVO board);
	List<BoardVO> selectCate(BoardVO board);
	BoardVO insertBoard(BoardVO board);
	
}
