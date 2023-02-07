package com.lec.amigo.dao;

import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.lec.amigo.mapper.SitterReplyRowMapper;
import com.lec.amigo.vo.SitterReplyVO;

@Repository("sitterReplyDAO")
@PropertySource("classpath:config/sitterreplysql.properties")
public class SitterReplyDAO {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	Environment environment;
	
	private String getSitterReplyList = "";
	private String updateSitterReply  = "";
	private String deleteSitterReply  = "";
	private String insertSitterReply  = "";
	private String getSitterReply     = "";
	
	@PostConstruct
	public void getSqlPropeties() {
		getSitterReplyList = environment.getProperty("getSitterReplyList");
		updateSitterReply  = environment.getProperty("updateSitterReply");
		deleteSitterReply  = environment.getProperty("deleteSitterReply");
		insertSitterReply  = environment.getProperty("insertSitterReply");
		getSitterReply     = environment.getProperty("getSitterReply");
		
	}

	public List<SitterReplyVO> getSitterReplyList(int sbd_no) {
		Object[] args = { sbd_no };
		return jdbcTemplate.query(getSitterReplyList, args, new SitterReplyRowMapper());
	}

	public int updateSitterReply(SitterReplyVO sreply) {
		return jdbcTemplate.update(updateSitterReply, sreply.getSbd_r_cont(), sreply.getSbd_r_no());
	}

	public int deleteSitterReply(SitterReplyVO sreply) {
		return jdbcTemplate.update(deleteSitterReply, sreply.getSbd_r_no());
	}

	public SitterReplyVO insertSitterReply(SitterReplyVO sreply) {
		jdbcTemplate.update(insertSitterReply, sreply.getSbd_no(), sreply.getSbd_r_cont(), sreply.getSbd_r_ref(), sreply.getSbd_r_lev(), sreply.getSbd_r_seq(), sreply.getUser_no());
		return sreply;
	}

	public SitterReplyVO getSitterReply(SitterReplyVO sreply) {
		Object[] args = { sreply.getSbd_r_no() };
		return jdbcTemplate.queryForObject(getSitterReply, args, new SitterReplyRowMapper());
	}

}
