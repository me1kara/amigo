package com.lec.amigo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.lec.amigo.chat.JDBCUtility.JDBCUtility;
import com.lec.amigo.vo.SitterVO;

@Repository("bookDAO")
public class BookDAO {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;

	public int calMoney(int days, int time) {
		String sql = "select sit_price from sit_price where sit_time=1";
		int price = jdbcTemplate.queryForObject(sql, Integer.class);
		int calResult = days*time*price;
		System.out.println(calResult+"예상비용입니다");
		return calResult;
	}

	public List<SitterVO> getArroudSitter(String address) {
		
		String[] addrList = address.split("\\s");
		String secondeAddr = addrList[1];

		String sql = "select u.user_no, s.sit_days, s.sit_time, s.sit_photo, s.sit_exp from user u,petsitter s "
				+ "where u.user_no = s.user_no and u.user_type='S' and user_addr like '%?%'";
		Object[] args = {secondeAddr};
		
		JSONObject sitterInfo = new JSONObject();
	
		Connection conn = JDBCUtility.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(0, secondeAddr);
			pstmt.executeQuery();			
			while(rs.next()) {
				
			}
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		
		
		
	
		
		return null;
	}

	
	
}
