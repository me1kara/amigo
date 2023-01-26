package com.lec.amigo.controller;

import java.io.File;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.service.BoardService;
import com.lec.amigo.service.ReplyService;
import com.lec.amigo.vo.BoardVO;
import com.lec.amigo.vo.ReplyVO;



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
	
	@RequestMapping("/user_board_list_Like.do")
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
		return "view/comunity/user_board_list.jsp";
	}
			
	
	@RequestMapping(value= "/user_board_detail.do", method=RequestMethod.GET)
	public String user_board_detail(Model model, BoardVO board, SearchVO searchVO, @RequestParam int ubd_no, HttpServletRequest req, ReplyVO replyVO) {
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("board", boardService.getBoard(board));
		if(req.getAttribute("updateCount_is")==null) {
			boardService.updateCount(ubd_no);
		}
		
			List<ReplyVO> replyList = null;
			replyList = replyService.getReplyList(replyVO.getUbd_no());
			model.addAttribute("replyList", replyList);
		
		return "view/comunity/user_board_detail.jsp";
	}
	
	@RequestMapping(value= "/user_board_update.do", method=RequestMethod.GET)
	public String user_board_update(Model model, BoardVO board, SearchVO searchVO) {
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("board", boardService.getBoard(board));
		return "view/comunity/user_board_update_form.jsp";
	}
	
	@RequestMapping(value="/user_board_update.do", method=RequestMethod.POST)
	public String user_board_update(Model model, BoardVO board) {
		boardService.updateBoard(board);
		model.addAttribute("msg","글이 정상적으로 수정되었습니다.");
		model.addAttribute("url","user_board_list.do");
		return "view/comunity/alert.jsp";
	}
	
	@RequestMapping(value="/user_board_delete.do", method=RequestMethod.GET)
	public String user_board_delete(BoardVO board) {
		boardService.deleteBoard(board);
		return "user_board_list.do";
	}
	
	@RequestMapping(value="/user_board_cate.do", method=RequestMethod.GET)
	public String user_board_cate(Model model, SearchVO searchVO, BoardVO board,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int rowSizePerPage,
			@RequestParam(defaultValue="") String searchCategory,
			@RequestParam(defaultValue="") String searchType,
			@RequestParam(defaultValue="") String searchWord) 
			{
		
		searchVO.setTotalRowCount(boardService.getTotalRowCount(searchVO));
		searchVO.setCurPage(curPage);
		searchVO.setRowSizePerPage(rowSizePerPage);
		searchVO.setSearchCategory(searchCategory);
		searchVO.setSearchType(searchType);
		searchVO.setSearchWord(searchWord);
		searchVO.pageSetting();
		
		List<BoardVO> boardList = boardService.selectCate(board);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("boardList", boardList);		
		return "view/comunity/user_board_list.jsp";
	}
	
	@RequestMapping(value="/user_board_insert.do", method=RequestMethod.GET)
	public String user_board_insert() {
		return "view/comunity/user_board_insert.jsp";
	}
	
	@RequestMapping(value="/user_board_insert.do", method=RequestMethod.POST)
	public String user_board_insert(Model model, BoardVO board) {
		MultipartFile uploadFile = board.getUploadFile();
		if (!uploadFile.isEmpty()) {
			String fileRealName = uploadFile.getOriginalFilename();
			String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length());
			
			UUID uuid = UUID.randomUUID();
			System.out.println(uuid.toString());
			String[] uuids = uuid.toString().split("-");
			String uniqueName = uuids[0];
			
			File saveFile = new File(uploadFolder+"\\"+uniqueName + fileExtension);  // 적용 후
			try {
				uploadFile.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			} 
			board.setUbd_file(fileRealName);
		}		
		
		boardService.insertBoard(board);
		model.addAttribute("msg","글이 정상적으로 등록되었습니다.");
		model.addAttribute("url","user_board_list.do");
		return "view/comunity/alert.jsp";
	}
	
}




