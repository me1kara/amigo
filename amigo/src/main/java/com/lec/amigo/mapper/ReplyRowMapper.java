package com.lec.amigo.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.lec.amigo.vo.ReplyVO;

public class ReplyRowMapper implements RowMapper<ReplyVO>{
	public ReplyVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		ReplyVO reply = new ReplyVO();
		reply.setUbd_r_no(rs.getInt("ubd_r_no"));
		reply.setUbd_no(rs.getInt("ubd_no"));
		reply.setUbd_r_content(rs.getString("ubd_r_content"));
		reply.setUbd_r_regdate(rs.getDate("ubd_r_regdate"));
		reply.setUbd_r_ref(rs.getInt("ubd_r_ref"));
		reply.setUbd_r_lev(rs.getInt("ubd_r_lev"));
		reply.setUbd_r_seq(rs.getInt("ubd_r_seq"));
		reply.setUser_no(rs.getInt("user_no"));
		reply.setUser_nick(rs.getString("user_nick"));
		return reply;
	}
}
