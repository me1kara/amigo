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
	public SitterVO insertSitter(SitterVO svo) {
		// SitterDAO.insertSitter(svo);
		return null;
	}

	@Override
	public List<SitterVO> getSitList(SitterVO svo) {
		// 펫시터 리스트를 여기서 사용할 건가요?
		return null;
	}

	@Override
	public SitterVO SitterInfo(SitterVO svo) {
		// 펫시터에 대한 상세정보
		return null;
	}
	
	

}
