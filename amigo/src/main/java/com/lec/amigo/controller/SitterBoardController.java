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
import com.lec.amigo.service.SitterReplyService;
import com.lec.amigo.vo.SitterBoardVO;
import com.lec.amigo.vo.SitterReplyVO;

@Controller
public class SitterBoardController {

	@Autowired
	SitterBoardService sitterboardService;
	
	@Autowired
	SitterReplyService sitterReplyService;
	
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
			                        @RequestParam int sbd_no, SitterReplyVO sitterReplyVO,
			                        @RequestParam("updateCount_is") String updateCount_is) {
			
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("sboard", sitterboardService.getSitterBoard(sboard));
		
		
		// 조회수 올리는 로직
		if(updateCount_is.equals("abc")) { 
			sitterboardService.updateSbdCount(sbd_no);
		}
		
		
		// 댓글 가져오는 로직
		List<SitterReplyVO> sreplyList = null; // 댓글 리스트 가져오기 위해 객체생성
		sreplyList = sitterReplyService.getSitterReplyList(sitterReplyVO.getSbd_no()); // 게시글 번호에 맞는 댓글 리스트 가져옴
		model.addAttribute("sreplyList", sreplyList); // jsp 파일에 댓글 보냄
		

		return "view/comunity/sitter_board_detail.jsp";
	}
	
	@RequestMapping(value="/sitter_board_insert.do", method=RequestMethod.GET)
	public String user_board_insert() {
		return "view/comunity/sitter_board_insert.jsp";
	}
	
	@RequestMapping(value="/sitter_board_insert.do", method=RequestMethod.POST)
	public String user_board_insert(Model model, SitterBoardVO sboard) {
		
		sitterboardService.insertSitterBoard(sboard);
		model.addAttribute("msg","글이 정상적으로 등록되었습니다.");
		model.addAttribute("url","sitter_board_list.do");
		return "view/comunity/alert.jsp";
	}
	
	@RequestMapping(value= "/sitter_board_update.do", method=RequestMethod.GET)
	public String user_board_update_form(Model model, SitterBoardVO sboard, SearchVO searchVO) {
		
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("sboard", sitterboardService.getSitterBoard(sboard));

		return "view/comunity/sitter_board_update.jsp";
	}
	

	@RequestMapping(value="/sitter_board_update.do", method=RequestMethod.POST)
	public String sitter_board_update(Model model, SitterBoardVO sboard, SearchVO searchVO) {	
		
		sitterboardService.updateSitterBoard(sboard);
		model.addAttribute("msg","글이 정상적으로 수정되었습니다.");
		model.addAttribute("url","sitter_board_detail.do?&sbd_no="+sboard.getSbd_no()+"&curPage="+searchVO.getCurPage()+"&rowSizePerPage="+searchVO.getRowSizePerPage()
							+"&searchType="+searchVO.getSearchType()+"&searchWord="+searchVO.getSearchWord()+"&updateCount_is=xyz");
		return "view/comunity/alert.jsp";
	}
	
	
	@RequestMapping(value="/sitter_board_delete.do", method=RequestMethod.GET)
	public String sitter_board_delete(SitterBoardVO sboard) {
		sitterboardService.deleteSitterBoard(sboard);
		return "sitter_board_list.do";
	}


}




