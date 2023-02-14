package com.lec.amigo.impl;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.net.ssl.HttpsURLConnection;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.lec.amigo.common.PagingVO;
import com.lec.amigo.common.SearchVO;
import com.lec.amigo.dao.BookDAO;
import com.lec.amigo.service.BookService;
import com.lec.amigo.vo.BookContentVO;
import com.lec.amigo.vo.BookVO;
import com.lec.amigo.vo.Payment;
import com.lec.amigo.vo.SitterVO;
import com.lec.amigo.vo.UserVO;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.request.CancelData;

@PropertySource("classpath:config/iamport.properties")
@Service("bookService")
public class BookServiceImpl implements BookService{
	
	@Autowired
	@Qualifier("bookDAO")
	BookDAO bookDao;
	
	@Autowired
	Environment environment;
	
	private String imp_key = "";
	private String imp_secret = "";
	
	@PostConstruct
	public void getIamportPropeties() {
		imp_key = environment.getProperty("imp_key");
		imp_secret = environment.getProperty("imp_secret");
	}
	@Override
	public int calMoney(int days, int time) {
		return bookDao.calMoney(days, time);
	}

	public List<SitterVO> getArroundSitter(String address,PagingVO page, String calr) {
		
		return bookDao.getArroudSitter(address,page, calr);
	}

	public List<UserVO> getUserNameList(String address) {
		// TODO Auto-generated method stub
		return bookDao.getArroundSitterNames(address);
	}
	
	public int getTotalRowCount(String address) {
		return bookDao.getTotalRowCount(address);
	}

	public int setBook(String calr, BookVO book, String merchant_uid) {
		
		return bookDao.setBook(calr, book, merchant_uid);
	}

	public List<BookVO> getBookList(int user_no, SearchVO search) {
		// TODO Auto-generated method stub
		return bookDao.getBookList(user_no,search);
	}

	public List<BookContentVO> getBookDetailList(int rno) {
		// TODO Auto-generated method stub
		return bookDao.getBookDetailList(rno);
	}

	public List<BookVO> getSitBookList(int user_no, SearchVO search) {
		
		return bookDao.getSitBookList(user_no, search);
	}
	
	public int getMyBookCount(int user_no, SearchVO searchvo) {
		return bookDao.getMyBookCount(user_no,searchvo);
	}

	public int deleteBook(int rno) {
		//환불로직
		Payment pay = bookDao.canclePay(rno);
		if(pay!=null) {
			try {
				String access_key = getToken();		
				IamportClient ic = new IamportClient(imp_key, imp_secret);
				CancelData cancle = new CancelData(pay.getImp_uid(), true);
				ic.cancelPaymentByImpUid(cancle);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
			bookDao.deleteBook(rno);
		}
		
		 
		return 0;
	}

	public int updateBook(int rno) {
		
		return bookDao.updateBook(rno);
	}

	public int getMyBookCount(SitterVO sitter, SearchVO searchVO) {
		// TODO Auto-generated method stub
		return bookDao.getMyBookCount(sitter, searchVO);
	}

	public int payBook(Payment payment) {
		// TODO Auto-generated method stub
		return bookDao.payBook(payment);
	}

	public List<Payment> getPayList(SearchVO search) {
		return null;//bookDao.getPaylist(search);
	}

	public Payment getPayment(int rno) {
		// TODO Auto-generated method stub
		return bookDao.getPayment(rno);
	}

	public List<BookVO> getPastBook(int user_no) {
		// TODO Auto-generated method stub
		return bookDao.getPastBook(user_no);
	}
	
	public String getToken() throws IOException {

		HttpsURLConnection conn = null;

		URL url = new URL("https://api.iamport.kr/users/getToken");

		conn = (HttpsURLConnection) url.openConnection();

		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-type", "application/json");
		conn.setRequestProperty("Accept", "application/json");
		conn.setDoOutput(true);
		JsonObject json = new JsonObject();

		json.addProperty("imp_key", imp_key);
		json.addProperty("imp_secret", imp_secret);
		
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
		
		bw.write(json.toString());
		bw.flush();
		bw.close();

		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));

		Gson gson = new Gson();

		String response = gson.fromJson(br.readLine(), Map.class).get("response").toString();
		
		System.out.println(response);

		String token = gson.fromJson(response, Map.class).get("access_token").toString();

		br.close();
		conn.disconnect();

		return token;
	}
	
	
}
