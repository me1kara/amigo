package com.lec.amigo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.socket.WebSocketSession;

import com.lec.amigo.chat.JDBCUtility.JDBCUtility;
import com.lec.amigo.mapper.ChatRowMapper;
import com.lec.amigo.vo.ChatRoom;
import com.lec.amigo.vo.ChatVO;
import com.lec.amigo.vo.UserVO;



@Repository("chatdao")
public class ChatDAO {
	
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public int idCheck(int no) {
		boolean check = false;
		Connection conn = JDBCUtility.getConnection();		
		int asd = 0;	
		String sql = "select count(user_no) from sit_chat where user_no=?";	
		asd = jdbcTemplate.queryForObject(sql, Integer.class);
		
		if(asd>0) {
			
			System.out.println("성공!");
			return asd;
		}
		
		/*
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				asd = rs.getInt("sitt_chat_index");
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
		*/
		
			
		return asd;
	}
	
	
	public List<ChatVO> getChatList(int index){
		List<ChatVO> chatList = new ArrayList<ChatVO>();
		Connection conn = JDBCUtility.getConnection();
		String sql = "SELECT sitt_chat_index,user_name, sitt_chat_content, sitt_chat_regdate"
				+ ",sitt_chat_readis FROM sit_chat s, user u where sitt_chat_index=?";
		
		Object[] args = {index};
		chatList = jdbcTemplate.query(sql, args, new ChatRowMapper());
		
		return chatList;
		
		
		/*
		ResultSet rs =null;
		PreparedStatement pstmt=null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, index);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ChatVO chat = new ChatVO();
				chat.setIndex(rs.getInt("sitt_chat_index"));
				chat.setUser(rs.getString("user_name"));
				chat.setContent(rs.getString("sitt_chat_content"));
				chat.setDate(rs.getDate("sitt_chat_regdate"));
				chat.setRead_is(rs.getBoolean("sitt_chat_readis"));
				chatList.add(chat);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCUtility.close(conn, rs, pstmt);
		}
		
		*/
		
		//return chatList;
	}
	
	public void insertChat(int index, String user, String content) {
		
		Connection conn = JDBCUtility.getConnection();
		String sql = "insert into sit_chat(sitt_chat_index, user_no, sitt_chat_content, sitt_chat_reg_date, sitt_read_is, sitt_chat_file, sitt_chat_emo) values(?,?,?,SYSDATE(),0,?,?)";
		
	
		
		try {
			jdbcTemplate.update(sql, index, user, content, null, null);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		/*
		
		int row = 0;
		PreparedStatement pstmt=null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, index);
			pstmt.setString(2, user);
			pstmt.setString(3, content);
			row = pstmt.executeUpdate();
			
			if(row>0) {
			System.out.println(row+"건이 업데이트됐습니다");
			System.out.println("디비 삽입성공!");
			JDBCUtility.commit(conn);
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
		
		
	}
	
	public void setRoom(ChatRoom ch){
		
		
		String sql = "insert into chat_room values(?,?)";
		
		
		Connection conn = JDBCUtility.getConnection();
		PreparedStatement pstmt = null;
		
		int chat_index = ch.getChat_index();
		int user_no = ch.getUser_no();
		
		try {
			jdbcTemplate.update(sql, chat_index, user_no);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		
		/*
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
			
			sql = "update chatroom set chat_index=?, user_no=?";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, chat_index);
				pstmt.setInt(2, user_no);
				pstmt.executeLargeUpdate();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			JDBCUtility.rollback(conn);
			e.printStackTrace();
		}finally {
			JDBCUtility.close(conn, null, pstmt);
		}
		*/
		
	}
	
	public boolean checkRoomIndex(int user_no, int roomindex) {
	
		String sql = "select count(chat_index) from chat_room where user_no=? and chat_index=?";
		
		int row = jdbcTemplate.queryForObject(sql, Integer.class);
		
		if(row>0) {
			return true;
		}
		
		/*
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
		*/
		
		return false;
	}
	
	
	
	public String getSessionId(int roomNo) {
		
		String sql = "select distinct session_id from chatRoom where chat_index=?";
		

		Connection conn = JDBCUtility.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs =null;
	
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, roomNo);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				String id = rs.getString(1);
				System.out.println("id"+"아이디라ㅏ고"+id);
				return id;
		
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCUtility.close(conn, rs, pstmt);
		}
		
		
		
		 
		return null;
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
				System.out.println(a+"확인용");
				myChatList.add(getLastChat(a));
			}
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCUtility.close(conn, rs, pstmt);
		}
		
		return myChatList; 	
	}
	
	public ChatVO getLastChat(int index) {
		
		ChatVO chat = new ChatVO();
		String sql = "select * from sit_chat where sitt_chat_index=? order by sitt_chat_regdate desc";
		Connection conn = JDBCUtility.getConnection();
		
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, index);
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				chat.setIndex(index);
				chat.setContent(rs.getString("sitt_chat_content"));
				chat.setUser_no(rs.getInt("user_no"));
				chat.setDate(rs.getDate("sitt_chat_regdate"));
				chat.setRead_is(rs.getBoolean("sitt_chat_readis"));
			}
			System.out.println(chat.toString());
		} catch (SQLException e) {
			System.out.println(chat.toString());
			e.printStackTrace();
		}finally {
			JDBCUtility.close(conn, rs, pstmt);
		}
		
	
<<<<<<< HEAD
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


	public List<Integer> getRoomList(int user_no) {
		
		List<Integer> room_list = new ArrayList<Integer>();
		String sql = "select chat_index from chat_room where user_no=?";
		Connection conn = JDBCUtility.getConnection();
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				System.out.println("챗 인덱스 확인용"+rs.getInt("chat_index"));
				room_list.add(rs.getInt("chat_index"));
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
	
	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}


	public void insertFile(int roomIndex, int user_no, String fileName) {
		
		String fileType = fileName.substring(fileName.lastIndexOf("."),fileName.length());
		
		System.out.println(fileType);
		fileName = fileName.split(fileType)[0];
		System.out.println(fileName);
		
		String selectEqualsFile = "select count(sitt_chat_file) from sit_chat where sitt_chat_file like '?%'";
		Object[] args = {fileName};
		
		int a = 0;
		a = jdbcTemplate.queryForObject(selectEqualsFile,args, Integer.class);
		
		if(a!=0) {
			fileName = fileName+"("+a+").";
		}		
		fileName = fileName+fileType;
		
		String insertSql = "insert into sit_chat(sitt_chat_index, user_no, sitt_chat_content, sitt_chat_regdate, sitt_chat_readis, sitt_chat_file, sitt_chat_emo) values(?,?,?,SYSDATE(),0,?,?)";	
		try {
			System.out.println("그래서 됨?");
			jdbcTemplate.update(insertSql, roomIndex, user_no,"file", fileName, null);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
=======
		return chat; 
>>>>>>> e77bbd4558ffe14921e3ceb90c3f41e30343f44f
	}


	public int getLastMyChat(int user_no) {
		
		String sql = "select sitt_chat_no from sit_chat where user_no=?";
		
		return 0;
	}
	
	
}

