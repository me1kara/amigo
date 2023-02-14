package com.lec.amigo.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.PostConstruct;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.service.CsBoardService;
import com.lec.amigo.service.CsReplyService;
import com.lec.amigo.vo.CsBoardVO;
import com.lec.amigo.vo.CsReplyVO;

@Controller
public class CsBoardController {

	@Autowired
	CsBoardService csBoardService;
	
	@Autowired
	CsReplyService csReplyService;
	
	@Autowired
	Environment environment;
	
	private String uploadFolder = "";
	
	@PostConstruct
	public void getUploadPathPropeties() {
		uploadFolder = environment.getProperty("uploadFolder");
	}
	
	
	// 메인으로 가줍니다.
		@RequestMapping(value = "/cs_main.do", method = RequestMethod.GET)
		public String csmain() {	
			return "view/cs/cs_main.jsp"; 
		}
	
	// 전체 글목록을 가져오기 
	@RequestMapping("/cs_board_list.do")
	public String getBoardList (Model model, SearchVO searchVO,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int rowSizePerPage,
			@RequestParam(defaultValue="") String searchCategory,
			@RequestParam(defaultValue="") String searchType,
			@RequestParam(defaultValue="") String searchWord) {
			
			searchVO.setTotalRowCount(csBoardService.getTotalRowCount(searchVO));
			searchVO.setCurPage(curPage);
			searchVO.setRowSizePerPage(rowSizePerPage);
			searchVO.setSearchCategory(searchCategory);
			searchVO.setSearchType(searchType);
			searchVO.setSearchWord(searchWord);
			searchVO.pageSetting();
		
			List<CsBoardVO> csboardList = csBoardService.getCsBoardList(searchVO);
			model.addAttribute("searchVO", searchVO);
			model.addAttribute("csboardList", csboardList);
			
			return "view/cs/cs_board_list.jsp";
	}
	
			
	
	@RequestMapping(value= "/cs_board_detail.do", method=RequestMethod.GET)
	public String cs_board_detail(Model model, CsBoardVO csboard, SearchVO searchVO, 
			                        @RequestParam int hbd_no, CsReplyVO csReplyVO,
			                        @RequestParam("updateCount_is") String updateCount_is) {
			
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("csboard", csBoardService.getCsBoard(csboard));
		
		
		// 조회수를 올려줍니다.
		if(updateCount_is.equals("abc")) { 
			csBoardService.updateHbdCount(hbd_no);
		}
		
		
		// 파일을 가져와줍니다. 그치만 파일을 가져오지는 않기로 했습니다.
		CsBoardVO csBoardUser = csBoardService.getCsBoard(csboard);  // 파일명 가져오기 위해 boardUser에 담아줌
		if(csBoardUser.getHbd_file()!=null) {
		String[] fileSplit = csBoardUser.getHbd_file().split(","); // ,를 기준으로 파일명 나눠서 배열에 담음
		
		model.addAttribute("fileSplit", fileSplit); 
		} 
		
		
		// 댓글 가져오는 로직입니다. 
		List<CsReplyVO> csreplyList = null; // 댓글 리스트 가져오기 위해 객체생성
		csreplyList = csReplyService.getCsReplyList(csReplyVO.getHbd_no()); // 게시글 번호에 맞는 댓글 리스트 가져옴
		model.addAttribute("csreplyList", csreplyList); // jsp 파일에 댓글 보내줍니다.
		

		return "view/cs/cs_board_detail.jsp";
	}
	
	@RequestMapping(value= "/cs_board_update.do", method=RequestMethod.GET)
	public String cs_board_update_form(Model model, CsBoardVO csboard, SearchVO searchVO) {
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("csboard", csBoardService.getCsBoard(csboard));
		
		// 파일 가져오는 로직
		CsBoardVO csBoardUser = csBoardService.getCsBoard(csboard);  // 파일명 가져오기 위해 boardUser에 담아줌
			if(csBoardUser.getHbd_file()!=null) {
			String[] fileSplit = csBoardUser.getHbd_file().split(","); // ,를 기준으로 파일명 나눠서 배열에 담음
							
			model.addAttribute("fileSplit", fileSplit); // jsp 파일에 파일 보냄
		}
		
		return "view/cs/cs_board_update.jsp";
	}
	
