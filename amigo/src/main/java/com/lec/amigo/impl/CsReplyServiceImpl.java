package com.lec.amigo.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lec.amigo.dao.CsReplyDAO;
import com.lec.amigo.service.CsReplyService;
import com.lec.amigo.vo.CsReplyVO;



@Service("csReplyService")
public class CsReplyServiceImpl implements CsReplyService{
	
	@Autowired
	CsReplyDAO csReplyDAO;

	@Override
	public List<CsReplyVO> getCsReplyList(int hbd_no) {
		return csReplyDAO.getCsReplyList(hbd_no);
	}

	@Override
	public int updateCsReply(CsReplyVO csreply) {
		return csReplyDAO.updateCsReply(csreply);
	}

	@Override
	public int deleteCsReply(CsReplyVO csreply) {
		return csReplyDAO.deleteCsReply(csreply);
	}

	@Override
	public CsReplyVO insertCsReply(CsReplyVO csreply) {
		return csReplyDAO.insertCsReply(csreply);
	}

	@Override
	public CsReplyVO getCsReply(CsReplyVO csreply) {
		return csReplyDAO.getCsReply(csreply);
	}

}
