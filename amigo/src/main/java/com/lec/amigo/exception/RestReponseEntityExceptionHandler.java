package com.lec.amigo.exception;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;

import lombok.extern.slf4j.Slf4j;

@RestControllerAdvice
@Slf4j
public class RestReponseEntityExceptionHandler {
	
	@ExceptionHandler(value=EmptyResultDataAccessException.class)
    protected ResponseEntity<String> jdbcTemplateException(RuntimeException ex, WebRequest request) {
	 	 log.error("qurry for object exception 발생 : "+ ex.getMessage());
		 return new ResponseEntity("not found", HttpStatus.NOT_FOUND);
    }
}
