package com.kh.pjtMungHub.member.controller;

import java.io.File;
import java.io.IOException;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.kh.pjtMungHub.chatting.vo.MessageVO;
import com.kh.pjtMungHub.common.model.vo.PageInfo;
import com.kh.pjtMungHub.common.model.vo.PetPhoto;
import com.kh.pjtMungHub.common.template.Pagination;
import com.kh.pjtMungHub.kindergarten.model.vo.Kindergarten;
import com.kh.pjtMungHub.member.model.service.MemberService;
import com.kh.pjtMungHub.member.model.vo.Member;
import com.kh.pjtMungHub.member.model.vo.Message;
import com.kh.pjtMungHub.pet.model.vo.Breed;
import com.kh.pjtMungHub.pet.model.vo.Pet;
import com.kh.pjtMungHub.petcare.model.vo.PetSitter;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@RequestMapping("enter.me")
	public String enterLogin() {
		
		return "member/memberLoginForm";
	}
	@RequestMapping("enroll.me")
	public String enterEnroll(HttpSession session) {
		return "member/memberEnrollForm";
	}
	
	@RequestMapping("loginInfo.me")
	public String loginUpdate() {
		return "member/memberLoginUpdate";
	}
	
	@RequestMapping("myPage.me")
	public String enterMyPage(HttpSession session) {
		Member m=(Member)session.getAttribute("loginUser");
		ArrayList<Pet> petList = service.selectPetList(m);
		ArrayList<PetPhoto> petPhotoList=new ArrayList<PetPhoto>();
		if(petList!=null) {
			for(Pet p : petList) {
				PetPhoto photo=service.selectPetPhoto(p);
				petPhotoList.add(photo);
			}
		}
		session.setAttribute("petList",petList);
		ArrayList<Breed> breed=service.selectBreedList();
		session.setAttribute("breed", breed);
		session.setAttribute("petPhotoList",petPhotoList);
		return "member/memberMyPage";
	}
	
	@RequestMapping("updatePet.me")
	public String enterUpdatePet(HttpSession session) {
		Member m=(Member)session.getAttribute("loginUser");
		ArrayList<Breed> breed=service.selectBreedList();
		session.setAttribute("breed", breed);
		ArrayList<Pet> petList = service.selectPetList(m);
		ArrayList<PetPhoto> petPhotoList=new ArrayList<PetPhoto>();
		if(petList!=null) {
			for(Pet p : petList) {
				PetPhoto photo=service.selectPetPhoto(p);
				petPhotoList.add(photo);
			}
		}
		session.setAttribute("petList",petList);
		session.setAttribute("petPhotoList",petPhotoList);
		return "member/memberPetUpdate";
	}
	
	@RequestMapping("msg.me")
	public String enterMsg(HttpSession session, PageInfo page) {
		Member m=(Member)session.getAttribute("loginUser");
		page.setListCount(service.msgCount(m));
		page.setBoardLimit(15);
		page.setPageLimit(5);
		new Pagination();
		PageInfo pi=Pagination.getPageInfo(page.getListCount(), page.getCurrentPage(), page.getPageLimit(), page.getBoardLimit());
		session.setAttribute("pi", pi);
		session.setAttribute("msgList",service.selectMessageList(m,pi.getCurrentPage()));
		return "member/memberMessage";
	}
	
	@RequestMapping("manage.me")
	public String enterManage(HttpSession session) {
		return "member/memberManage";
	}
	
	@RequestMapping("manageTeacher.me")
	public String enterManageTeacher(HttpSession session) {
		Member m=(Member)session.getAttribute("loginUser");
		ArrayList<Member> tList=new ArrayList<Member>();
		int count=0;
		//원장님 당 하나의 유치원을 운영할 경우
//		tList=service.searchTeacher(m);
		// 원장님 한 명이 여러 유치원을 담당할 경우
		ArrayList<Kindergarten> kindList=service.myKind(m);
		for(Kindergarten k : kindList) {
			ArrayList<Member> teacher=service.searchTeacherByKind(k);
			if(teacher!=null) {				
				for(Member me:teacher) {
					tList.add(me);
					if(me.getStatus().equals("N")) {						
						count++;
					}
				}
			}
		}
		session.setAttribute("kindList",kindList);
		session.setAttribute("tList", tList);
		session.setAttribute("newCount", count);
		return "member/memberManageTeacher";
	}
	
	@RequestMapping("login.me")
	public String loginMember(Member m, HttpSession session) {
		Member loginUser = service.loginMember(m);
		String msg="";
		if(loginUser==null || !bcryptPasswordEncoder.matches(m.getPassword(),loginUser.getPassword())) {
			msg="로그인 실패";
			session.setAttribute("alertMsg", msg);
			return "redirect:/enter.me";
		}else if(loginUser.getStatus().equals("N")){
			msg="아직 승인처리가 완료되지 않았습니다. 관리자에게 문의하시기 바랍니다.";
		}else {
			msg=loginUser.getUserId()+"님 환영합니다.";
			session.setAttribute("loginUser", loginUser);
			ArrayList<MessageVO> cList=service.getChatList(loginUser);
			ArrayList<MessageVO> chatList=new ArrayList<MessageVO>();
			for(MessageVO c:cList) {
				c.setMasterNo(loginUser.getUserNo());
				chatList.add(service.getNewChat(c));
			}
			session.setAttribute("chatList", chatList);
			session.setAttribute("sitterList", service.getSitterList());
		}
		session.setAttribute("alertMsg", msg);
		return "redirect:/";
	}
	
	@RequestMapping("logout.me")
	public String logoutMember(HttpSession session) {
		session.setAttribute("alertMsg", "이용해 주셔서 감사합니다.");
		session.removeAttribute("loginUser");
		session.removeAttribute("sitterUser");
		return "redirect:/";
	}
	
	@ResponseBody
	@GetMapping("checkId.me")
	public String checkId(Member m) {
		Member mem=service.checkId(m);
		if(mem!=null){
			return "NNNNN";						
		}else {
			return m.getUserId();
		}
	}
	
	@PostMapping("join.me")
	public String insertMember(Member m, Model model, HttpSession session) {
		String encPwd=bcryptPasswordEncoder.encode(m.getPassword());
		m.setPassword(encPwd);
		int result=0;
		if(m.getKindName()==null) {
			result = service.insertMember(m);
		}else {
			result = service.insertTeacher(m);
		}
		if(result>0) {
			session.setAttribute("alertMsg", "회원 가입이 완료되었습니다.");
			if(m.getPetYN().equals("Y")) {
				Member mem = service.loginMember(m);
				session.setAttribute("loginUser", mem);				
				return "redirect:/updatePet.me";
			}
		}else {
			model.addAttribute("alertMsg","회원 가입 실패");
		}
		return "redirect:/";
	}
	
	@PostMapping("searchId.me")
	public String searchId(Member m, HttpSession session) {
		Member result = service.searchId(m);
		if(result!=null) {
			session.setAttribute("alertMsg", "조회하신 아이디는 "+result.getUserId()+" 입니다.");
			return "member/memberLoginUpdate";
		}else {
			session.setAttribute("alertMsg","입력한 데이터를 다시 확인해 주세요.");
			return "member/memberLoginForm";
		}
	}
	
	@PostMapping("changePw.me")
	public String changePw(Member m, HttpSession session) {
		Member result=service.searchId(m);
		if(result==null||!result.getUserId().equals(m.getUserId())) {
			session.setAttribute("alertMsg", "입력하신 정보를 다시 확인해 주세요.");
		}else {
			m.setPassword(bcryptPasswordEncoder.encode(m.getPassword()));
			
			int rnum=service.changePw(m);
			if(rnum>0) {
				session.setAttribute("alertMsg", "비밀번호가 변경되었습니다. 다시 로그인해 주세요.");
			}else {
				System.out.println("통신오류");
			}
		}
		return "redirect:/enter.me";
	}

	@PostMapping("enrollPet.me")
	public String enrollPet(Pet p, MultipartFile upFile, HttpSession session) {
		Member m=(Member)session.getAttribute("loginUser");
		int result1;
		int result2;
		String alertMsg;
		if(!upFile.getOriginalFilename().equals("")) {
			PetPhoto petPhoto = new PetPhoto();
			int pNum=service.getPhotoNo();

			String changeName=saveFile(upFile, session);
			String filePath="/resources/uploadFiles/petPhoto/"+changeName;

			petPhoto.setPhotoNo(pNum);
			petPhoto.setOriginName(upFile.getOriginalFilename());
			petPhoto.setChangeName(changeName);
			petPhoto.setFilePath(filePath);
			result1=service.insertPetPhoto(petPhoto);
			if(result1>0) {
				p.setPhotoNo(pNum);
			}
		}else {
			result1=1;
		}
		result2=service.insertPet(p);
		if(result1*result2>0) {
			alertMsg="반려견 등록을 완료하였습니다!";
			m.setPetYN("Y");
			service.updateMember(m);
		}else{
			alertMsg="반려견 등록을 실패하셨습니다.";
		}
		session.setAttribute("alertMsg", alertMsg);
		return "redirect:/myPage.me";
	}
	
	@PostMapping("updatePetStat.me")
	public String updatePetStat(Pet p, MultipartFile reUpFile, HttpSession session) {
		boolean flag = false; //파일 삭제 필요시 사용할 논리값
		String deleteFile = "";//파일 저장경로 및 변경파일명 담아놓을 변수
		int del;
		int insertPhoto;
		//새로운 첨부파일이 넘어온 경우(파일명이 넘어왔을때) 
		if(!reUpFile.getOriginalFilename().equals("")) {
			PetPhoto photo = new PetPhoto();
			//새로운 첨부파일이 있는경우 기존 첨부파일을 찾아서 삭제하는 작업을 해야함
			if(p.getPhotoNo()!=0) {
				flag = true;
				photo=service.selectPetPhoto(p);
				deleteFile = photo.getChangeName();
			}
			//새로운 첨부파일 정보 데이터베이스에 등록,서버에 업로드 
			String changeName = saveFile(reUpFile,session);
			del=service.deletePhoto(p);
			//처리된 변경이름과 원본명을 board에 담아주기
			int pNum=service.getPhotoNo();
			photo.setPhotoNo(pNum);
			photo.setOriginName(reUpFile.getOriginalFilename());
			photo.setChangeName(changeName);
			photo.setFilePath("/resources/uploadFiles/petPhoto/"+changeName);
			p.setPhotoNo(photo.getPhotoNo());
			insertPhoto=service.insertPetPhoto(photo);
		}else {
			del=1;
			insertPhoto=1;
		}

		int result = service.updatePet(p);
		String msg = "";	
		if(result*del*insertPhoto>0) { //수정 성공시
			msg = "반려견 정보 수정 성공!";
			if(flag) {
				File f = new File(session.getServletContext().getRealPath(deleteFile));
				f.delete(); //삭제
			}
		}else {//수정 실패 
			msg = "반려견 정보 수정 실패!";
		}
		session.setAttribute("alertMsg", msg);
		return "redirect:/updatePet.me";
	}
	
	@ResponseBody
	@GetMapping("selectKind.me")
	public ArrayList<Kindergarten> searchKind(Kindergarten kind){
		ArrayList<Kindergarten> kindList = service.selectKindList(kind);
		return kindList;
	}
	
	@ResponseBody
	@GetMapping("selectPet.me")
	public Pet updatePetStat(Pet p) {
		Pet pet=service.selectPetByNo(p);
		return pet;
	}
	public String saveFile(MultipartFile upfile,HttpSession session) {

		String originName = upfile.getOriginalFilename();
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		String ext = originName.substring(originName.lastIndexOf("."));
		int ranNum = (int)(Math.random()*90000+10000);
		String changeName = currentTime+ranNum+ext;
		
		String savePath=session.getServletContext().getRealPath("/resources/uploadFiles/petPhoto/");
		try {
		upfile.transferTo(new File(savePath+changeName));
		} catch (IllegalStateException | IOException e) {
		e.printStackTrace();
		}	
		return changeName;
	}
	
	@PostMapping("updateMember.me")
	public String updateMember(Member m, HttpSession session) {
		int result=service.updateMember(m);
		String msg="";
		if(result>0) {
			msg="회원정보 변경 완료";
		}else {
			msg="회원 정보 변경 실패";
		}
		session.setAttribute("alertMsg", msg);
		return"redirect:/myPage.me";
	}
	
	@ResponseBody
	@GetMapping("searchUser.me")
	public ArrayList<Member> searchUser(Member m){
		ArrayList<Member> memList=service.searchUser(m);
		return memList;
	}
	
	@GetMapping("disableUser.me")
	public String disableUser(Member m, int disable, HttpSession session) {
		String msg;
		session.setAttribute("disable", disable);
		session.setAttribute("disableUser", m);
		int result=service.disableUser(m);
		if(result>0) {
			msg=m.getUserId()+" 계정을 "+disable+" 일간 정지하였습니다.";
		}else {
			msg="정지 실패.";
		}
		session.setAttribute("alertMsg", msg);
		return "redirect:/manage.me";
	}
	
	@GetMapping("acceptTeacher.me")
	public String acceptTeacher(Member m,HttpSession session) {
		int result=service.acceptTeacher(m);
		String msg="";
		if(result>0) {
			msg="선생님 등록 완료!";
		}else {
			msg="선생님 등록 실패. 관리자에게 문의하세요";
		}
		session.setAttribute("alertMsg", msg);
		return "redirect:/manageTeacher.me";
	}
	
	@GetMapping("notTeacher.me")
	public String notTeacher(Member m,HttpSession session) {
		int result=service.notTeacher(m);
		String msg="";
		if(result>0) {
			msg="해당 계정의 선생님 권한을 해제하였습니다.";
		}else {
			msg="권한 변경 실패. 관리자에게 문의하세요";
		}
		session.setAttribute("alertMsg", msg);
		return "redirect:/manageTeacher.me";
	}
	
	@GetMapping("newMaster.me")
	public String newMaster(Member m, HttpSession session) {
		Member mem=(Member)session.getAttribute("loginUser");
		String msg="";
		String link="";
		/*
		 * int result1=service.newMaster(m);
		 */		
		int result1=0;
		int result2=0;
		int result3=0;
		if(result1>0) {
			result2=service.acceptTeacher(m);
			if(result2>0) {
				mem.setStatus(m.getStatus());
				result3=service.acceptTeacher(mem);
			}
		}
		if(result1*result2*result3>0) {
			msg="고생하셨습니다. 다시 접속해 주시기 바랍니다.";
			session.removeAttribute("loginUser");
			link="redirect:/";
		}else {
			msg="위임 실패. 관리자에게 문의해 주세요";
			link="redirect:/manageTeacher.me";
		}
		session.setAttribute("alertMsg", msg);
		return link;
	}
	@ResponseBody
	@GetMapping("selectPetPhoto.me")
	public PetPhoto getPhoto(Pet p) {
		PetPhoto photo = service.selectPetPhoto(p);
		return photo;
	}
	@ResponseBody
	@GetMapping("checkMsg.me")
	public int checkMsg(Message msg) {
		String check=msg.getStatus().substring(1);
		String status="N"+check;
		msg.setStatus(status);
		int result=service.updateMsg(msg);
		return result;
	}
	@PostMapping("sendMsg.me")
	public String sendMsg(Message msg,HttpSession session) {
		Member m=new Member();
		int result=0;
		String alert="";
		m.setUserId(msg.getReceiver());
		Member Mem=service.loginMember(m);	
		if(Mem!=null) {
			msg.setReceiver(Integer.toString(Mem.getUserNo()));
			result=service.sendMsg(msg);
		}
		if(result>0) {			
			alert="메시지 전송 완료";
		}else {
			alert="메시지 전송 실패. 아이디를 다시 확인해 주세요.";
		}
		session.setAttribute("alertMsg", alert);
		return "redirect:/msg.me?currentPage=1";
	}
	@GetMapping("kakao.me")
	public String kakaoLogin(HttpSession session) throws IOException {
		String setState=generateState();
		session.setAttribute("setState", setState);
		String clientId="db01c7b6cca2d27d7a975ae0bd9aecdb";
		String url="https://kauth.kakao.com/oauth/authorize";
		String uri=URLEncoder.encode("http://localhost:8887/pjtMungHub/kakaoCheck.me","UTF-8");
		url+="?client_id="+clientId;
		url+="&response_type=code&redirect_uri="+uri;
		url+="&state="+setState;
		return "redirect:"+url;
	}
	@RequestMapping("kakaoCheck.me")
	public String kakaoLoginCheck(HttpSession session, HttpServletRequest request) throws IOException {
		String state=request.getParameter("state");
		String code=request.getParameter("code");
	    Member m=new Member();
		if(state.contentEquals((String)session.getAttribute("setState"))) {
			String clientId="db01c7b6cca2d27d7a975ae0bd9aecdb";
			String url="https://kauth.kakao.com/oauth/token";
		    MultiValueMap<String, String> parameter = new LinkedMultiValueMap<>();
		    parameter.add("grant_type", "authorization_code");
		    parameter.add("client_id", clientId);
		    parameter.add("redirect_uri", "http://localhost:8887/pjtMungHub/kakaoCheck.me");
		    parameter.add("code", code);

		    // request header 설정
		    HttpHeaders headers = new HttpHeaders();
		    // Content-type을 application/x-www-form-urlencoded 로 설정
		    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		    // header 와 body로 Request 생성
		    HttpEntity<?> entity = new HttpEntity<>(parameter, headers);

		    try {
		        RestTemplate restTemplate = new RestTemplate();
		        // 응답 데이터(json)를 Map 으로 받을 수 있도록 관련 메시지 컨버터 추가
		        restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());

		        // Post 방식으로 Http 요청
		        // 응답 데이터 형식은 Hashmap 으로 지정
		        ResponseEntity<HashMap> result = restTemplate.postForEntity(url, entity, HashMap.class);
		        Map<String, String> resMap = result.getBody();

		        // 리턴받은 access_token 가져오기
		        String access_token = resMap.get("access_token");
		        String userInfoURL = "https://kapi.kakao.com/v2/user/me";
		        // Header에 access_token 삽입
		        headers.set("Authorization", "Bearer "+access_token);

		        // Request entity 생성
		        HttpEntity<?> userInfoEntity = new HttpEntity<>(headers);

		        // Post 방식으로 Http 요청
		        // 응답 데이터 형식은 Hashmap 으로 지정
		        ResponseEntity<HashMap> userResult = restTemplate.postForEntity(userInfoURL, userInfoEntity, HashMap.class);
		        Map<String, String> userResultMap = (Map)userResult.getBody().get("kakao_account");
		        // 세션에 저장된 state 값 삭제
		        session.removeAttribute("state");
		        // 조회를 위한 데이터 정리
		        m.setEmail(userResultMap.get("email"));
		        Member loginUser=service.socialMember(m);
		        if(loginUser==null) {
		        	session.setAttribute("snsJoin", m);
		        }else {
		        	session.setAttribute("loginUser",loginUser);
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		}
		session.removeAttribute("setState");

		return "redirect:/callback";

	}
	@GetMapping("google.me")
	public String googleLogin(Member m,HttpSession session) {
		Member loginUser=service.socialMember(m);
		PetSitter sitterUser=service.selectSitterbySocial(m);
		String msg="";
		if(loginUser!=null) {
			msg=loginUser.getUserId()+"님 환영합니다.";
			session.setAttribute("loginUser", loginUser);
			ArrayList<MessageVO> cList=service.getChatList(loginUser);
			ArrayList<MessageVO> chatList=new ArrayList<MessageVO>();
			for(MessageVO c:cList) {
				c.setMasterNo(loginUser.getUserNo());
				chatList.add(service.getNewChat(c));
			}
			session.setAttribute("chatList", chatList);
			session.setAttribute("sitterList", service.getSitterList());
		}else if(sitterUser!=null) {
			session.setAttribute("sitterUser", sitterUser);
			msg=sitterUser.getPetSitterName()+" 펫시터님 환영합니다.";
			ArrayList<MessageVO> cList=service.getSitterChatList(sitterUser);
			System.out.println(cList);
			ArrayList<MessageVO> chatList=new ArrayList<MessageVO>();
			ArrayList<Member> masterList=new ArrayList<>();
			for(MessageVO c:cList) {
				c.setSitterNo(sitterUser.getPetSitterNo());
				chatList.add(service.getNewChat(c));
				Member mem=new Member();
				mem.setUserNo(c.getMasterNo());
				masterList.add(service.selectMaster(mem));
			}
			session.setAttribute("masterList", masterList);
			session.setAttribute("chatList", chatList);
			session.removeAttribute("loginUser");
			System.out.println(chatList);
		}else {			
			msg="해당하는 회원을 찾을 수 없습니다. 회원 가입 후 이용해 주세요.";
		}
		session.setAttribute("alertMsg", msg);
		return "redirect:/";
	}
	@GetMapping("naver.me")
	public String naverLogin(HttpSession session) throws IOException {
		
		// 상태 토큰으로 사용할 랜덤 문자열 생성
		String setState = generateState();
		// 세션 또는 별도의 저장 공간에 상태 토큰을 저장
		session.setAttribute("setState", setState);
		String clientId="fx5vZaNv0sDLANZnS_vt";
		String url="https://nid.naver.com/oauth2.0/authorize";
		String uri=URLEncoder.encode("http://localhost:8887/pjtMungHub/naverCheck.me","UTF-8");
		url+="?client_id="+clientId;
		url+="&response_type=code&redirect_uri="+uri;
		url+="&state="+setState+"&auth_type=reauthenticate";
		return "redirect:"+url;
	}
	
	@GetMapping("callback")
	public String callback(HttpServletRequest request) {
		
		return "member/callback";
	}
	@RequestMapping("naverCheck.me")
	public String naverLoginCheck(HttpSession session, HttpServletRequest request) throws IOException {
		String state=request.getParameter("state");
		String code=request.getParameter("code");
	    Member m=new Member();
		if(state.contentEquals((String)session.getAttribute("setState"))) {
			String clientId="fx5vZaNv0sDLANZnS_vt";
			String clientSec="JEw17FydxK";
			String url="https://nid.naver.com/oauth2.0/token";
		    MultiValueMap<String, String> parameter = new LinkedMultiValueMap<>();
		    parameter.add("grant_type", "authorization_code");
		    parameter.add("client_id", clientId);
		    parameter.add("client_secret", clientSec);
		    parameter.add("code", code);
		    parameter.add("state", state);

		    // request header 설정
		    HttpHeaders headers = new HttpHeaders();
		    // Content-type을 application/x-www-form-urlencoded 로 설정
		    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		    // header 와 body로 Request 생성
		    HttpEntity<?> entity = new HttpEntity<>(parameter, headers);

		    try {
		        RestTemplate restTemplate = new RestTemplate();
		        // 응답 데이터(json)를 Map 으로 받을 수 있도록 관련 메시지 컨버터 추가
		        restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());

		        // Post 방식으로 Http 요청
		        // 응답 데이터 형식은 Hashmap 으로 지정
		        ResponseEntity<HashMap> result = restTemplate.postForEntity(url, entity, HashMap.class);
		        Map<String, String> resMap = result.getBody();

		        // 리턴받은 access_token 가져오기
		        String access_token = resMap.get("access_token");

		        String userInfoURL = "https://openapi.naver.com/v1/nid/me";
		        // Header에 access_token 삽입
		        headers.set("Authorization", "Bearer "+access_token);

		        // Request entity 생성
		        HttpEntity<?> userInfoEntity = new HttpEntity<>(headers);

		        // Post 방식으로 Http 요청
		        // 응답 데이터 형식은 Hashmap 으로 지정
		        ResponseEntity<HashMap> userResult = restTemplate.postForEntity(userInfoURL, userInfoEntity, HashMap.class);
		        Map<String, String> userResultMap = (Map)userResult.getBody().get("response");
		        // 세션에 저장된 state 값 삭제
		        session.removeAttribute("state");
		        // 조회를 위한 데이터 정리
		        m.setEmail(userResultMap.get("email"));
		        m.setPhone(userResultMap.get("mobile"));
		        m.setName(userResultMap.get("name"));
		        m.setUserId(userResultMap.get("id"));
		        Member loginUser=service.socialMember(m);
		        if(loginUser==null) {
		        	session.setAttribute("snsJoin", m);
		        }else {
		        	session.setAttribute("loginUser",loginUser);
		        }
		        
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		}
		session.removeAttribute("setState");

		return "redirect:/callback";

	}
	@GetMapping("snsCheck.me")
	public String snsCheck(HttpSession session) {
		String url="redirect:/";
		Member snsJoin=(Member)session.getAttribute("snsJoin");
		Member loginUser=(Member)session.getAttribute("loginUser");
		PetSitter sitterUser=service.selectSitterbySocial(snsJoin);
		if(sitterUser!=null) {
			session.setAttribute("alertMsg",sitterUser.getPetSitterName()+" 펫시터님 환영합니다.");
			ArrayList<MessageVO> cList=service.getSitterChatList(sitterUser);
			ArrayList<MessageVO> chatList=new ArrayList<MessageVO>();
			for(MessageVO c:cList) {
				chatList.add(service.getNewChat(c));
			}
			session.setAttribute("chatList", chatList);
		}else if(snsJoin!=null) {
			session.setAttribute("alertMsg", "가입된 아이디가 없습니다. 회원 가입 페이지로 이동합니다.");
			url+="enroll.me";
		}else if(loginUser==null){
			session.setAttribute("alertMsg", "잘못된 접근");
		}else {
        	session.setAttribute("alertMsg", loginUser.getUserId()+"님 환영합니다.");
			ArrayList<MessageVO> cList=service.getChatList(loginUser);
			ArrayList<MessageVO> chatList=new ArrayList<MessageVO>();
			for(MessageVO c:cList) {
				chatList.add(service.getNewChat(c));
			}
			session.setAttribute("chatList", chatList);
			session.setAttribute("sitterList", service.getSitterList());
		}
		return url;
	}
	
	@ResponseBody
	@GetMapping("searchSitter.me")
	public PetSitter searchSitterStatus(PetSitter pst,HttpSession session) {
		PetSitter sitter=service.searchSitterStatus(pst);
		if(sitter!=null) {
			session.setAttribute("sitterUser", sitter);
		}
		return sitter;
	}
	@ResponseBody
	@GetMapping("/read.chat")
	public int chatRead(HttpSession session, MessageVO msg) {
		return service.chatRead(msg);
	}
	public String generateState()
	{
	    SecureRandom random = new SecureRandom();
	    return new BigInteger(130, random).toString(32);
	}
}

