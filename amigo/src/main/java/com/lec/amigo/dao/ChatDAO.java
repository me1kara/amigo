package com.lec.amigo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.socket.WebSocketSession;

import com.lec.amigo.chat.JDBCUtility.JDBCUtility;
import com.lec.amigo.mapper.ChatRowMapper;
import com.lec.amigo.vo.ChatRoom;
import com.lec.amigo.vo.ChatVO;
import com.lec.amigo.vo.UserVO;



@Repository("chatDAO")
public class ChatDAO {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	//예약완료 후 방생성
	public void setRoom(ChatRoom ch){
		String sql = "insert into chat_room values(?,?)";
		int chat_index = ch.getChat_index();
		int user_no = ch.getUser_no();	
		try {
			jdbcTemplate.update(sql, chat_index, user_no);
		} catch (Exception e) {
			e.getMessage();
		}
	}
	
	//특정채팅방 채팅목록 chatRoom.jsp
	public List<ChatVO> getChatList(int index){
		String sql = "SELECT sitt_chat_no, sitt_chat_index,user_nick, sitt_chat_content, sitt_chat_regdate,sitt_chat_readis,sitt_chat_file,sitt_chat_emo "
				+ "FROM sit_chat s, user u where sitt_chat_index=? and u.user_no=s.user_no order by s.sitt_chat_no";
		
		Object[] args = {index};
		
		try {		
			return jdbcTemplate.query(sql, args, new ChatRowMapper());
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		

	}
	//채팅내용 넣기
	public int insertChat(int index, int user_no, String content) {

		String sql = "insert into sit_chat(sitt_chat_index, user_no, sitt_chat_content, sitt_chat_regdate, sitt_chat_readis, sitt_chat_file, sitt_chat_emo) values(?,?,?,DATE_FORMAT(now(), '%Y-%m-%d %H:%i:%s'),0,?,?)";
		try {
			return jdbcTemplate.update(sql, index, user_no, content, null, null);
		} catch (Exception e) {
			e.getMessage();
			return 0;
		}
		
	}
	
	//파일이름 삽입로직
	public void insertFile(int roomIndex, int user_no, String fileName) {
		
		String fileType = fileName.substring(fileName.lastIndexOf("."),fileName.length());
		

		//랜덤이름
		fileName = UUID.randomUUID().toString();
		fileName = fileName+fileType;
		
		String insertSql = "insert into sit_chat(sitt_chat_index, user_no, sitt_chat_content, sitt_chat_regdate, sitt_chat_readis, sitt_chat_file, sitt_chat_emo) values(?,?,?,SYSDATE(),0,?,?)";	
		try {
			jdbcTemplate.update(insertSql, roomIndex, user_no,"file", fileName, null);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
	}
	
	// 특정 방의 마지막채팅 구하는 로직
	public ChatVO getLastChat(int index) {
		String sql = "select sitt_chat_no, s.user_no, sitt_chat_index,user_nick, sitt_chat_content,sitt_chat_regdate,sitt_chat_readis,sitt_chat_file,sitt_chat_emo from sit_chat s,user u where sitt_chat_index=? and u.user_no=s.user_no order by sitt_chat_no desc limit 1";

		ChatVO chat = new ChatVO();
		Connection conn = JDBCUtility.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, index);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				chat.setChat_no(rs.getInt("sitt_chat_no"));
				chat.setUser_no(rs.getInt("user_no"));
				chat.setIndex(rs.getInt("sitt_chat_index"));
				chat.setUser_nick(rs.getString("user_nick"));
				chat.setContent(rs.getString("sitt_chat_content"));
				chat.setDate(rs.getDate("sitt_chat_regdate"));
				chat.setRead_is(rs.getBoolean("sitt_chat_readis"));
				chat.setFile(rs.getString("sitt_chat_file"));
				chat.setEmo(rs.getString("sitt_chat_emo"));
			}
			System.out.println(chat.toString());
		} catch (SQLException e) {
			System.out.println(chat.toString());
			e.printStackTrace();
		} finally {
			JDBCUtility.close(conn, rs, pstmt);
		}

