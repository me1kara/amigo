package com.lec.amigo.service;

import java.util.List;

import com.lec.amigo.common.SearchVO;
import com.lec.amigo.vo.BoardVO;

public interface BoardService {

	List<BoardVO> getBoardList(SearchVO searchVO);
	
}
