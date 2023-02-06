package com.lec.amigo.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.dao.SitterBoardDAO;
import com.lec.amigo.service.SitterBoardService;
import com.lec.amigo.vo.HeartVO;
import com.lec.amigo.vo.SitterBoardVO;

@Service("sitterboardService")
public class SitterBoardServiceImpl implements SitterBoardService{

	@Autowired
	SitterBoardDAO sitterboardDAO;
	
	@Override
	public List<SitterBoardVO> getSitterBoardList(SearchVO searchVO) {
		return sitterboardDAO.getSitterBoardList(searchVO);
	}
	
	@Override
	public int getTotalRowCount(SearchVO searchVO) {
		return sitterboardDAO.getTotalRowCount(searchVO);
	}

	@Override
	public SitterBoardVO getSitterBoard(SitterBoardVO sboard) {
		return null;
	}

	@Override
	public SitterBoardVO insertSitterBoard(SitterBoardVO sboard) {
		return null;
	}

	@Override
	public int updateSitterBoard(SitterBoardVO sboard) {
		return 0;
	}

	@Override
	public int deleteSitterBoard(SitterBoardVO sboard) {
		return 0;
	}

	@Override
	public int findHeart(int user_no, int ubd_no) {
		return 0;
	}

	@Override
	public int insertHeart(HeartVO heart) {
		return 0;
	}

	@Override
	public void updateCount(int ubd_no) {
		
	}


}
