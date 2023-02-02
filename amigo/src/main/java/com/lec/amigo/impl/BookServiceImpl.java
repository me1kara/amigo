package com.lec.amigo.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.lec.amigo.common.PagingVO;
import com.lec.amigo.dao.BookDAO;
import com.lec.amigo.service.BookService;
import com.lec.amigo.vo.SitterVO;
import com.lec.amigo.vo.UserVO;

@Service("bookService")
public class BookServiceImpl implements BookService{
	
	@Autowired
	@Qualifier("bookDAO")
	BookDAO bookDao;
	
	@Override
	public int calMoney(int days, int time) {
		return bookDao.calMoney(days, time);
	}

	public List<SitterVO> getArroundSitter(String address,PagingVO page) {
		
		return bookDao.getArroudSitter(address,page);
	}

	public List<UserVO> getUserNameList(String address) {
		// TODO Auto-generated method stub
		return bookDao.getArroundSitterNames(address);
	}
	
	public int getTotalRowCount(String address) {
		return bookDao.getTotalRowCount(address);
	}
	
	
	
}
