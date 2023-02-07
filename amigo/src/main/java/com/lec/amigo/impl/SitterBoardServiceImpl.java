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
		return sitterboardDAO.getSitterBoard(sboard);
	}

	@Override
	public SitterBoardVO insertSitterBoard(SitterBoardVO sboard) {
		return sitterboardDAO.insertSitterBoard(sboard);
	}

	@Override
	public int updateSitterBoard(SitterBoardVO sboard) {
		return sitterboardDAO.updateSitterBoard(sboard);
	}

	@Override
	public int deleteSitterBoard(SitterBoardVO sboard) {
		return sitterboardDAO.deleteSitterBoard(sboard);
	}

	@Override
	public void updateSbdCount(int sbd_no) {
		sitterboardDAO.updateSbdCount(sbd_no);
	}


}
