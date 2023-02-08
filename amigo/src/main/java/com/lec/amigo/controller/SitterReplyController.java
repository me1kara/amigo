package com.lec.amigo.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.service.SitterReplyService;
import com.lec.amigo.vo.SitterReplyVO;

@Controller
public class SitterReplyController {
	
	@Autowired
	SitterReplyService sitterReplyService;
	
	@RequestMapping(value="/insertSitterReply.do", method=RequestMethod.POST)
	public String insertSitterReply(SitterReplyVO sreply, RedirectAttributes redirectAttributes, SearchVO searchVO) {
		
		redirectAttributes.addAttribute("updateCount_is", "xyz");
		
		sitterReplyService.insertSitterReply(sreply);
		
		return "redirect:/sitter_board_detail.do?sbd_no="
		+ sreply.getSbd_no() +"&user_no=" + sreply.getUser_no()
		+ "&curPage="+searchVO.getCurPage() + "&rowSizePerPage="+searchVO.getRowSizePerPage()
		+ "&searchType="+searchVO.getSearchType() + "&searchWord="+ searchVO.getSearchWord();
	}

	@RequestMapping(value="/deleteSitterReply.do", method=RequestMethod.GET)
	public String deleteSitterReply(SitterReplyVO sreply, RedirectAttributes redirectAttributes, SearchVO searchVO) {

		redirectAttributes.addAttribute("updateCount_is", "xyz");
		
		sitterReplyService.deleteSitterReply(sreply);
		return "redirect:/sitter_board_detail.do?sbd_no=" + sreply.getSbd_no()
		+ "&user_no=" + sreply.getUser_no()
		+ "&curPage="+searchVO.getCurPage() + "&rowSizePerPage="+searchVO.getRowSizePerPage()
		+ "&searchType="+searchVO.getSearchType() + "&searchWord="+ searchVO.getSearchWord();
	}
	
	
	@RequestMapping(value="/updateSitterReply.do", method=RequestMethod.GET)
	public String updateSitterReply(SitterReplyVO sreply, Model model, SearchVO searchVO) {
		
		model.addAttribute("sreply", sitterReplyService.getSitterReply(sreply));
		model.addAttribute("searchVO", searchVO);
		
		return "view/comunity/sitter_reply_update.jsp";
	}
	
	@RequestMapping(value="/updateSitterReply.do", method=RequestMethod.POST)
	public String updateSitterReply(SitterReplyVO sreply, RedirectAttributes redirectAttributes, SearchVO searchVO) {
		
		redirectAttributes.addAttribute("updateCount_is", "xyz");
		
		sitterReplyService.updateSitterReply(sreply);
		return "redirect:/sitter_board_detail.do?sbd_no=" + sreply.getSbd_no()
				+ "&user_no=" + sreply.getUser_no()
				+ "&curPage="+searchVO.getCurPage() + "&rowSizePerPage="+searchVO.getRowSizePerPage()
				+ "&searchType="+searchVO.getSearchType() + "&searchWord="+ searchVO.getSearchWord();
	}

}
