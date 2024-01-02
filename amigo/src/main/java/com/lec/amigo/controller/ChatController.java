package com.lec.amigo.controller;

import java.io.File;
import java.io.IOException;
import java.net.http.HttpRequest;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.lec.amigo.dao.ChatDAO;
import com.lec.amigo.impl.ChatServiceImpl;
import com.lec.amigo.impl.UserServiceImpl;
import com.lec.amigo.service.ChatService;
import com.lec.amigo.vo.ChatRoom;
import com.lec.amigo.vo.ChatVO;
import com.lec.amigo.vo.Payment;
import com.lec.amigo.vo.UserVO;

@Controller
public class ChatController {
	
	@Autowired
	@Qualifier("chatService")
	ChatServiceImpl chatService; 
	
	@Autowired
	UserServiceImpl userService;
	
	/*
	 * TODO : CL-1 채팅방목록 컨트롤러
	 */
	@GetMapping("/myChatList.do")
	public String getChatRoomList(HttpServletRequest req) {
		HttpSession session = req.getSession();
		UserVO user = (UserVO)session.getAttribute("user");
		int user_no = user.getUser_no();
		List<ChatRoom> roomUserList = chatService.getRoomUserList(user_no);
		List<UserVO> userList = userService.getUserList();
		List<ChatVO> myChatRoomList = chatService.getMyChatRoomList(user_no);
	
		req.setAttribute("myChatRoomList", myChatRoomList);
		req.setAttribute("userList", userList);
		req.setAttribute("roomUserList", roomUserList);
		
		return "/view/chat/myChatList.jsp";
	}
	/*
	 * TODO : CR-1 채팅방 컨트롤러
	 */
	@GetMapping("/chatList.do")
	public String getChatInRoom(HttpServletRequest req) {
		HttpSession session = req.getSession();
		UserVO user = (UserVO)session.getAttribute("user");
		int user_no = user.getUser_no();
		int index = Integer.parseInt(req.getParameter("index"));
		boolean checkRoom = chatService.checkRoomIndex(user_no, index);
		List<ChatVO> chatList = chatService.getChatList(index);
		
		req.setAttribute("checkRoom", checkRoom);
		req.setAttribute("chatList", chatList);
		
		return "view/chat/chatRoom.jsp";
	}
	
	/*
	 * TODO : CD-1 채팅방 삭제 컨트롤러
	 */
	@PostMapping("/ajax/deleteChatRoom.do")
	@ResponseBody 
	public int deleteChatRoom(HttpServletRequest req) {
		int index = Integer.parseInt(req.getParameter("index"));
		int row = 0;
		int user_no = ((UserVO)req.getSession().getAttribute("user")).getUser_no();
		row = chatService.exitRoom(index, user_no);
		return row;
	}
	
	
}
