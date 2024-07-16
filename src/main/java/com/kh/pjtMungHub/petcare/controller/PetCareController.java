package com.kh.pjtMungHub.petcare.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pjtMungHub.common.model.vo.PageInfo;
import com.kh.pjtMungHub.common.template.Pagination;
import com.kh.pjtMungHub.member.model.vo.Member;
import com.kh.pjtMungHub.petcare.model.service.PetCareServiceImpl;
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

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PetCareController {
	
	@Autowired
	private PetCareServiceImpl petCareService;
	
	//펫시터 선택 페이지 이동
	@RequestMapping("sitter.re")
	public String enrollSitter(@RequestParam(value="currentPage",defaultValue="1")int currentPage
							   ,Model model) {
		
		model.addAttribute("currentPage",currentPage);
		return "petCare/selectSitter";
	}
	
	//페이지 첫화면 펫시터 리스트
	@ResponseBody
	@RequestMapping("firstSitterList.re")
	public HashMap<String,Object> firstSitterList(String firstCurrentPage){
		
		int currentPage = Integer.parseInt(firstCurrentPage);
		int listCount = petCareService.firstListCount();
		int pageLimit = 3;
		int boardLimit = 3;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList <PetSitter> list = petCareService.firstSitterList(pi);
		
		HashMap<String,Object> result = new HashMap<>();
		result.put("list", list);
		result.put("pi", pi);
		return result;
	}
	
	//날짜,시간 지정시 스케줄 가능한 펫시터 리스트형태로 불러오기
	@ResponseBody
	@PostMapping(value="selectSitter.re",produces="application/json;charset=UTF-8")
	public HashMap<String,Object> selectSitter(@RequestParam(value="currentPage",defaultValue="1")int currentPage
											,@ModelAttribute AvailableTimes at) {
		
		int listCount = petCareService.selectSitterCount(at);
		int pageLimit = 3;
		int boardLimit = 3;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<PetSitter> sList = petCareService.selectSitter(at,pi);
		
		HashMap<String,Object> result = new HashMap<>();
		result.put("list", sList);
		result.put("pi", pi);
		
		return result;
	}
	
	//단기돌봄 예약 페이지 이동하면서 요금표 테이블에서 결제가격 가져오기
	@GetMapping("short.re")
	public String shortReservation(AvailableTimes at,Model model) {
		
		Price p = petCareService.priceTable(at);
		
		at.setTotalPrice(p.getTotalPrice());
		at.setPriceName(p.getPriceName());
		model.addAttribute("at",at);
		return "petCare/reservation";
	}
	
	//단기돌봄 새로운 선택화면 (펫시터 가능 날짜 같이)
	@GetMapping("shortSitter.re")
	public ModelAndView shortSitterRe(ModelAndView mv,PetSitter petSitter) {
		
		//날짜 지정 후 시간 비활성화에 필요한
		ArrayList<Reservation> disabledPlan = petCareService.disabledDates(petSitter.getPetSitterNo());
		
		mv.addObject("disabledPlan", disabledPlan).setViewName("petCare/reservationSitter");
		mv.addObject("petSitter", petSitter).setViewName("petCare/reservationSitter");
		return mv;
	}
	
	//단기돌봄 새로운 예약 페이지
	@GetMapping("shortSencond.re")
	public String shortReservationSencond(AvailableTimes at,Model model) {
		
		Price p = petCareService.priceTable(at);
		at.setTotalPrice(p.getTotalPrice());
		at.setPriceName(p.getPriceName());
		model.addAttribute("at",at);
		return "petCare/reservationSitterRe";
	}
	
	//단기돌봄 예약 정보 저장하기
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
		
		// reservationNo 가져오기
		int reservationId = petCareService.reservationId();
		
		//펫시터정보
		PetSitter sitter = petCareService.sitterInfo(re);
		
		if(result>0) {
			session.setAttribute("alertMsg", "예약에 성공했습니다! 결제 페이지로 이동합니다.");
			model.addAttribute("re",re);
			model.addAttribute("reservationId",reservationId);
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
		
		String reservationId = payment.getCustomData().get("reservationId");
		String reservationHouseNo = payment.getCustomData().get("reservationHouseNo");
		String userNo = payment.getCustomData().get("userNo");
		String userId = payment.getCustomData().get("userId");
		payment.setReservationNo(reservationId);
		payment.setReservationHouseNo(reservationHouseNo);
		payment.setUserNo(userNo);
		payment.setUserId(userId);
		
		return petCareService.insertPayment(payment);
	}
	
	//결제내역 페이지로 이동
	@RequestMapping("payDetail.re")
	public ModelAndView payDetail(String uid,ModelAndView mv,HttpSession session) {
		
		Payment payment = petCareService.payDetail(uid);
		
		//결제성공 후 각 paymentStatus '결제완료' 변경작업
		if(Integer.parseInt(payment.getDifferentNo())==1) {
			
			String reservationNo = String.valueOf(petCareService.selectReservationId(payment));
			
			int result = petCareService.updateReservation(reservationNo);
			int result2 = petCareService.updatePayment(reservationNo);
			
			if(result*result2>0) {
					session.setAttribute("alertMsg", "결제성공!! 내역을 확인해주세요.");
					mv.addObject("p",payment).setViewName("petCare/payDetail"); 
			}else {
				mv.addObject("alertMsg","결제실패..관리자에게 문의해주세요").setViewName("redirect:/houseList.re"); 
			}
			
		}else if(Integer.parseInt(payment.getDifferentNo())==2) {
			
			int result = petCareService.updateHouseRe(payment.getReservationHouseNo());
			int result2 = petCareService.updatePayment2(payment.getReservationHouseNo());
			
			if(result*result2>0) {
				session.setAttribute("alertMsg", "결제성공!! 내역을 확인해주세요.");
				mv.addObject("p",payment).setViewName("petCare/payDetail"); 
			}else {
				mv.addObject("alertMsg","결제실패..관리자에게 문의해주세요").setViewName("redirect:/houseList.re"); 
			}
		}
		return mv;
	}
	
	//결제 statusName
	@ResponseBody
	@RequestMapping("statusName.re")
	public Payment statusName(String paymentId) {
		
		Payment statusName = petCareService.statusName(paymentId);
		return statusName;
	}
	
	
	//장기돌봄 예약 리스트로 이동
	@RequestMapping("houseList.re")
	public String selectHouse(@RequestParam(value="currentPage",defaultValue="1")int currentPage
							 ,Model model) {
		
		model.addAttribute("currentPage",currentPage);
		return "petCare/selectHouse";
	}
	
	//장기돌봄 페이지 처음화면
	@ResponseBody
	@RequestMapping("firstHouseList.re")
	public HashMap<String,Object> firstHouseList(String firstCurrentPage) {
		
		int currentPage = Integer.parseInt(firstCurrentPage);
		int listCount = petCareService.firstListCount();
		int pageLimit = 3;
		int boardLimit = 3;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<House> list = petCareService.firstHouseList(pi);
		
		HashMap<String,Object> result = new HashMap<>(); //ArrayList 와 pi를 같이 보내려면 map 을 활용
		result.put("houseList",list);
		result.put("pi", pi);
		return result;
	}
	
	//장기돌봄 예약 리스트로 이동
	@ResponseBody
	@RequestMapping(value="selectHouseList.re",produces="application/json;charset=UTF-8")
	public HashMap<String,Object> selectHouseList(@RequestParam(value="currentPage",defaultValue="1")int currentPage
										   ,HouseReservation houseRe,Date endJavaDate) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); //날짜형식
		String formatDate = sdf.format(endJavaDate); //날짜형식으로 적용
		java.sql.Date sqlDate = java.sql.Date.valueOf(formatDate); //sql 형식으로 변환 성공!!
		houseRe.setEndDate(sqlDate); //필드에 적용
		
		String address = houseRe.getAddress().substring(0,2); //주소 앞2글자
		houseRe.setAddress(address);

		int listCount = petCareService.listCount(houseRe);
		int pageLimit = 3;
		int boardLimit = 3;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<House> houseList = petCareService.selectHouseList(houseRe,pi);
		
		HashMap<String,Object> result = new HashMap<>(); //ArrayList 와 pi를 같이 보내려면 map 을 활용
		result.put("houseList",houseList);
		result.put("pi", pi);
		
		return result;
	}
	
	//집 상세정보 / 정보전달 
	@RequestMapping("detailHouse.re")
	public String detailHouse(int houseNo,Model model) {
		
		House house = petCareService.detailHouse(houseNo); //집
		ArrayList<HousePrice> price = petCareService.selectHousePrice(); //요금
		ArrayList<Certification> cer = petCareService.selectCertification(houseNo);//인증
		ArrayList<Environment> env = petCareService.selectEnvironment(houseNo);//환경
		ArrayList<SupplyGuide> sup = petCareService.selectSupplyGuide(houseNo);//지원서비스
		
		//Disabled 를 위해 예약된 Date 정보 불러오기
		ArrayList<HouseReservation> reList = petCareService.selectReList(houseNo);
		
		model.addAttribute("reList", reList); //Disabled 를 위해 예약된 Date 정보
		model.addAttribute("house", house); //집번호,집주인이름,주소,간단소개,자세한소개,근처병원,사진이름/경로
		model.addAttribute("price",price); //숙박 일정에 따른 요금정보 (ex : 1박2일 = 4만원..)
		model.addAttribute("cer",cer); //인증정보(ex: 신원인증..)
		model.addAttribute("env",env); //환경정보(ex: #1인가구,#단독주택..)
		model.addAttribute("sup",sup); //지원서비스(ex: 산책,응급처치..)
		return "petCare/detailHouse";
	}
	
	//집 후기
	@ResponseBody
	@RequestMapping("longReview.re")
	public HashMap<String,Object> longReview(@RequestParam(value="currentPage",defaultValue="1")int currentPage
									,ModelAndView mv,int houseNo) {
		//후기정보 페이징바와 같이
		int listCount = petCareService.reviewCount(houseNo);
		int pageLimit = 3;
		int boardLimit = 2;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		ArrayList<LongReview> reviewList = petCareService.selectLongReview(houseNo,pi); 
		
		HashMap<String,Object> result = new HashMap<>();
		result.put("reviewList", reviewList);
		result.put("pi", pi);
		return result;
	}
	
	//맵이동
	@RequestMapping("mapTest.do")
	public String mapTest() {
		return "petCare/mapTest";
	}
	
	//장기돌봄 예약 저장 후 결제 페이지로 이동
	@PostMapping("enrollHouse.re")
	public ModelAndView enrollHouse(String javaDate,String inputDate,HouseReservation hr
			   				 ,ModelAndView mv,HttpSession session) {
		
		java.sql.Date sqlDate1 = java.sql.Date.valueOf(javaDate);
		java.sql.Date sqlDate2 = java.sql.Date.valueOf(inputDate);
		hr.setEndDate(sqlDate1);
		hr.setStartDate(sqlDate2);
		
		int result = petCareService.enrollHouse(hr); //예약정보 저장
		
		House house = petCareService.detailHouse(Integer.parseInt(hr.getHouseNo())); //집정보
		HousePrice price = petCareService.selectPriceInfo(hr.getStayNo()); //선택한 요금정보
		
		if(result>0) {
			int reservationHouseNo = petCareService.houserReservationNo();
			
			session.setAttribute("alertMsg", "예약에 성공하셨습니다! 결제를 완료하셔야 예약이 확정 됩니다.");
			mv.addObject("hr",hr);
			mv.addObject("reservationHouseNo",reservationHouseNo);
			mv.addObject("house",house);
			mv.addObject("price",price);
			mv.setViewName("petCare/paymentHouse");
		}else {
			mv.addObject("alertMsg","오류가 발생 했습니다. 관리자에게 문의해주세요.").setViewName("redirect:/");
		}
		return mv;
	}
	
	
	//병원검색 페이지로 이동
	@RequestMapping("hospital.ho")
	public String hospitalPage() {
		return "petCare/hospital";
	}
	
	//공공데이터 API 설정
	@ResponseBody
	@RequestMapping(value="hospitalList.ho", produces="text/xml;charset=UTF-8")
	public String hospitalList(String location) throws IOException {
		
		String serviceKey = "00d6f801245544b987ad67dfe6210312";
		String url = "https://openapi.gg.go.kr/Animalhosptl";
		url+="?KEY="+serviceKey;
		url+="&pIndex=1";
		url+="&pSize=50";
		url+="&SIGUN_CD="+URLEncoder.encode(location,"UTF-8");
		
		URL requestUrl = new URL(url);
		
		HttpURLConnection urlCon = (HttpURLConnection)requestUrl.openConnection();
		urlCon.setRequestMethod("GET");
		
		BufferedReader br = new BufferedReader(new InputStreamReader(urlCon.getInputStream()));
		
		String str = "";
		
		String line;
		while((line=br.readLine()) != null) {
			str+=line;
		}
		br.close();
		urlCon.disconnect();
		return str;
	}
	
	//지도 api 를 통해서 가져온 url 주소로 필요한 특정 데이터 가져오기
	@RequestMapping("mapInfo.ho")
	public String getMapInfo(Model model,String url) {
		//처음엔 RestTemplate 를 활용하여 정보를 추출하려 했으나 실패
		//Selenium(브라우저 제어, UI테스트, 크롤링, 스크립트작성)
		//Jsoup(HTML파싱, 데이터 추출 및 조작, HTML 필터링)
		//Selenium(동적)으로 가져온 자료를 Jsoup(정적)으로 변환해서 데이터 처리.
		
		
		//익셉션 발생 대비 tryCatch
	    try {
	        // Selenium WebDriver 설정
	        System.setProperty("webdriver.chrome.driver", "C:\\devtool\\chromedriver-win64\\chromedriver.exe"); // chromedriver 경로 지정
	        ChromeOptions options = new ChromeOptions();
	        options.addArguments("--headless"); // 브라우저 창을 열지 않음
	        WebDriver driver = new ChromeDriver(options);
	        // 해당 url 경로 페이지 로드
	        driver.get(url);
	        // 페이지가 완전히 로드될 때까지 기다림 
	        //(이게 결정적인 해결방안 이었음. setTimeout 과 비슷한역할)
	        WebDriverWait wait = new WebDriverWait(driver, 10); // timeoutInSeconds 값을 사용
            wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("h3.tit_subject")));
	        // 페이지 소스 가져오기
	        String pageSource = driver.getPageSource();
	        driver.quit();
	        System.out.println("Page Source: " + pageSource.substring(0, 500)); // 페이지 소스의 일부 500자 출력 (디버깅용)
	        
	        
	        // Jsoup 를 이용한 HTML 파싱
	        Document doc = Jsoup.parse(pageSource);
	        // 원하는 CSS 셀렉터 지정
	        Elements reviewTitleElements = doc.select("h3.tit_subject");

	        // text 나 html 을 추출하는 과정
	        StringBuilder reviewText = new StringBuilder();
	        StringBuilder reviewHtml = new StringBuilder();
	        for (Element reviewTitle : reviewTitleElements) {
	            reviewText.append(reviewTitle.text()).append("\n");
	            reviewHtml.append(reviewTitle.html()).append("\n");
	        }

	        model.addAttribute("reviewText", reviewText.toString());
	        model.addAttribute("reviewHtml", reviewHtml.toString());
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("예외 발생: " + e.getMessage());
	    }

	    return "petCare/hospital";
	}
	
	//접수 페이지로 이동
	@GetMapping("hospital.re")
	public ModelAndView hospitalReservation(ModelAndView mv,HospitalRe hosRe) {
		
		String hosName = hosRe.getHosName();
		ArrayList<HospitalRe> reList = petCareService.selectPreHos(hosName);
		mv.addObject("hosRe",hosRe).addObject("reList",reList).setViewName("petCare/hospitalReservation");
		return mv;
	}
	
	//접수한 예약 내용 저장 후 확인 페이지로 이동
	@PostMapping("hospitalInsert.re")
	public ModelAndView enrollReservation(HospitalRe hosRe
								   ,MultipartFile upfile
								   ,HttpSession session
								   ,ModelAndView mv) {

		if(!upfile.getOriginalFilename().equals("")) {
			String changeName = PetSaveFile.getHospitalFile(upfile, session);
			hosRe.setOriginName(upfile.getOriginalFilename());
			hosRe.setChangeName("resources/uploadFiles/hospital/"+changeName);
		}
		//증상(구토,설사) 을 배열->해쉬맵 으로 바꿔서 mapper 에 전달
		String symptomName = hosRe.getSymptom();
		List<String> symList = Arrays.asList(symptomName.split(","));//쉼표를 기준으로 List로 변환
		HashMap<String,Object> symMap = new HashMap<>();
		symMap.put("symList", symList); //증상들을 해쉬맵에 담아서 병명 쿼리문으로 보내주기
		
		//병명은 쿼리문으로 
		List <String> diseaseName = petCareService.diseaseName(symMap);
		//List 형태 -> String 변환
		StringBuilder sb = new StringBuilder();
		for(String name : diseaseName) {
			if(sb.length() > 0) {
				sb.append(", ");
			}
			sb.append(name);
		}
		String resultName = sb.toString();
		hosRe.setDiseaseName(resultName);
		
		int result = petCareService.insertHosRe(hosRe);
		//펫타입no를 이름으로 가져오기
		String petType = petCareService.selectPetType(hosRe);
		hosRe.setPetTypeNo(petType);
		
		if(result>0) {
			//업데이트 식별자 hosReNo 가져오기
			int hosReNo = petCareService.selectHosReNo();
			hosRe.setHosReNo(hosReNo);

			//시간형태 00:00 으로 변경
			String timeString = hosRe.getReTime();
			LocalTime time = LocalTime.parse(timeString, DateTimeFormatter.ofPattern("HHmm"));
			String formattedTime = time.format(DateTimeFormatter.ofPattern("HH:mm"));
			hosRe.setReTime(formattedTime);
			
			mv.addObject("alertMsg","예약성공! 내역을 확인해주세요.").addObject("hosRe",hosRe).setViewName("petCare/hospitalDetail");
		}else {
			mv.addObject("alertMsg","예약실패 ㅠㅠ 관리자에게 문의 해주세요.").setViewName("redirect:/hospital.ho");
		}
		return mv;
	}
	
	//업데이트 실행할 정보와 함께 페이지로 이동
	@RequestMapping("hospitalUpdate.re")
	public ModelAndView hospitalUpdate(String hosReNo,ModelAndView mv) {
		HospitalRe hosRe = petCareService.selectHospitalRe(Integer.parseInt(hosReNo));
		mv.addObject("hosRe",hosRe).setViewName("petCare/hospitalUpdate");
		return mv;
	}
	
	//예약정보 업데이트
	@RequestMapping("hospitalEnrollUp.re")
	public ModelAndView hospitalEnrollUp(HospitalRe hosRe,MultipartFile upfile,HttpSession session, ModelAndView mv) {
		
		String oldFilePath = hosRe.getChangeName(); //기존 파일경로
		String oldChangeName = oldFilePath.substring(oldFilePath.lastIndexOf("/")+1);
		
		//새로운 파일이 업로드 됐을때
		if(!upfile.getOriginalFilename().equals("")) {
			//기존파일 삭제
			if(!oldFilePath.equals("")) {
				String realPath = session.getServletContext().getRealPath("/resources/uploadFiles/hospital/")+oldChangeName;
				
				File oldFile = new File(realPath);
				if(oldFile.exists()) {
					oldFile.delete();
				}
			}
			//새로운 파일 서버에 저장 후 이름지정
			String changeName = PetSaveFile.getHospitalFile(upfile, session);
			
			hosRe.setOriginName(upfile.getOriginalFilename());
			hosRe.setChangeName("resources/uploadFiles/hospital/"+changeName);
		}
		
		int result = petCareService.hospitalEnrollUp(hosRe);
		
		if(result>0) {
			//펫타입no를 이름으로 가져오기
			String petType = petCareService.selectPetType(hosRe);
			hosRe.setPetTypeNo(petType);
			mv.addObject("alertMsg","예약정보 변경에 성공 했습니다.").addObject("hosRe",hosRe).setViewName("petCare/hospitalDetail");
		}else {
			mv.addObject("alertMsg","예약정보 변경실패 ㅠㅠ").setViewName("redirect:/hospital.re");
		}
		return mv;
	}
	//예약 확정버튼 클릭(메인으로)
	@RequestMapping("hospitalDone.re")
	public String hospitalDone(HttpSession session) {
	    session.setAttribute("alertMsg", "예약이 확정 되었습니다. 내역에서 확인가능");
	    return "redirect:/hospital.ho";
	}
	
	//나의 예약내역 불러오기
	@ResponseBody
	@RequestMapping("hospitalChk.re")
	public ArrayList<HospitalRe> hospitalChk(String userNo) {
		int newUserNo = Integer.parseInt(userNo);
		ArrayList<HospitalRe> hosRe = petCareService.hospitalChk(newUserNo);
		return hosRe;
	}
	
	//불러온 예약내역 보기
	@RequestMapping("hospitalChkView.re")
	public ModelAndView hospitalChkView(String hosReNo,ModelAndView mv) {
		
		int newHosReNo = Integer.parseInt(hosReNo);
		
		HospitalRe hosRe = petCareService.hospitalChkView(newHosReNo);
		//펫타입no를 이름으로 가져오기
		String petType = petCareService.selectPetType(hosRe);
		hosRe.setPetTypeNo(petType);
		
		mv.addObject("hosRe",hosRe).setViewName("petCare/hospitalDetail");
		
		return mv;
	}
	
	//예약내역 삭제하기
	@RequestMapping("hospitalDelete.re")
	public ModelAndView hospitalDelete(String hosReNo, ModelAndView mv) {
		
		int newHosReNo = Integer.parseInt(hosReNo);
		int result = petCareService.hospitalDelete(newHosReNo);
		if(result > 0) {
			mv.addObject("alertMsg","예약 삭제완료!!").setViewName("redirect:/hospital.ho");
		}else {
			mv.addObject("alertMsg","예약 삭제실패.. 관리자에게 문의").setViewName("redirect:/hospital.ho");
		}
		return mv;
	}
	
	//메인페이지
	@ResponseBody
	@RequestMapping("mainSitter.re")
	public PetSitter mainSitter() {
		PetSitter sitList = petCareService.mainSitter();
		return sitList;
	}
	@ResponseBody
	@RequestMapping("mainHouse.re")
	public House mainHouse() {
		House HouseList = petCareService.mainHouse();
		return HouseList;
	}
	@ResponseBody
	@RequestMapping("mainHospital.re")
	public HospitalRe mainHospotal() {
		HospitalRe hosRe = petCareService.mainHospital();
		return hosRe;
	}
	
	
	@RequestMapping("css.re")
	public String cssRe() {
		return "petCare/css";
	}
	
	
}






















