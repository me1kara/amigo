package com.lec.amigo.impl;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lec.amigo.dao.SitterDAO;
import com.lec.amigo.service.SitterService;
import com.lec.amigo.vo.SitterVO;


@Service("sitterservice")
public class SitterServiceImpl implements SitterService {
	
	@Autowired
	SitterDAO sitterDAO;
	

	@Override
	public int insertSitter(SitterVO svo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<SitterVO> getSitList(SitterVO svo) {
		// TODO Auto-generated method stub
		return null;
	}

}
