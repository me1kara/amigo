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
import com.lec.amigo.impl.ChatServiceImpl;
import com.lec.amigo.vo.ChatRoom;
import com.lec.amigo.vo.UserVO;

import lombok.RequiredArgsConstructor;


public class ChatHandler extends TextWebSocketHandler{
	
	private static HashMap<String, WebSocketSession> sessions = new HashMap<>();
	private static final String FILE_UPLOAD_PATH = "C:/FTP/upload/img/chatImg/";

	@Autowired
	@Qualifier("chatService")
	ChatServiceImpl chatServiceImpl;
	
	private final Logger logger = LoggerFactory.getLogger(ChatHandler.class);
	
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
		JSONObject jms = jsonToObjectParser(msg);
	
		String no=null;
		int roomIndex=0;
		String sendUser=null;
		String text=null;
		String type=null;

		//메세지 분기, 삭제하란 요청이면
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
	
		int user_no = getUser(session).getUser_no();
		
		
		//채팅방 입장한것일시
		if (no.equals("1")) {
				for (String key : sessions.keySet()) {
					WebSocketSession s = sessions.get(key);
						if (s != session) { // 현재 접속자가 아닌 나머지 사람들				
							try {
								//세션의 로그인정보가 있으면
								if(getUser(s)!=null) {
									//해당 세션의 유저가 메세지의 룸번호를 가지고있는지 조회
									boolean checkIndex = chatServiceImpl.checkRoomIndex(getUser(s).getUser_no(), roomIndex);
									
									//해당 				
									if(checkIndex) {
										s.sendMessage(new TextMessage(jms.toJSONString()));
									}	
								}
							} catch (IOException e) {
								e.printStackTrace();
							}
					
					}
				}
		//채팅메세지일시
		} else if (no.equals("2") && type.equals("message")) {
			
			//받은 메세지를 db에 삽입 
			text = (String)jms.get("msg");
			int a = chatServiceImpl.insertChatMessage(roomIndex, user_no, text);
			int chat_no=0;
			if(a>0) {
				chat_no = chatServiceImpl.getLastChat(roomIndex).getChat_no();
			}
			
			//같은 방 접속자에게 메세지 보내기 위한 로직
			for (String key : sessions.keySet()) {
				WebSocketSession s = sessions.get(key);							
						try {
							if(getUser(s)!=null) {
								//같은 방인지 체크
								boolean checkIndex = chatServiceImpl.checkRoomIndex(getUser(s).getUser_no(), roomIndex);								
								if(checkIndex) {
									//json형태로 보내기
									jms.put("chatNo", chat_no);
									s.sendMessage(new TextMessage(jms.toJSONString()));							
								}
							}
						} catch (IOException e) {
							e.printStackTrace();
						}
			
					//}
				//}
				
			//}
			}
			
		}else if(no.equals("2") && type.equals("fileUpload")){
			//이미지일시		
			String fileName = (String)jms.get("file");
			chatServiceImpl.insertFile(roomIndex, user_no, fileName);
		//나갔을시
		}else if (no.equals("3")) {
					for (String key : sessions.keySet()) {
						WebSocketSession s = sessions.get(key);
			
						if (s != session) { // 현재 접속자가 아닌 나머지 사람들
							try {			
								if(getUser(s)!=null) {
									boolean checkIndex = chatServiceImpl.checkRoomIndex(getUser(s).getUser_no(), roomIndex);
									if(checkIndex) {
									s.sendMessage(new TextMessage(jms.toJSONString()));
									}
								}
							} catch (IOException e) {
								e.printStackTrace();
							}
						}	
					//}
				}
				sessions.remove(session.getId());
			//삭제일시
			}else if(no.equals("4")) {
				String ab = (String)jms.get("chatNo");
				int chat_no = Integer.parseInt(ab);
				String fileName = chatServiceImpl.getFileName(chat_no);
				
				//서버에 파일존재여부체크, 있을시 삭제
				File deleteFile = new File("C:/FTP/upload/img/chatImg/"+fileName);
				if(deleteFile.exists()) {
					deleteFile.delete();
				}
				//db삭제
				chatServiceImpl.deleteChat(chat_no);
				
				//같은 방에 있는 유저들의 화면에서도 채팅이 삭제되게 하기
					for (String key : sessions.keySet()) {
						WebSocketSession s = sessions.get(key);
						if (s != session) { // 현재 접속자가 아닌 나머지 사람들
							try {
								if(getUser(s)!=null) {
					
									boolean checkIndex = chatServiceImpl.checkRoomIndex(getUser(s).getUser_no(), roomIndex);
									if(checkIndex) {
						
										s.sendMessage(new TextMessage(jms.toJSONString()));
									}
								}
							} catch (IOException e) {
								e.printStackTrace();
							}
						}	
					//}
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
		UserVO user = getUser(session);
		
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
							if(getUser(s)!=null) {		
								//방번호 체크
								boolean checkIndex = chatServiceImpl.checkRoomIndex(getUser(s).getUser_no(), roomIndex);								
								if(checkIndex) {
									JSONObject jms = new JSONObject();
									jms.put("no", "2");
									jms.put("type", "file");
									jms.put("fileName", fileName);
									jms.put("roomIndex", roomIndex);
									jms.put("userName", sendUser);
									jms.put("chatNo", last_chat_no);								
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
	
	//http세션에 담긴 유저얻어오기
	private UserVO getUser(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		UserVO loginUser = (UserVO)httpSession.get("user");
		
		if(loginUser!=null) {
			return loginUser;
		}else return null;
		
	}
	
	//json파싱용
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
