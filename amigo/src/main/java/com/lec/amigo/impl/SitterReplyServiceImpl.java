package com.lec.amigo.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lec.amigo.dao.SitterReplyDAO;
import com.lec.amigo.service.SitterReplyService;
import com.lec.amigo.vo.SitterReplyVO;

@Service("sitterReplyService")
public class SitterReplyServiceImpl implements SitterReplyService{
	
	@Autowired
	SitterReplyDAO sitterReplyDAO;

	@Override
	public List<SitterReplyVO> getSitterReplyList(int sbd_no) {
		return sitterReplyDAO.getSitterReplyList(sbd_no);
	}

	@Override
	public int updateSitterReply(SitterReplyVO sreply) {
		return sitterReplyDAO.updateSitterReply(sreply);
	}

	@Override
	public int deleteSitterReply(SitterReplyVO sreply) {
		return sitterReplyDAO.deleteSitterReply(sreply);
	}

	@Override
	public SitterReplyVO insertSitterReply(SitterReplyVO sreply) {
		return sitterReplyDAO.insertSitterReply(sreply);
	}

	@Override
	public SitterReplyVO getSitterReply(SitterReplyVO sreply) {
		return sitterReplyDAO.getSitterReply(sreply);
	}

}
