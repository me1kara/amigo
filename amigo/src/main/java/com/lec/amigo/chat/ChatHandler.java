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
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.lec.amigo.chat.JDBCUtility.JDBCUtility;
import com.lec.amigo.dao.ChatDAO;
import com.lec.amigo.vo.ChatRoom;
import com.lec.amigo.vo.UserVO;

public class ChatHandler extends TextWebSocketHandler{
	
	private static List<WebSocketSession> sessions = new ArrayList();
	
	//세션구별용
	
//	private Map<String, WebSocketSession> userSessions = new HashMap();
	
	//private Map<ChatRoom, WebSocketSession> indexSessions = new HashMap();
	
	ChatDAO chatDao = new ChatDAO();
	
	//private static final Logger logger = LoggerFactory.getLogger(ChatServer.class);
	//ChatDAO chatDao = new ChatDAO();
<<<<<<< HEAD
	
	

	
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
	protected void handleBinaryMessage(WebSocketSession session, BinaryMessage message) {
		String curWorkingDir = System.getProperty("user.dir");
		System.out.println("현재 작업 폴더 : " + curWorkingDir);
		

		ByteBuffer byteBuffer = message.getPayload();		
		String url = session.getUri().toString();
		System.out.println("url:"+url);
		
		String roomIndex = url.split("/chatHandler.do?")[1].substring(1);
		UserVO user = getUser(session);
		int user_no = user.getUser_no();
		
		int chat_no = chatDao.getLastMyChat(user_no);
		
		
		
		UUID uuid = UUID.randomUUID();
		String[] uuids = uuid.toString().split("-");
		
		String fileName = uuids[0];
		File dir = new File(FILE_UPLOAD_PATH);
		
		if(!dir.exists()) {
			dir.mkdirs();
		}
		File file = new File(FILE_UPLOAD_PATH, fileName+".png");
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
	
		
=======
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("서버연결");	
		//세션리스트에 세션저장
		sessions.add(session);
		//유저-세션 저장	
		ChatRoom ch = getRoomUser(session);
		if(ch!=null) chatDao.setRoom(ch);
		
		//일단 채팅방 생성시기는 계약이 성립됐을때
		//인덱스만 가져오고 
		
			
>>>>>>> e77bbd4558ffe14921e3ceb90c3f41e30343f44f
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
				sendUser =strs[1];
				roomIndex = Integer.parseInt(strs[2]);
		}else if(strs!=null && strs.length==4) {
				no = strs[0];
				sendUser =strs[1];
				text = strs[2];
				roomIndex = Integer.parseInt(strs[3]);
				
		}		
		
		
		
		//String id = chatDao.getSessionId(roomIndex);
		 
		
<<<<<<< HEAD
=======
		int index=getRoomUser(session).getChat_index();
		
>>>>>>> e77bbd4558ffe14921e3ceb90c3f41e30343f44f
		
		if (no.equals("1")) {
			// 누군가 접속 > 1#아무개
			
			//for(String id:idList) {
				for (WebSocketSession s : sessions) {
						if (s != session) { // 현재 접속자가 아닌 나머지 사람들				
							try {
								
								//해당 세션의 인덱스 리스트를 속성으로 가져오고
								//인덱스리스트를 for 돌려서 메세지 보낸사람의 인덱스와 일치하는것만 추출하고
								//둘이 비교해서 보냄
								if(getRoomUser(s)!=null) {
									
									boolean checkIndex = chatDao.checkRoomIndex(getRoomUser(s).getUser_no(), index);
									
									//해당 유저가 해당 인덱스를 가지고있기 때문에 
									
									System.out.println("작성자인덱스:"+index+"다른방인덱스:"+getRoomUser(s).getChat_index());				
									if(checkIndex) {
										s.sendMessage(new TextMessage("1#" + sendUser + "#"));
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
			chatDao.insertChat(index, sendUser, text);
		//	for(String id:idList) {			
			// 누군가 메세지를 전송
			for (WebSocketSession s : sessions) {
				

					if (s != session) { // 현재 접속자가 아닌 나머지 사람들							
						try {
							System.out.println("2#" + sendUser + ":" + text);
							
							//세션아이디로 인덱스를 구하고,
							//해당인덱스와 일치하면 문자를 보내면됨
							
							if(getRoomUser(s)!=null) {
								
								
								boolean checkIndex = chatDao.checkRoomIndex(getRoomUser(s).getUser_no(), index);
								System.out.println("작성자인덱스:"+index+"다른방인덱스:"+getRoomUser(s).getChat_index());
								if(checkIndex) {
									s.sendMessage(new TextMessage("2#" + sendUser +"#" + text));
									
								}
							}
							//s.getBasicRemote().sendText("2#" + snderId +"#" + text);
						} catch (IOException e) {
							e.printStackTrace();
						}
			
					//}
				}
				
			//}
			}
<<<<<<< HEAD
		}else if(no.equals("2") && type.equals("fileUpload")){
			
			System.out.println("들어와짐?");
			String fileName = (String)jms.get("file");
			System.out.println(fileName);
			chatDao.insertFile(roomIndex, user_no, fileName);
			
			
			
		}else if (no.equals("3")) {
=======
		} else if (no.equals("3")) {
>>>>>>> e77bbd4558ffe14921e3ceb90c3f41e30343f44f
			
			System.out.println("호히히히");
			//for(String id:idList) {
			// 누군가 접속 > 3#아무개
				for (WebSocketSession s : sessions) {
					
				//	if(id.equals(s.getId())) {
						if (s != session) { // 현재 접속자가 아닌 나머지 사람들
							try {
								
								
								if(getRoomUser(s)!=null) {
									boolean checkIndex = chatDao.checkRoomIndex(getRoomUser(s).getUser_no(), index);
									
									System.out.println("작성자인덱스:"+index+"다른방인덱스:"+getRoomUser(s).getChat_index());
								
									if(checkIndex) {
									s.sendMessage(new TextMessage("3#" + sendUser + "#"));
									}
								}
								
//								s.getBasicRemote().sendText("3#" + user + "#");
							} catch (IOException e) {
								e.printStackTrace();
							}
						}	
					//}
				}
				sessions.remove(session);
			}
		
			
		}	
	
	private String getId(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		
		UserVO loginUser = (UserVO)httpSession.get("힝");
		
		if(loginUser!=null) {
			return session.getId();
		}else return loginUser.getUser_name();
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
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
