package com.lec.amigo.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;


import org.springframework.jdbc.core.RowMapper;
import org.springframework.web.multipart.MultipartFile;

import com.lec.amigo.vo.DogVO;

public class DogRowMapper implements RowMapper<DogVO> {

	@Override
	public DogVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		DogVO dog = new DogVO();
		dog.setDog_no(rs.getInt("dog_no"));
		dog.setUser_no(rs.getInt("user_no"));
		dog.setDog_name(rs.getString("dog_name"));
		dog.setDog_gender(rs.getString("dog_gender"));
		dog.setDog_breeds(rs.getString("dog_breeds"));
		dog.setDog_birth(rs.getString("dog_birth"));
		dog.setDog_weight(rs.getDouble("dog_weight"));
		dog.setDog_neutered(rs.getBoolean("dog_neutered"));
		dog.setDog_rabies_vacc(rs.getBoolean("dog_rabies_vacc"));
		dog.setDog_image_file(rs.getString("dog_image_file"));
		dog.setDog_notice(rs.getString("dog_notice"));
		dog.setDog_terms(rs.getBoolean("dog_terms"));
		return dog;
	}
}
