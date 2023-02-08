package com.lec.amigo.impl;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.dao.SitterDAO;
import com.lec.amigo.service.SitterService;
import com.lec.amigo.vo.SitterVO;
import com.lec.amigo.vo.UserVO;


@Service("sitterService")
public class SitterServiceImpl implements SitterService {
	
	@Autowired
	SitterDAO sitterDAO;
	
	@Override
	public SitterVO getSitter(SitterVO svo) {
		// TODO Auto-generated method stub
		return sitterDAO.getSitter(svo);
	}

	@Override
	public List<SitterVO> getSitList(SearchVO searchVO) {
		return sitterDAO.getSitList(searchVO);
	}
	
	@Override
	public int getTotalSitRowCount(SearchVO searchVO) {
		
		return 0;
	}
	
	@Override
	public SitterVO insertSitter(SitterVO svo) {
		return sitterDAO.insertSitter(svo);
	}

	@Override
	public int updateSitter(SitterVO svo, boolean sit_auth_is) {
		
		return sitterDAO.updateSitter(svo, sit_auth_is);
	}
	
	@Override
	public int deleteSitter(int user_no) {
		
		return sitterDAO.deleteSitter(user_no);
	}

	@Override
	public void updateTypeS(SitterVO svo) {
		
		sitterDAO.updateTypeS(svo);
		
	}

	@Override
	public void updateTypeU(SitterVO svo) {
		
		sitterDAO.updateTypeU(svo);
		
	}


	@Override
	public int getCateRowCount(SearchVO searchVO, SitterVO svo) {
		// TODO Auto-generated method stub
		return 0;
	}



}