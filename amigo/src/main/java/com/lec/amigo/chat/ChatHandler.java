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

import com.lec.amigo.chat.JDBCUtility.JDBCUtility;
import com.lec.amigo.dao.ChatDAO;
import com.lec.amigo.vo.ChatRoom;
import com.lec.amigo.vo.UserVO;

import lombok.RequiredArgsConstructor;


public class ChatHandler extends TextWebSocketHandler{
	
	private static HashMap<String, WebSocketSession> sessions = new HashMap<>();
	private static final String FILE_UPLOAD_PATH = "C:/test/websocket/";
	//세션구별용	
//	private Map<String, WebSocketSession> userSessions = new HashMap();
	
	//private Map<ChatRoom, WebSocketSession> indexSessions = new HashMap();
	
	@Autowired
	@Qualifier("chatDAO")
	ChatDAO chatDao;
	
	//private static final Logger logger = LoggerFactory.getLogger(ChatServer.class);
	//ChatDAO chatDao = new ChatDAO();
	
	
	
	@Override
	protected void handleBinaryMessage(WebSocketSession session, BinaryMessage message) {
		String curWorkingDir = System.getProperty("user.dir");
		System.out.println("현재 작업 폴더 : " + curWorkingDir);
		ByteBuffer byteBuffer = message.getPayload();
		
		UUID uuid = UUID.randomUUID();
		String[] uuids = uuid.toString().split("-");
		
		String fileName = uuids[0];
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
			outChannel.write(byteBuffer); //파일을 쓴다.
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
			session.sendMessage(new BinaryMessage(byteBuffer));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		
	}
	
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
		JSONObject jms = jsonToObjectParser(msg);
		
		
		
		String no=null;
		int roomIndex=0;
		String sendUser=null;
		String text=null;
		String type=null;
		
		
		//삭제, 입장 분기
		if(jms!=null && jms.size()==4) {
				no = (String) jms.get("no");
				roomIndex = Integer.parseInt((String)jms.get("roomIndex"));
				if(no.equals("1")) {
				sendUser =(String)jms.get("userName");				
				}
		//메세지분기
		}else if(jms!=null && jms.size()==5) {
				no = (String) jms.get("no");
				sendUser =(String)jms.get("userName");
				roomIndex = Integer.parseInt((String)jms.get("roomIndex"));
				type = (String) jms.get("type");
		}		
		
		//String id = chatDao.getSessionId(roomIndex);
		 
	
		int user_no = getUser(session).getUser_no();
		
		System.out.println();
		
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
										s.sendMessage(new TextMessage(jms.toJSONString()));
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
			
				
			
		} else if (no.equals("2") && type.equals("message")) {
			text = (String)jms.get("msg");
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
									jms.put("chatNo", chat_no);
									System.out.println(jms);
									s.sendMessage(new TextMessage(jms.toJSONString()));							
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
		} else if(no.equals("2") && type.equals("fileUpload")){
			String fileName = (String)jms.get("file");
			chatDao.insertFile(roomIndex, user_no, fileName);
			
		} if (no.equals("3")) {
			
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
									s.sendMessage(new TextMessage(jms.toJSONString()));
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
				System.out.println(jms.get("chatNo")+"삭제 확인용");
				String ab = (String)jms.get("chatNo");
				System.out.println(ab);
				int chat_no = Integer.parseInt(ab);
				chatDao.delete(chat_no);
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
										s.sendMessage(new TextMessage(jms.toJSONString()));
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
	
	private static JSONObject jsonToObjectParser(String jsonStr) {
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
