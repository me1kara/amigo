package com.lec.amigo.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.lec.amigo.vo.SitPageInfo;
import com.lec.amigo.vo.SitterVO;


public interface SitterService {

	static SitPageInfo getSitPageInfo(int p, int perPage) {
		// TODO Auto-generated method stub
		return null;
	}

	int insertSitter(SitterVO svo);
	List<SitterVO> getSitList(SitterVO svo);
	
	
	
}
