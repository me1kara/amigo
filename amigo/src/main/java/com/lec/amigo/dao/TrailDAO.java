package com.lec.amigo.dao;

import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.lec.amigo.common.PagingVO;
import com.lec.amigo.mapper.DogRowMapper;
import com.lec.amigo.mapper.TrailRowMapper;
import com.lec.amigo.vo.DogVO;
import com.lec.amigo.vo.TrailVO;

@Repository("trailDAO")
@PropertySource("classpath:config/trailsql.properties")
public class TrailDAO {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	Environment environment;
	
	private String sql = "";
	private String selectTrail = "";                   
	private String insertTrail = "";      		  
	private String deleteTrail = "";      		  
	private String updateTrail = "";    	  	  
	private String selectTrailReviewListByRouteNo = "";
	private String trailTotalRowCount = "";

	
	@PostConstruct
	public void getSqlPropeties() {
		selectTrail                    = environment.getProperty("selectTrail");             
		insertTrail                    = environment.getProperty("insertTrail");      		 
		deleteTrail                    = environment.getProperty("deleteTrail");       		 
		updateTrail                    = environment.getProperty("updateTrail");        	  	 
		selectTrailReviewListByRouteNo = environment.getProperty("selectTrailReviewListByRouteNo");
		trailTotalRowCount             = environment.getProperty("trailTotalRowCount");
	}
	
	public List<TrailVO> getTrailReviewList(int route_no,PagingVO pagingVO) {
		Object[] args = {route_no,pagingVO.getFirstRow(),pagingVO.getRowSizePerPage()};
		return jdbcTemplate.query(selectTrailReviewListByRouteNo,args,new TrailRowMapper());
	}

	public int getTotalRowCount(int route_no) {
		return jdbcTemplate.queryForObject(trailTotalRowCount, Integer.class, route_no);
	}

	public TrailVO insertTrailReview(TrailVO trail) {
		jdbcTemplate.update(insertTrail,trail.getUser_no(),trail.getRoute_no(),trail.getWalk_star(),trail.getWalk_cont());
		return trail;
	}

	public int deleteTrailReview(int walk_review_no) {
		return jdbcTemplate.update(deleteTrail,walk_review_no);
	}

	public int updateTraiReview(TrailVO trail) {
		return jdbcTemplate.update(updateTrail,trail.getWalk_star(),trail.getWalk_cont(),trail.getWalk_review_no());
	}

	public TrailVO selectTrailReview(int walk_review_no) {
		Object[] args = {walk_review_no};
		return (TrailVO)jdbcTemplate.queryForObject(selectTrail, args, new TrailRowMapper());
	}
	
	
}
