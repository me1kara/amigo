package com.lec.amigo.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.mail.search.IntegerComparisonTerm;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.eclipse.jdt.internal.compiler.lookup.ImportConflictBinding;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.annotation.RequestScope;

import com.lec.amigo.common.PagingVO;
import com.lec.amigo.common.SearchVO;
import com.lec.amigo.dao.SitterDAO;
import com.lec.amigo.impl.BookServiceImpl;
import com.lec.amigo.impl.DogServiceImpl;
import com.lec.amigo.impl.SitterServiceImpl;
import com.lec.amigo.impl.UserServiceImpl;
import com.lec.amigo.vo.BookContentVO;
import com.lec.amigo.vo.BookVO;
import com.lec.amigo.vo.DogVO;
import com.lec.amigo.vo.HeartVO;
import com.lec.amigo.vo.Payment;
import com.lec.amigo.vo.SitterVO;
import com.lec.amigo.vo.UserVO;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;

@Controller
public class BookController {
	
	@Autowired
	BookServiceImpl bookService;
	
	@Autowired
	SitterServiceImpl sitterService;
	
	@Autowired
	UserServiceImpl userService;
	
	@Autowired
	DogServiceImpl dogSerice;
	
	@RequestMapping(value = "/view/book/book.do", method = { RequestMethod.GET })
	public String book (HttpServletRequest req, Model model, SearchVO search, 
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int rowSizePerPage, BookVO bookVO) {
		
		String calr = req.getParameter("bookDate");
		String address = req.getParameter("res_addr"); //주소
		
		System.out.println(bookVO.toString());
		
		String[] addrList = address.split("\\s");
		String secondeAddr = addrList[0];
		
		search.setCurPage(curPage); // 현재페이지
		search.setRowSizePerPage(rowSizePerPage); // 페이지당 담길 글 갯수
		int totalCount = bookService.getTotalRowCount(secondeAddr);
		int totalPage = (totalCount % rowSizePerPage>0) ? (totalCount/rowSizePerPage)+1 : (totalCount/rowSizePerPage); //나머지가 있다면, 없다면 
		search.setTotalRowCount(totalCount); // 토탈 펫시터 갯수
		search.setTotalPageCount(totalPage); // 토탈 페이지 갯수
		int startPage = (search.getCurPage() % search.getRowSizePerPage()>0) ? (int)(search.getCurPage()/search.getRowSizePerPage())+1:((int)(search.getCurPage()/search.getRowSizePerPage()))-search.getRowSizePerPage()+1;
		int endPage = startPage+rowSizePerPage-1;
		if(endPage>totalPage) {
			endPage=totalPage;
		}
		search.setFirstPage(startPage);//현재 페이지기준 스타트페이지
		search.setLastPage(endPage);//현재 페이지기준 엔드페이지
		search.setPageSize(rowSizePerPage);
		List<SitterVO> sittList = bookService.getArroundSitter(secondeAddr,search,calr);
		List<UserVO> sittNameList = bookService.getUserNameList(secondeAddr);
		
		for(SitterVO sit : sittList) {
			System.out.println(sit.getUser_no()+"컨트롤러에서 확인!");			
		}
		
		req.setAttribute("sittList", sittList); //현재쪽기반리스트
		req.setAttribute("sittNameList", sittNameList); // 이름
		req.setAttribute("searchVO", search); //페이징 정보
		
		//페이징때문에 넣은 주소 보존
		req.setAttribute("address", address);
		
		//예약정보담김
		req.setAttribute("calr", calr);
		HttpSession sess =req.getSession(); 
		
		sess.setAttribute("calr", calr);
		sess.setAttribute("book", bookVO);
		
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
			System.out.println(title);
		}


