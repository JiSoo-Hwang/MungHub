package com.kh.pjtMungHub.petcare.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.pjtMungHub.common.model.vo.PageInfo;
import com.kh.pjtMungHub.member.model.vo.Member;
import com.kh.pjtMungHub.petcare.model.dao.PetCareDao;
import com.kh.pjtMungHub.petcare.model.vo.AvailableTimes;
import com.kh.pjtMungHub.petcare.model.vo.Certification;
import com.kh.pjtMungHub.petcare.model.vo.Environment;
import com.kh.pjtMungHub.petcare.model.vo.House;
import com.kh.pjtMungHub.petcare.model.vo.HousePrice;
import com.kh.pjtMungHub.petcare.model.vo.HouseReservation;
import com.kh.pjtMungHub.petcare.model.vo.Payment;
import com.kh.pjtMungHub.petcare.model.vo.PetSitter;
import com.kh.pjtMungHub.petcare.model.vo.Price;
import com.kh.pjtMungHub.petcare.model.vo.Reservation;
import com.kh.pjtMungHub.petcare.model.vo.SupplyGuide;

@Service
public class PetCareServiceImpl implements PetCareService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private PetCareDao petCareDao;
	
	//날짜,시간 지정시 펫시터 리스트형태로 불러오기
	@Override
	public ArrayList<PetSitter> selectSitter(AvailableTimes at) {
		return petCareDao.selectSitter(sqlSession,at);
	}
	
	//요금테이블에서 가격정보 가져오기
	@Override
	public Price priceTable(AvailableTimes at) {
		return petCareDao.priceTable(sqlSession,at);
	}

	//예약 정보 저장하기
	@Override
	public int enrollReservation(Reservation re) {
		return petCareDao.enrollReservation(sqlSession,re);
	}

	//펫시터 정보 가져오기
	@Override
	public PetSitter sitterInfo(Reservation re) {
		return petCareDao.sitterInfo(sqlSession,re);
	}

	//첫페이지 펫시터 리스트 불러오기
	@Override
	public ArrayList<PetSitter> firstSitterList(PageInfo pi) {
		return petCareDao.firstSitterList(sqlSession,pi);
	}
	
	//펫시터 선택 불가능한 날짜 가져오기
	@Override
	public ArrayList<Reservation> disabledDates(int petSitterNo) {
		return petCareDao.disabledDates(sqlSession,petSitterNo);
	}
	
	//예약번호 가져오기
	@Override
	public int selectReservationId(Payment payment) {
		return petCareDao.selectReservationId(sqlSession,payment);
	}

	//결제정보 저장하기
	@Override
	public int insertPayment(Payment payment) {
		return petCareDao.insertPayment(sqlSession,payment);
	}

	//결제내역 보여주기
	@Override
	public Payment payDetail(String uid) {
		return petCareDao.payDetail(sqlSession,uid);
	}
	
	//장기돌봄 처음 페이지 화면
	@Override
	public ArrayList<House> firstHouseList(PageInfo pi) {
		return petCareDao.firstHouseList(sqlSession,pi);
	}
	@Override
	public int firstListCount() {
		return petCareDao.firstListCount(sqlSession);
	}

	//장기돌봄 집리스트 조건부로 불러오기
	@Override
	public ArrayList<House> selectHouseList(HouseReservation houseRe,PageInfo pi) {
		return petCareDao.selectHouseList(sqlSession,houseRe,pi);
	}

	//페이징바처리에 필요한 집 리스트 갯수
	@Override
	public int listCount(HouseReservation houseRe) {
		return petCareDao.listCount(sqlSession,houseRe);
	}

	//집 상세정보
	@Override
	public House detailHouse(int houseNo) {
		return petCareDao.detailHouse(sqlSession,houseNo);
	}

	//집 요금정보
	@Override
	public ArrayList<HousePrice> selectHousePrice() {
		return petCareDao.selectHousePrice(sqlSession);
	}

	//인증정보
	@Override
	public ArrayList<Certification> selectCertification(int houseNo) {
		return petCareDao.selectCertification(sqlSession,houseNo);
	}

	//환경정보
	@Override
	public ArrayList<Environment> selectEnvironment(int houseNo) {
		return petCareDao.selectEnvironment(sqlSession,houseNo);
	}

	//지원서비스 정보
	@Override
	public ArrayList<SupplyGuide> selectSupplyGuide(int houseNo) {
		return petCareDao.selectSupplyGuide(sqlSession,houseNo);
	}

	//장기돌봄 예약저장
	@Override
	public int enrollHouse(HouseReservation hr) {
		return petCareDao.enrollHouse(sqlSession,hr);
	}

	//선택한 요금정보
	@Override
	public HousePrice selectPriceInfo(int stayNo) {
		return petCareDao.selectPriceInfo(sqlSession,stayNo);
	}

	//결제확정 후 각 paymentStatus 업뎃
	@Override
	public int updateReservation(String reservationNo) {
		return petCareDao.updateReservation(sqlSession,reservationNo);
	}
	@Override
	public int updateHouseRe(String reservationHouseNo) {
		return petCareDao.updateHouseRe(sqlSession,reservationHouseNo);
	}

	//결제 구분을 위한 houserReservationNo 가져오기
	@Override
	public int houserReservationNo() {
		return petCareDao.houserReservationNo(sqlSession);
	}

	//결제 구분을 위한 reservationId 가져오기
	@Override
	public int reservationId() {
		return petCareDao.reservationId(sqlSession);
	}

	


	

	


	
	
	


	
	

}
