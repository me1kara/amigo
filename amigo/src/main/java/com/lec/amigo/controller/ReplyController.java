package com.lec.amigo.controller;


import javax.servlet.http.HttpServletRequest;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.service.ReplyService;
import com.lec.amigo.vo.ReplyVO;

@Controller
public class ReplyController {

	@Autowired
	ReplyService replyService;
	
	@RequestMapping(value="/insertReply.do", method=RequestMethod.POST)
	public String insertReply(ReplyVO reply, RedirectAttributes redirectAttributes, 
							  SearchVO searchVO, @RequestParam int cnt) {
		
		redirectAttributes.addAttribute("updateCount_is", "xyz");
		
		replyService.insertReply(reply);
		
		return "redirect:/user_board_detail.do?ubd_no="
		+ reply.getUbd_no() +"&user_no=" + reply.getUser_no()+"&cnt="+cnt
		+ "&curPage="+searchVO.getCurPage() + "&rowSizePerPage="+searchVO.getRowSizePerPage()
		+ "&searchType="+searchVO.getSearchType() + "&searchWord="+ searchVO.getSearchWord();
	}

	@RequestMapping(value="/deleteReply.do", method=RequestMethod.GET)
	public String deleteReply(ReplyVO reply, HttpServletRequest req, RedirectAttributes redirectAttributes, 
							  SearchVO searchVO, @RequestParam int cnt) {
		
		
		
		redirectAttributes.addAttribute("updateCount_is", "xyz");
		
		replyService.deleteReply(reply);
		return "redirect:/user_board_detail.do?ubd_no=" + req.getParameter("ubd_no") 
		+ "&user_no=" + req.getParameter("user_no")+"&cnt="+cnt
		+ "&curPage="+searchVO.getCurPage() + "&rowSizePerPage="+searchVO.getRowSizePerPage()
		+ "&searchType="+searchVO.getSearchType() + "&searchWord="+ searchVO.getSearchWord();
	}
	
	@RequestMapping(value="/updateReply.do", method=RequestMethod.GET)
	public String updateReply(ReplyVO reply, Model model, SearchVO searchVO, @RequestParam int cnt) {
		
		model.addAttribute("reply", replyService.getReply(reply));
		model.addAttribute("cnt", cnt);
		model.addAttribute("searchVO", searchVO);
		
		return "view/comunity/reply_update.jsp";
	}
	
	@RequestMapping(value="/updateReply.do", method=RequestMethod.POST)
	public String updateReply(ReplyVO reply, HttpServletRequest req, RedirectAttributes redirectAttributes,
			                  SearchVO searchVO, @RequestParam int cnt) {
		
		redirectAttributes.addAttribute("updateCount_is", "xyz");
		
		replyService.updateReply(reply);
		return "redirect:/user_board_detail.do?ubd_no=" + req.getParameter("ubd_no") 
				+ "&user_no=" + req.getParameter("user_no")+"&cnt="+cnt
				+ "&curPage="+searchVO.getCurPage() + "&rowSizePerPage="+searchVO.getRowSizePerPage()
				+ "&searchType="+searchVO.getSearchType() + "&searchWord="+ searchVO.getSearchWord();
	}
	
}
