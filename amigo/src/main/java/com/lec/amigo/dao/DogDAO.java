package com.lec.amigo.dao;

import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.lec.amigo.mapper.DogRowMapper;
import com.lec.amigo.vo.DogVO;

@Repository("dogDAO")
@PropertySource("classpath:config/dogsql.properties")
public class DogDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	Environment environment;
	
	private String sql = "";
	private String selectDog = "";
	private String insertDog = "";
	private String deleteDog = "";
	private String updateDog = "";
	private String selectDogListByUserNo = "";
	
	@PostConstruct
	public void getSqlPropeties() {
		selectDog             = environment.getProperty("selectDog");      
		insertDog             = environment.getProperty("insertDog");      
		deleteDog             = environment.getProperty("deleteDog");      
		updateDog             = environment.getProperty("updateDog");      
		selectDogListByUserNo = environment.getProperty("selectDogListByUserNo");
			
	}
	
	public List<DogVO> getDogList(DogVO dog) {
		
		//select * from dog where user_no = ?
		
		Object[] args = {};
		
		return jdbcTemplate.query(selectDogListByUserNo, args, new DogRowMapper());
	}
	
	public DogVO getDog(DogVO dog) {
		Object[] args = { dog.getDog_no() };
		return (DogVO) jdbcTemplate.queryForObject(selectDog, args, new DogRowMapper());
	}
	
	public void insertDog(DogVO dog) {
		
		//jdbcTemplate.update(sql, user.getId(), user.getPassword(), user.getName(), role);
	}
	
	
	
	
	
	
	
	
	
	
	
}
