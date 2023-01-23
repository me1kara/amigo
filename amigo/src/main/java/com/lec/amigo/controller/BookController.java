package com.lec.amigo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class BookController {
	
	@RequestMapping(value = "/view/book/book.do", method = { RequestMethod.GET })
	public String book (HttpServletRequest req, HttpServletResponse resp) {
		System.out.println("예약폼");
		return "book_sitter_list.jsp";
	}
	
	
	@RequestMapping(value = "/view/book/sitter_profile.do", method = { RequestMethod.GET })
	public String getSitterProfile (HttpServletRequest req, HttpServletResponse resp) {
		System.out.println("예약폼");	
		return "/view/sitter/sitter_profile.jsp";
	}
	
	
}
