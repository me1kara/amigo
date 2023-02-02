package com.lec.amigo.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.lec.amigo.vo.SitPageInfo;
import com.lec.amigo.vo.SitterVO;
import com.lec.amigo.vo.UserVO;


public interface SitterService {

	
	
	

	SitterVO getSitter(int sit_no);
	List<SitterVO> getSitList(SitterVO svo);
	SitterVO insertSitter(SitterVO svo);

	int deleteSitter(int user_no);
	int updateSitter(SitterVO svo, boolean sit_auth_is);
	void updateTypeS(SitterVO svo);
	void updateTypeU(SitterVO svo);

	
	
}
