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
	private String boardTotalRowCount = "";
	private String selectByUbdNo = "";
	private String updateCount = "";
	private String updateBoard = "";
	private String deleteBoard = "";
	private String selectCate = "";
	private String boardCateRowCount = "";
	
	@PostConstruct
	public void getSqlPropeties() {
		selectBoardListByUbdTitle = environment.getProperty("selectBoardListByUbdTitle");
		selectBoardListByUserNick = environment.getProperty("selectBoardListByUserNick");
		selectBoardListByUbdCont  = environment.getProperty("selectBoardListByUbdCont");
		boardTotalRowCount        = environment.getProperty("boardTotalRowCount");
		selectByUbdNo             = environment.getProperty("selectByUbdNo");
		updateCount               = environment.getProperty("updateCount");
		updateBoard               = environment.getProperty("updateBoard");
		deleteBoard               = environment.getProperty("deleteBoard");
		selectCate                = environment.getProperty("selectCate");
		boardCateRowCount         = environment.getProperty("boardCateRowCount");
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


	public int getTotalRowCount(SearchVO searchVO) {
		if(searchVO.getSearchType()==null || searchVO.getSearchType().isEmpty() ||
				searchVO.getSearchWord()==null || searchVO.getSearchWord().isEmpty()) {
			sql = boardTotalRowCount;
			searchVO.setSearchType("ubd_title");
		} else {			
			if(searchVO.getSearchType().equalsIgnoreCase("ubd_title")) {
				sql = boardTotalRowCount + " and ubd_title like '%" + searchVO.getSearchWord() + "%'";
			} else if(searchVO.getSearchType().equalsIgnoreCase("user_nick")) {
				sql = boardTotalRowCount + " and user_nick like '%" + searchVO.getSearchWord() + "%'";
			} else if(searchVO.getSearchType().equalsIgnoreCase("ubd_cont")) {
				sql = boardTotalRowCount + " and ubd_cont like '%" + searchVO.getSearchWord() + "%'";
			}	
		}
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}


	public BoardVO getBoard(BoardVO board) {
		Object[] args = { board.getUbd_no() };		
		return (BoardVO) jdbcTemplate.queryForObject(selectByUbdNo, args, new BoardRowMapper());
	}


	public void updateCount(int ubd_no) {
		jdbcTemplate.update(updateCount, ubd_no);
	}

	public int updateBoard(BoardVO board) {
		return jdbcTemplate.update(updateBoard, board.getUbd_title(), board.getUbd_file(), board.getUbd_cont(), board.getUbd_cate(), board.getDog_kind(), board.getUbd_no());
	}


	public int deleteBoard(BoardVO board) {
		return jdbcTemplate.update(deleteBoard, board.getUbd_no());
	}

	public List<BoardVO> selectCate(BoardVO board) {
		Object[] args = { board.getUbd_cate() };
		return jdbcTemplate.query(selectCate, args, new BoardRowMapper());
	}
	
	
	
}
