package com.lec.amigo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.lec.amigo.chat.JDBCUtility.JDBCUtility;
import com.lec.amigo.mapper.SitRowMapper;
import com.lec.amigo.vo.SitterVO;



@Repository("sitterDAO")
@PropertySource("classpath:config/sittersql.properties")

public class SitterDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;	// Jdbc 템플릿 사용.
	
	@Autowired
	Environment environment;			// 설정(properties)을 java에서 가져오지 않고 외부의 파일에서 sql문 등을 가져오기 위해 이 객체를 사용하여 스프링 빈과 설정을 세팅함.
	
	private String sql          = "";
	private String selectSitter = "";	// getSitter
	private String insertSitter = "";
	private String deleteSitter = "";
	private String updateSitter = "";
	private String selectSitListByUserNo = "";
	
	@PostConstruct
	public void getSqlProperties() {
		
		selectSitter          = environment.getProperty("selectSitter");
		insertSitter          = environment.getProperty("insertSitter");
		deleteSitter          = environment.getProperty("deleteSitter");
		updateSitter          = environment.getProperty("updateSitter");
		selectSitListByUserNo = environment.getProperty("selectSitListByUserNo");
	}
	

	
	public List<SitterVO> getSitList(int user_no) {
		Object[] args = {user_no};
		return jdbcTemplate.query(selectSitListByUserNo, args, new SitRowMapper());
	}
	
	public SitterVO getSitter(int sit_no) {
		Object[] args = {sit_no};
		return (SitterVO) jdbcTemplate.query(selectSitter, args, new SitRowMapper());
		
	}
	
	public SitterVO insertSitter(SitterVO svo) {
		jdbcTemplate.update(insertSitter,svo.getUser_no(),svo.getSit_gender(),svo.getSit_birth(),svo.isSit_smoking(),svo.getSit_job(),svo.getSit_days(),svo.getSit_time(),svo.isSit_exp(),svo.getSit_care_exp(),svo.getSit_intro(),svo.getSit_photo(),svo.isSit_auth_is());
		return svo;
	}
	
/*	
	public int updateSitter(SitterVO svo) {
		return jdbcTemplate.update(updateSitter,svo.getSit_gender(),svo.getSit_birth(),svo.isSit_smoking(),svo.getSit_job(),svo.getSit_days(),svo.getSit_time(),svo.isSit_exp(),svo.getSit_care_exp(),svo.getSit_intro(),svo.getSit_photo(),svo.isSit_auth_is());
	}
	
	public int deleteSitter(int sit_no) {
		return jdbcTemplate.update(deleteSitter, sit_no);
	}
*/	
}	



	/*private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;
	SitterVO sit = null;
	
	public SitterVO sitterInfo (int sit_no) {
		try {
			conn = JDBCUtility.getConnection();
			stmt = conn.prepareStatement(sitterInfo);
			stmt.setInt(1, sit_no);
			rs = stmt.executeQuery();
			while(rs.next()) {
				sit = new SitterVO();
				sit.setUser_no(rs.getInt("user_no"));
				sit.setSit_gender(rs.getString("sit_gender"));
				sit.setSit_birth(rs.getString("sit_birth"));
				sit.setSit_smoking(rs.getBoolean("sit_smoking"));
				sit.setSit_job(rs.getString("sit_job"));
				sit.setSit_days(rs.getString("sit_days"));
				sit.setSit_time(rs.getString("sit_time"));
				sit.setSit_exp(rs.getBoolean("sit_exp"));
				sit.setSit_care_exp(rs.getString("sit_care_exp"));
				sit.setSit_intro(rs.getString("sit_intro"));
				sit.setSit_photo(rs.getString("sit_photo"));
				sit.setSit_auth_is(rs.getBoolean("sit_auth_is"));
			}
		} catch (Exception e) {
			System.out.println("접속실패 " + e.getMessage());
		} finally {
			JDBCUtility.close(conn, rs, stmt);
		}
		return sit;
	}
	
	/*public SitterVO insertSitter(SitterVO svo) {
		jdbcTemplate.update(insertSitter, svo.getUser_no(), svo.getSit_gender(), 
        		svo.getSit_birth(), svo.isSit_smoking(),
        		svo.getSit_job(), svo.getSit_days(), svo.getSit_time(), 
        		svo.isSit_exp(), svo.getSit_care_exp(), svo.getSit_intro(),
        		svo.getSit_photo(), svo.isSit_auth_is());
        return svo;  
	}*/
		

		
		
		
	//}














