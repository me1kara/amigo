package com.lec.amigo.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lec.amigo.dao.DogDAO;
import com.lec.amigo.service.DogService;
import com.lec.amigo.vo.DogVO;

@Service("dogService")
public class DogServiceImpl implements DogService {
	
	@Autowired
	DogDAO dogDAO;
	
	@Override
	public DogVO getDog(DogVO dog) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<DogVO> getDogList(DogVO dog) {
		// TODO Auto-generated method stub
		return dogDAO.getDogList(dog);
	}

	@Override
	public DogVO insertDog(DogVO dog) {
		//dogDAO.insertDog(dog);
		return null; 
	}

	@Override
	public int deleteDog(DogVO dog) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateDog(DogVO dog) {
		// TODO Auto-generated method stub
		return 0;
	}

}
