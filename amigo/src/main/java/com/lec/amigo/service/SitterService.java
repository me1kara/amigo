package com.lec.amigo.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.lec.amigo.vo.SitPageInfo;
import com.lec.amigo.vo.SitterVO;
import com.lec.amigo.vo.UserVO;


public interface SitterService {  //시터를 추가하는것과 시터목록을 구현할 것.

	SitterVO getSitter(String birth);          // 시터VO에 대한 getter
	SitterVO sitterInfo(int sitno);         // 시터 프로필 정보를 보여주기

	SitterVO insertSitter(SitterVO svo);       // 시터 신청해서 승인나면 추가
	List<SitterVO> getSitList(SitterVO svo);   // 시터 리스트 뽑아보기.
	
	
	
}
