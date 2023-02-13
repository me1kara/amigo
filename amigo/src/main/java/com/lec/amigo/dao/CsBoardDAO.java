package com.lec.amigo.dao;

import java.util.List;


import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.mapper.CsBoardRowMapper;
import com.lec.amigo.vo.CsBoardVO;


@Repository("csboardDAO")
@PropertySource("classpath:config/csboardsql.properties")
public class CsBoardDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	Environment environment;
	
	private String sql = "";
	private String selectCsBoardListByHbdTitle = "";
	private String selectCsBoardListByUserNick = "";
	private String selectCsBoardListByHbdCont = "";
	private String CsBoardTotalRowCount = "";
	private String selectByHbdNo = "";
	private String updateHbdCount = "";
	private String insertCsBoard = "";
	private String updateCsBoard = "";
	private String deleteCsBoard = "";
	
	@PostConstruct
	public void getSqlPropeties() {
	
		selectCsBoardListByHbdTitle = environment.getProperty("selectCsBoardListByHbdTitle");
		selectCsBoardListByUserNick = environment.getProperty("selectCsBoardListByUserNick");
		selectCsBoardListByHbdCont  = environment.getProperty("selectCsBoardListByHbdCont");
		CsBoardTotalRowCount        = environment.getProperty("CsBoardTotalRowCount");
		selectByHbdNo                   = environment.getProperty("selectByHbdNo");
		updateHbdCount                  = environment.getProperty("updateHbdCount");
		insertCsBoard               = environment.getProperty("insertCsBoard");
		updateCsBoard               = environment.getProperty("updateCsBoard");
		deleteCsBoard               = environment.getProperty("deleteCsBoard");
	}
	
	public List<CsBoardVO> getCsBoardList(SearchVO searchVO) {
		if(searchVO.getSearchType()==null || searchVO.getSearchType().isEmpty() ||
				searchVO.getSearchWord()==null || searchVO.getSearchWord().isEmpty()) {
			sql = selectCsBoardListByHbdTitle;
			searchVO.setSearchType("Hbd_title");
		} else {
			if(searchVO.getSearchType().equalsIgnoreCase("Hbd_title")) {
				sql = selectCsBoardListByHbdTitle;
			} else if(searchVO.getSearchType().equalsIgnoreCase("user_nick")) {
				sql = selectCsBoardListByUserNick;
			} else if(searchVO.getSearchType().equalsIgnoreCase("Hbd_cont")) {
				sql = selectCsBoardListByHbdCont;
			} 
		}
		
		String searchWord = "%" + searchVO.getSearchWord() + "%";					
		Object[] args = {searchWord, searchVO.getFirstRow(), searchVO.getRowSizePerPage()};
		return jdbcTemplate.query(sql, args, new CsBoardRowMapper());
	}
	
	
	public int getTotalRowCount(SearchVO searchVO) {
		if(searchVO.getSearchType()==null || searchVO.getSearchType().isEmpty() ||
				searchVO.getSearchWord()==null || searchVO.getSearchWord().isEmpty()) {
			sql = CsBoardTotalRowCount;
			searchVO.setSearchType("hbd_title");
		} else {			
			if(searchVO.getSearchType().equalsIgnoreCase("hbd_title")) {
				sql = CsBoardTotalRowCount + " and hbd_title like '%" + searchVO.getSearchWord() + "%'";
			} else if(searchVO.getSearchType().equalsIgnoreCase("user_nick")) {
				sql = CsBoardTotalRowCount + " and user_nick like '%" + searchVO.getSearchWord() + "%'";
			} else if(searchVO.getSearchType().equalsIgnoreCase("hbd_cont")) {
				sql = CsBoardTotalRowCount + " and hbd_cont like '%" + searchVO.getSearchWord() + "%'";
			}	
		}
		return jdbcTemplate.queryForObject(sql, Integer.class);
	} 
	
	public CsBoardVO getCsBoard(CsBoardVO csboard) {
		Object[] args = { csboard.getHbd_no() };		
		return (CsBoardVO) jdbcTemplate.queryForObject(selectByHbdNo, args, new CsBoardRowMapper());
	}
	
	public void updateHbdCount(int hbd_no) {
		jdbcTemplate.update(updateHbdCount, hbd_no);
	}

	public CsBoardVO insertCsBoard(CsBoardVO csboard) {
		jdbcTemplate.update(insertCsBoard, csboard.getHbd_title(),csboard.getHbd_file(), csboard.getHbd_cont(), csboard.getUser_no());
		return csboard;
	}

	public int updateCsBoard(CsBoardVO csboard) {
		return jdbcTemplate.update(updateCsBoard, csboard.getHbd_title(),csboard.getHbd_file(), csboard.getHbd_cont(), csboard.getHbd_no());
	}

	public int deleteCsBoard(CsBoardVO csboard) {
		return jdbcTemplate.update(deleteCsBoard, csboard.getHbd_no());
	}
	

}

