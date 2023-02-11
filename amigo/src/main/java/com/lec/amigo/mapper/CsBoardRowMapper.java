package com.lec.amigo.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.lec.amigo.vo.CsBoardVO;


public class CsBoardRowMapper implements RowMapper<CsBoardVO>{

	@Override
	public CsBoardVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		CsBoardVO csboard = new CsBoardVO();
		csboard.setHbd_no(rs.getInt("hbd_no"));
		csboard.setHbd_title(rs.getString("hbd_title"));
		csboard.setHbd_date(rs.getDate("hbd_date"));
		csboard.setHbd_cont(rs.getString("hbd_cont"));
		csboard.setHbd_cnt(rs.getInt("hbd_cnt"));
		csboard.setUser_no(rs.getInt("user_no"));
		csboard.setUser_nick(rs.getString("user_nick"));
		csboard.setReply_cnt(rs.getInt("reply_cnt"));
		csboard.setUser_photo(rs.getString("user_photo"));
		return csboard ;
	}

}
