package com.lec.amigo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.service.SitterBoardService;
import com.lec.amigo.vo.SitterBoardVO;

@Controller
public class SitterBoardController {

	@Autowired
	SitterBoardService sitterboardService;
	
	@Autowired
	Environment environment;
	
	
	// 전체 글 목록
	@RequestMapping("/sitter_board_list.do")
	public String getBoardList (Model model, SearchVO searchVO,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int rowSizePerPage,
			@RequestParam(defaultValue="") String searchCategory,
			@RequestParam(defaultValue="") String searchType,
			@RequestParam(defaultValue="") String searchWord) {
			
			searchVO.setTotalRowCount(sitterboardService.getTotalRowCount(searchVO));
			searchVO.setCurPage(curPage);
			searchVO.setRowSizePerPage(rowSizePerPage);
			searchVO.setSearchCategory(searchCategory);
			searchVO.setSearchType(searchType);
			searchVO.setSearchWord(searchWord);
			searchVO.pageSetting();
		
			List<SitterBoardVO> sboardList = sitterboardService.getSitterBoardList(searchVO);
			model.addAttribute("searchVO", searchVO);
			model.addAttribute("sboardList", sboardList);
			
			return "view/comunity/sitter_board_list.jsp";
	}
	
			
	
	@RequestMapping(value= "/sitter_board_detail.do", method=RequestMethod.GET)
	public String user_board_detail(Model model, SitterBoardVO sboard, SearchVO searchVO, 
			                        @RequestParam int sbd_no,
			                        @RequestParam("updateCount_is") String updateCount_is) {
			
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("sboard", sitterboardService.getSitterBoard(sboard));
		System.out.println(sboard.getSbd_no());
		System.out.println(sboard.getSbd_cont());
		System.out.println(sboard.getSbd_title());
		System.out.println(sboard.getUser_nick());
		
		
		
		// 조회수 올리는 로직
		if(updateCount_is.equals("abc")) { 
			sitterboardService.updateCount(sbd_no);
		}
		
		
//		// 댓글 가져오는 로직
//		List<ReplyVO> replyList = null; // 댓글 리스트 가져오기 위해 객체생성
//		replyList = replyService.getReplyList(replyVO.getUbd_no()); // 게시글 번호에 맞는 댓글 리스트 가져옴
//		model.addAttribute("replyList", replyList); // jsp 파일에 댓글 보냄
//		
//		// 이미 좋아요했는지 확인하는 로직
//		model.addAttribute("findHeart", boardService.findHeart(userVO.getUser_no(), ubd_no));
//
		return "view/comunity/sitter_board_detail.jsp";
	}
//	
//	@RequestMapping(value= "/user_board_update.do", method=RequestMethod.GET)
//	public String user_board_update_form(Model model, BoardVO board, SearchVO searchVO, @RequestParam int cnt) {
//		model.addAttribute("searchVO", searchVO);
//		model.addAttribute("board", boardService.getBoard(board));
//		model.addAttribute("cnt", cnt);
//		
//		// 파일 가져오는 로직
//		BoardVO boardUser = boardService.getBoard(board);  // 파일명 가져오기 위해 boardUser에 담아줌
//			if(boardUser.getUbd_file()!=null) {
//			String[] fileSplit = boardUser.getUbd_file().split(","); // ,를 기준으로 파일명 나눠서 배열에 담음
//							
//			model.addAttribute("fileSplit", fileSplit); // jsp 파일에 파일 보냄
//		}
//		
//		return "view/comunity/user_board_update.jsp";
//	}
//	
//	@RequestMapping(value="/user_board_update.do", method=RequestMethod.POST)
//	public String user_board_update(Model model, BoardVO board, SearchVO searchVO, @RequestParam int cnt) {	
//		
//		if(board.getUploadFile() != null) {
//		List<MultipartFile> uploadFile = board.getUploadFile(); 
//		
//		if (!uploadFile.isEmpty()) {
//
//			List<Map<String, String>> uploadFileList = new ArrayList<>();
//
//			for(int i = 0; i < uploadFile.size(); i++) {
//			String fileRealName = uploadFile.get(i).getOriginalFilename(); // 파일 진짜 이름 가져오기
//				if(fileRealName != "") {
//
//			String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length()); // 확장자명 구하기
//			
//			UUID uuid = UUID.randomUUID();
//			String[] uuids = uuid.toString().split("-");
//			String uniqueName = uuids[0] + fileExtension; // 랜덤 글자 생성
//			
//			Map<String, String> map = new HashMap<>();
//			map.put("fileRealName", fileRealName);
//			map.put("uniqueName", uniqueName);
//			
//			uploadFileList.add(map);
//				}
//			}			
//				
//			try {
//				for(int i=0; i<uploadFileList.size(); i++) {
//					File saveFile = new File(uploadFolder+"\\"+uploadFileList.get(i).get("uniqueName"));
//					uploadFile.get(i).transferTo(saveFile);
//				}
//				
//			} catch (Exception e) {
//				System.out.println("------------------------> 다중 파일 업로드 실패");
//				for(int i=0; i<uploadFile.size(); i++) {
//					new File(uploadFolder+"\\"+uploadFileList.get(i).get("uniqueName")).delete();
//				}
//				e.printStackTrace();
//			} 
//			ArrayList<String> DBUpload = new ArrayList<>();
//			for(int i=0; i<uploadFileList.size(); i++) {
//				DBUpload.add(uploadFileList.get(i).get("uniqueName"));
//			}
//		
//			String DBUploadFile = StringUtils.join(DBUpload, ",");  // 리스트 값들을 ,로 연결해주는 자바에 있는 메서드
//			board.setUbd_file(DBUploadFile); // 파일 이름을 ,로 연결해서 DB에 저장
//		} 
//		}
//		
//		boardService.updateBoard(board);
//		model.addAttribute("msg","글이 정상적으로 수정되었습니다.");
//		model.addAttribute("url","user_board_detail.do?&ubd_no="+board.getUbd_no()+"&curPage="+searchVO.getCurPage()+"&rowSizePerPage="+searchVO.getRowSizePerPage()
//							+"&searchType="+searchVO.getSearchType()+"&searchWord="+searchVO.getSearchWord()+"&updateCount_is=xyz"+"&cnt="+cnt);
//		return "view/comunity/alert.jsp";
//	}
//	
//	@RequestMapping(value="/user_board_delete.do", method=RequestMethod.GET)
//	public String user_board_delete(BoardVO board) {
//		boardService.deleteBoard(board);
//		return "user_board_list.do";
//	}
//
//	
//	@RequestMapping(value="/user_board_insert.do", method=RequestMethod.GET)
//	public String user_board_insert() {
//		return "view/comunity/user_board_insert.jsp";
//	}
//	
//	@RequestMapping(value="/user_board_insert.do", method=RequestMethod.POST)
//	public String user_board_insert(Model model, BoardVO board) {
//		
//		if(board.getUploadFile() != null) {
//		List<MultipartFile> uploadFile = board.getUploadFile(); 
//		
//		if (!uploadFile.isEmpty()) {
//
//			List<Map<String, String>> uploadFileList = new ArrayList<>();
//
//			for(int i = 0; i < uploadFile.size(); i++) {
//			String fileRealName = uploadFile.get(i).getOriginalFilename(); // 파일 진짜 이름 가져오기
//				if(fileRealName != "") {
//
//					String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length()); // 확장자명 구하기
//				
//					UUID uuid = UUID.randomUUID();
//					String[] uuids = uuid.toString().split("-");
//					String uniqueName = uuids[0] + fileExtension; // 랜덤 글자 생성
//							
//					Map<String, String> map = new HashMap<>();
//					map.put("fileRealName", fileRealName);
//					map.put("uniqueName", uniqueName);
//			
//					uploadFileList.add(map);
//				}
//			}
//				
//			try {
//				for(int i=0; i<uploadFileList.size(); i++) {
//					File saveFile = new File(uploadFolder+"\\"+uploadFileList.get(i).get("uniqueName"));
//						uploadFile.get(i).transferTo(saveFile);
//				}
//				
//			} catch (Exception e) {
//				System.out.println("------------------------> 다중 파일 업로드 실패");
//				for(int i=0; i<uploadFile.size(); i++) {
//					new File(uploadFolder+"\\"+uploadFileList.get(i).get("uniqueName")).delete();
//				}
//				e.printStackTrace();
//			} 
//			ArrayList<String> DBUpload = new ArrayList<>();
//			for(int i=0; i<uploadFileList.size(); i++) {
//				DBUpload.add(uploadFileList.get(i).get("uniqueName"));
//			}
//		
//			String DBUploadFile = StringUtils.join(DBUpload, ",");  // 리스트 값들을 ,로 연결해주는 자바에 있는 메서드
//			board.setUbd_file(DBUploadFile); // 파일 이름을 ,로 연결해서 DB에 저장
//		} 
//		}
//		boardService.insertBoard(board);
//		model.addAttribute("msg","글이 정상적으로 등록되었습니다.");
//		model.addAttribute("url","user_board_list.do");
//		return "view/comunity/alert.jsp";
//	}
//	
//	
//	@PostMapping("heart.do")
//	@ResponseBody 
//	public int heart(@ModelAttribute HeartVO heart) {
//		int data = boardService.insertHeart(heart);
//		return data;
//	}
	
}




