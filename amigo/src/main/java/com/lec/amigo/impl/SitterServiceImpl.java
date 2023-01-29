package com.lec.amigo.impl;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lec.amigo.dao.SitterDAO;
import com.lec.amigo.service.SitterService;
import com.lec.amigo.vo.SitterVO;
import com.lec.amigo.vo.UserVO;


@Service("sitterService")
public class SitterServiceImpl implements SitterService {
	
	@Autowired
	SitterDAO sitterDAO;
	
	@Override
	public SitterVO getSitter(int sit_no) {
		// TODO Auto-generated method stub
		return sitterDAO.getSitter(sit_no);
	}

	@Override
	public List<SitterVO> getSitList(int user_no) {
		return sitterDAO.getSitList(user_no);
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
	public int deleteSitter(int sit_no) {
		
		return sitterDAO.deleteSitter(sit_no);
	}


	



}
