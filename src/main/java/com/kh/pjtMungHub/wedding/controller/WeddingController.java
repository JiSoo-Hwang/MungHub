package com.kh.pjtMungHub.wedding.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pjtMungHub.kindergarten.model.vo.Vaccine;
import com.kh.pjtMungHub.member.model.vo.Member;
import com.kh.pjtMungHub.pet.model.vo.Breed;
import com.kh.pjtMungHub.pet.model.vo.Pet;
import com.kh.pjtMungHub.wedding.model.service.WeddingService;
import com.kh.pjtMungHub.wedding.model.vo.Wedding;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class WeddingController {

	@Autowired
	private WeddingService service;

	@Autowired
	private SqlSessionTemplate sqlSession;

//	@ResponseBody
//	@RequestMapping("breedList.wd")
//	public ArrayList<Breed> selectBreeds(){
//		ArrayList<Breed> breedList = service.selectBreeds();
//		
//		return breedList;
//		
//	}

	@GetMapping("wedList.wd")
	public ModelAndView weddingList(ModelAndView mv) {
		ArrayList<Breed> breedList = service.selectBreeds();
		ArrayList<Wedding> weddingList = service.selectWeddings();
		mv.addObject("weddingList", weddingList).addObject("breedList", breedList)
		.addObject("breedId", "ALL").setViewName("wedding/weddingListView");
		return mv;
	}

	@GetMapping("selectList.wd")
	public ModelAndView selectByBreeds(String breedId,ModelAndView mv){
		if(breedId.equals("ALL")) {
			mv.setViewName("redirect:/wedList.wd");
		}else {
			ArrayList<Wedding> list = service.selectByBreed(breedId);
			ArrayList<Breed> breedList = service.selectBreeds();
			mv.addObject("weddingList", list).addObject("breedList", breedList).addObject("breedId", breedId)
			.setViewName("wedding/weddingListView");
		}
		return mv;
	}
	
	// 최초 웨딩플래너 등록 신청시 상세 뷰페이지
	@GetMapping("detail.wd")
	public ModelAndView selectWedding(int weddingNo, ModelAndView mv) {
		Wedding w = service.selectWedding(weddingNo);
		mv.addObject("wedding", w).setViewName("wedding/weddingDetailView");
		return mv;
	}

	// 등록된 신랑/신부 상세 뷰페이지
	@GetMapping("info.wd")
	public ModelAndView selectWeddingInfo(int weddingNo, ModelAndView mv) {
		Wedding w = service.selectWedding(weddingNo);
		mv.addObject("wedding", w).setViewName("wedding/weddingInfoView");
		return mv;
	}

	// 최초 웨딩플래너 등록 신청페이지 이동
	@GetMapping("insert.wd")
	public String insertWeddingForm(HttpSession session, Model model) {
		Member m = (Member) session.getAttribute("loginUser");
		int userNo = m.getUserNo();
		Pet pet = service.selectPet(userNo);
		model.addAttribute("pet", pet);
		return "wedding/insertWeddingView";
	}

	// 최초 웨딩플래너 등록 신청
	@PostMapping("insert.wd")
	public String insertWedding(Wedding w, MultipartFile upFile, ArrayList<MultipartFile> vacCert, Model model,
			HttpSession session) {
		if (!upFile.getOriginalFilename().equals("")) {
			String changeName = saveFile(upFile, session);
			w.setOriginName(upFile.getOriginalFilename());
			w.setChangeName("resources/uploadFiles/wedding/" + changeName);
			w.setApproval("N");
		}
		// 여기까지가 웨딩 기본 정보 추가, 이후는 백신 정보 추가
		ArrayList<Vaccine> vacList = new ArrayList<Vaccine>();
		for (MultipartFile m : vacCert) {
			vacList.add(Vaccine.builder().petNo(w.getPetNo()).originName(m.getOriginalFilename())
					.changeName("resources/uploadFiles/kindergarten/" + saveFile(m, session)).build());
		}
		int result = service.insertWedding(w, vacList);
		if (result > 0) {
			session.setAttribute("alertMsg", "웨딩 신청 성공! 승인 결과를 기다려주세요~♡(ᐢ ᴥ ᐢし)");
			return "redirect:/wedList.wd";
		} else {
			session.setAttribute("alertMsg", "웨딩 신청 실패 └(°ᴥ°)┓...다시 시도해주세요...!");
			return "redirect:/wedList.wd";
		}
	}

	// 관리자만이 접근 가능한 웨딩플래너 신청 조회 페이지로 이동
	@GetMapping("admin.wd")
	public ModelAndView wedManager(ModelAndView mv) {
		ArrayList<Wedding> regList = service.selectRegList();
		mv.addObject("weddingList", regList).setViewName("wedding/weddingRegListView4admin");
		return mv;
	}

	@GetMapping("update.wd")
	public ModelAndView updateWedding(int weddingNo, ModelAndView mv, HttpSession session) {
		Member m = (Member) session.getAttribute("loginUser");
		Wedding w = service.selectWedding(weddingNo);
		Pet p = service.selectPet(m.getUserNo());
		mv.addObject("wedding", w).addObject("pet", p).setViewName("wedding/updateWeddingView");
		;
		return mv;
	}

	@PostMapping("reject.wd")
	public String rejectReg(Wedding w, HttpSession session) {
		int result = service.rejectReg(w);
		Member m=(Member)session.getAttribute("loginUser");
		if (result > 0) {
			session.setAttribute("alertMsg", "거절 처리되었습니다(´ᴥ`)");
			if(m.getName().equals("admin")) {
				return "redirect:/admin.wd";
			}else {
				return "redirect:/regList.wd?userNo=" + m.getUserNo();
			}
		} else {
			session.setAttribute("alertMsg", "처리 실패. 다시 시도해주세요.");
			if(m.getName().equals("admin")) {
				return "redirect:/admin.wd";
			}else {
				return "redirect:/regList.wd?userNo=" + m.getUserNo();
			}
		}
	}

	@GetMapping("approve.wd")
	public String approveReg(int weddingNo, HttpSession session) {
		int result = service.approveReg(weddingNo);
		if (result > 0) {
			session.setAttribute("alertMsg", "승인처리되었습니다 (ᐡ-ܫ•ᐡ)");
		} else {
			session.setAttribute("alertMsg", "처리 실패 └(°ᴥ°)┓...다시 시도해주세요...!");
		}
		return "redirect:/admin.wd";
	}

	// 만남 신청 페이지로 이동
	@GetMapping("apply.wd")
	public String applyMatchingForm(int petNo, HttpSession session, Model model) {
		Member m = (Member) session.getAttribute("loginUser");
		int count = service.countAppliedList(m.getUserNo());
		Pet pet = service.selectPet(m.getUserNo());
		if (count >= 3) {
			session.setAttribute("alertMsg", "계정당 만남 신청은 3회로 제한되어있습니다 ꌩ-ꌩ");
			return "redirect:/wedList.wd";
		} else {
			model.addAttribute("matchingPet", petNo);
			model.addAttribute("pet", pet);
			return "wedding/apply4MatchingView";
		}
	}

	// 만남 신청
	@PostMapping("apply.wd")
	public String applyMatching(Wedding w, MultipartFile upFile, ArrayList<MultipartFile> vacCert, Model model,
			HttpSession session) {

		if (!upFile.getOriginalFilename().equals("")) {
			String changeName = saveFile(upFile, session);
			w.setOriginName(upFile.getOriginalFilename());
			w.setChangeName("resources/uploadFiles/wedding/" + changeName);
		}
		ArrayList<Vaccine> vacList = new ArrayList<Vaccine>();
		for (MultipartFile m : vacCert) {
			vacList.add(Vaccine.builder().petNo(w.getPetNo()).originName(m.getOriginalFilename())
					.changeName("resources/uploadFiles/wedding/" + saveFile(m, session)).build());
		}
		int result = service.applyMatching(w, vacList);
		if (result > 0) {
			ArrayList<Wedding> appliedList = service.selectAppliedList(w);
			session.setAttribute("alertMsg", "신청 성공! 상대방의 수락을 기다려보아요(ᐡ-ܫ•ᐡ)♥");
			model.addAttribute("weddingList", appliedList);
			return "wedding/weddingRegList";
		} else {
			session.setAttribute("alertMsg", "신청실패૮ ºﻌºა...다시 시도해보세요!");
			return "redirect:/wedList.wd";
		}
	}

	@GetMapping("regList.wd")
	public ModelAndView selectMyList(Wedding w, ModelAndView mv) {
		ArrayList<Wedding> myList = service.selectAppliedList(w);
		mv.addObject("weddingList", myList).setViewName("wedding/weddingRegList");
		return mv;
	}

	@GetMapping("accept.wd")
	public String acceptWedding(int weddingNo, HttpSession session) {
		int result = service.acceptWedding(weddingNo);
		Member m = (Member) session.getAttribute("loginUser");
		if (result > 0) {
			session.setAttribute("alertMsg", "만남을 정상적으로 수락하셨습니다♡(ᐢ ᴥ ᐢし)");
			return "redirect:/regList.wd?userNo=" + m.getUserNo();
		} else {
			session.setAttribute("alertMsg", "수락 처리가 되지 않았습니다!!!└(°ᴥ°)┓ 다시 시도해주세요...!");
			return "redirect:/regList.wd?userNo=" + m.getUserNo();
		}
	}

	// 파일 업로드 처리 메소드(재활용)
	public String saveFile(MultipartFile upfile, HttpSession session) {

		// 파일명 수정작업하기
		// 1.원본파일명 추출
		String originName = upfile.getOriginalFilename();

		// 2.시간형식 문자열로 만들기
		// 20240527162730
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

		// 3.확장자 추출하기 파일명 뒤에서부터 . 찾아서 뒤로 잘라내기
		String ext = originName.substring(originName.lastIndexOf("."));

		// 4.랜덤값 5자리 뽑기
		int ranNum = (int) (Math.random() * 90000 + 10000);

		// 5.하나로 합쳐주기
		String changeName = currentTime + ranNum + ext;

		// 6.업로드하고자하는 물리적인 경로 알아내기 (프로젝트 내에 저장될 실제 경로 찾기)
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/wedding/");

		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return changeName;
	}
}
