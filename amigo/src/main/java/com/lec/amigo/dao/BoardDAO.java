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
import com.lec.amigo.vo.BoardVO;



@Repository("boardDAO")
@PropertySource("classpath:config/boardsql.properties")
public class BoardDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	Environment environment;
	
	private String sql = "";
	private String selectBoardListByUbdTitle = "";
	private String selectBoardListByUserNick = "";
	private String selectBoardListByUbdCont = "";
	
	@PostConstruct
	public void getSqlPropeties() {
		selectBoardListByUbdTitle = environment.getProperty("selectBoardListByUbdTitle");
		selectBoardListByUserNick = environment.getProperty("selectBoardListByUserNick");
		selectBoardListByUbdCont  = environment.getProperty("selectBoardListByUbdCont");
	}
	

	public List<BoardVO> getBoardList(SearchVO searchVO) {
		if(searchVO.getSearchType()==null || searchVO.getSearchType().isEmpty() ||
				searchVO.getSearchWord()==null || searchVO.getSearchWord().isEmpty()) {
			sql = selectBoardListByUbdTitle;
			searchVO.setSearchType("ubd_title");
		} else {
			if(searchVO.getSearchType().equalsIgnoreCase("ubd_title")) {
				sql = selectBoardListByUbdTitle;
			} else if(searchVO.getSearchType().equalsIgnoreCase("user_nick")) {
				sql = selectBoardListByUserNick;
			} else if(searchVO.getSearchType().equalsIgnoreCase("ubd_cont")) {
				sql = selectBoardListByUbdCont;
			} 					
		}
		
		String searchWord = "%" + searchVO.getSearchWord() + "%";					
		Object[] args = {searchWord, searchVO.getFirstRow(), searchVO.getRowSizePerPage()};
		return jdbcTemplate.query(sql, args, new BoardRowMapper());
	}
	
}
