package com.lec.amigo.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.lec.amigo.vo.UserVO;
import com.lec.amigo.mapper.JDBCUtility;
import com.lec.amigo.mapper.UserRowMapper;

@Repository("userDAO")
@PropertySource("classpath:config/usersql.properties")
public class UserDAO {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	Environment environment;
	
	private String selectByEmail = "select * from user where user_email = ?";
	private String updatePw = "";
	private String insertUser = "";
	private String emailCheck = "";
	
	@PostConstruct
	public void getSqlPropeties() {
		updatePw   = environment.getProperty("updatePw");
		insertUser = environment.getProperty("insertUser");
		emailCheck = environment.getProperty("emailCheck");
	}
	
	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;
	UserVO user = null;
	
	public UserVO getUser(String email) {
		
		try {
			conn = JDBCUtility.getConnection();
			stmt = conn.prepareStatement(selectByEmail);
			stmt.setString(1, email);
			rs = stmt.executeQuery();
			while(rs.next()) {
				user = new UserVO();
				user.setUser_no(rs.getInt("user_no"));
				user.setUser_type(rs.getString("user_type"));
				user.setUser_email(rs.getString("user_email"));
				user.setUser_pw(rs.getString("user_pw"));
				user.setUser_name(rs.getString("user_name"));
				user.setUser_nick(rs.getString("user_nick"));
				user.setUser_addr(rs.getString("user_addr"));
				user.setUser_phone(rs.getString("user_phone"));
				user.setUser_photo(rs.getString("user_photo"));
				user.setUser_terms(rs.getBoolean("user_terms"));
			}
			
		} catch (Exception e) {
			System.out.println("DB접속 실패다 " + e.getMessage() );
		} finally {
			JDBCUtility.close(conn, rs, stmt);
		}
		
		return user;
	}

	public int updatePw(UserVO vo) {
		return jdbcTemplate.update(updatePw, vo.getUser_pw(), vo.getUser_email());
	}

	public UserVO insertUser(UserVO userVO) {
		userVO.setUser_type((userVO.getUser_type() != null ? "A" : "U"));
		jdbcTemplate.update(insertUser, userVO.getUser_type(), userVO.getUser_email(), userVO.getUser_pw(), userVO.getUser_name(), userVO.getUser_nick(), userVO.getUser_addr(), userVO.getUser_phone());
		return userVO;
	}

	public int emailCheck(String user_email) {
		int cnt = jdbcTemplate.queryForObject(emailCheck, Integer.class, user_email);
		return cnt;
	}

}
