package com.lec.amigo.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lec.amigo.dao.ReplyDAO;
import com.lec.amigo.service.ReplyService;
import com.lec.amigo.vo.ReplyVO;

@Service("replyService")
public class ReplyServiceImpl implements ReplyService{

	@Autowired
	ReplyDAO replyDAO;
	
	@Override
	public List<ReplyVO> getReplyList(int ubd_no) {
		return replyDAO.getReplyList(ubd_no);
	}

	@Override
	public int updateReply(ReplyVO reply) {
		return replyDAO.updateReply(reply);
	}

	@Override
	public int deleteReply(ReplyVO reply) {
		return replyDAO.deleteReply(reply);
	}

	@Override
	public ReplyVO insertReply(ReplyVO reply) {
		return replyDAO.insertReply(reply);
	}

	@Override
	public ReplyVO getReply(ReplyVO reply) {
		return replyDAO.getReply(reply);
	}

}
