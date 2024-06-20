package com.kh.pjtMungHub.kindergartenMap.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.pjtMungHub.kindergartenMap.model.dao.MapDao;
import com.kh.pjtMungHub.kindergartenMap.model.vo.MapVO;
import com.kh.pjtMungHub.pet.model.vo.Pet;

@Service
public class MapServiceImpl implements MapService{
	
	@Autowired
	private MapDao mapDao;
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Override
	public ArrayList<MapVO> selectMap() {
		
		ArrayList<MapVO> mapList = mapDao.selectMap(sqlsession);
		
		return mapList;
	}

	//해당 회원의 반려동물 정보 조회 메서드
	@Override
	public Pet selectPet(int ownerNo) {
		Pet pet = mapDao.selectPet(sqlsession,ownerNo);
		return pet;
	}

	@Override
	public MapVO selectKindergarten(int kindNo) {
		MapVO kindergarten = mapDao.selectKindergarten(sqlsession, kindNo);
		return kindergarten;
	}


}
