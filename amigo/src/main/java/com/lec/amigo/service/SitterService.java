package com.lec.amigo.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.vo.BoardVO;
import com.lec.amigo.vo.SitPageInfo;
import com.lec.amigo.vo.SitterVO;
import com.lec.amigo.vo.UserVO;


public interface SitterService {

	
	
	
	// 펫시터상세정보
	SitterVO getSitter(SitterVO svo);
	
	// 펫시터(신청)리스트(승인무관)
	List<SitterVO> getSitList(SearchVO searchVO);
	
	// 펫시터 페이징 관련
	int getTotalSitRowCount(SearchVO searchVO);
	int getCateRowCount(SearchVO searchVO, SitterVO svo);
	
	// 펫시터신청하기 
	SitterVO insertSitter(SitterVO svo);

	// 펫시터 실격또는 삭제
	int deleteSitter(int user_no);
	
	// 펫시터 승인하기
	int updateSitter(SitterVO svo, boolean sit_auth_is);
	
	// 승인된 펫시터 회원타입 바꾸기 ( U -> S )
	void updateTypeS(SitterVO svo);
	
	// 펫시터 삭제하면 회원타입 원복시키기 (아직 보류)
	void updateTypeU(SitterVO svo);

	
	
}
