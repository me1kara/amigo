package com.lec.amigo.dao;

import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.lec.amigo.mapper.CsReplyRowMapper;

import com.lec.amigo.vo.CsReplyVO;




@Repository("CsReplyDAO")
@PropertySource("classpath:config/csreplysql.properties")
public class CsReplyDAO {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	Environment environment;
	
	private String getCsReplyList = "";
	private String updateCsReply  = "";
	private String deleteCsReply  = "";
	private String insertCsReply  = "";
	private String getCsReply     = "";
	
	@PostConstruct
	public void getSqlPropeties() {
		getCsReplyList = environment.getProperty("getCsReplyList");
		updateCsReply  = environment.getProperty("updateCsReply");
		deleteCsReply  = environment.getProperty("deleteCsReply");
		insertCsReply  = environment.getProperty("insertCsReply");
		getCsReply     = environment.getProperty("getCsReply");
		
	}

	public List<CsReplyVO> getCsReplyList(int hbd_no) {
		Object[] args = { hbd_no };
		return jdbcTemplate.query(getCsReplyList, args, new CsReplyRowMapper());
	}

	public int updateCsReply(CsReplyVO csreply) {
		return jdbcTemplate.update(updateCsReply, csreply.getHbd_r_cont(), csreply.getHbd_r_no());
	}

	public int deleteCsReply(CsReplyVO csreply) {
		return jdbcTemplate.update(deleteCsReply, csreply.getHbd_r_no());
	}

	public CsReplyVO insertCsReply(CsReplyVO csreply) {
		jdbcTemplate.update(insertCsReply, csreply.getHbd_no(), csreply.getHbd_r_cont(), csreply.getHbd_r_ref(), csreply.getHbd_r_lev(), csreply.getHbd_r_seq(), csreply.getUser_no());
		return csreply;
	}

	public CsReplyVO getCsReply(CsReplyVO csreply) {
		Object[] args = { csreply.getHbd_r_no() };
		return jdbcTemplate.queryForObject(getCsReply, args, new CsReplyRowMapper());
	}


}
