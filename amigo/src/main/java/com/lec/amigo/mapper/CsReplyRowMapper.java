package com.lec.amigo.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.lec.amigo.vo.CsReplyVO;

public class CsReplyRowMapper implements RowMapper<CsReplyVO> {

	@Override
	public CsReplyVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		CsReplyVO csreply = new CsReplyVO();
		csreply.setHbd_r_no(rs.getInt("hbd_r_no"));
		csreply.setHbd_no(rs.getInt("hbd_no"));
		csreply.setHbd_r_cont(rs.getString("hbd_r_cont"));
		csreply.setHbd_r_regdate(rs.getDate("hbd_r_regdate"));
		csreply.setHbd_r_ref(rs.getInt("hbd_r_ref"));
		csreply.setHbd_r_lev(rs.getInt("hbd_r_lev"));
		csreply.setHbd_r_seq(rs.getInt("hbd_r_seq"));
		csreply.setUser_no(rs.getInt("user_no"));
		csreply.setUser_nick(rs.getString("user_nick"));
		return csreply;
	}

}