		return chat;
	}

	//내 마지막 체팅 구하기,파일 삽입 이전 먼저 채팅을 삽입해서 파일이름을 가져오는 방식
	public int getLastMyChat(int user_no, int roomIndex) {
		String sql = "select sitt_chat_no from sit_chat where user_no=? and sitt_chat_index=? and sitt_chat_file!='' order by sitt_chat_no desc limit 1";
		
		Object[] args = {user_no, roomIndex};
		int chat_no=0;
		try {
			chat_no = jdbcTemplate.queryForObject(sql, args, Integer.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		
		return chat_no;
	}

	//위에 언급한대로 파일이름 가져옴
	public String getFileName(int chat_no) {
		String sql = "select sitt_chat_file from sit_chat where sitt_chat_no=?";
		Object[] args = {chat_no};
		String fileName = null;
		try {
			fileName = jdbcTemplate.queryForObject(sql, args, String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fileName;
	}
	
	//채팅삭제 로직
	public boolean delete(int chat_no) {	
			String sql = "delete from sit_chat where sitt_chat_no=?";
			Connection conn = JDBCUtility.getConnection();
			PreparedStatement pstmt = null;
			int row = 0;
			
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, chat_no);
				row = pstmt.executeUpdate();
				if(row>0) {
					JDBCUtility.commit(conn);
					return true;
				}else {
					JDBCUtility.rollback(conn);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				JDBCUtility.close(conn, null, pstmt);
			}
		
		return false;
	}
	
	//방번호 확인, 실챗 방구분 전달을 위함
	public boolean checkRoomIndex(int user_no, int roomindex) {
		
		String sql = "select distinct chat_index chat_index from chat_room where user_no=? and chat_index=?";
				
		Connection conn = JDBCUtility.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, user_no);
			pstmt.setInt(2, roomindex);
			rs=pstmt.executeQuery();
			if(rs.next()) {	
				int ab = rs.getInt("chat_index");
				if(ab==roomindex) {return true;}
			}else {
				
				return false;
			}	
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCUtility.close(conn, rs, pstmt);
		}
		
		return false; 
		

	}
	
	

	
	//내가 가진 채팅방들 구하기 + 해당방의 마지막채팅 mychatList.jsp
	public List<ChatVO> getMyChatList(int user_no){
		String sql = "select distinct sitt_chat_no, s.user_no, sitt_chat_index,user_nick, sitt_chat_content,sitt_chat_regdate,sitt_chat_readis,sitt_chat_file,sitt_chat_emo from sit_chat s,user u where sitt_chat_index in (select chat_index from chat_room where user_no=?) and s.user_no = u.user_no order by sitt_chat_no desc limit 1";
		
		Connection conn = JDBCUtility.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<ChatVO> myChatList = new ArrayList<ChatVO>();
		
		int a = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,user_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ChatVO chat = new ChatVO();
				//해당 방의 마지막 채팅 구하기 
				//myChatList.add(getLastChat(a));
				chat.setChat_no(rs.getInt("sitt_chat_no"));
				chat.setUser_no(rs.getInt("user_no"));
				chat.setIndex(rs.getInt("sitt_chat_index"));
				chat.setUser_nick(rs.getString("user_nick"));
				chat.setContent(rs.getString("sitt_chat_content"));
				chat.setDate(rs.getDate("sitt_chat_regdate"));
				chat.setRead_is(rs.getBoolean("sitt_chat_readis"));
				chat.setFile(rs.getString("sitt_chat_file"));
				chat.setEmo(rs.getString("sitt_chat_emo"));
				myChatList.add(chat);
			}
			//마지막 채팅만 담은 리스트를 반환
			return myChatList;
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtility.close(conn, rs, pstmt);
		}
		return null;
	}
	
	//방가지고있는지 아닌지 체크를 위한 로직, 내 채팅방리스트
	public ChatRoom getRoom(int user_no) {
		String sql = "select * from chat_room where user_no=?";
	
		Connection conn = JDBCUtility.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user_no);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				ChatRoom chatRoom = new ChatRoom();
				chatRoom.setChat_index(rs.getInt("chat_index"));
				chatRoom.setUser_no(rs.getInt("user_no"));
				return chatRoom;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtility.close(conn, rs, pstmt);
		}
	
		return null;
		
	}
	

	//내 채팅방목록, 실시간알림용
	public List<ChatRoom> getRoomList(int user_no) {
		
		List<ChatRoom> room_list = new ArrayList<ChatRoom>();
		String sql = "select chat_index,user_no from chat_room where user_no=?";
		Connection conn = JDBCUtility.getConnection();
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ChatRoom room = new ChatRoom();
				
				room.setChat_index(rs.getInt("chat_index"));
				room.setUser_no(rs.getInt("user_no"));
				room_list.add(room);
			}
			return room_list;		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCUtility.close(conn, rs, null);
		}
				
		return null;
	}
	
	//채팅방목록에서 마지막 채팅이 없을시, 차집합을 통해 방만 구함
	public List<ChatRoom> getElseRoomList(int user_no){
		List<ChatRoom> room_list = new ArrayList<ChatRoom>();
		String sql="select chat_index, r.user_no from chat_room r where r.user_no=? and r.chat_index not in"
				+ "(select distinct sitt_chat_index from sit_chat s where r.user_no=?"
				+ ")";
		Connection conn = JDBCUtility.getConnection();
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user_no);
			pstmt.setInt(2, user_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ChatRoom room = new ChatRoom();		
				room.setChat_index(rs.getInt("chat_index"));
				room.setUser_no(rs.getInt("user_no"));
				room_list.add(room);
			}
			return room_list;		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCUtility.close(conn, rs, null);
		}
				
		return null;
	}
	//해당 채팅방의 유저목록
	public List<ChatRoom> getRoomUserList(int user_no) {
		List<ChatRoom> roomUserList = new ArrayList();
		String sql = "select c.chat_index, c.user_no from chat_room c, (select chat_index from chat_room where user_no=?) r where c.chat_index = r.chat_index";
		Connection conn = JDBCUtility.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user_no);
			rs= pstmt.executeQuery();
			while (rs.next()) {
				ChatRoom room = new ChatRoom();
				room.setChat_index(rs.getInt("chat_index"));
				room.setUser_no(rs.getInt("user_no"));
				roomUserList.add(room);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return roomUserList;
	}

	//채팅방 나가기
	public int exitRoom(int index, int user_no) {
		String sql = "delete from chat_room where chat_index=? and user_no=?";
		
		int row = 0;
		row = jdbcTemplate.update(sql,index,user_no);
		
		if(row>0) {
			sql = "insert into sit_chat(sitt_chat_index, user_no, sitt_chat_content, sitt_chat_regdate, sitt_chat_readis) values(?,?,?,DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s'),0)";
			jdbcTemplate.update(sql, index, user_no, "해당유저는 나갔습니다");
		}
		
		/* 채팅삭제 로직 but 보관후 매주금요일 삭제하는것으로.
		 * if(row>0) { String delete_chat =
		 * "delete from sit_chat where sitt_chat_index=? and user_no=?"; row =
		 * jdbcTemplate.update(delete_chat, index, user_no); }
		 */
		
		return row; 
	}

	public List<ChatVO> getMyChatRoomList(int user_no) {
		String sql = "select chat_index, user_no, sitt_chat_content, sitt_chat_file, user_nick from (select ROW_NUMBER() OVER(PARTITION BY chat_index ORDER BY sitt_chat_no DESC) rn,chat_index, s.user_no, s.sitt_chat_content,s.sitt_chat_file,user_nick from chat_room r left outer join (select d.*, u.user_nick from sit_chat d, user u where d.user_no=u.user_no) s on sitt_chat_index=chat_index where r.user_no="
				+ user_no
				+ ") r where rn=1";
		Connection conn = JDBCUtility.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ChatVO> myChatRoomList = new ArrayList<ChatVO>();
		try {
		pstmt = conn.prepareStatement(sql);
		rs=pstmt.executeQuery();
		
		while(rs.next()) {
			ChatVO chat = new ChatVO();
			chat.setIndex(rs.getInt("chat_index"));
			chat.setUser_no(rs.getInt("user_no"));
			chat.setContent(rs.getString("sitt_chat_content"));
			chat.setFile(rs.getString("sitt_chat_file"));
			chat.setUser_nick(rs.getString("user_nick"));
			myChatRoomList.add(chat);
		}
		
		if(!myChatRoomList.isEmpty()) {
			return myChatRoomList;
		}else {
			return null;
		}
		}catch(Exception e) {
			
		}finally {
			JDBCUtility.close(conn, rs, pstmt);
		}
		
		
		return null;
	}
	
}


