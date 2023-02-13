package com.lec.amigo.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.dao.CsBoardDAO;
import com.lec.amigo.service.CsBoardService;
import com.lec.amigo.vo.CsBoardVO;


@Service("csboardService")
public class CsBoardServiceImpl implements CsBoardService{

	@Autowired
	CsBoardDAO csboardDAO;
	
	@Override
	public List<CsBoardVO> getCsBoardList(SearchVO searchVO) {
		return csboardDAO.getCsBoardList(searchVO);
	}
	
	@Override
	public int getTotalRowCount(SearchVO searchVO) {
		return csboardDAO.getTotalRowCount(searchVO);
	}

	@Override
	public CsBoardVO getCsBoard(CsBoardVO csboard) {
		return csboardDAO.getCsBoard(csboard);
	}

	@Override
	public CsBoardVO insertCsBoard(CsBoardVO csboard) {
		return csboardDAO.insertCsBoard(csboard);
	}

	@Override
	public int updateCsBoard(CsBoardVO csboard) {
		return csboardDAO.updateCsBoard(csboard);
	}

	@Override
	public int deleteCsBoard(CsBoardVO csboard) {
		return csboardDAO.deleteCsBoard(csboard);
	}

	@Override
	public void updateHbdCount(int hbd_no) {
		csboardDAO.updateHbdCount(hbd_no);
	}




}
