package com.lec.amigo.service;

import java.util.List;

import com.lec.amigo.vo.CsReplyVO;


public interface CsReplyService {
	
	// 댓글 리스트
	List<CsReplyVO> getCsReplyList(int hbd_no);
	
	// 댓글 수정
	int updateCsReply(CsReplyVO csreply);
	
	// 댓글 삭제
	int deleteCsReply(CsReplyVO csreply);
	
	// 댓글 등록
	CsReplyVO insertCsReply(CsReplyVO csreply);

	// 댓글 조회
	CsReplyVO getCsReply(CsReplyVO csreply);
	

}
