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
import com.lec.amigo.common.SearchVO;
import com.lec.amigo.mapper.SitRowMapper;
import com.lec.amigo.vo.SitterVO;
import com.lec.amigo.vo.UserVO;



@Repository("sitterDAO")
@PropertySource("classpath:config/sittersql.properties")

public class SitterDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;	// Jdbc 템플릿 사용.
	
	@Autowired
	Environment environment;			// 설정(properties)을 java에서 가져오지 않고 외부의 파일에서 sql문 등을 가져오기 위해 이 객체를 사용하여 스프링 빈과 설정을 세팅함.
	
	private String sql          = "";
	private String selectSitter = "";	// getSitter
	private String selectSitterA   = "";
	private String selectSitterByG = "";
	private String selectSitterByUserName = "";
	private String sitterTotalRowCount = "";
	private String selectSitterInfo = "";   // 펫시터 개인의 상세정보
	private String selectSitterCate = "";   // 승인/미승인 을 나눠서 정렬하기
	private String insertSitter = "";
	private String deleteSitter = "";
	private String updateSitter = "";
	private String updateTypeS  = "";
	private String updateTypeU  = "";
	private String selectSitListByUserNo = "";
	
	@PostConstruct
	public void getSqlProperties() {
		
		selectSitter            = environment.getProperty("selectSitter");
		selectSitterA           = environment.getProperty("selectSitterA");
		selectSitterByG         = environment.getProperty("selectSitterByG");
		selectSitterByUserName  = environment.getProperty("selectSitterByUserName");
		sitterTotalRowCount     = environment.getProperty("sitterTotalRowCount");
		selectSitterInfo        = environment.getProperty("selectSitterInfo");
		selectSitterCate        = environment.getProperty("selectSitterCate");
		insertSitter            = environment.getProperty("insertSitter");
		deleteSitter            = environment.getProperty("deleteSitter");
		updateSitter            = environment.getProperty("updateSitter");
		updateTypeS             = environment.getProperty("updateTypeS");
		updateTypeU             = environment.getProperty("updateTypeU");
		selectSitListByUserNo   = environment.getProperty("selectSitListByUserNo");
	}
	

	public SitterVO getSitter(SitterVO svo) {
		Object[] args = { svo.getSit_no() };
		return jdbcTemplate.queryForObject(selectSitterInfo, args, new SitRowMapper());
		
	}
	
	public List<SitterVO> getSitList(SearchVO searchVO) {
		if(searchVO.getSearchType()==null || searchVO.getSearchType().isEmpty() ||
				searchVO.getSearchWord()==null || searchVO.getSearchWord().isEmpty()) {
			sql = selectSitter;
			// searchVO.setSearchType("user_name");
		} else {
			if(searchVO.getSearchType().equalsIgnoreCase("user_name")) {
				sql = selectSitterByUserName;
			} else if(searchVO.getSearchType().equalsIgnoreCase("sit_auth_is")) {
				sql = selectSitterA;
			} else if(searchVO.getSearchType().equalsIgnoreCase("sit_gender")) {
				sql = selectSitterByG;
			} 					
		}
		
		String searchWord = "%" + searchVO.getSearchWord() + "%";			  // sql문에서 limit를 나타냄		
		Object[] args = {searchWord, searchVO.getFirstRow(), searchVO.getRowSizePerPage()};	
		return jdbcTemplate.query(sql, args, new SitRowMapper());
	}

	
	public int getTotalSitRowCount(SearchVO searchVO) {
		if(searchVO.getSearchType()==null || searchVO.getSearchType().isEmpty() ||
				searchVO.getSearchWord()==null || searchVO.getSearchWord().isEmpty()) {
			sql = sitterTotalRowCount;
			searchVO.setSearchType("user_name");  // 검색조건이 비어있을때 모두 나오게 (또는 모든 갯수) 를 보이게 하려면?
		} else {			
			if(searchVO.getSearchType().equalsIgnoreCase("user_name")) {
				sql = sitterTotalRowCount + " where user_name like '%" + searchVO.getSearchWord() + "%'";
			} else if(searchVO.getSearchType().equalsIgnoreCase("sit_auth_is")) {
				sql = sitterTotalRowCount + " where sit_auth_is like '%" + searchVO.getSearchWord() + "%'";
			} else if(searchVO.getSearchType().equalsIgnoreCase("sit_gender")) {
				sql = sitterTotalRowCount + " where sit_gender like '%" + searchVO.getSearchWord() + "%'";
			}	
		}
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}
	
	
	public List<SitterVO> getSitListCate(SitterVO svo, SearchVO searchVO){
		return null;	
	}
	
	
	public SitterVO insertSitter(SitterVO svo) {
		jdbcTemplate.update(insertSitter,svo.getUser_no(),svo.getSit_gender(),svo.getSit_birth(),svo.isSit_smoking(),svo.getSit_job(),svo.getSit_days(),svo.getSit_time(),svo.isSit_exp(),svo.getSit_care_exp(),svo.getSit_intro(),svo.getSit_photo(),svo.isSit_auth_is());
		return svo;
	}
	
	public int updateSitter(SitterVO svo, boolean sit_auth_is) {
		System.out.println(updateSitter);
		int a = jdbcTemplate.update(updateSitter, true, svo.getUser_no());  // int로 받아서,, 쿼리문, true처리, 객체에서 유저정보를 받아와서 -> 처리.
		System.out.println(a+"성공여부 확인");                              // 콘솔로 성공여부 확인하기.
		return a;                                                           // a 라는 업뎃문 실행.
	}
	
	public void updateTypeS(SitterVO svo) {
		jdbcTemplate.update(updateTypeS, svo.getUser_type());
	}
	
	public void updateTypeU(SitterVO svo) {
		jdbcTemplate.update(updateTypeU, svo.getUser_type());
	}
	
/*public int updateSitter(SitterVO svo) {
		return jdbcTemplate.update(updateSitter,svo.getSit_gender(),svo.getSit_birth(),svo.isSit_smoking(),svo.getSit_job(),svo.getSit_days(),svo.getSit_time(),svo.isSit_exp(),svo.getSit_care_exp(),svo.getSit_intro(),svo.getSit_photo(),svo.isSit_auth_is());
	}*/
	
	public int deleteSitter(int user_no) {
		
		
		System.out.println(deleteSitter);                    // 쿼리 확인하기
		int del = jdbcTemplate.update(deleteSitter, user_no); // 업데이트 매서드를 위한 변수.
		return del;                                          // 변수 반환.
	}

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