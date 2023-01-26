package com.lec.amigo.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.lec.amigo.vo.ChatVO;

public class ChatRowMapper implements RowMapper<ChatVO>{

	@Override
	public ChatVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		System.out.println("확인용");
		
		ChatVO chat = new ChatVO();
		chat.setIndex(rs.getInt("sitt_chat_index"));
		chat.setUser_nick(rs.getString("user_nick"));
		chat.setContent(rs.getString("sitt_chat_content"));
		chat.setDate(rs.getDate("sitt_chat_regdate"));
		chat.setRead_is(rs.getBoolean("sitt_chat_readis"));
		
		if(rs.getString("sitt_chat_file")!=null)chat.setFile(rs.getString("sitt_chat_file"));
		if(rs.getString("sitt_chat_emo")!=null)chat.setEmo(rs.getString("sitt_chat_emo"));
		
		return chat;
	}
	
	
}
