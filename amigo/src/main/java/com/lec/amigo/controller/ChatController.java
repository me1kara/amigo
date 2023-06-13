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
		
		return "view/chat/chatRoom.jsp";
	}
	
	
	
	//내채팅방목록
	@GetMapping("/myChatList.do")
	public String getMyChatList(HttpServletRequest req) {
		System.out.println("입장확인용");
		HttpSession session = req.getSession();
		UserVO user = (UserVO)session.getAttribute("user");
		int user_no = user.getUser_no();
		
/*		List<ChatRoom> elseRoomList = chatService.getElseRoomList(user_no);
		ChatRoom checkRoom = chatService.getRoom(user_no);
		List<ChatVO> myChatList = chatService.getMyChatList(user_no);*/
		List<ChatRoom> roomUserList = chatService.getRoomUserList(user_no);
		List<UserVO> userList = userService.getUserList();
		List<ChatVO> myChatRoomList = chatService.getMyChatRoomList(user_no);
	
		req.setAttribute("myChatRoomList", myChatRoomList);
		req.setAttribute("userList", userList);
		req.setAttribute("roomUserList", roomUserList);
		//해당방의 유저
		/*
		 * 
		 * 
		 * //방있는지여부 체크 req.setAttribute("checkRoom", checkRoom);
		 * 
		 * //내채팅방(마지막채팅 있는것만) req.setAttribute("myChatList", myChatList);
		 * 
		 * //채팅이 없는 채팅방 req.setAttribute("elseRoomList", elseRoomList);
		 * 
		 * //유저이름 매칭용 req.setAttribute("userList", userList);
		 */
		
		return "/view/chat/myChatList.jsp";
	}
	
	/*
	 * @GetMapping("/exit_chat_room.do") public String
	 * delete_room(HttpServletRequest req) {
	 * 
	 * int index = Integer.parseInt(req.getParameter("room_index")); int user_no =
	 * ((UserVO)req.getSession().getAttribute("user")).getUser_no();
	 * chatService.exitRoom(index,user_no);
	 * 
	 * return "view/chat/myChatList.jsp"; }
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
