package com.kh.pjtMungHub.wedding.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.kh.pjtMungHub.kindergarten.model.vo.Vaccine;
import com.kh.pjtMungHub.pet.model.vo.Breed;
import com.kh.pjtMungHub.pet.model.vo.Pet;
import com.kh.pjtMungHub.wedding.model.vo.Wedding;

@Repository
public class WeddingDao {

	//견종 조회 메서드
	public ArrayList<Breed> selectBreeds(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("weddingMapper.selectBreeds");
	}

	//웨딩 목록 조회 메서드
	public ArrayList<Wedding> selectWeddings(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("weddingMapper.selectWeddings");
	}

	//웨딩 정보 상세 조회 메서드
	public Wedding selectWedding(SqlSessionTemplate sqlSession, int weddingNo) {
		return sqlSession.selectOne("weddingMapper.selectWedding",weddingNo);
	}

	public Pet selectPet(SqlSessionTemplate sqlSession,int userNo) {
		return sqlSession.selectOne("weddingMapper.selectPet",userNo);
	}

	//해당 메소드를 하나의 트랜잭션으로 관리할 것
	@Transactional
	public int insertWedding(SqlSessionTemplate sqlSession, Wedding w, ArrayList<Vaccine> vacList) {
		int result = sqlSession.insert("weddingMapper.insertWedding",w);
		int result2 = 1;
			for	(Vaccine v:vacList) {
				result2 *= sqlSession.insert("weddingMapper.insertVaccine",v);
			}
		return result*result2;
	}

	public ArrayList<Wedding> selectRegList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("weddingMapper.selectRegList");
	}

	//웨딩플랜 신청 거절 메서드
	public int rejectReg(SqlSessionTemplate sqlSession, Wedding w) {
		return sqlSession.update("weddingMapper.rejectReg",w);
	}

	//웨딩플랜 신청 승인 메서드
	public int approveReg(SqlSessionTemplate sqlSession, int weddingNo) {

		return sqlSession.update("weddingMapper.approveReg",weddingNo);
	}

	//신청한 만남 조회해오는 메서드
	public int countAppliedList(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("weddingMapper.countAppliedList",userNo);
	}

	@Transactional
	//만남 신청 메서드
	public int applyMatching(SqlSessionTemplate sqlSession, Wedding w, ArrayList<Vaccine> vacList) {
		//만남 신청 처리
		int result1 = sqlSession.insert("weddingMapper.applyMatching",w);
		//백신 접종 증명서 추가
		int result2 =1;
		for(Vaccine v:vacList) {
		result2 *=sqlSession.insert("weddingMapper.insertVaccine",v);	
		}
		return result1 * result2;
	}

	//만남 신청 내역 조회 메서드
	public ArrayList<Wedding> selectAppliedList(SqlSessionTemplate sqlSession, Wedding w) {
		return (ArrayList)sqlSession.selectList("weddingMapper.selectAppliedList",w);
	}


	
}
