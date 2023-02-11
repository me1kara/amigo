package com.lec.amigo.controller;

import java.io.File;

import java.io.IOException;

import java.util.UUID;

import javax.annotation.PostConstruct;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.lec.amigo.impl.SitterServiceImpl;
import com.lec.amigo.vo.SitterVO;


@Controller
@PropertySource("classpath:config/uploadpath.properties")
public class SitterController {
	
	@Autowired
	private SitterServiceImpl sitterService;
	
	@Autowired
	Environment environment;
	
	private String uploadFolder = "";
	
	@PostConstruct
	public void getUploadPathPropeties() {
		uploadFolder = environment.getProperty("uploadFolderSitter");
	}
	
	@RequestMapping("/view/apply/getSitter.do")                    // 유저가 보는 시터정보(승인된시터만 get)
	public String sitterInfo(HttpSession sess, Model model, SitterVO svo) {
		System.out.println("시터의 상세 프로필");
		sitterService.getSitter(svo);
		return "sitter_profile.jsp";
		
	}
	

	@RequestMapping(value="/view/mypage/apply/sitter_join.do", method=RequestMethod.GET) 
	public String insertSitter() {
		
		System.out.println("1........................");
		
		return "/view/apply/sitter_join.jsp";
	}
	
	@PostMapping("/view/apply/sitter_join.do") //펫시터 개인정보가 있어 패킷을 숨겨 전송하고 싶어 post씀
	public String insertSitter(HttpSession sess, Model model, SitterVO svo) throws IOException {				// 도메인에 데이터 등을 노출시키지 않으려고.
		
		MultipartFile uploadFile = svo.getUploadFile();
		if(!uploadFile.isEmpty()) {
			String fileName = uploadFile.getOriginalFilename();  // 파일 진짜 이름 가져오기
			if(fileName != "") {
				String fileExtension = fileName.substring(fileName.lastIndexOf("."),fileName.length()); // 확장자명 구하기
				UUID uuid = UUID.randomUUID();
				String[] uuids = uuid.toString().split("-");
				fileName = uuids[0] + fileExtension; // 랜덤 글자 생성
			}
			uploadFile.transferTo(new File(uploadFolder+fileName));
			svo.setSit_photo(fileName);
		}
		
		
		System.out.println("시터등록");				
		System.out.println(svo.toString());													// VO 에 데이터가 제대로 담겼는지 테스트 해봄
		sitterService.insertSitter(svo);
	

		return "/view/main.jsp";
	}
/*
    230127부터 사진업로드 구현하고, 로그인한 회원의 세션을 지원 페이지에 받아서 값은 admin에게 넘겨주고 유저의 페이지는 마이페이지 리스트로 리다이렉트 시키기.
    admin 이 승인하게 되면 유저에게 알림이 오고, 다시 로그인하면 파트너로 접속할 수 있도록 해주기
    시터를 누르면 시터에 대한 상세 프로필정보가 뜨도록 한다.
 */
	
	
	
	
	
	
	
/*	
  	230127 : 아래 코드는 펫시터 삭제 또는 수정이 필요하다면 이용할 예정.
 
	@RequestMapping(value="/view/apply/sitter_apply_form.do", method=RequestMethod.POST) 
	public String updateSitter(HttpSession sess, Model model, SitterVO svo) {
		System.out.println("시터수정");
		System.out.println(svo.toString());
		sitterService.updateSitter(svo);
		
		int user_no = 4;   // 임시
		List<SitterVO> sitList = sitterService.getSitList(user_no);
		model.addAttribute("sitList", sitList);
		return "my_page_list.jsp";
	}
	
	@RequestMapping(value="/view/apply/sitter_apply_form.do", method=RequestMethod.GET) 
	public String deleteSitter(HttpServletRequest req, HttpSession sess, Model model) {
		//int sit_no = Integer.parseInt(sit_no);
		int sit_no = Integer.parseInt(req.getParameter("sit_no"));
		System.out.println("시터삭제");
		
		sitterService.deleteSitter(sit_no);
		
		int user_no = 4;   // 임시
		List<SitterVO> sitList = sitterService.getSitList(user_no);
		model.addAttribute("sitList", sitList);
		return "my_page_list.jsp";
	}
*/	
	
	

}
	
/*	int sit_smoking = request.getParameter("sit_smoking").equals("true") ? 1 : 0;
		int sit_exp = request.getParameter("sit_exp").equals("true") ? 1 : 0;
		int sit_auth_is = request.getParameter("sit_auth_is").equals("true") ? 1 : 0;
		 sittervo.setSit_smoking(sit_smoking);
		 sittervo.setSit_exp(sit_exp);
		 sittervo.setSit_auth_is(sit_auth_is);*/
/*@RequestMapping("/view/mypage/getSitterList.do")
	
	public String getSitList (HttpSession sess, Model model, SitterVO sittervo) {
		   
		int user_no = 4; //임시
		List<SitterVO> sitList = sitterService.getSitList(user_no);
		model.addAttribute("sitList", sitList); 
		   
		System.out.println(sittervo.toString());
		System.out.println("gggggggggggggggggggggggggggggggggggg");
			
		return "my_page_list.jsp";
	}*/