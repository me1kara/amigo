package com.lec.amigo.exception;

import java.net.http.HttpHeaders;
import java.sql.SQLException;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.slf4j.Slf4j;

@ControllerAdvice
@Slf4j
public class ResponseEntityExceptionHandler {
				 
	 @ExceptionHandler(NoHandlerFoundException.class)
	 @ResponseStatus(value= HttpStatus.NOT_FOUND) 
	 public String handle404(NoHandlerFoundException ex, Model model) {
		 log.error("404",ex.getRequestURL()); 
		 model.addAttribute("msg", "해당페이지는 존재하지 않습니다"); 
		 return "/view/error/error404.jsp"; 
	}	 
}
