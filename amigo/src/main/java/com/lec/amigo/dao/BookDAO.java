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

import javax.annotation.PostConstruct;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.lec.amigo.common.PagingVO;
import com.lec.amigo.common.SearchVO;
import com.lec.amigo.etc.JDBCUtility;
import com.lec.amigo.mapper.BoardRowMapper;
import com.lec.amigo.mapper.BookContentRowMapper;
import com.lec.amigo.mapper.BookRowMapper;
import com.lec.amigo.mapper.PaymentRowMapper;
import com.lec.amigo.mapper.SitterRowMapper;
import com.lec.amigo.mapper.UserRowMapper;
import com.lec.amigo.service.BookService;
import com.lec.amigo.vo.BoardVO;
import com.lec.amigo.vo.BookContentVO;
import com.lec.amigo.vo.BookVO;
import com.lec.amigo.vo.Payment;
import com.lec.amigo.vo.SitterVO;
import com.lec.amigo.vo.UserVO;

@Repository("bookDAO")
@PropertySource("classpath:config/paymentsql.properties")
public class BookDAO {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	/*
	 * @Autowired Environment environment;
	 * 
	 * private String sql = ""; private String selectBoardListByUbdTitle = "";
	 * private String selectBoardListByUserNick = ""; private String
	 * selectBoardListByUbdCont = ""; private String selectBoardListByUbdTitleLike =
	 * ""; private String selectBoardListByUserNickLike = ""; private String
	 * selectBoardListByUbdContLike = ""; private String boardTotalRowCount = "";
	 * private String boardCateRowCount = ""; private String selectByUbdNo = "";
	 * private String updateCount = ""; private String updateBoard = ""; private
	 * String deleteBoard = ""; private String selectCateByUbdTitle = ""; private
	 * String selectCateByUserNick = ""; private String selectCateByUbdCont = "";
	 * private String insertBoard = ""; private String findHeart = ""; private
	 * String insertHeart = ""; private String deleteHeart = ""; private String
	 * countHeart = "";
	 * 
	 * @PostConstruct public void getSqlPropeties() { selectBoardListByUbdTitleLike
	 * = environment.getProperty("selectBoardListByUbdTitleLike");
	 * selectBoardListByUserNickLike =
	 * environment.getProperty("selectBoardListByUserNickLike");
	 * selectBoardListByUbdContLike =
	 * environment.getProperty("selectBoardListByUbdContLike");
	 * selectBoardListByUbdTitle =
	 * environment.getProperty("selectBoardListByUbdTitle");
	 * selectBoardListByUserNick =
	 * environment.getProperty("selectBoardListByUserNick");
	 * selectBoardListByUbdCont =
	 * environment.getProperty("selectBoardListByUbdCont"); boardTotalRowCount =
	 * environment.getProperty("boardTotalRowCount"); boardCateRowCount =
	 * environment.getProperty("boardCateRowCount"); selectByUbdNo =
	 * environment.getProperty("selectByUbdNo"); selectCateByUbdTitle =
	 * environment.getProperty("selectCateByUbdTitle"); selectCateByUserNick =
	 * environment.getProperty("selectCateByUserNick"); selectCateByUbdCont =
	 * environment.getProperty("selectCateByUbdCont"); }
	 */
	
	
	
	//계산
	public int calMoney(int days, int time) {
		String sql = "select sit_price from sit_price where sit_time=1";
		int price = jdbcTemplate.queryForObject(sql, Integer.class);
		int calResult = days*time*price;
		System.out.println(calResult+"예상비용입니다");
		return calResult;
	}
	
