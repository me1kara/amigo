package com.lec.amigo.service;

import java.util.List;

import com.lec.amigo.vo.DogVO;

public interface DogService {
	
	DogVO getDog(int dog_no);
	List<DogVO> getDogList(int user_no);
	DogVO insertDog(DogVO dog);
	int deleteDog(int dog_no);
	int updateDog(DogVO dog);
}
