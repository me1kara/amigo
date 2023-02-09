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
import com.lec.amigo.vo.HeartVO;



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
	private String selectBoardListByUbdTitleLike = "";
	private String selectBoardListByUserNickLike = "";
	private String selectBoardListByUbdContLike = "";
	private String boardTotalRowCount = "";
	private String boardCateRowCount = "";
	private String selectByUbdNo = "";
	private String updateCount = "";
	private String updateBoard = "";
	private String deleteBoard = "";
	private String selectCateByUbdTitle = "";
	private String selectCateByUserNick = "";
	private String selectCateByUbdCont = "";
	private String insertBoard = "";
	private String findHeart = "";
	private String insertHeart = "";
	private String deleteHeart = "";
	private String countHeart = "";
	
	@PostConstruct
	public void getSqlPropeties() {
		selectBoardListByUbdTitleLike = environment.getProperty("selectBoardListByUbdTitleLike");
		selectBoardListByUserNickLike = environment.getProperty("selectBoardListByUserNickLike");
		selectBoardListByUbdContLike  = environment.getProperty("selectBoardListByUbdContLike");
		selectBoardListByUbdTitle     = environment.getProperty("selectBoardListByUbdTitle");
		selectBoardListByUserNick     = environment.getProperty("selectBoardListByUserNick");
		selectBoardListByUbdCont      = environment.getProperty("selectBoardListByUbdCont");
		boardTotalRowCount            = environment.getProperty("boardTotalRowCount");
		boardCateRowCount             = environment.getProperty("boardCateRowCount");
		selectByUbdNo                 = environment.getProperty("selectByUbdNo");
		updateCount                   = environment.getProperty("updateCount");
		updateBoard                   = environment.getProperty("updateBoard");
		deleteBoard                   = environment.getProperty("deleteBoard");
		selectCateByUbdTitle          = environment.getProperty("selectCateByUbdTitle");
		selectCateByUserNick          = environment.getProperty("selectCateByUserNick");
		selectCateByUbdCont           = environment.getProperty("selectCateByUbdCont");
		insertBoard                   = environment.getProperty("insertBoard");
		findHeart                     = environment.getProperty("findHeart");
		insertHeart                   = environment.getProperty("insertHeart");
		deleteHeart                   = environment.getProperty("deleteHeart");
		countHeart                    = environment.getProperty("countHeart");
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
	
	public List<BoardVO> getBoardListLike(SearchVO searchVO) {
		if(searchVO.getSearchType()==null || searchVO.getSearchType().isEmpty() ||
				searchVO.getSearchWord()==null || searchVO.getSearchWord().isEmpty()) {
			sql = selectBoardListByUbdTitleLike;
			searchVO.setSearchType("ubd_title");
		} else {
			if(searchVO.getSearchType().equalsIgnoreCase("ubd_title")) {
				sql = selectBoardListByUbdTitleLike;
			} else if(searchVO.getSearchType().equalsIgnoreCase("user_nick")) {
				sql = selectBoardListByUserNickLike;
			} else if(searchVO.getSearchType().equalsIgnoreCase("ubd_cont")) {
				sql = selectBoardListByUbdContLike;
			} 					
		}
		
		String searchWord = "%" + searchVO.getSearchWord() + "%";					
		Object[] args = {searchWord, searchVO.getFirstRow(), searchVO.getRowSizePerPage()};
		return jdbcTemplate.query(sql, args, new BoardRowMapper());
	}
	

	public List<BoardVO> selectCate(BoardVO board, SearchVO searchVO) {
		if(searchVO.getSearchType()==null || searchVO.getSearchType().isEmpty() ||
				searchVO.getSearchWord()==null || searchVO.getSearchWord().isEmpty()) {
			sql = selectCateByUbdTitle;
			searchVO.setSearchType("ubd_title");
		} else {
			if(searchVO.getSearchType().equalsIgnoreCase("ubd_title")) {
				sql = selectCateByUbdTitle;
			} else if(searchVO.getSearchType().equalsIgnoreCase("user_nick")) {
				sql = selectCateByUserNick;
			} else if(searchVO.getSearchType().equalsIgnoreCase("ubd_cont")) {
				sql = selectCateByUbdCont;
			} 					
		}
		
		String searchWord = "%" + searchVO.getSearchWord() + "%";					
		Object[] args = { board.getUbd_cate(), searchWord, searchVO.getFirstRow(), searchVO.getRowSizePerPage() };
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
	
	public int getCateRowCount (SearchVO searchVO, BoardVO board) {
		if(searchVO.getSearchType()==null || searchVO.getSearchType().isEmpty() ||
				searchVO.getSearchWord()==null || searchVO.getSearchWord().isEmpty()) {
			sql = boardCateRowCount;
			searchVO.setSearchType("ubd_title");
		} else {			
			if(searchVO.getSearchType().equalsIgnoreCase("ubd_title")) {
				sql = boardCateRowCount + " and ubd_title like '%" + searchVO.getSearchWord() + "%'";
			} else if(searchVO.getSearchType().equalsIgnoreCase("user_nick")) {
				sql = boardCateRowCount + " and user_nick like '%" + searchVO.getSearchWord() + "%'";
			} else if(searchVO.getSearchType().equalsIgnoreCase("ubd_cont")) {
				sql = boardCateRowCount + " and ubd_cont like '%" + searchVO.getSearchWord() + "%'";
			}	
		}
		return jdbcTemplate.queryForObject(sql, Integer.class, board.getUbd_cate());
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


	public BoardVO insertBoard(BoardVO board) {
		jdbcTemplate.update(insertBoard, board.getUbd_title(), board.getUbd_file(), board.getUbd_cont(), board.getUbd_cate(), board.getUser_no(), board.getDog_kind());
		return board;	
	}


	public int findHeart(int user_no, int ubd_no) {
		return jdbcTemplate.queryForObject(findHeart, Integer.class, user_no, ubd_no);
	}


	public int insertHeart(HeartVO heart) {
		return jdbcTemplate.update(insertHeart, heart.getUser_no(), heart.getUbd_no());
	}


	public void deleteHeart(HeartVO heart) {
		jdbcTemplate.update(deleteHeart, heart.getUser_no(), heart.getUbd_no());
	}
	
	public int countHeart(int ubd_no) {
		return jdbcTemplate.queryForObject(countHeart, Integer.class, ubd_no);
	}
	
}
