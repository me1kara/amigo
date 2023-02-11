package com.lec.amigo.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.service.CsReplyService;
import com.lec.amigo.vo.CsReplyVO;


@Controller
public class CsReplyController {
	
	@Autowired
	CsReplyService csReplyService;
	
	@RequestMapping(value="/insertCsReply.do", method=RequestMethod.POST)
	public String insertCsReply(CsReplyVO csreply, RedirectAttributes redirectAttributes, SearchVO searchVO) {
		
		redirectAttributes.addAttribute("updateCount_is", "xyz");
		
		csReplyService.insertCsReply(csreply);
		
		return "redirect:/cs_board_detail.do?hbd_no="
		+ csreply.getHbd_no() +"&user_no=" + csreply.getUser_no()
		+ "&curPage="+searchVO.getCurPage() + "&rowSizePerPage="+searchVO.getRowSizePerPage()
		+ "&searchType="+searchVO.getSearchType() + "&searchWord="+ searchVO.getSearchWord();
	}

	@RequestMapping(value="/deleteCsReply.do", method=RequestMethod.GET)
	public String deleteCsReply(CsReplyVO csreply, RedirectAttributes redirectAttributes, SearchVO searchVO) {

		redirectAttributes.addAttribute("updateCount_is", "xyz");
		
		csReplyService.deleteCsReply(csreply);
		return "redirect:/cs_board_detail.do?hbd_no=" + csreply.getHbd_no()
		+ "&user_no=" + csreply.getUser_no()
		+ "&curPage="+searchVO.getCurPage() + "&rowSizePerPage="+searchVO.getRowSizePerPage()
		+ "&searchType="+searchVO.getSearchType() + "&searchWord="+ searchVO.getSearchWord();
	}
	
	
	@RequestMapping(value="/updateCsReply.do", method=RequestMethod.GET)
	public String updateCsReply(CsReplyVO csreply, Model model, SearchVO searchVO) {
		
		model.addAttribute("csreply", csReplyService.getCsReply(csreply));
		model.addAttribute("searchVO", searchVO);
		
		return "view/cs/cs_reply_update.jsp";
	}
	
	@RequestMapping(value="/updateCsReply.do", method=RequestMethod.POST)
	public String updateCsReply(CsReplyVO csreply, RedirectAttributes redirectAttributes, SearchVO searchVO) {
		
		redirectAttributes.addAttribute("updateCount_is", "xyz");
		System.out.println(csreply.getHbd_r_cont());
		
		csReplyService.updateCsReply(csreply);
		
		
		return "redirect:/cs_board_detail.do?hbd_no=" + csreply.getHbd_no()
				+ "&user_no=" + csreply.getUser_no()
				+ "&curPage="+searchVO.getCurPage() + "&rowSizePerPage="+searchVO.getRowSizePerPage()
				+ "&searchType="+searchVO.getSearchType() + "&searchWord="+ searchVO.getSearchWord();
	}

}
