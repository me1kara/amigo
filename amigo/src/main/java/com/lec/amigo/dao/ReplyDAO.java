package com.lec.amigo.dao;

import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.lec.amigo.mapper.ReplyRowMapper;
import com.lec.amigo.vo.ReplyVO;

@Repository("replyDAO")
@PropertySource("classpath:config/replysql.properties")
public class ReplyDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	Environment environment;
	
	private String selectReplyList = "";
	private String updateReply = "";
	private String deleteReply = "";
	private String insertReply = "";
	private String selectReplyNo = "";
	
	@PostConstruct
	public void getSqlPropeties() {
		selectReplyList = environment.getProperty("selectReplyList");
		updateReply     = environment.getProperty("updateReply");
		deleteReply     = environment.getProperty("deleteReply");
 		insertReply     = environment.getProperty("insertReply");
 		selectReplyNo   = environment.getProperty("selectReplyNo");
	}

	public List<ReplyVO> getReplyList(int ubd_no) {
		Object[] args = { ubd_no };
		return jdbcTemplate.query(selectReplyList, args, new ReplyRowMapper());
	}

	public int updateReply(ReplyVO reply) {
		return jdbcTemplate.update(updateReply, reply.getUbd_r_content(), reply.getUbd_r_no());
	}

	public int deleteReply(ReplyVO reply) {
		return jdbcTemplate.update(deleteReply, reply.getUbd_r_no());
	}

	public ReplyVO insertReply(ReplyVO reply) {
		jdbcTemplate.update(insertReply, reply.getUbd_no(), reply.getUbd_r_content(), reply.getUbd_r_ref(), reply.getUbd_r_lev(), reply.getUbd_r_seq(), reply.getUser_no());
		return reply;
	}

	public ReplyVO getReply(ReplyVO reply) {
		Object[] args = { reply.getUbd_r_no() };
		return jdbcTemplate.queryForObject(selectReplyNo, args, new ReplyRowMapper());
	}
	
	
	
}
