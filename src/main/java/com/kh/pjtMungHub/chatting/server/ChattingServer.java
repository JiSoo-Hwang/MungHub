package com.kh.pjtMungHub.chatting.server;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.kh.pjtMungHub.chatting.controller.WebsocketController;
import com.kh.pjtMungHub.chatting.vo.MessageVO;
import com.kh.pjtMungHub.member.model.service.MemberServiceImpl;
import com.kh.pjtMungHub.member.model.vo.Member;
import com.kh.pjtMungHub.petcare.model.vo.PetSitter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ChattingServer extends TextWebSocketHandler{

	// 접속한 전체 유저의 웹소켓 세션 담아놓을 set
	private Set<WebSocketSession> users = new CopyOnWriteArraySet<>();
	private Set<WebSocketSession> sitters = new CopyOnWriteArraySet<>();
	// 현재 접속 유저의 유저정보 - 웹소켓 세션을 엮어 놓은 hashMap
	private HashMap<Integer, WebSocketSession> chatUser=new HashMap<>();
	private HashMap<Integer, WebSocketSession> chatSitter=new HashMap<>();
	private Set<WebSocketSession> chattingSet= new CopyOnWriteArraySet<WebSocketSession>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		Member loginUser=(Member)session.getAttributes().get("loginUser");
		WebSocketSession counter=null;
		if(loginUser!=null) {
			PetSitter counterUser=(PetSitter)session.getAttributes().get("counterUser");
			System.out.println("counterUser : "+counterUser);
			users.add(session);
			chattingSet.add(session);
			counter=chatSitter.get(counterUser.getPetSitterNo());
			System.out.println("counter : "+counter);
		}else {
			System.out.println("로그인안함");
			Member counterUser=(Member)session.getAttributes().get("counterUser");
			sitters.add(session);
			chattingSet.add(session);
			counter=chatUser.get(counterUser.getUserNo());
		}
		if(counter!=null) {
			chattingSet.add(counter);
		}
		System.out.println(chattingSet);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// TODO Auto-generated method stub
		// 메시지를 전달받아 아이디와 메시지를 vo에 담아 처리해보기
		Member loginUser = ((Member)(session.getAttributes().get("loginUser")));
		MessageVO mv=new MessageVO();
		if(loginUser!=null) {
			PetSitter counterUser = ((PetSitter)(session.getAttributes().get("counterUser")));
			int lnth=message.getPayloadLength();
			mv.setSitterNo(counterUser.getPetSitterNo());
			mv.setMasterNo(loginUser.getUserNo());
			System.out.println(message.getPayload());
			mv.setChatContent(message.getPayload().substring((6)));
			mv.setChatWriter(message.getPayload().substring(0,6));
		}else {
			PetSitter sitterUser=(PetSitter)session.getAttributes().get("sitterUser");
			Member counterUser=(Member)session.getAttributes().get("counterUser");
			int lnth=message.getPayloadLength();
			mv.setSitterNo(sitterUser.getPetSitterNo());
			mv.setMasterNo(counterUser.getUserNo());
			mv.setChatContent(message.getPayload().substring(6));
			mv.setChatWriter(message.getPayload().substring(0,6));
			}
		
		System.out.println(chattingSet);
		for(WebSocketSession ws : chattingSet) {
			System.out.println(ws);
			ws.sendMessage(message);
		}
		log.debug("전송완료");
	}
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		log.debug("접속 종료");
		Member loginUser=(Member)session.getAttributes().get("loginUser");
		chattingSet.remove(session);
		if(loginUser!=null) {
			chatUser.remove(loginUser.getUserNo(), session);
			users.remove(session);	
			log.debug("반려견주 세션 삭제");
		}else {
			PetSitter sitterUser=(PetSitter)session.getAttributes().get("sitterUser");
			chatSitter.remove(sitterUser.getPetSitterNo(), session);
			sitters.remove(session);	
			log.debug("펫시터 세션 삭제");
		}
		System.out.println(session);
	}
}
