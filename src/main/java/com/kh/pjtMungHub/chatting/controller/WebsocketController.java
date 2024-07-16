package com.kh.pjtMungHub.chatting.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.socket.WebSocketSession;

import com.kh.pjtMungHub.chatting.vo.MessageVO;
import com.kh.pjtMungHub.member.model.service.MemberService;
import com.kh.pjtMungHub.member.model.vo.Member;
import com.kh.pjtMungHub.petcare.model.vo.PetSitter;

@Controller
@RequestMapping("/chat")
public class WebsocketController {
	
	@Autowired
	private MemberService service;
	
	@GetMapping("/code{code}")
	public String enterChat(@PathVariable String code, HttpSession session) {
		Member loginUser=(Member)session.getAttribute("loginUser");
		PetSitter sitterUser=(PetSitter)session.getAttribute("sitterUser");
		if(loginUser!=null) {
			ArrayList<PetSitter> sitterList=service.getSitterList();
			ArrayList<MessageVO> lastChat=(ArrayList)session.getAttribute("chatList");
			String[] code2=code.split("n");
			int petSitterNo=Integer.parseInt(code2[0]);
			MessageVO p= new MessageVO();
			for(MessageVO msg:lastChat) {
				if(msg.getSitterNo()==petSitterNo) {
					p=msg;
				}
			}
			ArrayList<MessageVO> chatList=service.selectChatList(p);
			for(PetSitter pst :sitterList){
				if(pst.getPetSitterNo()==p.getSitterNo()) {
					session.setAttribute("counterUser",pst);
					break;
				}
			}
			session.setAttribute("chatList", chatList);
		}else if(sitterUser!=null){
			ArrayList<MessageVO> lastChat=(ArrayList)session.getAttribute("chatList");
			String[] code2=code.split("n");
			int masterNo=Integer.parseInt(code2[1]);
			MessageVO p= new MessageVO();
			for(MessageVO msg:lastChat) {
				if(msg.getMasterNo()==masterNo) {
					p=msg;
				}
			}
			ArrayList<MessageVO> chatList=service.selectChatList(p);
			ArrayList<Member> masterList=(ArrayList)session.getAttribute("masterList");
			for(Member mem :masterList){
				if(mem.getUserNo()==p.getMasterNo()) {
					session.setAttribute("counterUser",mem);
					break;
				}
			}
			session.setAttribute("chatList", chatList);
		}
		return "member/memberChatting";
	}
	@ResponseBody
	@PostMapping("/uploadFile.chat")
	public String imageUpload(MultipartFile file, HttpSession session){
		String fullName="";
		try {
			String uploadPath = session.getServletContext().getRealPath("/resources/uploadFiles/chat/");
			String originFile = file.getOriginalFilename();
			String changeName = saveFile(file,session);
			fullName="../resources/uploadFiles/chat/"+changeName;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fullName;
	}
	@ResponseBody
	@GetMapping("/save.chat")
	public int saveChat(HttpSession session, MessageVO msg) {
		return service.saveChat(msg);
	}
	
	public int chatUpload(MessageVO msg) {
		System.out.println(msg);
		return service.chatUpload(msg);
	}
	@ResponseBody
	@GetMapping("/delete.chat")
	public int deleteChat(HttpSession session, MessageVO msg) {
		return service.deleteChat(msg);
	}
	public String saveFile(MultipartFile upfile,HttpSession session) {

		String originName = upfile.getOriginalFilename();
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		String ext = originName.substring(originName.lastIndexOf("."));
		int ranNum = (int)(Math.random()*90000+10000);
		String changeName = currentTime+ranNum+ext;
		String savePath=session.getServletContext().getRealPath("/resources/uploadFiles/chat/");
		try {
		upfile.transferTo(new File(savePath+changeName));
		} catch (IllegalStateException | IOException e) {
		e.printStackTrace();
		}	
		return changeName;
	}
}

