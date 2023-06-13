package com.lec.amigo.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.dao.BoardDAO;
import com.lec.amigo.dao.ChatDAO;
import com.lec.amigo.service.BoardService;
import com.lec.amigo.service.ChatService;
import com.lec.amigo.vo.BoardVO;
import com.lec.amigo.vo.ChatRoom;
import com.lec.amigo.vo.ChatVO;
import com.lec.amigo.vo.HeartVO;


@Service("chatService")
public class ChatServiceImpl implements ChatService{
	
	@Autowired
	@Qualifier("chatDAO")
	ChatDAO chatDao;

	@Override
	public List<ChatVO> getChatList(int roomIndex) {
		// TODO Auto-generated method stub
		return chatDao.getChatList(roomIndex);
	}

	@Override
	public List<ChatVO> getMyChatList(int user_no) {
		// TODO Auto-generated method stub
		return chatDao.getMyChatList(user_no);
	}

	@Override
	public int insertChatMessage(int index, int user_no, String content) {
		return chatDao.insertChat(index, user_no, content);
	}

	@Override
	public void insertFile(int roomIndex, int user_no, String fileName) {
		chatDao.insertFile(roomIndex, user_no, fileName);
	}

	@Override
	public void setRoom(ChatRoom ch) {
		chatDao.setRoom(ch);
	}

	@Override
	public List<ChatRoom> getRoomList(int user_no) {
		return chatDao.getRoomList(user_no);
	}

	@Override
	public boolean deleteChat(int chat_no) {
		
		return chatDao.delete(chat_no);
	}
	
	public boolean checkRoomIndex(int user_no, int index) {
		return chatDao.checkRoomIndex(user_no, index);
	}
	
	public ChatRoom getRoom(int user_no) {
		return chatDao.getRoom(user_no);
	}
	
	public int getLastMyChatNo(int user_no, int roomIndex) {
		return chatDao.getLastMyChat(user_no, roomIndex); 
	}
	
	public ChatVO getLastChat(int roomIndex) {
		return chatDao.getLastChat(roomIndex); 
	}
	
	public String getFileName(int chat_no) {
		return chatDao.getFileName(chat_no); 
	}
	
	public List<ChatRoom> getElseRoomList(int chat_no) {
		return chatDao.getElseRoomList(chat_no);
	}


	public int exitRoom(int index, int user_no) {
		
		return chatDao.exitRoom(index,user_no);
		
	}

	public List<ChatRoom> getRoomUserList(int user_no) {
		// TODO Auto-generated method stub
		return chatDao.getRoomUserList(user_no);
	}

	public List<ChatVO> getMyChatRoomList(int user_no) {
		
		return chatDao.getMyChatRoomList(user_no);
	}
	
}
