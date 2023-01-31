package com.lec.amigo.controller;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lec.amigo.vo.UserVO;

@Controller
public class BookController {
	
	@RequestMapping(value = "/view/book/book.do", method = { RequestMethod.GET })
	public String book (HttpServletRequest req, HttpServletResponse resp) {
		
		String calr = req.getParameter("bookDate");
		System.out.println(calr);
	
		JSONParser parser = new JSONParser();
		JSONArray jms = null;
		try {
			jms = (JSONArray) parser.parse(calr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		for(int i=0; i< jms.size(); i++) {
			 JSONObject jsonObj = (JSONObject)jms.get(i);
			 System.out.println(jsonObj.get("title"));
			 System.out.println(jsonObj.get("start"));
			 System.out.println(jsonObj.get("end"));
		}
		
		
		//해당날짜,
		
		
		
		
		return "book_sitter_list.jsp";
	}
	
	
	@RequestMapping(value = "/view/book/sitter_profile.do", method = { RequestMethod.GET })
	public String getSitterProfile (HttpServletRequest req, HttpServletResponse resp, UserVO userVO) {
		
		System.out.println("예약폼");	
		return "/view/sitter/sitter_profile.jsp";
	}

	
}
