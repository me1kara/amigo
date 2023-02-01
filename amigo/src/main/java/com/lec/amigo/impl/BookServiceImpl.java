package com.lec.amigo.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.lec.amigo.dao.BookDAO;
import com.lec.amigo.service.BookService;
import com.lec.amigo.vo.SitterVO;

@Service("bookService")
public class BookServiceImpl implements BookService{
	
	@Autowired
	@Qualifier("bookDAO")
	BookDAO bookDao;
	
	@Override
	public int calMoney(int days, int time) {
		return bookDao.calMoney(days, time);
	}

	public List<SitterVO> getArroundSitter(String address) {
		
		return bookDao.getArroudSitter(address);
	}
	
}
