package com.lec.amigo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.lec.amigo.chat.JDBCUtility.JDBCUtility;
import com.lec.amigo.common.SearchVO;
import com.lec.amigo.mapper.BookContentRowMapper;
import com.lec.amigo.mapper.SitRowMapper;
import com.lec.amigo.mapper.SitterRowMapper;
import com.lec.amigo.vo.SitterVO;
import com.lec.amigo.vo.UserVO;



@Repository("sitterDAO")
@PropertySource("classpath:config/sittersql.properties")

public class SitterDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;	// Jdbc 템플릿 사용.
	
	@Autowired
	Environment environment;			// 설정(properties)을 java에서 가져오지 않고 외부의 파일에서 sql문 등을 가져오기 위해 이 객체를 사용하여 스프링 빈과 설정을 세팅함.
	
	private String sql          = "";
	private String selectSitter = "";	// getSitter
	private String selectSitterA   = "";
	private String selectSitterByG = "";
	private String selectSitterByUserName = "";
	private String sitterTotalRowCount = "";
	private String selectSitterByUserNo = "";
	private String selectSitterInfo = "";   // 펫시터 개인의 상세정보
	private String selectSitterCate = "";   // 승인/미승인 을 나눠서 정렬하기
	private String insertSitter = "";
	private String deleteSitter = "";
	private String updateSitter = "";
	private String updateTypeS  = "";
	private String updateTypeU  = "";
	private String selectSitListByUserNo = "";
	
	@PostConstruct
	public void getSqlProperties() {
		
		selectSitter            = environment.getProperty("selectSitter");
		selectSitterA           = environment.getProperty("selectSitterA");
		selectSitterByG         = environment.getProperty("selectSitterByG");
		selectSitterByUserName  = environment.getProperty("selectSitterByUserName");
		sitterTotalRowCount     = environment.getProperty("sitterTotalRowCount");
		selectSitterInfo        = environment.getProperty("selectSitterInfo");
		selectSitterByUserNo    = environment.getProperty("selectSitterByUserNo");
		selectSitterCate        = environment.getProperty("selectSitterCate");
		insertSitter            = environment.getProperty("insertSitter");
		deleteSitter            = environment.getProperty("deleteSitter");
		updateSitter            = environment.getProperty("updateSitter");
		updateTypeS             = environment.getProperty("updateTypeS");
		updateTypeU             = environment.getProperty("updateTypeU");
		selectSitListByUserNo   = environment.getProperty("selectSitListByUserNo");
	}
	
	public SitterVO getSitter(SitterVO svo) {
		String sql = "select p.*, u.user_name from petsitter p, user u WHERE u.user_no = p.user_no and p.sit_no=?";
		Object[] args = {svo.getSit_no()};		
		return jdbcTemplate.queryForObject(sql, args, new SitRowMapper());
	}
	public SitterVO getSitter(int user_no) {
		String sql = "select * from petsitter where user_no=?";
		System.out.println(user_no+"유넘 확인용");
		Object[] args = {user_no};		
		return jdbcTemplate.queryForObject(sql, args, new SitterRowMapper());
	}

	public SitterVO sitterInfo(SitterVO svo) {
		Object[] args = { svo.getUser_no() };
		return (SitterVO) jdbcTemplate.query(selectSitterInfo, args, new SitRowMapper());
		
	}
	
	public List<SitterVO> getSitInfoList(int userno) {
		
		sql = selectSitterByUserNo;
		Object[] args = {userno};
		
		try {
			return jdbcTemplate.query(sql, args, new SitRowMapper());
		} catch (Exception e) {
			// TODO: handle exception
		}
		 
		return null;
		
	}
	
	public List<SitterVO> getSitList(SearchVO searchVO) {
		if(searchVO.getSearchType()==null || searchVO.getSearchType().isEmpty() ||
				searchVO.getSearchWord()==null || searchVO.getSearchWord().isEmpty()) {
			sql = selectSitter;
			searchVO.setSearchType("user_name");
		} else {
			if(searchVO.getSearchType().equalsIgnoreCase("user_name")) {
				sql = selectSitterByUserName;
			} else if(searchVO.getSearchType().equalsIgnoreCase("sit_auth_is")) {
				sql = selectSitterA;
			} else if(searchVO.getSearchType().equalsIgnoreCase("sit_gender")) {
				sql = selectSitterByG;
			} 					
		}
		
		String searchWord = "%" + searchVO.getSearchWord() + "%";			  // sql문에서 limit를 나타냄		
		Object[] args = {searchWord, searchVO.getFirstRow(), searchVO.getRowSizePerPage()};	
		return jdbcTemplate.query(sql, args, new SitRowMapper());
	}

	
	public int getTotalSitRowCount(SearchVO searchVO) {
		if(searchVO.getSearchType()==null || searchVO.getSearchType().isEmpty() ||
				searchVO.getSearchWord()==null || searchVO.getSearchWord().isEmpty()) {
			sql = sitterTotalRowCount;
			searchVO.setSearchType("user_name");  // 검색조건이 비어있을때 모두 나오게 (또는 모든 갯수) 를 보이게 하려면?
		} else {			
			if(searchVO.getSearchType().equalsIgnoreCase("user_name")) {
				sql = sitterTotalRowCount + " where user_name like '%" + searchVO.getSearchWord() + "%'";
			} else if(searchVO.getSearchType().equalsIgnoreCase("sit_auth_is")) {
				sql = sitterTotalRowCount + " where sit_auth_is like '%" + searchVO.getSearchWord() + "%'";
			} else if(searchVO.getSearchType().equalsIgnoreCase("sit_gender")) {
				sql = sitterTotalRowCount + " where sit_gender like '%" + searchVO.getSearchWord() + "%'";
			}	
		}
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}
	
	
	public List<SitterVO> getSitListCate(SitterVO svo, SearchVO searchVO){
		return null;	
	}
	
	
	public SitterVO insertSitter(SitterVO svo) {
		jdbcTemplate.update(insertSitter,svo.getUser_no(),svo.getSit_gender(),svo.getSit_birth(),svo.isSit_smoking(),svo.getSit_job(),svo.getSit_days(),svo.getSit_time(),svo.isSit_exp(),svo.getSit_care_exp(),svo.getSit_intro(),svo.getSit_photo(),svo.isSit_auth_is());
		return svo;
	}
	
	public int updateSitter(SitterVO svo, boolean sit_auth_is) {
		System.out.println(updateSitter);
		int a = jdbcTemplate.update(updateSitter, true, svo.getUser_no());  // int로 받아서,, 쿼리문, true처리, 객체에서 유저정보를 받아와서 -> 처리.
		System.out.println(a+"성공여부 확인");                              // 콘솔로 성공여부 확인하기.
		return a;                                                           // a 라는 업뎃문 실행.
	}
	
	public void updateTypeS(SitterVO svo) {
		jdbcTemplate.update(updateTypeS, svo.getUser_type());
	}
	
	public void updateTypeU(SitterVO svo) {
		jdbcTemplate.update(updateTypeU, svo.getUser_type());
	}
	
/*public int updateSitter(SitterVO svo) {
		return jdbcTemplate.update(updateSitter,svo.getSit_gender(),svo.getSit_birth(),svo.isSit_smoking(),svo.getSit_job(),svo.getSit_days(),svo.getSit_time(),svo.isSit_exp(),svo.getSit_care_exp(),svo.getSit_intro(),svo.getSit_photo(),svo.isSit_auth_is());
	}*/
	
	public int deleteSitter(int user_no) {
		
		
		System.out.println(deleteSitter);                    // 쿼리 확인하기
		int del = jdbcTemplate.update(deleteSitter, user_no); // 업데이트 매서드를 위한 변수.
		return del;                                          // 변수 반환.
	}

}