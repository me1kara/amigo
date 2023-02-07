package com.lec.amigo.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.lec.amigo.vo.SitterReplyVO;

public class SitterReplyRowMapper implements RowMapper<SitterReplyVO> {

	@Override
	public SitterReplyVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		SitterReplyVO sreply = new SitterReplyVO();
		sreply.setSbd_r_no(rs.getInt("sbd_r_no"));
		sreply.setSbd_no(rs.getInt("sbd_no"));
		sreply.setSbd_r_cont(rs.getString("sbd_r_cont"));
		sreply.setSbd_r_regdate(rs.getDate("sbd_r_regdate"));
		sreply.setSbd_r_ref(rs.getInt("sbd_r_ref"));
		sreply.setSbd_r_lev(rs.getInt("sbd_r_lev"));
		sreply.setSbd_r_seq(rs.getInt("sbd_r_seq"));
		sreply.setUser_no(rs.getInt("user_no"));
		sreply.setUser_nick(rs.getString("user_nick"));
		return sreply;
	}

}