//private String insertSitter = "INSERT INTO pet_sitter (user_no, sit_gender, sit_birth, sit_smoking, sit_job, sit_days, "
//		+ "sit_time, sit_exp, sit_care_exp, sit_intro, sit_photo) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
// 23/01/19 : JDBC템플릿이,,,즉,,property 가 안먹힌다면, 주석을 푼다. 23/01/19





//sit.setSitNo(rs.getInt("sit_no"));
//sit.setUserNo(rs.getInt("user_no"));
/*   2023 / 01  /  17  VO에 테이블조인 및 들어오는값들은 어떻게처리?
 * Yes, the code above is a Java class that implements the "RowMapper" 
 * interface, which is used to map rows of data from a JDBC ResultSet 
 * to an object. The class maps data from a ResultSet to a "SitApplyVO"
 *  object, which is a Java object that represents a pet sitter's information. 
 *  The mapRow() method is called for each row in the ResultSet and maps
 *   the columns of the ResultSet to the fields of the SitApplyVO object,
 *    which is then returned. So this code is intended to add pet sitter's 
 *    data into the database when the query is executed.
 *    However, if the information is already stored in the "members" table and the application 
 *    doesn't need to store the same information in the pet sitter table 
 *    then it would be unnecessary to include these values in the SitApplyVO object.
				->중요 It might be a good idea to double check the database design and the requirements 
					   of the application to see if these values are actually necessary.*/
// sit.setSitPhone(rs.getString("user_phone"));            // 자동 입력
// sit.setSitGender(rs.getString("user_addr"));             // 자동 입력
//sit.setSitName(rs.getString("user_name"));             // 자동 입력
//sit.setSitAuthIs(rs.getBoolean("sit_auth_is"));
// 회원번호 회원vo, 펫시터지원vo,
/*	public int insertSitter(int index, SitApplyVO sitApplyVO, boolean sitAuthIs) {
			// int index, String gender, String birth, boolean smoking, String job, String days, String time, boolean exp, 
			// String sit_care_exp, String intro, String photo, boolean auth ) 
		
		//첨에신청:0 허락= 1 허락전에는 0.
		{
			String sql = "insert into petsitter(sit_no, user_no, sit_gender, sit_birth, sit_smoking, sit_job, sit_days, sit_time, sit_exp, sit_care_exp, sit_intro, sit_photo, sit_auth_is) "
					+ "values(?,?,?,?,?,?,?,?,?,?,?,?)";
			Connection conn = JDBCUtility.getConnection();
			PreparedStatement pstmt = null;
			int row=0;
			
			String sit_auth_is = (SitApplyVO.ge)
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1,  );
			} catch (Exception e) {
				// TODO: handle exception
			}
	}*/


/*int user_no = uvo.getUser_no();
	    String sit_gender = svo.getSit_gender();
	    String sit_birth = svo.getSit_birth();
	    boolean sit_smoking = svo.isSit_smoking();
	    String sit_job = svo.getSit_job();
	    String sit_days = svo.getSit_days();
	    String sit_time = svo.getSit_time();
	    boolean sit_exp = svo.isSit_exp();
	    String sit_care_exp = svo.getSit_care_exp();
	    String sit_intro = svo.getSit_intro();
	    String sit_photo = svo.getSit_intro();
	    boolean sit_auth_is = svo.isSit_auth_is();*/

//String sql = "INSERT INTO pet_sitter (user_no, sit_gender, sit_birth, sit_smoking, sit_job, sit_days, "
//		+ "sit_time, sit_exp, sit_care_exp, sit_intro, sit_photo) VALUES (?,?,?,?,?,?,?,?,?,?,?)";