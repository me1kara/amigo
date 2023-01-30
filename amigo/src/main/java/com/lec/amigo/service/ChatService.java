package com.lec.amigo.service;

import java.util.List;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.vo.BoardVO;
import com.lec.amigo.vo.ChatRoom;
import com.lec.amigo.vo.ChatVO;
import com.lec.amigo.vo.HeartVO;

public interface ChatService {

	// 방채팅리스트
	List<ChatVO> getChatList(int roomIndex);
	
	// 내 채팅목록
	List<ChatVO> getMyChatList(int user_no);
	
	// 채팅메세지보내기
	int insertChatMessage(int index, int user_no, String content);
	
	// 채팅파일보내기
	void insertFile(int roomIndex, int user_no, String fileName);
	
	// 채팅방등록
	void setRoom(ChatRoom ch);
	
	// 내가 가진 방목록
	List<ChatRoom> getRoomList(int user_no);
	
	// 채팅삭제
	boolean deleteChat(int chat_no);

	

}
