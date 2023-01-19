package com.lec.amigo.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.lec.amigo.vo.ChatVO;

public class ChatRowMapper implements RowMapper<ChatVO>{

	@Override
	public ChatVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		ChatVO chat = new ChatVO();
		
		chat.setIndex(rs.getInt("sitt_chat_index"));
		chat.setUser_no(rs.getInt("user_no"));
		chat.setContent(rs.getString("sitt_chat_content"));
		chat.setDate(rs.getDate("sitt_chat_regdate"));
		chat.setRead_is(rs.getBoolean("sitt_chat_readis"));
		
		return chat;
	}
	
	
}
