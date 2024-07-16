package com.kh.pjtMungHub.petcare.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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

@Repository
public class PetCareDao {

	//날짜,시간 지정시 펫시터 리스트형태로 불러오기
	public int selectSitterCount(SqlSessionTemplate sqlSession, AvailableTimes at) {
		return sqlSession.selectOne("petcareMapper.selectSitterCount",at);
	}
	public ArrayList<PetSitter> selectSitter(SqlSessionTemplate sqlSession, AvailableTimes at,PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset =(pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		return (ArrayList)sqlSession.selectList("petcareMapper.selectSitter",at,rowBounds);
	}
	
	//요금테이블에서 가격정보 가져오기
	public Price priceTable(SqlSessionTemplate sqlSession, AvailableTimes at) {
		return sqlSession.selectOne("petcareMapper.priceTable",at);
	}

	//예약정보 저장하기
	public int enrollReservation(SqlSessionTemplate sqlSession, Reservation re) {
		return sqlSession.insert("petcareMapper.enrollReservation",re);
	}

	//펫시터 정보 가져오기
	public PetSitter sitterInfo(SqlSessionTemplate sqlSession, Reservation re) {
		return sqlSession.selectOne("petcareMapper.sitterInfo",re);
	}
	
	//첫페이지 펫시터 리스트 불러오기
	public ArrayList<PetSitter> firstSitterList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset =(pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		return (ArrayList)sqlSession.selectList("petcareMapper.firstSitterList",null,rowBounds);
	}
	
	//펫시터 선택 불가능한 날짜 가져오기
	public ArrayList<Reservation> disabledDates(SqlSessionTemplate sqlSession, int petSitterNo) {
		return (ArrayList)sqlSession.selectList("petcareMapper.disabledDates",petSitterNo);
	}
	
	
	//예약번호 가져오기
	public int selectReservationId(SqlSessionTemplate sqlSession, Payment payment) {
		return sqlSession.selectOne("petcareMapper.selectReservationId",payment);
	}

	//결제정보 저장하기
	public int insertPayment(SqlSessionTemplate sqlSession, Payment payment) {
		return sqlSession.insert("petcareMapper.insertPayment",payment);
	}

	//결제내역 보여주기
	public Payment payDetail(SqlSessionTemplate sqlSession, String uid) {
		return sqlSession.selectOne("petcareMapper.payDetail",uid);
	}
	
	//장기돌봄 처음 페이지 화면
	public ArrayList<House> firstHouseList(SqlSessionTemplate sqlSession,PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset =(pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		return (ArrayList)sqlSession.selectList("petcareMapper.firstHouseList",null,rowBounds);
	}
	public int firstListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("petcareMapper.firstListCount");
	}

	//장기돌봄 집리스트 조건부로 불러오기
	public ArrayList<House> selectHouseList(SqlSessionTemplate sqlSession, HouseReservation houseRe,PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset =(pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		return (ArrayList)sqlSession.selectList("petcareMapper.selectHouseList",houseRe,rowBounds);
	}
	public int listCount(SqlSessionTemplate sqlSession,HouseReservation houseRe) {
		return sqlSession.selectOne("petcareMapper.listCount",houseRe);
	}

	//집 상세정보
	public House detailHouse(SqlSessionTemplate sqlSession, int houseNo) {
		return sqlSession.selectOne("petcareMapper.detailHouse",houseNo);
	}

	//집 요금정보
	public ArrayList<HousePrice> selectHousePrice(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("petcareMapper.selectHousePrice");
	}

	//인증정보
	public ArrayList<Certification> selectCertification(SqlSessionTemplate sqlSession, int houseNo) {
		return (ArrayList)sqlSession.selectList("petcareMapper.selectCertification",houseNo);
	}

	//환경정보
	public ArrayList<Environment> selectEnvironment(SqlSessionTemplate sqlSession, int houseNo) {
		return (ArrayList)sqlSession.selectList("petcareMapper.selectEnvironment",houseNo);
	}

	//지원서비스 정보
	public ArrayList<SupplyGuide> selectSupplyGuide(SqlSessionTemplate sqlSession, int houseNo) {
		return (ArrayList)sqlSession.selectList("petcareMapper.selectSupplyGuide",houseNo);
	}

	//장기돌봄 예약저장
	public int enrollHouse(SqlSessionTemplate sqlSession, HouseReservation hr) {
		return sqlSession.insert("petcareMapper.enrollHouse",hr);
	}
	
	//집 후기정보
	public int reviewCount(SqlSessionTemplate sqlSession,int houseNo) {
		return sqlSession.selectOne("petcareMapper.reviewCount",houseNo);
	}
	public ArrayList<LongReview> selectLongReview(SqlSessionTemplate sqlSession, int houseNo,PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() -1) + limit;
		RowBounds rowBounds = new RowBounds(offset,limit);
		return (ArrayList)sqlSession.selectList("petcareMapper.selectLongReview",houseNo,rowBounds);
	}
	
	//Disabled 를 위해 예약된 Date 정보 불러오기
	public ArrayList<HouseReservation> selectReList(SqlSessionTemplate sqlSession, int houseNo) {
		return (ArrayList)sqlSession.selectList("petcareMapper.selectReList",houseNo);
	}

	//선택한 요금정보
	public HousePrice selectPriceInfo(SqlSessionTemplate sqlSession, int stayNo) {
		return sqlSession.selectOne("petcareMapper.selectPriceInfo",stayNo);
	}

	//결제확정 후 각 paymentStatus 업뎃
	public int updateReservation(SqlSessionTemplate sqlSession, String reservationNo) {
		return sqlSession.update("petcareMapper.updateReservation",reservationNo);
	}
	public int updateHouseRe(SqlSessionTemplate sqlSession, String reservationHouseNo) {
		return sqlSession.update("petcareMapper.updateHouseRe",reservationHouseNo);
	}

	//결제 구분을 위한 houserReservationNo 가져오기
	public int houserReservationNo(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("petcareMapper.houserReservationNo");
	}
	//결제 구분을 위한 reservationId 가져오기
	public int reservationId(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("petcareMapper.reservationId");
	}
	
	//병명 가져오기
	public List <String> diseaseName(SqlSessionTemplate sqlSession, HashMap<String,Object> symMap) {
		return (ArrayList)sqlSession.selectList("petcareMapper.diseaseName",symMap);
	}
	
	//예약정보 저장하기
	public int insertHosRe(SqlSessionTemplate sqlSession, HospitalRe hosRe) {
		return sqlSession.insert("petcareMapper.insertHosRe",hosRe);
	}
	
	//펫타입 이름 가져오기
	public String selectPetType(SqlSessionTemplate sqlSession, HospitalRe hosRe) {
		return sqlSession.selectOne("petcareMapper.selectPetType",hosRe);
	}
	
	//예약번호 가져오기
	public int selectHosReNo(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("petcareMapper.selectHosReNo");
	}
	
	//업데이트 정보와 함께 페이지 이동
	public HospitalRe selectHospitalRe(SqlSessionTemplate sqlSession, int hosReNo) {
		return sqlSession.selectOne("petcareMapper.selectHospitalRe",hosReNo);
	}
	
	//예약정보 업데이트
	public int hospitalEnrollUp(SqlSessionTemplate sqlSession, HospitalRe hosRe) {
		return sqlSession.update("petcareMapper.hospitalEnrollUp",hosRe);
	}
	
	//예약내역 불러오기
	public ArrayList<HospitalRe> hospitalChk(SqlSessionTemplate sqlSession, int userNo) {
		return (ArrayList)sqlSession.selectList("petcareMapper.hospitalChk",userNo);
	}
	
	//불러온 예약내역보기
	public HospitalRe hospitalChkView(SqlSessionTemplate sqlSession, int hosReNo) {
		return sqlSession.selectOne("petcareMapper.selectHospitalRe",hosReNo);
	}
	
	//예약내역 삭제하기
	public int hospitalDelete(SqlSessionTemplate sqlSession, int hosReNo) {
		return sqlSession.update("petcareMapper.hospitalDelete",hosReNo);
	}
	
	//메인페이지
	public PetSitter mainSitter(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("petcareMapper.mainSitter");
	}
	public House mainHouse(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("petcareMapper.mainHouse");
	}
	public HospitalRe mainHospital(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("petcareMapper.mainHospital");
	}
	
	//결제테이블, 결제상태변경
	public int updatePayment(SqlSessionTemplate sqlSession, String reservationNo) {
		return sqlSession.update("petcareMapper.updatePayment",reservationNo);
	}
	public int updatePayment2(SqlSessionTemplate sqlSession, String reservationHouseNo) {
		return sqlSession.update("petcareMapper.updatePayment2",reservationHouseNo);
	}
	
	//결제 statusName
	public Payment statusName(SqlSessionTemplate sqlSession, String paymentId) {
		return sqlSession.selectOne("petcareMapper.statusName",paymentId);
	}
	
	//병원 접수페이지로
	public ArrayList<HospitalRe> selectPreHos(SqlSessionTemplate sqlSession, String hosName) {
		return (ArrayList)sqlSession.selectList("petcareMapper.selectPreHos",hosName);
	}
	


	

	

	



	

	
	


	

	

	

}
