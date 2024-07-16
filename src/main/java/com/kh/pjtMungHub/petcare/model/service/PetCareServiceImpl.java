package com.kh.pjtMungHub.petcare.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.pjtMungHub.common.model.vo.PageInfo;
import com.kh.pjtMungHub.member.model.vo.Member;
import com.kh.pjtMungHub.petcare.model.dao.PetCareDao;
import com.kh.pjtMungHub.petcare.model.vo.AvailableTimes;
import com.kh.pjtMungHub.petcare.model.vo.Certification;
import com.kh.pjtMungHub.petcare.model.vo.Disease;
import com.kh.pjtMungHub.petcare.model.vo.Environment;
import com.kh.pjtMungHub.petcare.model.vo.HospitalRe;
import com.kh.pjtMungHub.petcare.model.vo.House;
import com.kh.pjtMungHub.petcare.model.vo.HousePrice;
import com.kh.pjtMungHub.petcare.model.vo.HouseReservation;
import com.kh.pjtMungHub.petcare.model.vo.LongReview;
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
	public int selectSitterCount(AvailableTimes at) {
		return petCareDao.selectSitterCount(sqlSession,at);
	}
	@Override
	public ArrayList<PetSitter> selectSitter(AvailableTimes at,PageInfo pi) {
		return petCareDao.selectSitter(sqlSession,at,pi);
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
	
	//집 후기정보
	@Override
	public int reviewCount(int houseNo) {
		return petCareDao.reviewCount(sqlSession,houseNo);
	}
	@Override
	public ArrayList<LongReview> selectLongReview(int houseNo,PageInfo pi) {
		return petCareDao.selectLongReview(sqlSession,houseNo,pi);
	}
	
	//Disabled 를 위해 예약된 Date 정보 불러오기
	@Override
	public ArrayList<HouseReservation> selectReList(int houseNo) {
		return petCareDao.selectReList(sqlSession,houseNo);
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
	
	//병명 가져오기
	@Override
	public List <String> diseaseName(HashMap<String,Object> symMap) {
		return petCareDao.diseaseName(sqlSession,symMap);
	}
	
	//예약정보 저장하기
	@Override
	public int insertHosRe(HospitalRe hosRe) {
		return petCareDao.insertHosRe(sqlSession,hosRe);
	}
	
	//펫타입 이름 가져오기
	@Override
	public String selectPetType(HospitalRe hosRe) {
		return petCareDao.selectPetType(sqlSession,hosRe);
	}
	
	//예약번호 가져오기
	@Override
	public int selectHosReNo() {
		return petCareDao.selectHosReNo(sqlSession);
	}
	
	//업데이트 정보와 함께 페이지 이동
	@Override
	public HospitalRe selectHospitalRe(int hosReNo) {
		return petCareDao.selectHospitalRe(sqlSession,hosReNo);
	}
	
	//예약정보 업데이트
	@Override
	public int hospitalEnrollUp(HospitalRe hosRe) {
		return petCareDao.hospitalEnrollUp(sqlSession,hosRe);
	}
	
	//예약정보 불러오기
	@Override
	public ArrayList<HospitalRe> hospitalChk(int userNo) {
		return petCareDao.hospitalChk(sqlSession,userNo);
	}
	
	//불러온 예약내역보기
	@Override
	public HospitalRe hospitalChkView(int hosReNo) {
		return petCareDao.hospitalChkView(sqlSession,hosReNo);
	}
	
	//예약내역 삭제하기
	@Override
	public int hospitalDelete(int hosReNo) {
		return petCareDao.hospitalDelete(sqlSession,hosReNo);
	}
	
	//메인페이지
	@Override
	public PetSitter mainSitter() {
		return petCareDao.mainSitter(sqlSession);
	}
	@Override
	public House mainHouse() {
		return petCareDao.mainHouse(sqlSession);
	}
	@Override
	public HospitalRe mainHospital() {
		return petCareDao.mainHospital(sqlSession);
	}
	
	//결제테이블, 결제상태변경
	@Override
	public int updatePayment(String reservationNo) {
		return petCareDao.updatePayment(sqlSession,reservationNo);
	}
	@Override
	public int updatePayment2(String reservationHouseNo) {
		return petCareDao.updatePayment2(sqlSession,reservationHouseNo);
	}
	
	//결제 statusName
	@Override
	public Payment statusName(String paymentId) {
		return petCareDao.statusName(sqlSession,paymentId);
	}
	
	//병원 접수페이지로
	@Override
	public ArrayList<HospitalRe> selectPreHos(String hosName) {
		return petCareDao.selectPreHos(sqlSession,hosName);
	}
	

	

	

	

	

	


	

	


	
	
	


	
	

}
