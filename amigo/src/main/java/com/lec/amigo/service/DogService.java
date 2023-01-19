package com.lec.amigo.service;

import java.util.List;

import com.lec.amigo.vo.DogVO;

public interface DogService {
	
	DogVO getDog(DogVO dog);
	List<DogVO> getDogList(DogVO dog);
	DogVO insertDog(DogVO dog);
	int deleteDog(DogVO dog);
	int updateDog(DogVO dog);
}
