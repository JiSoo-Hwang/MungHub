package com.kh.pjtMungHub.petcare.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.kh.pjtMungHub.common.model.vo.PageInfo;
import com.kh.pjtMungHub.member.model.vo.Member;
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

public interface PetCareService {
	
	//날짜,시간 지정시 펫시터 리스트형태로 불러오기
	int selectSitterCount(AvailableTimes at);
	ArrayList<PetSitter> selectSitter(AvailableTimes at,PageInfo pi);
	//요금테이블에서 가격정보 가져오기
	Price priceTable(AvailableTimes at);
	//예약 정보 저장하기
	int enrollReservation(Reservation re);
	//펫시터 정보 가져오기
	PetSitter sitterInfo(Reservation re);
	//예약번호 가져오기
	int selectReservationId(Payment payment);
	//결제 구분을 위한 houserReservationNo 가져오기
	int reservationId ();
	//첫페이지 펫시터 리스트 불러오기
	ArrayList<PetSitter> firstSitterList(PageInfo pi);
	//펫시터 선택 불가능한 날짜 가져오기
	ArrayList<Reservation> disabledDates(int petSitterNo);
	
	
	//결제정보 저장하기
	int insertPayment(Payment payment);
	//결제내역 보여주기
	Payment payDetail(String uid);
	//결제확정 후 각 paymentStatus 업뎃
	int updateReservation(String reservationNo);
	int updateHouseRe(String reservationHouseNo);
	//결제테이블, 결제상태변경
	int updatePayment(String reservationNo);
	int updatePayment2(String reservationHouseNo);
	//결제 statusName
	Payment statusName(String paymentId);
	
	
	//장기돌봄 페이지 처음화면
	ArrayList<House> firstHouseList(PageInfo pi);
	int firstListCount();
	
	//장기돌봄 집리스트 조건부로 불러오기
	ArrayList<House> selectHouseList(HouseReservation houseRe,PageInfo pi);
	//페이징바처리에 필요한 집 리스트 갯수
	int listCount(HouseReservation houseRe);
	
	
	//집 상세정보
	House detailHouse(int houseNo);
	//집 요금정보
	ArrayList<HousePrice> selectHousePrice();
	//인증정보
	ArrayList<Certification> selectCertification(int houseNo);
	//환경정보
	ArrayList<Environment> selectEnvironment(int houseNo);
	//지원서비스정보
	ArrayList<SupplyGuide> selectSupplyGuide(int houseNo);
	//집 후기정보
	int reviewCount(int houseNo);
	ArrayList<LongReview> selectLongReview(int houseNo,PageInfo pi);
	//Disabled 를 위해 예약된 Date 정보 불러오기
	ArrayList<HouseReservation> selectReList(int houseNo);
	
	
	//장기돌봄 예약저장
	int enrollHouse(HouseReservation hr);
	//선택한 요금정보
	HousePrice selectPriceInfo(int stayNo);
	//결제 구분을 위한 houserReservationNo 가져오기
	int houserReservationNo();
	
	
	//병원 접수페이지로
	ArrayList<HospitalRe> selectPreHos(String hosName);
	//병명 가져오기
	List <String> diseaseName(HashMap<String,Object> symMap);
	//예약정보 저장하기
	int insertHosRe(HospitalRe hosRe);
	//펫타입 이름 가져오기
	String selectPetType(HospitalRe hosRe);
	//예약번호 가져오기
	int selectHosReNo();
	//업데이트 정보와 함께 페이지 이동
	HospitalRe selectHospitalRe(int hosReNo);
	//예약정보 업데이트
	int hospitalEnrollUp(HospitalRe hosRe);
	//예약정보 불러오기
	ArrayList<HospitalRe> hospitalChk(int userNo);
	//불러온 예약내역보기
	HospitalRe hospitalChkView(int hosReNo);
	//예약내역 삭제하기
	int hospitalDelete(int hosReNo);
	
	
	//메인페이지
	PetSitter mainSitter();
	House mainHouse();
	HospitalRe mainHospital();
	
	

}