		return "book_sitter_list.jsp?addr="+secondeAddr;
	}
	
	
	@RequestMapping(value = "/view/book/sitter_profile.do", method = { RequestMethod.GET })
	public String getSitterProfile (HttpServletRequest req, HttpServletResponse resp, SitterVO sitterVO, HttpSession sess) {

		SitterVO s = sitterService.getSitter(sitterVO);
		BookVO book = (BookVO)sess.getAttribute("book");
		
		System.out.println(s.toString());
		
		req.setAttribute("sitter", s);
		req.setAttribute("book", book);
		return "/view/sitter/sitter_profile.jsp";
	}
	
	@RequestMapping(value = "/view/book/book_sitter_form.do", method = { RequestMethod.GET })
	public String book_from (HttpSession sess) {
		UserVO user = (UserVO)sess.getAttribute("user");
		List<DogVO> myDog_list = dogSerice.getDogList(user.getUser_no());
		
		if(!myDog_list.isEmpty()) {
			sess.setAttribute("myDog_list", myDog_list);
		}else {
			sess.removeAttribute("myDog_list");
		}
		
		return "/view/book/book_sitter_form.jsp";
	}
	
	
	@RequestMapping(value = "/requestBook.do", method = { RequestMethod.GET })
	public String finalBook (HttpServletRequest req) {
		HttpSession sess= req.getSession();
		int sit_no = Integer.parseInt(req.getParameter("sit_no"));
		int user_no = ((UserVO)sess.getAttribute("user")).getUser_no();
		String calr = (String)sess.getAttribute("calr");
		BookVO book = (BookVO)sess.getAttribute("book");
		
		String merchant_uid = req.getParameter("merchant_uid");
		
		System.out.println("확인확인확인영"+merchant_uid);
		
		book.setSit_no(sit_no);
		book.setUser_no(user_no);
		
		int b = bookService.setBook(calr, book, merchant_uid);
		
		
		if(b>0) {
			sess.removeAttribute("calr");
			sess.removeAttribute("book");
			req.setAttribute("count", b);
		}

		return "/view/book/book_sitter_request.jsp";
	}
	
	@PostMapping("/view/book/ajax/calMoney.do")
	@ResponseBody 
	public int calMoney(HttpServletRequest req) {
		int data = 0;
		String calr = req.getParameter("book_date");
		JSONParser parser = new JSONParser();
		JSONArray jms = null;
		try {
			jms = (JSONArray) parser.parse(calr);
		} catch (ParseException e) {
			e.printStackTrace();
		}	
		int time = 0;
		
		for(int i=0; i< jms.size(); i++) {
			 JSONObject jsonObj = (JSONObject)jms.get(i);
			 String title = (String) jsonObj.get("title");
			 String start = (String) jsonObj.get("start");
			 String end = (String) jsonObj.get("end");

			 SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
			 String timeList = title.split(",")[1];
			 String startTime = timeList.split("~")[0];
			 String endTime = timeList.split("~")[1];
			 
			 SimpleDateFormat f = new SimpleDateFormat("HH:mm");

		
			 try {
				Date date1 = transFormat.parse(start);
				Date date2 = transFormat.parse(end);
		        long diffSec = (date2.getTime() - date1.getTime()) / 1000;
				Long diffDays = diffSec / (24*60*60);
				
				//이벤트의 일차이
				int days = diffDays.intValue();			
				System.out.println(days+"일차이");
				Date t1 = f.parse(startTime);
				Date t2 = f.parse(endTime);
				long diff = t2.getTime() - t1.getTime();				
				Long diffMinute = diff/(1000*60);
				int bun = diffMinute.intValue();		
				System.out.println(bun+"해당 분은");
				data += bookService.calMoney(days, bun);
				 
			} catch (java.text.ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			 System.out.println(title);
			 System.out.println(start);
			 System.out.println(end);
		}
		
		
		return data;
		
	}
	
	@PostMapping("/ajax/getBook_detail.do")
	@ResponseBody 
	public List<BookContentVO> getBook_datail(HttpServletRequest req) {
		int rno = Integer.parseInt(req.getParameter("rno")) ;
		
		List<BookContentVO> bookDetailList = bookService.getBookDetailList(rno);
		
		System.out.println(rno);
		
		for (BookContentVO bookContentVO : bookDetailList) {
			System.out.println(bookContentVO.getRes_time()+"확인용시간");
		}
		
		return bookDetailList;
	}
	
	@PostMapping("/ajax/deleteBook.do")
	@ResponseBody 
	public Payment deleteBook(HttpServletRequest req) {
		int rno = Integer.parseInt(req.getParameter("rno"));		
		int result = bookService.deleteBook(rno);
		
		if(result>0) {
			Payment payment = bookService.getPayment(rno);
			return payment;
		}else {
			return null;
		}


	}
	
	
	@PostMapping("/ajax/updateBook.do")
	@ResponseBody 
	public int updateBook(HttpServletRequest req) {
		int rno = Integer.parseInt(req.getParameter("rno")) ;
		int result = bookService.updateBook(rno);

		return result;
	}
	
	
	@PostMapping("/view/book/ajax/payment.do")
	@ResponseBody 
	public ResponseEntity<?> payBook(@RequestBody Map<String, Object> model, HttpServletRequest req) {
		
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "application/json; charset=UTF-8");
		JSONObject responseObj = new JSONObject();
		
		System.out.println(model.toString());
		
		UserVO user = (UserVO)req.getSession().getAttribute("user");
		
		System.out.println("입장확인");
		
		int money = (int)model.get("paid_amount"); //돈
		String imp_uid = (String)model.get("imp_uid"); //고유번호
		String merchant_uid = (String)model.get("merchant_uid"); //주문번호
		String card = (String)model.get("card_number");
		int user_no = Integer.parseInt((String)model.get("buyer_postcode"));
		
		boolean success = (Boolean)model.get("success");
		String error_msg = (String)model.get("error_msg");
		
		System.out.println(money + imp_uid + merchant_uid);
		System.out.println("카드넘버"+card);
		
		if(success==true) {
			Payment payment = new Payment();
			payment.setImp_uid(imp_uid);
			payment.setMerchant_uid(merchant_uid);
			payment.setPay(money);
			payment.setUser_no(user_no);
			try {
				
				String api_key = "7637382105357040";
				String api_secret = "GLH595QqwqJMZ9Z7oeiFmpbvOLTfO6w7iojqLlHtiuJA01jHK09c0AJXqQugN2hGMppj3qS7U17cwE7x";
				
				IamportClient ic = new IamportClient(api_key, api_secret);
				IamportResponse<com.siot.IamportRestClient.response.Payment> response = ic.paymentByImpUid(imp_uid);
				BigDecimal import_amount =response.getResponse().getAmount(); //api_amount
			
				if(payment.getPay()==import_amount.intValue()) {
					int insertPay = bookService.payBook(payment);
					
					if(insertPay>0) {responseObj.put("process_result", "결제성공:" + payment.getMerchant_uid());}
					else {
						ic.cancelPaymentByImpUid(new CancelData(merchant_uid, true));
						responseObj.put("process_result", "결제에러:디비삽입실패");
						}
				}else {
				   ic.cancelPaymentByImpUid(new CancelData(merchant_uid, true));
				   responseObj.put("process_result", "결제에러:금액불일치");
				}
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		}else {
			System.out.println("error_msg:" + error_msg);
			responseObj.put("process_result", "결제에러:" + error_msg);
		}
		System.out.println("responseObj:" + responseObj.toString());
		return new ResponseEntity<String>(responseObj.toString(), responseHeaders, HttpStatus.OK);
	}
	
	@PostMapping("/ajax/canclePay.do")
	@ResponseBody
	public String canclePay(HttpServletRequest req) {
		
		
		return null;
	}
	
	
	@RequestMapping(value = "/book_check.do", method = { RequestMethod.GET })
	public String myBookList (Model model, HttpSession sess,SearchVO searchVO,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int rowSizePerPage,
			@RequestParam(defaultValue="") String searchCategory,
			@RequestParam(defaultValue="") String searchType,
			@RequestParam(defaultValue="") String searchWord) {
		
		UserVO user = (UserVO)sess.getAttribute("user");
		int user_no = user.getUser_no();
		
		searchVO.setTotalRowCount(bookService.getMyBookCount(user_no, searchVO));
		searchVO.setCurPage(curPage);
		searchVO.setRowSizePerPage(rowSizePerPage);
		searchVO.setSearchCategory(searchCategory);
		searchVO.setSearchType(searchType);
		searchVO.setSearchWord(searchWord);
		searchVO.pageSetting();
		
		List<BookVO> myBookList = bookService.getBookList(user_no,searchVO);
		List<SitterVO> sitList = sitterService.getSitList(new SearchVO());
		
		model.addAttribute("myBookList", myBookList);
		model.addAttribute("sitList", sitList);

		return "/view/book/book_check.jsp";
	}
	
	@RequestMapping(value = "/receiveBook_check.do", method = { RequestMethod.GET })
	public String myReceiveBookList (Model model, HttpSession sess,SearchVO searchVO,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int rowSizePerPage,
			@RequestParam(defaultValue="") String searchCategory,
			@RequestParam(defaultValue="") String searchType,
			@RequestParam(defaultValue="") String searchWord) {
		
		UserVO user = (UserVO)sess.getAttribute("user");
		int user_no = user.getUser_no();
		
		if(user.getUser_type().equals("S")) {
			SitterVO sitter = new SitterVO();
			sitter.setUser_no(user_no);
			searchVO.setTotalRowCount(bookService.getMyBookCount(sitter,searchVO));
			searchVO.pageSetting();
			List<BookVO> sitBookList = bookService.getSitBookList(user_no,searchVO);
			List<UserVO> userList  = userService.getUserList();
			model.addAttribute("userList", userList);
			model.addAttribute("sitBookList", sitBookList);
		}
					
		return "/view/sitter/sitter_recive_book_check.jsp";
	}
	
	/*
	 * @RequestMapping("/pastBook_check.do") public String
	 * pastBook(HttpServletRequest req) { UserVO user =
	 * (UserVO)(req.getSession().getAttribute("user"));
	 * 
	 * List<BookVO> pastBookList =bookService.getPastBook(user.getUser_no());
	 * req.setAttribute("pastBookList", pastBookList);
	 * 
	 * return "pastBook.jsp"; }
	 */
	
		

	
}
