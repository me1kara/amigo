package com.lec.amigo.controller;

import java.io.File;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.service.BoardService;
import com.lec.amigo.service.ReplyService;
import com.lec.amigo.vo.BoardVO;
import com.lec.amigo.vo.HeartVO;
import com.lec.amigo.vo.ReplyVO;
import com.lec.amigo.vo.UserVO;



@Controller
@PropertySource("classpath:config/uploadpath.properties")
public class BoardController {

	@Autowired
	BoardService boardService;
	
	@Autowired
	ReplyService replyService;
	
	@Autowired
	Environment environment;
	
	private String uploadFolder = "";
	
	@PostConstruct
	public void getUploadPathPropeties() {
		uploadFolder = environment.getProperty("uploadFolder");
	}
	
	// 전체 글 목록
	@RequestMapping("/user_board_list.do")
	public String getBoardList (Model model, SearchVO searchVO,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int rowSizePerPage,
			@RequestParam(defaultValue="") String searchCategory,
			@RequestParam(defaultValue="") String searchType,
			@RequestParam(defaultValue="") String searchWord) {
			
			searchVO.setTotalRowCount(boardService.getTotalRowCount(searchVO));
			searchVO.setCurPage(curPage);
			searchVO.setRowSizePerPage(rowSizePerPage);
			searchVO.setSearchCategory(searchCategory);
			searchVO.setSearchType(searchType);
			searchVO.setSearchWord(searchWord);
			searchVO.pageSetting();
		
			List<BoardVO> boardList = boardService.getBoardList(searchVO);
			model.addAttribute("searchVO", searchVO);
			model.addAttribute("boardList", boardList);
			return "view/comunity/user_board_list.jsp";
	}
	
	
	// 인기글 목록
	@RequestMapping("/user_board_list_like.do")
	public String getBoardListLike (Model model, SearchVO searchVO,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int rowSizePerPage,
			@RequestParam(defaultValue="") String searchCategory,
			@RequestParam(defaultValue="") String searchType,
			@RequestParam(defaultValue="") String searchWord) {
		
		searchVO.setTotalRowCount(boardService.getTotalRowCount(searchVO));
		searchVO.setCurPage(curPage);
		searchVO.setRowSizePerPage(rowSizePerPage);
		searchVO.setSearchCategory(searchCategory);
		searchVO.setSearchType(searchType);
		searchVO.setSearchWord(searchWord);
		searchVO.pageSetting();
		
		List<BoardVO> boardList = boardService.getBoardListLike(searchVO);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("boardList", boardList);		
		return "view/comunity/user_board_list_like.jsp";
	}
	
	
	//  카테고리별 목록
	@RequestMapping("/user_board_cate.do")
	public String user_board_cate(Model model, SearchVO searchVO, BoardVO board,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int rowSizePerPage,
			@RequestParam(defaultValue="") String searchCategory,
			@RequestParam(defaultValue="") String searchType,
			@RequestParam(defaultValue="") String searchWord) 
			{
		
		searchVO.setTotalRowCount(boardService.getCateRowCount(searchVO, board));
		searchVO.setCurPage(curPage);
		searchVO.setRowSizePerPage(rowSizePerPage);
		searchVO.setSearchCategory(searchCategory);
		searchVO.setSearchType(searchType);
		searchVO.setSearchWord(searchWord);
		searchVO.pageSetting();
		
		List<BoardVO> boardList = boardService.selectCate(board, searchVO);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("boardList", boardList);
		model.addAttribute("cate", board.getUbd_cate());
		return "view/comunity/user_board_list_cate.jsp";
	}
			
	
	@RequestMapping(value= "/user_board_detail.do", method=RequestMethod.GET)
	public String user_board_detail(Model model, BoardVO board, SearchVO searchVO, 
			                        @RequestParam int ubd_no, HttpServletRequest req, 
			                        @RequestParam("cnt") int cnt,
			                        ReplyVO replyVO, UserVO userVO) {
			
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("board", boardService.getBoard(board));
		model.addAttribute("cnt", cnt);
		
		// 조회수 올리는 로직
		if(req.getAttribute("updateCount_is")==null) { 
			boardService.updateCount(ubd_no);
		}
		
		// 파일 가져오는 로직
		BoardVO boardUser = boardService.getBoard(board);  // 파일명 가져오기 위해 boardUser에 담아줌
		if(boardUser.getUbd_file()!=null) {
		String[] fileSplit = boardUser.getUbd_file().split(","); // ,를 기준으로 파일명 나눠서 배열에 담음
		
		model.addAttribute("fileSplit", fileSplit); // jsp 파일에 파일 보냄
		} 
		
		// 댓글 가져오는 로직
		List<ReplyVO> replyList = null; // 댓글 리스트 가져오기 위해 객체생성
		replyList = replyService.getReplyList(replyVO.getUbd_no()); // 게시글 번호에 맞는 댓글 리스트 가져옴
		model.addAttribute("replyList", replyList); // jsp 파일에 댓글 보냄
		
		// 이미 좋아요했는지 확인하는 로직
		model.addAttribute("findHeart", boardService.findHeart(userVO.getUser_no(), ubd_no));

		return "view/comunity/user_board_detail.jsp";
	}
	
	@RequestMapping(value= "/user_board_update.do", method=RequestMethod.GET)
	public String user_board_update_form(Model model, BoardVO board, SearchVO searchVO) {
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("board", boardService.getBoard(board));
		return "view/comunity/user_board_update.jsp";
	}
	
	@RequestMapping(value="/user_board_update.do", method=RequestMethod.POST)
	public String user_board_update(Model model, BoardVO board, SearchVO searchVO) {	
		
		if(board.getUploadFile() != null) {
		List<MultipartFile> uploadFile = board.getUploadFile(); 
		
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
			board.setUbd_file(DBUploadFile); // 파일 이름을 ,로 연결해서 DB에 저장
		} 
		}
		
		boardService.updateBoard(board);
		model.addAttribute("msg","글이 정상적으로 수정되었습니다.");
		model.addAttribute("url","user_board_detail.do?ubd_no="+board.getUbd_no()+"&curPage="+searchVO.getCurPage()+"&rowSizePerPage="+searchVO.getRowSizePerPage()+"&searchType="+searchVO.getSearchType()+"&searchWord="+searchVO.getSearchWord());
		return "view/comunity/alert.jsp";
	}
	
	@RequestMapping(value="/user_board_delete.do", method=RequestMethod.GET)
	public String user_board_delete(BoardVO board) {
		boardService.deleteBoard(board);
		return "user_board_list.do";
	}

	
	@RequestMapping(value="/user_board_insert.do", method=RequestMethod.GET)
	public String user_board_insert() {
		return "view/comunity/user_board_insert.jsp";
	}
	
	@RequestMapping(value="/user_board_insert.do", method=RequestMethod.POST)
	public String user_board_insert(Model model, BoardVO board) {
		
		if(board.getUploadFile() != null) {
		List<MultipartFile> uploadFile = board.getUploadFile(); 
		
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
			board.setUbd_file(DBUploadFile); // 파일 이름을 ,로 연결해서 DB에 저장
		} 
		}
		boardService.insertBoard(board);
		model.addAttribute("msg","글이 정상적으로 등록되었습니다.");
		model.addAttribute("url","user_board_list.do");
		return "view/comunity/alert.jsp";
	}
	
	
	@PostMapping("heart.do")
	@ResponseBody 
	public int heart(@ModelAttribute HeartVO heart) {
		int data = boardService.insertHeart(heart);
		return data;
		
	}
	
}




