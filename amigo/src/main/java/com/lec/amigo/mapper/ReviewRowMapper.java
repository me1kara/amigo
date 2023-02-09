package com.lec.amigo.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.lec.amigo.vo.ReviewVO;

public class ReviewRowMapper implements RowMapper<ReviewVO>{
	public ReviewVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		ReviewVO rvo = new ReviewVO();
		rvo.setRev_no(rs.getInt("rev_no"));
		rvo.setSit_no(rs.getInt("sit_no"));
		rvo.setUser_no(rs.getInt("user_no"));
		rvo.setStar_cnt(rs.getInt("star_cnt"));
		rvo.setRev_content(rs.getString("rev_content"));
		rvo.setRev_date(rs.getDate("rev_date"));
		rvo.setUser_addr(rs.getString("user_addr"));
		rvo.setUser_nick(rs.getString("user_nick"));
		rvo.setUser_name(rs.getString("user_name"));
		rvo.setUser_photo(rs.getString("user_photo"));


		return rvo;
	}

}
