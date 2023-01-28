package com.lec.amigo.service;

import java.util.List;

import com.lec.amigo.vo.ReplyVO;

public interface ReplyService {

	// 댓글 리스트
	List<ReplyVO> getReplyList(int ubd_no);
	
	// 댓글 수정
	int updateReply(ReplyVO reply);
	
	// 댓글 삭제
	int deleteReply(ReplyVO reply);
	
	// 댓글 등록
	ReplyVO insertReply(ReplyVO reply);

	// 댓글 조회
	ReplyVO getReply(ReplyVO reply);
}
