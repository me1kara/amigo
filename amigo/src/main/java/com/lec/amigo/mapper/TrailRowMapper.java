package com.lec.amigo.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.lec.amigo.vo.TrailVO;

public class TrailRowMapper implements RowMapper<TrailVO> {

	@Override
	public TrailVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		TrailVO trail = new TrailVO();	
		trail.setWalk_review_no(rs.getInt("walk_review_no"));
		trail.setRoute_no(rs.getInt("route_no"));
		trail.setUser_no(rs.getInt("user_no"));
		trail.setWalk_star(rs.getInt("walk_star"));
		trail.setWalk_cont(rs.getString("walk_cont"));
		trail.setUser_nick(rs.getString("user_nick"));	
		return trail;
	}

}
