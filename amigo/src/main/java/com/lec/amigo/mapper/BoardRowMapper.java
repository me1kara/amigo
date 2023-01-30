package com.lec.amigo.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.lec.amigo.vo.BoardVO;

public class BoardRowMapper implements RowMapper<BoardVO>{
	public BoardVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		BoardVO board = new BoardVO();
		board.setUbd_no(rs.getInt("ubd_no"));
		board.setUbd_title(rs.getString("ubd_title"));
		board.setUbd_date(rs.getDate("ubd_date"));
		board.setUbd_file(rs.getString("ubd_file"));
		board.setUbd_cont(rs.getString("ubd_cont"));
		board.setUbd_cnt(rs.getInt("ubd_cnt"));
		board.setUbd_cate(rs.getString("ubd_cate"));
		board.setUser_no(rs.getInt("user_no"));
		board.setDog_kind(rs.getString("dog_kind"));
		board.setUser_nick(rs.getString("user_nick"));
		board.setLike_cnt(rs.getInt("like_cnt"));
		board.setReply_cnt(rs.getInt("reply_cnt"));
		return board;
	}

}
