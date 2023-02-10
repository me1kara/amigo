package com.lec.amigo.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;


import org.springframework.jdbc.core.RowMapper;

import com.lec.amigo.vo.DogVO;
import com.lec.amigo.vo.Payment;

public class PaymentRowMapper implements RowMapper<Payment> {

	@Override
	public Payment mapRow(ResultSet rs, int rowNum) throws SQLException {
		Payment pay = new Payment();
		pay.setImp_uid(rs.getString("imp_uid"));
		pay.setMerchant_uid(rs.getString("merchant_uid"));
		pay.setPay(rs.getInt("pay"));
		pay.setRes_no(rs.getInt("res_no"));
		pay.setUser_no(rs.getInt("user_no"));
		return pay;
	}
}
