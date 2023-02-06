package com.lec.amigo.dao;

import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.mapper.BoardRowMapper;
import com.lec.amigo.mapper.SitterBoardRowMapper;
import com.lec.amigo.vo.BoardVO;
import com.lec.amigo.vo.SitterBoardVO;

@Repository("sitterboardDAO")
@PropertySource("classpath:config/sitterboardsql.properties")
public class SitterBoardDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	Environment environment;
	
	private String sql = "";
	private String selectSitterBoardListBySbdTitle = "";
	private String selectSitterBoardListByUserNick = "";
	private String selectSitterBoardListBySbdCont = "";
	private String sitterBoardTotalRowCount = "";
	private String selectBySbdNo = "";
	private String updateCount = "";
	
	@PostConstruct
	public void getSqlPropeties() {
	
		selectSitterBoardListBySbdTitle = environment.getProperty("selectSitterBoardListBySbdTitle");
		selectSitterBoardListByUserNick = environment.getProperty("selectSitterBoardListByUserNick");
		selectSitterBoardListBySbdCont  = environment.getProperty("selectSitterBoardListBySbdCont");
		sitterBoardTotalRowCount        = environment.getProperty("sitterBoardTotalRowCount");
		selectBySbdNo                   = environment.getProperty("selectBySbdNo");
		updateCount                     = environment.getProperty("updateCount");
		
	}
	
	public List<SitterBoardVO> getSitterBoardList(SearchVO searchVO) {
		if(searchVO.getSearchType()==null || searchVO.getSearchType().isEmpty() ||
				searchVO.getSearchWord()==null || searchVO.getSearchWord().isEmpty()) {
			sql = selectSitterBoardListBySbdTitle;
			searchVO.setSearchType("ubd_title");
		} else {
			if(searchVO.getSearchType().equalsIgnoreCase("ubd_title")) {
				sql = selectSitterBoardListBySbdTitle;
			} else if(searchVO.getSearchType().equalsIgnoreCase("user_nick")) {
				sql = selectSitterBoardListByUserNick;
			} else if(searchVO.getSearchType().equalsIgnoreCase("ubd_cont")) {
				sql = selectSitterBoardListBySbdCont;
			} 
		}
		
		String searchWord = "%" + searchVO.getSearchWord() + "%";					
		Object[] args = {searchWord, searchVO.getFirstRow(), searchVO.getRowSizePerPage()};
		return jdbcTemplate.query(sql, args, new SitterBoardRowMapper());
	}
	
	
	public int getTotalRowCount(SearchVO searchVO) {
		if(searchVO.getSearchType()==null || searchVO.getSearchType().isEmpty() ||
				searchVO.getSearchWord()==null || searchVO.getSearchWord().isEmpty()) {
			sql = sitterBoardTotalRowCount;
			searchVO.setSearchType("ubd_title");
		} else {			
			if(searchVO.getSearchType().equalsIgnoreCase("ubd_title")) {
				sql = sitterBoardTotalRowCount + " and ubd_title like '%" + searchVO.getSearchWord() + "%'";
			} else if(searchVO.getSearchType().equalsIgnoreCase("user_nick")) {
				sql = sitterBoardTotalRowCount + " and user_nick like '%" + searchVO.getSearchWord() + "%'";
			} else if(searchVO.getSearchType().equalsIgnoreCase("ubd_cont")) {
				sql = sitterBoardTotalRowCount + " and ubd_cont like '%" + searchVO.getSearchWord() + "%'";
			}	
		}
		return jdbcTemplate.queryForObject(sql, Integer.class);
	} 
	
	public SitterBoardVO getSitterBoard(SitterBoardVO sboard) {
		Object[] args = { sboard.getSbd_no() };		
		return (SitterBoardVO) jdbcTemplate.queryForObject(selectBySbdNo, args, new SitterBoardRowMapper());
	}
	
	public void updateCount(int sbd_no) {
		jdbcTemplate.update(updateCount, sbd_no);
	}
	

}

