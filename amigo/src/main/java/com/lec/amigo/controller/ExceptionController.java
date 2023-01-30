//package com.lec.amigo.controller;
//
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.http.HttpStatus;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.ControllerAdvice;
//import org.springframework.web.bind.annotation.ExceptionHandler;
//import org.springframework.web.bind.annotation.ResponseStatus;
//import org.springframework.web.servlet.NoHandlerFoundException;
//
//@ControllerAdvice
//public class ExceptionController {
//	
//	public static final Logger logger= LoggerFactory.getLogger(ExceptionController.class);
//	
//	@ExceptionHandler(Exception.class)
//	public String handleException(Exception ex, Model model) {
//		logger.error("exception 발생 : {}"+ ex.getMessage());
//		model.addAttribute("msg", "에러발생!");
//		return "/view/error/error.jsp";
//	}
//	
//	@ExceptionHandler(NoHandlerFoundException.class)
//	@ResponseStatus(value= HttpStatus.NOT_FOUND)
//	public String handle404(NoHandlerFoundException ex, Model model) {
//		logger.error("404", ex.getRequestURL());
//		model.addAttribute("msg", "해당페이지는 존재하지 않습니다");
//		return "/view/error/error404.jsp";
//	}
//}
