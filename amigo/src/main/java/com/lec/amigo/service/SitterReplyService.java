package com.lec.amigo.service;

import java.util.List;

import com.lec.amigo.vo.SitterReplyVO;


public interface SitterReplyService {
	
	// 댓글 리스트
	List<SitterReplyVO> getSitterReplyList(int sbd_no);
	
	// 댓글 수정
	int updateSitterReply(SitterReplyVO sreply);
	
	// 댓글 삭제
	int deleteSitterReply(SitterReplyVO sreply);
	
	// 댓글 등록
	SitterReplyVO insertSitterReply(SitterReplyVO sreply);

	// 댓글 조회
	SitterReplyVO getSitterReply(SitterReplyVO sreply);
	

}
