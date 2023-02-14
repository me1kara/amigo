package com.lec.amigo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.impl.BookServiceImpl;
import com.lec.amigo.impl.SitterServiceImpl;
import com.lec.amigo.impl.UserServiceImpl;
import com.lec.amigo.vo.BookVO;
import com.lec.amigo.vo.SitterVO;
import com.lec.amigo.vo.UserVO;



@Controller
public class AdminController {													// 관리자로 접속하면 마이페이지에서 펫시터 신청관리라는 메뉴가 별도로 뜨고 클릭하면 이동
	
//	@Autowired
//	private UserServiceImpl userService;
	
	@Autowired
	private SitterServiceImpl sitterService;									// 시터서비스에서 필요한 매서드를 가져오려고 함
	
//	@Autowired
//	private BookServiceImpl bookService;
	
	// 펫시터 신청인 전체 리스트
	@RequestMapping(value="/view/admin/getSitList.do", method=RequestMethod.GET) // 관리자로 접속하면 펫시터 전체 신청인원을 볼 수 있게끔 함. 승인 여부 관계없이.
	public String getSitList(Model model, SearchVO searchVO,					 // 성명, 승인여부 등을 검색하고 페이지를 넘길 수 있도록 SearchVO 와 페이징 사용 
 			@RequestParam(defaultValue="1") int curPage,						 // 현재 페이지는 1로
			@RequestParam(defaultValue="10") int rowSizePerPage,                 // 페이지의 row 수는 10개로 함.
			@RequestParam(defaultValue="") String searchCategory,
			@RequestParam(defaultValue="") String searchType,
			@RequestParam(defaultValue="") String searchWord) {	
		
		searchVO.setTotalRowCount(sitterService.getTotalSitRowCount(searchVO));  
		searchVO.setCurPage(curPage);
		searchVO.setRowSizePerPage(rowSizePerPage);
		searchVO.setSearchCategory(searchCategory);
		searchVO.setSearchType(searchType);
		searchVO.setSearchWord(searchWord);
		searchVO.pageSetting();
		
		
		List<SitterVO> sitList = sitterService.getSitList(searchVO);			  // 승인 여부 관계없이 신청리스트 전부 불러옴.
		System.out.println("펫시터 신청리스트 조회");
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("sitList", sitList);
		return "/view/admin/admin_sitList.jsp";
		
	}
	
	// 펫시터 자격 승인해주기
	@RequestMapping(value="/view/admin/updateSitter.do", method=RequestMethod.GET)		  // 관리자가 승인해주면 시터 테이블의 sit_auth_is(불리언) 이 true로 바뀌면서
	public String updateSitter(Model model, SitterVO svo, boolean sit_auth_is) {          // 동시에 회원 테이블에서 회원 구분이 'S' 로 바뀌게끔 고안
		System.out.println("승인합니다");//승인확인
		System.out.println(svo.toString()); // 투스트링으로 객체에 다 담기었는지 확인
		sitterService.updateSitter(svo, true);  // 객체, 불리언(true)
		sitterService.updateTypeS(svo);         //  회원 테이블에서 타입이 S로 바뀜
		
				
		return "/view/admin/getSitList.do";  
	}
	
	// 펫시터 삭제하기
	@RequestMapping(value="/view/admin/deleteSitter.do", method=RequestMethod.GET)        //  펫시터 신청을 실격시키거나 펫시터 자격 자체를 해제하는 용도
	public String deleteSitter(Model model, int user_no, SitterVO svo) {				  //  

		
		System.out.println("삭제합니다");
		sitterService.deleteSitter(user_no);
		
		

		return "/view/admin/getSitList.do"; 
	}

	// 펫시터 모달창에서 보기
	@PostMapping("/ajax/getSit_info.do")													// 펫시터 신청리스트에서 유저번호를 클릭하면 신청한 유저의 상세정보를 볼 수 있음
	@ResponseBody
	public List<SitterVO> getSit_info(HttpServletRequest req) {                             // 리퀘스트 객체에서 
		System.out.println("유저넘버가져오기"+ req.getParameter("userno"));					// 리퀘스트에서 유저번호를 가져오고
		int userno = Integer.parseInt(req.getParameter("userno"));							// 해당 유저번호를 기반으로
		
		List<SitterVO> sitterInfoList = sitterService.getSitInfoList(userno);               // sql select 문을 실행
		
		System.out.println(userno);
		
		for(SitterVO svo : sitterInfoList) {												// 향상된 for문 사용. 시터 정보 리스트의 갯수만큼 돌려서 
			System.out.println(svo.getUser_name()+"성명");									// svo 에서 시터 이름을 가져온 후 콘솔에 제대로 출력되는지 확인
		}
		return sitterInfoList;
	}
	
	

}

//	
//	@RequestMapping(value="/view/admin/getPayList.do", method=RequestMethod.GET) 
//	public String getPayList(Model model,SearchVO searchVO,
//			@RequestParam(defaultValue="1") int curPage,
//			@RequestParam(defaultValue="10") int rowSizePerPage,
//			@RequestParam(defaultValue="") String searchCategory,
//			@RequestParam(defaultValue="") String searchType,
//			@RequestParam(defaultValue="") String searchWord) {	



/*
 * searchVO.setTotalRowCount(); searchVO.setCurPage(curPage);
 * searchVO.setRowSizePerPage(rowSizePerPage);
 * searchVO.setSearchCategory(searchCategory);
 * searchVO.setSearchType(searchType); searchVO.setSearchWord(searchWord);
 * searchVO.pageSetting();
 * 
 * List<BookVO> payList = bookService.getPayList(searchVO);
 */

//		model.addAttribute("myBookList", payList);



//		
//		
//		return "/view/admin/admin_payList.jsp";
//		
//	}
//	