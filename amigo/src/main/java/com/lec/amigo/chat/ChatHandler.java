package com.lec.amigo.chat;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Qualifier;
import javax.websocket.Session;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.lec.amigo.chat.JDBCUtility.JDBCUtility;
import com.lec.amigo.dao.ChatDAO;
import com.lec.amigo.vo.ChatRoom;
import com.lec.amigo.vo.UserVO;

import lombok.RequiredArgsConstructor;


public class ChatHandler extends TextWebSocketHandler{
	
	private static HashMap<String, WebSocketSession> sessions = new HashMap<>();
	
	//세션구별용	
//	private Map<String, WebSocketSession> userSessions = new HashMap();
	
	//private Map<ChatRoom, WebSocketSession> indexSessions = new HashMap();
	
	ChatDAO chatDao = new ChatDAO();
	

	//private static final Logger logger = LoggerFactory.getLogger(ChatServer.class);
	//ChatDAO chatDao = new ChatDAO();
	
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("서버연결"+session.getId());	
		//세션리스트에 세션저장
		//유저-세션 저장
		sessions.put(session.getId(), session);
		
		/*
		ChatRoom ch = getRoomUser(session);
		if(ch!=null) {
			boolean chat_room_is = chatDao.getRoom(ch);		
			if(!chat_room_is)chatDao.setRoom(ch);
		};
		*/
		
	
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String msg = message.getPayload();
		
		String no=null;
		int roomIndex=0;
		String sendUser=null;
		String text=null;
		
		
		String[] strs = msg.split("#");
		
		
		if(strs!=null && strs.length==3) {
				no = strs[0];
				roomIndex = Integer.parseInt(strs[2]);
				if(no.equals("1")) {
				sendUser =strs[1];				
				}
		}else if(strs!=null && strs.length==4) {
				no = strs[0];
				sendUser =strs[1];
				text = strs[2];
				roomIndex = Integer.parseInt(strs[3]);
				
		}		
		
		//String id = chatDao.getSessionId(roomIndex);
		 
	
		int user_no = getUser(session).getUser_no();
		
		
		
		if (no.equals("1")) {
			// 누군가 접속 > 1#아무개
			
			//for(String id:idList) {
				for (String key : sessions.keySet()) {
					WebSocketSession s = sessions.get(key);
						if (s != session) { // 현재 접속자가 아닌 나머지 사람들				
							try {
								
								//세션의 로그인정보가 있으면
								if(getUser(s)!=null) {
									//해당 세션의 유저가 메세지의 룸번호를 가지고있는지 조회
									boolean checkIndex = chatDao.checkRoomIndex(getUser(s).getUser_no(), roomIndex);
									
									//해당 
									System.out.println("작성자인덱스:"+roomIndex+"다른방작성자:"+getUser(s).getUser_nick());				
									if(checkIndex) {
										s.sendMessage(new TextMessage("1#" + sendUser + "#"+roomIndex));
									}	
								}
								
										
								//s.getBasicRemote().sendText();
							} catch (IOException e) {
								e.printStackTrace();
							}
					
					}
				}
				//}
			//}
			
				
			
		} else if (no.equals("2")) {
			
			int a = chatDao.insertChat(roomIndex, user_no, text);
			int chat_no=0;
			if(a>0) {
			chat_no = chatDao.getLastChat(roomIndex).getChat_no();
			}
			System.out.println("챗넘버"+chat_no);
		//	for(String id:idList) {			
			// 누군가 메세지를 전송
			for (String key : sessions.keySet()) {
				WebSocketSession s = sessions.get(key);

					//if (s != session) { // 현재 접속자가 아닌 나머지 사람들							
						try {
							System.out.println("2#" + sendUser + ":" + text);
							//세션아이디로 인덱스를 구하고,
							//해당인덱스와 일치하면 문자를 보내면됨
							if(getUser(s)!=null) {				
								boolean checkIndex = chatDao.checkRoomIndex(getUser(s).getUser_no(), roomIndex);
								System.out.println("작성자인덱스:"+"다른방작성자:"+getUser(s).getUser_nick());
								if(checkIndex) {
									s.sendMessage(new TextMessage("2#" + sendUser +"#" + text+"#"+roomIndex+"#"+chat_no));							
								}
							}
							//s.getBasicRemote().sendText("2#" + snderId +"#" + text);
						} catch (IOException e) {
							e.printStackTrace();
						}
			
					//}
				//}
				
			//}
			}
		} else if (no.equals("3")) {
			
			System.out.println("호히히히");
			//for(String id:idList) {
			// 누군가 접속 > 3#아무개
					for (String key : sessions.keySet()) {
						WebSocketSession s = sessions.get(key);
				//	if(id.equals(s.getId())) {
						if (s != session) { // 현재 접속자가 아닌 나머지 사람들
							try {
								
								
								if(getUser(s)!=null) {
									boolean checkIndex = chatDao.checkRoomIndex(getUser(s).getUser_no(), roomIndex);
									
									System.out.println("작성자인덱스:"+roomIndex+"다른방작성자:"+getUser(s).getUser_nick());
								
									if(checkIndex) {
									s.sendMessage(new TextMessage("3#" + sendUser + "#"+roomIndex));
									}
								}
								
//								s.getBasicRemote().sendText("3#" + user + "#");
							} catch (IOException e) {
								e.printStackTrace();
							}
						}	
					//}
				}
				sessions.remove(session.getId());
			}else if(no.equals("4")) {
				System.out.println("삭제"+strs[1]);
				if(strs[1]!=null) {
					int chat_no = Integer.parseInt(strs[1]);
					boolean deleteCheck = chatDao.delete(chat_no);
					for (String key : sessions.keySet()) {
						WebSocketSession s = sessions.get(key);
				//	if(id.equals(s.getId())) {
						if (s != session) { // 현재 접속자가 아닌 나머지 사람들
							try {
								if(getUser(s)!=null) {
									boolean checkIndex = chatDao.checkRoomIndex(getUser(s).getUser_no(), roomIndex);
									
									System.out.println("작성자인덱스:"+roomIndex+"다른방작성자:"+getUser(s).getUser_nick());
								
									if(checkIndex) {
										System.out.println(chat_no+"방번호입니다");
									s.sendMessage(new TextMessage(chat_no + "#"+roomIndex));
									}
								}
								
//								s.getBasicRemote().sendText("3#" + user + "#");
							} catch (IOException e) {
								e.printStackTrace();
							}
						}	
					//}
				}
				}  
				
				
			}
		
			
		}	
	
	private UserVO getUser(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		UserVO loginUser = (UserVO)httpSession.get("user");
		
		if(loginUser!=null) {
			return loginUser;
		}else return null;
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessions.remove(session.getId());
		System.out.println(status.toString());
		System.out.println("닫혀용!");
		
	}
	
	
	public ChatRoom getRoomUser(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		ChatRoom room = (ChatRoom)httpSession.get("chatRoom");
		if(room.getChat_index()>0) {
			return room;
		}else {
			System.out.println("인덱스 조회 실패!");
			return null;
			
		}	
	}
	

}
