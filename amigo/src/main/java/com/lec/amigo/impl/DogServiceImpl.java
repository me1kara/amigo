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
	public DogVO getDog(int dog_no) {
		return dogDAO.getDog(dog_no);
	}

	@Override
	public List<DogVO> getDogList(int user_no) {
		return dogDAO.getDogList(user_no);
	}

	@Override
	public DogVO insertDog(DogVO dog) {
		return dogDAO.insertDog(dog);
	}


	@Override
	public int updateDog(DogVO dog) {
		return dogDAO.updateDog(dog);
	}

	@Override
	public int deleteDog(int dog_no) {
		return dogDAO.deleteDog(dog_no);
	}
}
