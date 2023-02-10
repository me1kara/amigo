package com.lec.amigo.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.lec.amigo.chat.JDBCUtility.JDBCUtility;
import com.lec.amigo.common.PagingVO;
import com.lec.amigo.common.SearchVO;
import com.lec.amigo.mapper.BoardRowMapper;
import com.lec.amigo.mapper.BookContentRowMapper;
import com.lec.amigo.mapper.BookRowMapper;
import com.lec.amigo.mapper.SitterRowMapper;
import com.lec.amigo.mapper.UserRowMapper;
import com.lec.amigo.vo.BoardVO;
import com.lec.amigo.vo.BookContentVO;
import com.lec.amigo.vo.BookVO;
import com.lec.amigo.vo.Payment;
import com.lec.amigo.vo.SitterVO;
import com.lec.amigo.vo.UserVO;

@Repository("bookDAO")
@PropertySource("classpath:config/booksql.properties")
public class BookDAO {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	Environment environment;
	
	public int calMoney(int days, int time) {
		String sql = "select sit_price from sit_price where sit_time=1";
		int price = jdbcTemplate.queryForObject(sql, Integer.class);
		int calResult = days*time*price;
		System.out.println(calResult+"예상비용입니다");
		return calResult;
	}

	public List<SitterVO> getArroudSitter(String secondeAddr, PagingVO page) {
		
		System.out.println(secondeAddr);

		String sql = "select u.user_no, s.sit_no, s.sit_days, s.sit_time, s.sit_photo, s.sit_intro, s.sit_care_exp from user u,petsitter s"+ 
				" where u.user_no = s.user_no and u.user_type='S' and user_addr like ? limit ?,?";
		
		String sqlinput = "%"+secondeAddr+"%";
		//1 -> 0 
		//2 -> 10
		//3 ->
		// 1*10 -> 10 - 10 = 0;
		// 2*10 -> 20 - 10 = 10;
		int startSno = (page.getCurPage()*page.getRowSizePerPage())-page.getRowSizePerPage();	
		List<SitterVO> sitList = new ArrayList<SitterVO>();
		Connection conn = JDBCUtility.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sqlinput);
			pstmt.setInt(2, startSno);
			pstmt.setInt(3, page.getRowSizePerPage());
			rs = pstmt.executeQuery();
			while(rs.next()) {
				SitterVO si = new SitterVO();
				si.setUser_no(rs.getInt("user_no"));
				si.setSit_days(rs.getString("sit_days"));
				si.setSit_no(rs.getInt("sit_no"));
				si.setSit_time(rs.getString("sit_time"));
				si.setSit_photo(rs.getString("sit_photo"));
				si.setSit_intro(rs.getString("sit_intro"));
				si.setSit_care_exp(rs.getString("sit_care_exp"));
				sitList.add(si);
				
				System.out.println(si.getSit_no()+"sit_no 확인용");
				
			}
		
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("해당한 결과가 없습니다!");
		}
	
		
		return sitList;
	}

	public List<UserVO> getArroundSitterNames(String secondeAddr) {
	
		String sqlinput = "%"+secondeAddr+"%";
		String sql = "select * from user where user_addr like ?";
		
		Object[] args = {sqlinput};
		
		List<UserVO> uList = new ArrayList<UserVO>();
		
		try {
			uList = jdbcTemplate.query(sql, args, new UserRowMapper());
			if(!uList.isEmpty()) {
				return uList;
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	
	public int getTotalRowCount(String secondeAddr) {
		String sql = "select count(u.user_no) cno from user u,petsitter s"+ 
				" where u.user_no = s.user_no and u.user_type='S' and user_addr like ?";
		String sqlinput = "%"+secondeAddr+"%";
		Object[] args = {sqlinput};
		return jdbcTemplate.queryForObject(sql, args, Integer.class);
	}
	
	public int getCateRowCount () {
		
		return 0;
	}

	
	
	
	public int setBook(String calr, BookVO book, String merchant_uid) {
		
		String sql = "insert into reservation(user_no,sit_no,res_regdate,res_is,res_etc,res_pay,res_visit_is,res_term_is) "
				+ "values(?,?,SYSDATE(),false, ?,?,?,?)";
		
		System.out.println(calr+"확인용");
		
		int user_no = book.getUser_no();
		int sit_no = book.getSit_no();
		String res_etc = book.getRes_etc();
		int res_pay = book.getRes_pay();
		boolean res_visit_is = book.isRes_visit_is();
		boolean res_term_is = book.isRes_term_is();
		int row = jdbcTemplate.update(sql, user_no, sit_no, res_etc, res_pay, res_visit_is, res_term_is);
		
		if(row>0) {
			
			String selectBook = "select res_no from reservation where user_no = ? and sit_no = ? ORDER BY res_regdate desc limit 0,1";
			Object[] args = {user_no, sit_no};
			int res_no = jdbcTemplate.queryForObject(selectBook, args, Integer.class);
	
			JSONParser parser = new JSONParser();
			JSONArray jms = null;
			try {
				jms = (JSONArray) parser.parse(calr);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			for (int i = 0; i < jms.size(); i++) {
				JSONObject jsonObj = (JSONObject) jms.get(i);
				String title = (String)jsonObj.get("title");
				String start = (String) jsonObj.get("start");
				String end = (String) jsonObj.get("end");
				
				SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
				Calendar cal = Calendar.getInstance();
				
				String dog_name = title.split(",")[0];
				String time = title.split(",")[1];
				
				String selectDogNo = "select dog_no from dog where dog_name=? and user_no=?";
				Object[] dogO = {dog_name, user_no};
				int dog_no = jdbcTemplate.queryForObject(selectDogNo, dogO, Integer.class);
				
				System.out.println(dog_no+"도그번호 확인용");
				
				try {
					java.util.Date date1 = transFormat.parse(start);
					java.util.Date date2 = transFormat.parse(end);
			        long diffSec = (date2.getTime() - date1.getTime()) / 1000;
					Long diffDays = diffSec / (24*60*60);
					int days = diffDays.intValue();
					String insertContent = "insert into res_content(res_no, res_date, res_time, dog_no, res_addr) values(?,?,?,?,?)";
					if(days==1) {
						jdbcTemplate.update(insertContent, res_no,start,time,dog_no,book.getRes_addr());
					}else {
						for(int day=0;day<days;day++) {
							cal.setTime(date1);
							cal.add(Calendar.DATE, day);
							String da = transFormat.format(cal.getTime()).toString();
							
						
							jdbcTemplate.update(insertContent, res_no,da,time,dog_no,book.getRes_addr());
						}
					}		
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}


			}
			insertPayment(merchant_uid, res_no);
			return row;
		}
		
		
		
		
		return 0;
	}

	public List<BookVO> getBookList(int user_no, SearchVO search) {
		String sql = "select r.*, rs.res_date  from reservation r, (select res_no, \r\n"
				+ "IF(DATEDIFF(max(res_date), min(res_date))!=0,concat(min(res_date),' ~ ',max(res_date)),min(res_date)) res_date, DATEDIFF(max(res_date),sysdate()) df from res_content GROUP BY res_no) rs \r\n"
				+ "where user_no=? and r.res_no = rs.res_no and rs.df>=0 ORDER BY res_date limit ?,?";
		Connection conn = JDBCUtility.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BookVO> bookList = new ArrayList<BookVO>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user_no);
			pstmt.setInt(2, search.getFirstRow());
			pstmt.setInt(3, search.getRowSizePerPage());
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BookVO book = new BookVO();
				book.setRes_no(rs.getInt("res_no"));
				book.setUser_no(user_no);
				book.setSit_no(rs.getInt("sit_no"));
				book.setRes_regdate(rs.getDate("res_regdate"));
				book.setRes_is(rs.getBoolean("res_is"));
				book.setRes_etc(rs.getString("res_etc"));
				book.setRes_pay(rs.getInt("res_pay"));
				book.setRes_visit_is(rs.getBoolean("res_visit_is"));
				book.setRes_date(rs.getString("res_date"));
				bookList.add(book);
			}
			
			JDBCUtility.commit(conn);
		} catch (SQLException e) {
			JDBCUtility.rollback(conn);
			e.printStackTrace();
		}finally {
			JDBCUtility.close(conn, rs, pstmt);
		}

		return bookList; 
	}

	public List<BookContentVO> getBookDetailList(int rno) {
		String sql = "select * from res_content where res_no=?";
		Object[] args = {rno};
		
		try {
			return jdbcTemplate.query(sql, args, new BookContentRowMapper());
		} catch (Exception e) {
			// TODO: handle exception
		}
		 
		return null;
	}

	public List<BookVO> getSitBookList(int user_no, SearchVO search) {
		String sql = "select r.res_no, res_etc, user_no, sit_no, res_regdate, res_is,res_date,res_pay, res_visit_is, res_term_is from reservation r, (select res_no, IF(DATEDIFF(max(res_date), min(res_date))!=0,concat(min(res_date),' ~ ',max(res_date)),min(res_date)) res_date,DATEDIFF(max(res_date), sysdate()) df from res_content GROUP BY res_no) rs where sit_no = (select p.sit_no from user u, petsitter p where u.user_no = p.user_no and p.user_no=?) and r.res_no = rs.res_no and rs.df>=0 ORDER BY res_date limit ?,?";
		Connection conn = JDBCUtility.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BookVO> bookList = new ArrayList<BookVO>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user_no);
			pstmt.setInt(2, search.getFirstRow()); 
			pstmt.setInt(3, search.getRowSizePerPage());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BookVO book = new BookVO();
				book.setRes_no(rs.getInt("res_no"));
				book.setUser_no(rs.getInt("user_no"));
				book.setSit_no(rs.getInt("sit_no"));
				book.setRes_regdate(rs.getDate("res_regdate"));
				book.setRes_is(rs.getBoolean("res_is"));
				book.setRes_etc(rs.getString("res_etc"));
				book.setRes_pay(rs.getInt("res_pay"));
				book.setRes_visit_is(rs.getBoolean("res_visit_is"));
				book.setRes_date(rs.getString("res_date"));
				bookList.add(book);;
				System.out.println(rs.getString("res_date"));
				System.out.println(rs.getString("res_regdate"));
			}
			
			JDBCUtility.commit(conn);
		} catch (SQLException e) {
			JDBCUtility.rollback(conn);
			e.printStackTrace();
		}finally {
			JDBCUtility.close(conn, rs, pstmt);
		}

		
		return bookList;
	}

	public int getMyBookCount(int user_no) {
		String sql = "select count(distinct r.res_no) from reservation r, res_content rs where user_no=? and r.res_no = rs.res_no";
		Object[] args = {user_no};
		return jdbcTemplate.queryForObject(sql, args, Integer.class);
	}

	public int deleteBook(int rno) {
		String sql ="delete from reservation where res_no=?";
		int row = 0;
		row = jdbcTemplate.update(sql, rno);
		if(row>0) {
			sql = "delete from res_content where res_no=?";
			row = jdbcTemplate.update(sql,rno);
		}

		return row;
	}

	public int updateBook(int rno) {
		String sql ="update reservation set res_is=1 where res_no=?";
		int row = 0;
		try {		
		row = jdbcTemplate.update(sql, rno);
		if(row>0) {
			sql = "select max(chat_index)+1 from chat_room";
			int room_index = jdbcTemplate.queryForObject(sql, Integer.class);
			sql = "select * from reservation where res_no=?";
			Object[] a = {rno};
			BookVO book = jdbcTemplate.queryForObject(sql, a, new BookRowMapper());
			System.out.println(book.getUser_no()+"유넘확인");
			sql="select user_no from petsitter where sit_no = ?";
			Object[] args = {book.getSit_no()};
			int suno = jdbcTemplate.queryForObject(sql, args, Integer.class);
			sql = "insert into chat_room values(?,?)";
			jdbcTemplate.update(sql, room_index, book.getUser_no());
			row = jdbcTemplate.update(sql, room_index, suno);
		}
		}
		catch (Exception e) {
			e.printStackTrace();
		}

		return row; 
	}

	public int getMyBookCount(SitterVO sitter) {
		String sql = "select count(distinct r.res_no) from reservation r, res_content rs where sit_no=? and r.res_no = rs.res_no";
		Object[] args = {sitter.getSit_no()};
		int rs =0;
		try {
			rs = jdbcTemplate.queryForObject(sql, args, Integer.class);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return rs; 
	}

	public int payBook(Payment payment) {
		String sql ="insert into payment(imp_uid, merchant_uid, pay,user_no) values(?,?,?,?)";
		int result = 0;
		try {
			result = jdbcTemplate.update(sql, payment.getImp_uid(), payment.getMerchant_uid(), payment.getPay(), payment.getUser_no());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	public void insertPayment(String merchant_uid, int res_no) {
		
		
		
		String sql = "update payment set res_no=? where merchant_uid=?";
		int r = jdbcTemplate.update(sql,res_no, merchant_uid);
		System.out.println(r+"최종결과"+merchant_uid+res_no);
		
		
	}
	
	

	
	
}
