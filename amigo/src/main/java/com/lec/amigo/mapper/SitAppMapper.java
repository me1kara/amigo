package com.lec.amigo.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.lec.amigo.vo.UserVO;         // 펫시터 정보가 row단위로 db에 쌓이도록??
import com.lec.amigo.vo.SitterVO;
											// JDBC 템플릿이  있어야 됨.
public class SitAppMapper implements RowMapper<SitterVO>{

	@Override
	public SitterVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		SitterVO sit = new SitterVO();
		UserVO  user = new UserVO();
		
                      
		sit.setUser_no(rs.getInt("user_no"));                       
		sit.setSit_gender(rs.getString("sit_gender"));      
		sit.setSit_birth(rs.getString("sit_birth"));        
		sit.setSit_smoking(rs.getBoolean("sit_smoking"));   
		sit.setSit_job(rs.getString("sit_job"));            
		sit.setSit_days(rs.getString("sit_days"));          
		sit.setSit_time(rs.getString("sit_time"));          
		sit.setSit_exp(rs.getBoolean("sit_exp"));           
		sit.setSit_care_exp(rs.getString("sit_care_exp"));  
		sit.setSit_intro(rs.getString("sit_intro"));        
		sit.setSit_photo(rs.getString("sit_photo"));        
		
		
		
		return sit;
	}

	
}
