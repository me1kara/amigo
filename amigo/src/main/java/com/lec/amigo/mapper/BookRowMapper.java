package com.lec.amigo.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.lec.amigo.vo.BookVO;
import com.lec.amigo.vo.ChatVO;

public class BookRowMapper implements RowMapper<BookVO>{

	@Override
	public BookVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		System.out.println("확인용");
		
		BookVO book = new BookVO();
		book.setRes_no(rs.getInt("res_no"));
		book.setUser_no(rs.getInt("user_no"));
		book.setSit_no(rs.getInt("sit_no"));
		book.setRes_regdate(rs.getDate("res_regdate"));
		
		if(rs.getString("res_date")!=null)book.setRes_date(rs.getString("res_date"));
		if(rs.getString("res_time")!=null)book.setRes_time(rs.getString("res_time"));
		book.setRes_etc(rs.getString("res_etc"));
		book.setRes_pay(rs.getInt("res_pay"));
		book.setRes_visit_is(rs.getBoolean("res_visit_is"));
		book.setRes_term_is(rs.getBoolean("res_term_is"));
		
		return book;
	}
	
	
}
