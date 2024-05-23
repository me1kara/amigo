package com.lec.amigo.chat;

import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketSession;

import com.lec.amigo.vo.UserVO;

public class ChatUtil {
	//http세션에 담긴 유저얻어오기
	public static UserVO getUser(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		UserVO loginUser = (UserVO)httpSession.get("user");
		
		if(loginUser!=null) {
			return loginUser;
		}else return null;
		
	}
	
	//json파싱용
	public  static JSONObject jsonToObjectParser(String jsonStr) {
		JSONParser parser = new JSONParser();
		JSONObject obj = null;
		try {
			obj = (JSONObject) parser.parse(jsonStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return obj;
	}


}