	@RequestMapping(value="/cs_board_update.do", method=RequestMethod.POST)
	public String cs_board_update(Model model, CsBoardVO csboard, SearchVO searchVO ) {	
		
		if(csboard.getUploadFile() != null) {
		List<MultipartFile> uploadFile = csboard.getUploadFile(); 
		
		if (!uploadFile.isEmpty()) {

			List<Map<String, String>> uploadFileList = new ArrayList<>();

			for(int i = 0; i < uploadFile.size(); i++) {
			String fileRealName = uploadFile.get(i).getOriginalFilename(); // 파일 진짜 이름 가져오기
				if(fileRealName != "") {

			String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length()); // 확장자명 구하기
			
			UUID uuid = UUID.randomUUID();
			String[] uuids = uuid.toString().split("-");
			String uniqueName = uuids[0] + fileExtension; // 랜덤 글자 생성
			
			Map<String, String> map = new HashMap<>();
			map.put("fileRealName", fileRealName);
			map.put("uniqueName", uniqueName);
			
			uploadFileList.add(map);
				}
			}			
				
			try {
				for(int i=0; i<uploadFileList.size(); i++) {
					File saveFile = new File(uploadFolder +"\\"+uploadFileList.get(i).get("uniqueName"));
					uploadFile.get(i).transferTo(saveFile);
				}
				
			} catch (Exception e) {
				System.out.println("------------------------> 다중 파일 업로드 실패");
				for(int i=0; i<uploadFile.size(); i++) {
					new File(uploadFolder+"\\"+uploadFileList.get(i).get("uniqueName")).delete();
				}
				e.printStackTrace();
			} 
			ArrayList<String> DBUpload = new ArrayList<>();
			for(int i=0; i<uploadFileList.size(); i++) {
				DBUpload.add(uploadFileList.get(i).get("uniqueName"));
			}
		
			String DBUploadFile = StringUtils.join(DBUpload, ",");  // 리스트 값들을 ,로 연결해주는 자바에 있는 메서드
			csboard.setHbd_file(DBUploadFile); // 파일 이름을 ,로 연결해서 DB에 저장
		} 
		}
		
		csBoardService.updateCsBoard(csboard);
		model.addAttribute("msg","글이 정상적으로 수정되었습니다.");
		model.addAttribute("url","cs_board_detail.do?&Hbd_no="+csboard.getHbd_no()+"&curPage="+searchVO.getCurPage()+"&rowSizePerPage="+searchVO.getRowSizePerPage()
							+"&searchType="+searchVO.getSearchType()+"&searchWord="+searchVO.getSearchWord()+"&updateCount_is=xyz");
		return "view/cs/cs_alert.jsp";
	}
	/* 파일 업로드 종료 */
	
	@RequestMapping(value="/cs_board_insert.do", method=RequestMethod.GET)
	public String cs_board_insert() {
		return "view/cs/cs_board_insert.jsp";
	}
	
	@RequestMapping(value="/cs_board_insert.do", method=RequestMethod.POST)
	public String cs_board_insert(Model model, CsBoardVO csboard) {
		
		if(csboard.getUploadFile() != null) {
		List<MultipartFile> uploadFile = csboard.getUploadFile(); 
		
		if (!uploadFile.isEmpty()) {

			List<Map<String, String>> uploadFileList = new ArrayList<>();

			for(int i = 0; i < uploadFile.size(); i++) {
			String fileRealName = uploadFile.get(i).getOriginalFilename(); // 파일 진짜 이름 가져오기
				if(fileRealName != "") {

					String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length()); // 확장자명 구하기
				
					UUID uuid = UUID.randomUUID();
					String[] uuids = uuid.toString().split("-");
					String uniqueName = uuids[0] + fileExtension; // 랜덤 글자 생성
							
					Map<String, String> map = new HashMap<>();
					map.put("fileRealName", fileRealName);
					map.put("uniqueName", uniqueName);
			
					uploadFileList.add(map);
				}
			}
				
			try {
				for(int i=0; i<uploadFileList.size(); i++) {
					File saveFile = new File(uploadFolder+"\\"+uploadFileList.get(i).get("uniqueName"));
						uploadFile.get(i).transferTo(saveFile);
				}
				
			} catch (Exception e) {
				System.out.println("------------------------> 다중 파일 업로드 실패");
				for(int i=0; i<uploadFile.size(); i++) {
					new File(uploadFolder+"\\"+uploadFileList.get(i).get("uniqueName")).delete();
				}
				e.printStackTrace();
			} 
			ArrayList<String> DBUpload = new ArrayList<>();
			for(int i=0; i<uploadFileList.size(); i++) {
				DBUpload.add(uploadFileList.get(i).get("uniqueName"));
			}
		
			String DBUploadFile = StringUtils.join(DBUpload, ",");  // 리스트 값들을 ,로 연결해주는 자바에 있는 메서드
			csboard.setHbd_file(DBUploadFile); // 파일 이름을 ,로 연결해서 DB에 저장
		} 
		}
		csBoardService.insertCsBoard(csboard);
		model.addAttribute("msg","글이 정상적으로 등록되었습니다.");
		model.addAttribute("url","cs_board_list.do");
		return "view/cs/cs_alert.jsp";
	}
	
	
	@RequestMapping(value="/cs_board_delete.do", method=RequestMethod.GET)
	public String cs_board_delete(CsBoardVO csboard) {
		csBoardService.deleteCsBoard(csboard);
		return "cs_board_list.do";
	}


}




