package com.lec.amigo.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.lec.amigo.vo.BookContentVO;
public class BookContentRowMapper implements RowMapper<BookContentVO>{
	public BookContentVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		BookContentVO bookContent = new BookContentVO();
		
		bookContent.setRes_no(rs.getInt("res_no"));
		bookContent.setRes_date(rs.getDate("res_date"));
		bookContent.setRes_time(rs.getString("res_time"));
		bookContent.setDog_no(rs.getInt("dog_no"));
		bookContent.setRes_addr(rs.getString("res_addr"));
		
		return bookContent;
	}

}
