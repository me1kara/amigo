package com.lec.amigo.controller;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.impl.SitterServiceImpl;
import com.lec.amigo.impl.UserServiceImpl;
import com.lec.amigo.service.DogService;
import com.lec.amigo.vo.SitterVO;
import com.lec.amigo.vo.UserVO;



@Controller
@PropertySource("classpath:config/uploadpath.properties")
public class AdminController {
	
	@Autowired
	private UserServiceImpl userService;
	
	@Autowired
	private SitterServiceImpl sitterService;
	
	@Autowired
	Environment environment;
	
	private String uploadFolder = "";
	
	@PostConstruct
	public void getUploadPathPropeties() {
		uploadFolder = environment.getProperty("uploadFolder");
	}
	
	// 펫시터 신청인 전체 리스트
	@RequestMapping(value="/view/admin/getSitList.do", method=RequestMethod.GET) //
	public String getSitList(Model model, SearchVO searchVO,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int rowSizePerPage,
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
		
		
		List<SitterVO> sitList = sitterService.getSitList(searchVO);
		System.out.println("펫시터 신청리스트 조회");
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("sitList", sitList);
		return "/view/admin/admin_sitList.jsp";
		
	}
	
	
	@RequestMapping(value="/view/admin/updateSitter.do", method=RequestMethod.GET)
	public String updateSitter(Model model, SitterVO svo, boolean sit_auth_is) {
		System.out.println("승인합니다");//승인확인
		System.out.println(svo.toString()); // 투스트링
		sitterService.updateSitter(svo, true);  // 객체, 불리언(true)
		sitterService.updateTypeS(svo);         //  회원 테이블에서 타입이 S로 바뀜
		// 사용자수정로직.수정메서드(사용자번호)
				
		return "/view/admin/getSitList.do";  // 실제로 DAO의 매서드가 먹힘.
	}
	

	
	@RequestMapping(value="/view/admin/updateTypeU.do", method=RequestMethod.GET) 
	public String updateTypeU(Model model, int user_no, SitterVO svo, boolean sit_auth_is) {

		
		System.out.println("삭제합니다");
		sitterService.updateTypeU(svo, sit_auth_is);
		sitterService.deleteSitter(user_no);
		

		return "/view/admin/getSitList.do"; 
	}

	
	

}
	
