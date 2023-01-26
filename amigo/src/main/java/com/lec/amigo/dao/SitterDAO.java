package com.lec.amigo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.lec.amigo.chat.JDBCUtility.JDBCUtility;
import com.lec.amigo.vo.ChatVO;
import com.lec.amigo.vo.SitterVO;
import com.lec.amigo.vo.UserVO;


@Repository("sitterDAO")
@PropertySource("classpath:config/sittersql.properties")

public class SitterDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	Environment environment;
	
	private String sitterInfo   = "select * from petsitter where user_no = ?";
	private String insertSitter = "";
	private String selectSitterList = "select * from petsitter where sit_no = ? ";
	
	@PostConstruct
	public void getSqlProperties() {
		
		insertSitter = environment.getProperty("insertSitter");
		sitterInfo   = environment.getProperty("sitterInfo");
		selectSitterList = environment.getProperty("selectSitterList");
	}
	
	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;
	SitterVO sit = null;
	
	public SitterVO sitterInfo (int sitno) {
		try {
			
		} catch (Exception e) {
			
		}
		return sit;
	}
	//private String insertSitter = "INSERT INTO pet_sitter (user_no, sit_gender, sit_birth, sit_smoking, sit_job, sit_days, "
	//		+ "sit_time, sit_exp, sit_care_exp, sit_intro, sit_photo) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
	// 23/01/19 : JDBC템플릿이,,,즉,,property 가 안먹힌다면, 주석을 푼다. 23/01/19
	
	public SitterVO insertSitter(SitterVO svo) {
		
		 
	
       
		jdbcTemplate.update(insertSitter, svo.getUser_no(), svo.getSit_gender(), 
        		svo.getSit_birth(), svo.isSit_smoking(),
        		svo.getSit_job(), svo.getSit_days(), svo.getSit_time(), 
        		svo.isSit_exp(), svo.getSit_care_exp(), svo.getSit_intro(),
        		svo.getSit_photo(), svo.isSit_auth_is());
   
        return svo;
        
	}
		
		
		
		
	}
	