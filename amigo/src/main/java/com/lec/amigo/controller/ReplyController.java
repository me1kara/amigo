package com.lec.amigo.controller;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.service.ReplyService;
import com.lec.amigo.vo.ReplyVO;

@Controller
@PropertySource("classpath:config/replysql.properties")
public class ReplyController {

	@Autowired
	ReplyService replyService;
	
	@RequestMapping(value="/insertReply.do", method=RequestMethod.POST)
	public String insertReply(ReplyVO reply, RedirectAttributes redirectAttributes, SearchVO searchVO) {
		
		redirectAttributes.addAttribute("updateCount_is", "xyz");
		
		replyService.insertReply(reply);
		return "redirect:/user_board_detail.do?ubd_no="+ reply.getUbd_no() +"&user_no=" + reply.getUser_no();
	}

	@RequestMapping(value="/deleteReply.do", method=RequestMethod.GET)
	public String deleteReply(ReplyVO reply, HttpServletRequest req, RedirectAttributes redirectAttributes) {
		
		redirectAttributes.addAttribute("updateCount_is", "xyz");
		
		replyService.deleteReply(reply);
		return "redirect:/user_board_detail.do?ubd_no=" + req.getParameter("ubd_no") + "&user_no=" + req.getParameter("user_no");
	}
	
	@RequestMapping(value="/updateReply.do", method=RequestMethod.GET)
	public String updateReply(ReplyVO reply, Model model) {
		model.addAttribute("reply", replyService.getReply(reply));
		return "view/comunity/reply_update.jsp";
	}
	
	@RequestMapping(value="/updateReply.do", method=RequestMethod.POST)
	public String updateReply(ReplyVO reply, HttpServletRequest req, RedirectAttributes redirectAttributes) {
		
		redirectAttributes.addAttribute("updateCount_is", "xyz");
		
		replyService.updateReply(reply);
		return "redirect:/user_board_detail.do?ubd_no=" + req.getParameter("ubd_no") + "&user_no=" + req.getParameter("user_no");
	}
	
}
