package com.lec.amigo.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.lec.amigo.dao.ChatDAO;
import com.lec.amigo.impl.ChatServiceImpl;
import com.lec.amigo.impl.UserServiceImpl;
import com.lec.amigo.service.ChatService;
import com.lec.amigo.vo.ChatRoom;
import com.lec.amigo.vo.ChatVO;
import com.lec.amigo.vo.UserVO;

@Controller
public class ChatController {
	
	@Autowired
	@Qualifier("chatService")
	ChatServiceImpl chatService; 
	
	@Autowired
	UserServiceImpl userService;
	
	@RequestMapping(value = "/chat.do", method = { RequestMethod.GET })
	public String chat (HttpServletRequest req, HttpServletResponse resp) {
		return "chat/chat.jsp";
	}
	
	@RequestMapping(value = "/chat/createChat.do", method = { RequestMethod.GET })
	public String createChat (HttpServletRequest req, HttpServletResponse resp) {
		return "my_chat_list.jsp";
	}
	
	@GetMapping("/chatList.do")
	public String getChatList(HttpServletRequest req) {
		HttpSession session = req.getSession();
		UserVO user = (UserVO)session.getAttribute("user");
		int user_no = user.getUser_no();
		int index = Integer.parseInt(req.getParameter("index"));
		boolean checkRoom = chatService.checkRoomIndex(user_no, index);
		List<ChatVO> chatList = chatService.getChatList(index);
		
		req.setAttribute("checkRoom", checkRoom);
		req.setAttribute("chatList", chatList);
		
		return "chat/chat.jsp";
	}
	
	@GetMapping("/myChatList.do")
	public String getMyChatList(HttpServletRequest req) {
		HttpSession session = req.getSession();
		UserVO user = (UserVO)session.getAttribute("user");
		int user_no = user.getUser_no();
		
		List<ChatRoom> elseRoomList = chatService.getElseRoomList(user_no);
		ChatRoom checkRoom = chatService.getRoom(user_no);
		List<ChatVO> myChatList = chatService.getMyChatList(user_no);
		
		List<UserVO> userList = userService.getUserList();
		
		req.setAttribute("elseRoomList", elseRoomList);
		req.setAttribute("checkRoom", checkRoom);
		req.setAttribute("myChatList", myChatList);
		req.setAttribute("userList", userList);
		
		return "/view/customer_service/customer_service_chat.jsp";
	}	
	
	
}
