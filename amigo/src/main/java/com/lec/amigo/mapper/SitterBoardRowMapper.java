package com.lec.amigo.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.lec.amigo.vo.SitterBoardVO;

public class SitterBoardRowMapper implements RowMapper<SitterBoardVO>{

	@Override
	public SitterBoardVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		SitterBoardVO sboard = new SitterBoardVO();
		sboard.setSbd_no(rs.getInt("sbd_no"));
		sboard.setSbd_title(rs.getString("sbd_title"));
		sboard.setSbd_date(rs.getDate("sbd_date"));
		sboard.setSbd_cont(rs.getString("sbd_cont"));
		sboard.setSbd_cnt(rs.getInt("sbd_cnt"));
		sboard.setUser_no(rs.getInt("user_no"));
		sboard.setUser_nick(rs.getString("user_nick"));
		sboard.setReply_cnt(rs.getInt("reply_cnt"));
		sboard.setSit_photo(rs.getString("sit_photo"));
		return sboard;
	}

}