	//인근지역시터
	public List<SitterVO> getArroudSitter(String secondeAddr, PagingVO page, String calr) {		
		System.out.println(secondeAddr);
		String sql = "select u.user_name,u.user_addr, ss.* from user u,"
				+ "(select * from petsitter where sit_no not in("
				+ "select distinct r.sit_no from reservation r,(select distinct * from res_content where res_date in (";

		JSONParser parser = new JSONParser();
		JSONArray jms = null;
		
		try {
			jms = (JSONArray) parser.parse(calr);
			for (int i = 0; i < jms.size(); i++) {
				JSONObject jsonObj = (JSONObject) jms.get(i);
				String title = (String)jsonObj.get("title");
				String start = (String) jsonObj.get("start");
				String end = (String) jsonObj.get("end");
				
				SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
				Calendar cal = Calendar.getInstance();
					java.util.Date date1 = transFormat.parse(start);
					java.util.Date date2 = transFormat.parse(end);
			        long diffSec = (date2.getTime() - date1.getTime()) / 1000;
					Long diffDays = diffSec / (24*60*60);
					int days = diffDays.intValue();
						for(int day=0;day<days;day++) {
							cal.setTime(date1);
							cal.add(Calendar.DATE, day);
							String da = transFormat.format(cal.getTime()).toString();
							if(jms.size()-i==1 && days-day==1) {
								sql+="DATE('"+da+"')";
							}else {
								sql+="DATE('"+da+"'),";
							}
			
						}
			}
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		sql +=")) rs where r.res_no = rs.res_no)) ss where u.user_no=ss.user_no and u.user_type='S' and u.user_addr like ? limit ?,?";
		
		String sqlinput = "%"+secondeAddr+"%";
		
		System.out.println(sqlinput);
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
				si.setUser_name(rs.getString("user_name"));
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
	
	//인근시터이름매칭, 당시 시터vo에 이름 필드가 없었기때문,지금은 불필요
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
	
	
	//페이징 처리를 위한 인근지역 시터수
	public int getTotalRowCount(String secondeAddr) {
		String sql = "select count(u.user_no) cno from user u,petsitter s"+ 
				" where u.user_no = s.user_no and u.user_type='S' and user_addr like ?";
		String sqlinput = "%"+secondeAddr+"%";
		Object[] args = {sqlinput};
		return jdbcTemplate.queryForObject(sql, args, Integer.class);
	}
	
	
	//예약신청 확정시 db에 삽입 로직
	public int setBook(String calr, BookVO book, String merchant_uid) {
		
		
		//예약테이블에 첫번째삽입
		String sql = "insert into reservation(user_no,sit_no,res_regdate,res_etc,res_pay,res_visit_is,res_term_is) "
				+ "values(?,?,SYSDATE(), ?,?,?,?)";
		
		int user_no = book.getUser_no();
		int sit_no = book.getSit_no();
		String res_etc = book.getRes_etc();
		int res_pay = book.getRes_pay();
		boolean res_visit_is = book.isRes_visit_is();
		boolean res_term_is = book.isRes_term_is();
		int row = jdbcTemplate.update(sql, user_no, sit_no, res_etc, res_pay, res_visit_is, res_term_is);
		
		if(row>0) {
			
			//방금 삽입한 예약 조회
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
			
			//예약내용(json배열로 포장상태) 포장풀기
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
					
					//시작일자와 끝일자를 비교, 풀캘린더 사용으로 인함
					java.util.Date date1 = transFormat.parse(start);
					java.util.Date date2 = transFormat.parse(end);
			        long diffSec = (date2.getTime() - date1.getTime()) / 1000;
					Long diffDays = diffSec / (24*60*60);
					int days = diffDays.intValue();
					String insertContent = "insert into res_content(res_no, res_date, res_time, dog_no, res_addr) values(?,?,?,?,?)";
					
					//같은 날짜일 경우
					if(days==1) {
						jdbcTemplate.update(insertContent, res_no,start,time,dog_no,book.getRes_addr());
					}else {
					//아닐 경우, 차이만큼 반복해서 날짜 삽입
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
			updateBook(res_no);
			insertPayment(merchant_uid, res_no);
			return row;
		}
		
		
		
		
		return 0;
	}

	//내 예약목록 조회
	public List<BookVO> getBookList(int user_no, SearchVO search) {		
		String sql=null;
		System.out.println(search.getSearchType());
		if(search.getSearchCategory()!=null && search.getSearchCategory().equals("past")) {
			sql = "select r.*, rs.res_date from reservation r, (select res_no,"
					+ "IF(DATEDIFF(max(res_date), min(res_date))!=0,concat(min(res_date),' ~ ',max(res_date)),min(res_date)) res_date, DATEDIFF(max(res_date),sysdate()) df from res_content GROUP BY res_no) rs \r\n"
					+ "where user_no=? and r.res_no = rs.res_no and rs.df<0 ORDER BY res_date limit ?,?";
		}else {
			sql = "select r.*, rs.res_date  from reservation r, (select res_no,"
					+ "IF(DATEDIFF(max(res_date), min(res_date))!=0,concat(min(res_date),' ~ ',max(res_date)),min(res_date)) res_date, DATEDIFF(max(res_date),sysdate()) df from res_content GROUP BY res_no) rs \r\n"
					+ "where user_no=? and r.res_no = rs.res_no and rs.df>=0 ORDER BY res_date limit ?,?";
		}

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
	
	//예약내용 상세보기 로직(모달)
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

	//시터모드, 내 예약목록 조회
	public List<BookVO> getSitBookList(int user_no, SearchVO search) {
		String sql = null;
		
		if(search.getSearchCategory()!=null && search.getSearchCategory().equals("past")) {
			sql = "select r.res_no, res_etc, user_no, sit_no, res_regdate,res_date,res_pay, res_visit_is, res_term_is from reservation r, (select res_no, IF(DATEDIFF(max(res_date), min(res_date))!=0,concat(min(res_date),' ~ ',max(res_date)),min(res_date)) res_date,DATEDIFF(max(res_date), sysdate()) df from res_content GROUP BY res_no) rs where sit_no = (select p.sit_no from user u, petsitter p where u.user_no = p.user_no and p.user_no=?) and r.res_no = rs.res_no and rs.df<0 ORDER BY res_date limit ?,?";
		}else {
			sql = "select r.res_no, res_etc, user_no, sit_no, res_regdate,res_date,res_pay, res_visit_is, res_term_is from reservation r, (select res_no, IF(DATEDIFF(max(res_date), min(res_date))!=0,concat(min(res_date),' ~ ',max(res_date)),min(res_date)) res_date,DATEDIFF(max(res_date), sysdate()) df from res_content GROUP BY res_no) rs where sit_no = (select p.sit_no from user u, petsitter p where u.user_no = p.user_no and p.user_no=?) and r.res_no = rs.res_no and rs.df>=0 ORDER BY res_date limit ?,?";
		}
		Connection conn = com.lec.amigo.etc.JDBCUtility.getConnection();
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
	
	//시터모드,예약목록 페이징을 위한 예약수 확인
	public int getMyBookCount(int user_no,SearchVO searchvo) {
		String sql =null;
		if(searchvo.getSearchCategory()!=null && searchvo.getSearchCategory().equals("past")){
			sql = "select count(*) from reservation r, (select res_no,"
					+ "					IF(DATEDIFF(max(res_date), min(res_date))!=0,concat(min(res_date),' ~ ',max(res_date)),min(res_date)) res_date, DATEDIFF(max(res_date),sysdate()) df from res_content GROUP BY res_no) rs"
					+ "					where user_no=? and r.res_no = rs.res_no and rs.df<0 ORDER BY res_date";	
		}else {
			sql = "select count(*) from reservation r, (select res_no,"
					+ "					IF(DATEDIFF(max(res_date), min(res_date))!=0,concat(min(res_date),' ~ ',max(res_date)),min(res_date)) res_date, DATEDIFF(max(res_date),sysdate()) df from res_content GROUP BY res_no) rs"
					+ "					where user_no=? and r.res_no = rs.res_no and rs.df>=0 ORDER BY res_date";	
		}
		Object[] args = {user_no};
		return jdbcTemplate.queryForObject(sql, args, Integer.class);
	}
	
	//예약취소시 로직
	public int deleteBook(int rno) {
		String sql ="delete from reservation where res_no=?";
		int row = 0;
		row = jdbcTemplate.update(sql, rno);
		if(row>0) {
			sql = "delete from res_content where res_no=?";
			row = jdbcTemplate.update(sql,rno);
			if(row>0) {
				sql = "select distinct chat_index from chat_room where res_no=?";
				Object[] gs = {rno};
				int index = jdbcTemplate.queryForObject(sql,gs, Integer.class);
				sql = "delete from chat_room where res_no=?";
				jdbcTemplate.update(sql, rno);
				sql = "delete from sit_chat where sitt_chat_index=?";
				jdbcTemplate.update(sql, index);
				return rno;
			}
		}

		return row;
	}
	
	//
	public int updateBook(int rno) {
		
		String sql =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = null;
		int row=0;
		try {
			sql = "select IFNULL(max(chat_index), 0)+1 from chat_room";
			int room_index = jdbcTemplate.queryForObject(sql, Integer.class);
			sql = "select user_no,sit_no from reservation where res_no=?";
			conn = JDBCUtility.getConnection();
		
			pstmt = conn.prepareStatement(sql);
			BookVO book = new BookVO();
			pstmt.setInt(1, rno);
			rs=pstmt.executeQuery();
			System.out.println("rno:"+rno);
			if(rs.next()) {
				book.setUser_no(rs.getInt("user_no"));
				book.setSit_no(rs.getInt("sit_no"));
			}

			System.out.println(book.getUser_no()+"유넘확인");
			sql="select user_no from petsitter where sit_no = ?";
			Object[] args = {book.getSit_no()};
			int suno = jdbcTemplate.queryForObject(sql, args, Integer.class);
			
			sql = "insert into chat_room(chat_index, user_no, res_no) values(?,?,?)";
			jdbcTemplate.update(sql, room_index, book.getUser_no(), rno);
			row = jdbcTemplate.update(sql, room_index, suno, rno);
		
		}
		catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtility.close(conn, rs, pstmt);
		}

		return row; 
	}
	
	//예약목록 페이징을 위한 총 수 구하기
	public int getMyBookCount(SitterVO sitter,SearchVO search) {
		String sql = null;;
		if(search.getSearchCategory()!=null && search.getSearchCategory().equals("past")) {
			sql = "select count(*) from reservation r, (select res_no, IF(DATEDIFF(max(res_date), min(res_date))!=0,concat(min(res_date),' ~ ',max(res_date)),min(res_date)) res_date,DATEDIFF(max(res_date), sysdate()) df from res_content GROUP BY res_no) rs where sit_no = (select p.sit_no from user u, petsitter p where u.user_no = p.user_no and p.user_no=?) and r.res_no = rs.res_no and rs.df<0 ORDER BY res_date";
		}else {
			sql = "select count(*) from reservation r, (select res_no, IF(DATEDIFF(max(res_date), min(res_date))!=0,concat(min(res_date),' ~ ',max(res_date)),min(res_date)) res_date,DATEDIFF(max(res_date), sysdate()) df from res_content GROUP BY res_no) rs where sit_no = (select p.sit_no from user u, petsitter p where u.user_no = p.user_no and p.user_no=?) and r.res_no = rs.res_no and rs.df>=0 ORDER BY res_date";
		}
		Object[] args = {sitter.getUser_no()};
		int rs =0;
		try {
			rs = jdbcTemplate.queryForObject(sql, args, Integer.class);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return rs; 
	}
	
	//결제내용 삽입 
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
	
	//결제내용 삽입 마무리
	public void insertPayment(String merchant_uid, int res_no) {
		String sql = "update payment set res_no=? where merchant_uid=?";
		int r = jdbcTemplate.update(sql,res_no, merchant_uid);
		System.out.println(r+"최종결과"+merchant_uid+res_no);
		
		
	}

	//결제내용 확인
	public Payment getPayment(int rno) {
		String sql = "select * from payment where res_no=?";
		Object[] args = {rno};

		return jdbcTemplate.queryForObject(sql, args, new PaymentRowMapper());
	}

	//이전 예약 확인하기
	public List<BookVO> getPastBook(int user_no) {
		String sql = "select r.*, rc.res_time, concat(min(res_date),'~',max(res_date)) res_date  from reservation r, res_content rc where r.res_no = rc.res_no and r.user_no = ? and sysdate()>rc.res_date group by r.res_no";
		
		Object[] args = {user_no};
		
		try {
			return jdbcTemplate.query(sql, args, new BookRowMapper());
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}

	
	public Payment canclePay(int rno) {
		String sql = "select * from payment where res_no = ?";
		Object[] args = {rno};
		
		try {
			return jdbcTemplate.queryForObject(sql, args, new PaymentRowMapper());
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}		
	}


	
}
