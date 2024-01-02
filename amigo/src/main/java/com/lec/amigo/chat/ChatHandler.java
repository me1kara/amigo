package com.lec.amigo.chat;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.websocket.Session;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.lec.amigo.dao.ChatDAO;
import com.lec.amigo.impl.ChatServiceImpl;
import com.lec.amigo.vo.ChatRoom;
import com.lec.amigo.vo.UserVO;

import lombok.RequiredArgsConstructor;


public class ChatHandler extends TextWebSocketHandler{
	
	private static HashMap<String, WebSocketSession> sessions = new HashMap<>();
	private static final String FILE_UPLOAD_PATH = "C:/FTP/upload/img/chatImg/";

	private ChatServiceImpl chatServiceImpl;
	private ChatUtil chatUtil;
	
	@Autowired
	public ChatHandler(ChatUtil chatUtil, ChatServiceImpl chatServiceImpl) {
		this.chatServiceImpl = chatServiceImpl;
		this.chatUtil = chatUtil;
	}
	
	private final Logger logger = LoggerFactory.getLogger(ChatHandler.class);
	
	private final String ENTER = "enter";
	private final String SEND = "send";
	private final String EXIT = "exit";
	private final String DELETE = "delete";
	
	//웹소켓에 최초 접근시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//유저-세션 저장
		sessions.put(session.getId(), session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//채팅메세지 받기
		String msg = message.getPayload();
		JSONObject chat = chatUtil.jsonToObjectParser(msg);
		
		//채팅구분
		String order = (String) chat.get("order");
		int roomIndex = Integer.parseInt((String)chat.get("roomIndex"));
		String sendUser=sendUser =(String)chat.get("userName");					
		int user_no = chatUtil.getUser(session).getUser_no();
		
		if(order!=null) {
			String type = (String) chat.get("type");
			if(type.equals("message")){
				switch(order) { 
					case SEND : {
						//받은 메세지를 db에 삽입 
						String text = (String)chat.get("msg");
						int a = chatServiceImpl.insertChatMessage(roomIndex, user_no, text);
						int chat_no=0;
						if(a>0) {
							chat_no = chatServiceImpl.getLastChat(roomIndex).getChat_no();
						}
						chat.put("chatNo", chat_no);
						
					}
					case EXIT : {
						sessions.remove(session.getId());
					}
					case DELETE : {
						int chat_no = Integer.parseInt((String)chat.get("chatNo"));
						String fileName = chatServiceImpl.getFileName(chat_no);
						
						//서버에 파일존재여부체크, 있을시 삭제
						File deleteFile = new File("C:/FTP/upload/img/chatImg/"+fileName);
						if(deleteFile.exists()) {
							deleteFile.delete();
						}
						//db삭제
						chatServiceImpl.deleteChat(chat_no);
					}; 
				}
				sendOtherSessions(session, chat, roomIndex, order);
			}else {
				//이미지일시		
				String fileName = (String)chat.get("file");
				chatServiceImpl.insertFile(roomIndex, user_no, fileName);
			}
		}
	}
	
	
	//파일을 서버에 저장하는 로직 
	@Override
	protected void handleBinaryMessage(WebSocketSession session, BinaryMessage message) {
		
		ByteBuffer byteBuffer = message.getPayload();
		
		//url의 파라미터를 통해 채팅방번호 받아오기
		String url = session.getUri().toString();
		//url에서 방번호 구하는 로직
		int roomIndex = Integer.parseInt(url.split("/chatHandler.do?")[1].substring(1));
		//세션에 저장된 유저 읽어오기
		UserVO user = chatUtil.getUser(session);
		
		//파일 보낸이의 정보
		int user_no = user.getUser_no();
		String sendUser = user.getUser_nick();
		
		//파일을 보내기 전에 미리 채팅을 추가함으로서 파일이름 가져오기
		int last_chat_no = chatServiceImpl.getLastMyChatNo(user_no, roomIndex);
		String fileName = chatServiceImpl.getFileName(last_chat_no); 

		//파일생성로직
		File dir = new File(FILE_UPLOAD_PATH);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		File file = new File(FILE_UPLOAD_PATH, fileName);
		FileOutputStream out = null;
		FileChannel outChannel = null;
		try {
			byteBuffer.flip(); //byteBuffer를 읽기 위해 세팅
			out = new FileOutputStream(file, true); //생성을 위해 OutputStream을 연다.
			outChannel = out.getChannel(); //채널을 열고
			byteBuffer.compact(); //파일을 복사한다.
			outChannel.write(byteBuffer); //binary타입으로 받은 파일을 작성
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(out != null) {
					out.close();
				}
				if(outChannel != null) {
					outChannel.close();
				}
			}catch (IOException e) {
				e.printStackTrace();
			}
		}
		byteBuffer.position(0); 
		try {
			for (String key : sessions.keySet()) {
				WebSocketSession s = sessions.get(key);
						try {
							//세션아이디로 인덱스를 구하고,
							//해당인덱스와 일치하면 문자를 보내면됨
							if(chatUtil.getUser(s)!=null) {		
								//방번호 체크
								boolean checkIndex = chatServiceImpl.checkRoomIndex(chatUtil.getUser(s).getUser_no(), roomIndex);								
								if(checkIndex) {
									JSONObject chat = new JSONObject();
									chat.put("order", SEND);
									chat.put("type", "file");
									chat.put("fileName", fileName);
									chat.put("roomIndex", roomIndex);
									chat.put("userName", sendUser);
									chat.put("chatNo", last_chat_no);								
									s.sendMessage(new TextMessage(chat.toJSONString()));
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
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		
	}
	//접속이 끊겼을시
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessions.remove(session.getId());
		
	}	
	
	private void sendOtherSessions(WebSocketSession session, JSONObject chat, int roomIndex,String order) {
		if(order.equals(SEND)) {
			for (String key : sessions.keySet()) {
				WebSocketSession s = sessions.get(key);
				try {
					//세션의 로그인정보가 있으면
					if(chatUtil.getUser(s)!=null) {
						//해당 세션의 유저가 메세지의 룸번호를 가지고있는지 조회
						boolean checkIndex = chatServiceImpl.checkRoomIndex(chatUtil.getUser(s).getUser_no(), roomIndex);
						//해당 				
						if(checkIndex) {
							s.sendMessage(new TextMessage(chat.toJSONString()));
						}	
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
		}else {
			for (String key : sessions.keySet()) {
				WebSocketSession s = sessions.get(key);
					if (s != session) { // 현재 접속자가 아닌 나머지 사람들				
						try {
							//세션의 로그인정보가 있으면
							if(chatUtil.getUser(s)!=null) {
								//해당 세션의 유저가 메세지의 룸번호를 가지고있는지 조회
								boolean checkIndex = chatServiceImpl.checkRoomIndex(chatUtil.getUser(s).getUser_no(), roomIndex);
								//해당 				
								if(checkIndex) {
									s.sendMessage(new TextMessage(chat.toJSONString()));
								}	
							}
						} catch (IOException e) {
							e.printStackTrace();
					}
				
				}
			}
		}
		
	}

}
