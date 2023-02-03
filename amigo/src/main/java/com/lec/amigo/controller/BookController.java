package com.lec.amigo.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.mail.search.IntegerComparisonTerm;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lec.amigo.common.PagingVO;
import com.lec.amigo.common.SearchVO;
import com.lec.amigo.dao.SitterDAO;
import com.lec.amigo.impl.BookServiceImpl;
import com.lec.amigo.impl.SitterServiceImpl;
import com.lec.amigo.vo.HeartVO;
import com.lec.amigo.vo.SitterVO;
import com.lec.amigo.vo.UserVO;

@Controller
public class BookController {
	
	@Autowired
	BookServiceImpl bookService;
	
	@Autowired
	SitterServiceImpl sitterService;
	
	
	@RequestMapping(value = "/view/book/book.do", method = { RequestMethod.GET })
	public String book (HttpServletRequest req, Model model, SearchVO search, 
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int rowSizePerPage) {
		
		String calr = req.getParameter("bookDate");
		String address = req.getParameter("address");
		String[] addrList = address.split("\\s");
		String secondeAddr = addrList[1];
		
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
		List<SitterVO> sittList = bookService.getArroundSitter(secondeAddr,search);
		List<UserVO> sittNameList = bookService.getUserNameList(secondeAddr);
		
		for(SitterVO sit : sittList) {
			System.out.println(sit.getUser_no()+"컨트롤러에서 확인!");			
		}
		
		System.out.println("시작페이지"+startPage);
		System.out.println("끝페이지"+endPage);
		System.out.println("총페이지"+totalPage);
		System.out.println("현재페이지"+curPage);
		System.out.println("페이지당글갯수"+rowSizePerPage);
		
		
		req.setAttribute("sittList", sittList); //현재쪽기반리스트
		req.setAttribute("sittNameList", sittNameList); // 이름
		req.setAttribute("searchVO", search); //페이징 정보
		
		//페이징때문에 넣은 주소 보존
		req.setAttribute("address", address);
		
		//예약정보담김
		req.setAttribute("calr", calr);
		
		System.out.println(calr);
		
		/*
		 * JSONParser parser = new JSONParser(); JSONArray jms = null; try { jms =
		 * (JSONArray) parser.parse(calr); } catch (ParseException e) {
		 * e.printStackTrace(); }
		 * 
		 * for(int i=0; i< jms.size(); i++) { JSONObject jsonObj =
		 * (JSONObject)jms.get(i); System.out.println(jsonObj.get("title"));
		 * System.out.println(jsonObj.get("start"));
		 * System.out.println(jsonObj.get("end")); }
		 */
		
		
		//해당날짜,
		

		return "book_sitter_list.jsp?addr="+secondeAddr;
	}
	
	
	@RequestMapping(value = "/view/book/sitter_profile.do", method = { RequestMethod.GET })
	public String getSitterProfile (HttpServletRequest req, HttpServletResponse resp, SitterVO sitterVO) {

		SitterVO s = sitterService.getSitter(sitterVO);
		System.out.println(sitterVO.getSit_no()+"싯넘버 확인용");
		
		req.setAttribute("sitter", s);

		
		
	
		
		return "/view/sitter/sitter_profile.jsp";
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

	
}
