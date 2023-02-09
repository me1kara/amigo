package com.lec.amigo.impl;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.dao.BoardDAO;
import com.lec.amigo.service.BoardService;
import com.lec.amigo.vo.BoardVO;
import com.lec.amigo.vo.HeartVO;


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
	public int getCateRowCount(SearchVO searchVO, BoardVO board) {
		return boardDAO.getCateRowCount(searchVO, board);
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
	public List<BoardVO> selectCate(BoardVO board, SearchVO searchVO) {
		return boardDAO.selectCate(board, searchVO);
	}

	@Override
	public BoardVO insertBoard(BoardVO board) {
		return boardDAO.insertBoard(board);
	}

	@Override
	public List<BoardVO> getBoardListLike(SearchVO searchVO) {
		return boardDAO.getBoardListLike(searchVO);
	}

	@Override
	public int findHeart(int user_no, int ubd_no) {
		return boardDAO.findHeart(user_no, ubd_no);
	}

	@Override
	public int insertHeart(HeartVO heart) {
		int result = 0;
		int find = findHeart(heart.getUser_no(), heart.getUbd_no());
		
		if(find==0) {
			result = boardDAO.insertHeart(heart);
		} else {
			boardDAO.deleteHeart(heart);
		}
		return result;
	}

	@Override
	public int countHeart(int udb_no) {
		return boardDAO.countHeart(udb_no);
	}

	
}
