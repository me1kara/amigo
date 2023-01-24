package com.lec.amigo.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.dao.BoardDAO;
import com.lec.amigo.service.BoardService;
import com.lec.amigo.vo.BoardVO;


@Service("boardService")
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	BoardDAO boardDAO;

	@Override
	public List<BoardVO> getBoardList(SearchVO searchVO) {
		return boardDAO.getBoardList(searchVO);
	}

	@Override
	public int getTotalRowCount(SearchVO searchVO) {
		return boardDAO.getTotalRowCount(searchVO);
	}

	@Override
	public BoardVO getBoard(BoardVO board) {
		return boardDAO.getBoard(board);
	}

	@Override
	public void updateCount(int ubd_no) {
		boardDAO.updateCount(ubd_no);
	}

	@Override
	public int updateBoard(BoardVO board) {
		return boardDAO.updateBoard(board);
	}

	@Override
	public int deleteBoard(BoardVO board) {
		return boardDAO.deleteBoard(board);
	}

	@Override
	public List<BoardVO> selectCate(BoardVO board) {
		return boardDAO.selectCate(board);
	}

	@Override
	public BoardVO insertBoard(BoardVO board) {
		return boardDAO.insertBoard(board);
	}


	
	
}
