package com.kh.pjtMungHub.petcare.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.pjtMungHub.member.model.vo.Member;
import com.kh.pjtMungHub.petcare.model.service.PetCareServiceImpl;
import com.kh.pjtMungHub.petcare.model.vo.AvailableTimes;
import com.kh.pjtMungHub.petcare.model.vo.Payment;
import com.kh.pjtMungHub.petcare.model.vo.PetSitter;
import com.kh.pjtMungHub.petcare.model.vo.Price;
import com.kh.pjtMungHub.petcare.model.vo.Reservation;

@Controller
public class PetCareController {
	
	@Autowired
	private PetCareServiceImpl petCareService;
	
	
	//펫시터 선택 페이지 이동
	@RequestMapping("sitter.re")
	public String enrollSitter() {
		
		return "petCare/selectSitter";
	}
	
	//날짜,시간 지정시 펫시터 리스트형태로 불러오기
	@ResponseBody
	@PostMapping(value="selectSitter.re",produces="application/json;charset=UTF-8")
	public ArrayList<PetSitter> selectSitter(@ModelAttribute AvailableTimes at) {
		
		ArrayList<PetSitter> sList = petCareService.selectSitter(at);
		//파일 이름과 경로를 지정해서
		//소개글,사진,각종 정보를 페이지에 표현하기
		return sList;
	}
	
	//단기돌봄 예약 페이지 이동하면서 요금표 테이블에서 결제가격 가져오기
	@GetMapping("short.re")
	public String shortReservation(AvailableTimes at,Model model) {
		
		Price p = petCareService.priceTable(at);
		
		//가상의 로그인유저 (지울예정)
		Member member = petCareService.selectMember();
		model.addAttribute("member",member);
		
		at.setTotalPrice(p.getTotalPrice());
		at.setPriceName(p.getPriceName());
		model.addAttribute("at",at);
		return "petCare/reservation";
	}
	
	//예약 정보 저장하기
	@PostMapping("enroll.re")
	public String enrollReservation(Reservation re
								   ,String priceName
								   ,int totalPrice
								   ,MultipartFile upfile
								   ,HttpSession session
								   ,Model model) {
		
		if(!upfile.getOriginalFilename().equals("")) {
			
			String changeName = PetSaveFile.getSaveFile(upfile, session);
			re.setOriginName(upfile.getOriginalFilename());
			re.setChangeName("resources/uploadFiles/petPhoto/"+changeName);
		}
		//예약정보 저장하기
		re.setTotalAmount(totalPrice);
		int result = petCareService.enrollReservation(re);
		
		
		//펫시터정보
		PetSitter sitter = petCareService.sitterInfo(re);

		//가상의 로그인유저 (지울예정)
		Member member = petCareService.selectMember();
		
		if(result>0) {
			session.setAttribute("alertMsg", "예약에 성공했습니다! 결제 페이지로 이동합니다.");
			model.addAttribute("member",member);//가상 로그인유저
			model.addAttribute("re",re);
			model.addAttribute("sitter",sitter);
			model.addAttribute("priceName",priceName);
			model.addAttribute("totalPrice",totalPrice);
			return "petCare/payment";
		}else {
			session.setAttribute("alertMsg", "예약에 실패했습니다. 관리자에게 문의해주세요.");
			return "petCare/selectSitter";
		}
	}
	
	//결제정보 저장하기
	@ResponseBody
	@RequestMapping(value="insertPayment.re",produces="application/json;charset=UTF-8")
	public int insertPayment(Payment payment) {
		
		payment.setPaymentStatus(2); //2번 '결제완료'
		int result = petCareService.insertPayment(payment);
		
		return result;
	}
	
	//결제내역 페이지로 이동
	@RequestMapping("payDetail.re")
	public String payDetail(String uid,Model model) {
		
		Payment payment = new Payment();
		payment.setPaymentId(uid);
		
		System.out.println(payment);
		
		payment = petCareService.payDetail(payment);
		model.addAttribute("p",payment);
		return "petCare/payDetail";
	}
	
	
	
}
