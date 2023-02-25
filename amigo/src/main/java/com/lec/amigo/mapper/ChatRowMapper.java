package com.lec.amigo.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;

import com.lec.amigo.vo.ChatVO;

public class ChatRowMapper implements RowMapper<ChatVO>{

	@Override
	public ChatVO mapRow(ResultSet rs, int rowNum) throws SQLException {		
		ChatVO chat = new ChatVO();
		chat.setIndex(rs.getInt("sitt_chat_index"));
		chat.setUser_nick(rs.getString("user_nick"));
		chat.setContent(rs.getString("sitt_chat_content"));
		chat.setRead_is(rs.getBoolean("sitt_chat_readis"));
		chat.setChat_no(rs.getInt("sitt_chat_no"));
		if(rs.getString("sitt_chat_file")!=null)chat.setFile(rs.getString("sitt_chat_file"));
		if(rs.getString("sitt_chat_emo")!=null)chat.setEmo(rs.getString("sitt_chat_emo"));
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Date date = formatter.parse(rs.getString("sitt_chat_regdate"));
			chat.setDate(date);		
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	
		return chat;
	}
	
	
}
