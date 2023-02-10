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
	
	public int idCheck(int no) {
		boolean check = false;
		Connection conn = JDBCUtility.getConnection();		
		int idCount = 0;	
		String sql = "select count(user_no) from sit_chat where user_no=?";	
		idCount = jdbcTemplate.queryForObject(sql, Integer.class);
		
		if(idCount>0) {
			return idCount;
		}
		
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				int asd = rs.getInt("sitt_chat_index");
				JDBCUtility.commit(conn);
				return asd;
			}else {
				JDBCUtility.rollback(conn);
			}
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCUtility.close(conn, rs, pstmt);
		}			
		return idCount;
	}
	
	
	public List<ChatVO> getChatList(int index){
		//List<ChatVO> chatList = new ArrayList<ChatVO>();
		String sql = "SELECT sitt_chat_no, sitt_chat_index,user_nick, sitt_chat_content, sitt_chat_regdate,sitt_chat_readis,sitt_chat_file,sitt_chat_emo "
				+ "FROM sit_chat s, user u where sitt_chat_index=? and u.user_no=s.user_no order by s.sitt_chat_no";
		
		Object[] args = {index};
		
		try {		
			return jdbcTemplate.query(sql, args, new ChatRowMapper());
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		/*
		Connection conn = JDBCUtility.getConnection();

		ResultSet rs =null;
		PreparedStatement pstmt=null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, index);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ChatVO chat = new ChatVO();
				chat.setChat_no(rs.getInt("sitt_chat_no"));
				chat.setIndex(rs.getInt("sitt_chat_index"));
				chat.setUser_nick(rs.getString("user_nick"));
				chat.setContent(rs.getString("sitt_chat_content"));
				chat.setDate(rs.getDate("sitt_chat_regdate"));
				chat.setRead_is(rs.getBoolean("sitt_chat_readis"));
				chat.setFile(rs.getString("sitt_chat_file"));
				chat.setEmo(rs.getString("sitt_chat_emo"));
				chatList.add(chat);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCUtility.close(conn, rs, pstmt);
		}
		*/
		

	}
	
	public int insertChat(int index, int user_no, String content) {
		//Connection conn = JDBCUtility.getConnection();
		String sql = "insert into sit_chat(sitt_chat_index, user_no, sitt_chat_content, sitt_chat_regdate, sitt_chat_readis, sitt_chat_file, sitt_chat_emo) values(?,?,?,SYSDATE(),0,?,?)";
		/*
		try {
		//	jdbcTemplate.update(sql, index, user, content, null, null);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		int row = 0;
		PreparedStatement pstmt=null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, index);
			pstmt.setInt(2, user_no);
			pstmt.setString(3, content);
			pstmt.setString(4, null);
			pstmt.setString(5, null);
			row = pstmt.executeUpdate();
			
			if(row>0) {
			System.out.println(row+"건이 업데이트됐습니다");
			System.out.println("디비 삽입성공!");
			JDBCUtility.commit(conn);
			return row;
			}else {
				JDBCUtility.rollback(conn);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCUtility.close(conn, null, pstmt);
		}
		*/
		
		try {
			return jdbcTemplate.update(sql, index, user_no, content, null, null);
		} catch (Exception e) {
			e.getMessage();
			return 0;
		}
		
	}
	

	public void setRoom(ChatRoom ch){
		String sql = "insert into chat_room values(?,?)";
				
		int chat_index = ch.getChat_index();
		int user_no = ch.getUser_no();
		
		System.out.println(chat_index+""+user_no);
			
		try {
			jdbcTemplate.update(sql, chat_index, user_no);
		} catch (Exception e) {
			
		}
		
		/*
		Connection conn = JDBCUtility.getConnection();
		PreparedStatement pstmt = null;
		
		int row=0;
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, chat_index);
			pstmt.setInt(2, user_no);
			row = pstmt.executeUpdate();
			
			if(row>0) {
				System.out.println(row+"건 삽입 성공!");
				JDBCUtility.commit(conn);
			}
			
		} catch (SQLException e) {
			System.out.println("실패");
			
			sql = "update chat_room set chat_index=?, user_no=?";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, chat_index);
				pstmt.setInt(2, user_no);
				pstmt.executeLargeUpdate();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			
			//e.printStackTrace();
		}finally {
			JDBCUtility.close(conn, null, pstmt);
		}
		*/
		
	}
	
	public boolean checkRoomIndex(int user_no, int roomindex) {
		
		String sql = "select distinct chat_index chat_index from chat_room where user_no=? and chat_index=?";
		
		//int row = jdbcTemplate.queryForObject(sql, Integer.class);
		
		//if(row>0) {
			//return true;
		//}
		
		
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
	
	
	
	public int getSessionId(int roomNo) {
		
		String sql = "select distinct user_no from chat_room where chat_index=?";

		Connection conn = JDBCUtility.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, roomNo);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				int user_no = rs.getInt(1);
				return user_no;
		
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCUtility.close(conn, rs, pstmt);
		}

		return 0;
	}
	
	public List<ChatVO> getMyChatList(int user_no){			
		String sql = "select distinct sitt_chat_index from sit_chat where user_no=?";
		//Object[] args = {sql, name};
				
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
				a = rs.getInt("sitt_chat_index");
				myChatList.add(getLastChat(a));
			}
			return myChatList;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCUtility.close(conn, rs, pstmt);
		}
		
			
		return null;
	}
	
	public ChatVO getLastChat(int index) {
		String sql = "select sitt_chat_no, s.user_no, sitt_chat_index,user_nick, sitt_chat_content,sitt_chat_regdate,sitt_chat_readis,sitt_chat_file,sitt_chat_emo from sit_chat s,user u where sitt_chat_index=? and u.user_no=s.user_no order by sitt_chat_no desc limit 1";
		

		ChatVO chat = new ChatVO();
		Connection conn = JDBCUtility.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, index);
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
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
		}finally {
			JDBCUtility.close(conn, rs, pstmt);
		}
	
		return chat;
	}
	
	
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
	
	public List<ChatRoom> getElseRoomList(int user_no){
		List<ChatRoom> room_list = new ArrayList<ChatRoom>();
		String sql="select chat_index, r.user_no from chat_room r where r.user_no=? and r.chat_index not in"
				+ "(select distinct sitt_chat_index from sit_chat s where s.user_no=?"
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



	public void insertFile(int roomIndex, int user_no, String fileName) {
		
		String fileType = fileName.substring(fileName.lastIndexOf("."),fileName.length());
			
		fileName = UUID.randomUUID().toString();
		/*
		fileName = fileName.split(fileType)[0];
		Object[] args = {param};
		String selectEqualsFile = "select count(sitt_chat_file) from sit_chat where sitt_chat_file like ?";
		String param = fileName+"%";
	
		int a = 0;
		a = jdbcTemplate.queryForObject(selectEqualsFile,args, Integer.class);
		
		if(a!=0) {
		
			fileName = fileName+"("+a+")";
		}
		*/		
		fileName = fileName+fileType;
		
		String insertSql = "insert into sit_chat(sitt_chat_index, user_no, sitt_chat_content, sitt_chat_regdate, sitt_chat_readis, sitt_chat_file, sitt_chat_emo) values(?,?,?,SYSDATE(),0,?,?)";	
		try {
			jdbcTemplate.update(insertSql, roomIndex, user_no,"file", fileName, null);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
	}


	public int getLastMyChat(int user_no, int roomIndex) {
		String sql = "select sitt_chat_no from sit_chat where user_no=? and sitt_chat_index=? and sitt_chat_file!='' order by sitt_chat_no desc limit 1";
		
		Object[] args = {user_no, roomIndex};
		int chat_no=0;
		try {
			chat_no = jdbcTemplate.queryForObject(sql, args, Integer.class);
			System.out.println("마지막챗"+chat_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		
		return chat_no;
	}

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
	
	
}


