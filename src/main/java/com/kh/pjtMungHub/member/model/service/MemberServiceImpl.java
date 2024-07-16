package com.kh.pjtMungHub.member.model.service;

import java.util.ArrayList;
import java.time.LocalDateTime;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;

import com.kh.pjtMungHub.chatting.vo.MessageVO;
import com.kh.pjtMungHub.common.model.vo.PetPhoto;
import com.kh.pjtMungHub.kindergarten.model.vo.Kindergarten;
import com.kh.pjtMungHub.member.model.dao.MemberDao;
import com.kh.pjtMungHub.member.model.vo.Member;
import com.kh.pjtMungHub.member.model.vo.Message;
import com.kh.pjtMungHub.pet.model.vo.Breed;
import com.kh.pjtMungHub.pet.model.vo.Pet;
import com.kh.pjtMungHub.petcare.model.vo.PetSitter;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public Member loginMember(Member m) {
		return dao.loginMember(sqlSession,m);
	}

	@Override
	public Member searchId(Member m) {
		return dao.searchId(sqlSession,m);
	}

	@Override
	public int changePw(Member m) {
		return dao.changePw(sqlSession,m);
	}

	@Override
	public Member checkId(Member m) {
		return dao.checkId(sqlSession,m);
	}
	
	@Override
	public int insertMember(Member m) {
		return dao.insertMember(sqlSession,m);
	}

	@Override
	public int insertTeacher(Member m) {
		return dao.insertTeacher(sqlSession,m);
	}
	
	@Override
	public boolean isUserRestricted(int userNo) {
		return dao.isUserRestricted(sqlSession,userNo);
	}

	@Override
	public int restrictUser(int userNo, int days) {
		return dao.restrictUser(sqlSession,userNo,days);
		
	}

	@Override
	public ArrayList<Pet> selectPetList(Member m) {
		return dao.selectPetList(sqlSession, m);
	}

	@Override
	public PetPhoto selectPetPhoto(Pet p) {
		return dao.selectPetPhoto(sqlSession,p);
	}

	@Override
	public ArrayList<Kindergarten> selectKindList(Kindergarten kind) {
		return dao.selectKindList(sqlSession, kind);
	}

	@Override
	public ArrayList<Breed> selectBreedList() {
		return dao.selectBreedList(sqlSession);
	}
	
	@Override
	public ArrayList<Message> selectMessageList(Member m, int i) {
		return dao.selectMessageList(sqlSession,m,i);
	}

	@Override
	public int msgCount(Member m) {
		return dao.msgCount(sqlSession,m);
	}

	@Override
	public int getPhotoNo() {
		return dao.getPhotoNo(sqlSession);
	}

	@Override
	public int insertPetPhoto(PetPhoto petPhoto) {
		return dao.insertPetPhoto(sqlSession,petPhoto);
	}

	@Override
	public int insertPet(Pet p) {
		return dao.insertPet(sqlSession,p);
	}

	@Override
	public Pet selectPetByNo(Pet p) {
		return dao.selectPetByNo(sqlSession,p);
	}

	@Override
	public int updatePet(Pet p) {
		return dao.updatePet(sqlSession,p);
	}

	@Override
	public int updateMember(Member m) {
		return dao.updateMember(sqlSession,m);
	}

	@Override
	public ArrayList<Member> searchUser(Member m) {
		return dao.searchUser(sqlSession,m);
	}

	@Override
	public ArrayList<Kindergarten> myKind(Member m) {
		return dao.myKind(sqlSession,m);
	}

	@Override
	public ArrayList<Member> searchTeacherByKind(Kindergarten k) {
		return dao.searchTeacherByKind(sqlSession,k);
	}

	@Override
	public int acceptTeacher(Member m) {
		return dao.acceptTeacher(sqlSession,m);
	}

	@Override
	public int notTeacher(Member m) {
		return dao.notTeacher(sqlSession,m);
	}

	@Override
	public int newMaster(Member m) {
		return dao.newMaster(sqlSession,m);
	}

	@Override
	public int deletePhoto(Pet p) {
		return dao.deletePhoto(sqlSession,p);
	}

	@Override
	public int updateMsg(Message msg) {
		return dao.updateMsg(sqlSession,msg);
	}

	@Override
	public int sendMsg(Message msg) {
		return dao.sendMsg(sqlSession,msg);
	}

	@Override
	public Member socialMember(Member m) {
		return dao.socialMember(sqlSession,m);
	}

	@Override
	public int disableUser(Member m) {
		return dao.disableUser(sqlSession,m);
	}

	@Override
	public int enableMember(Member m) {
		return dao.enableMember(sqlSession, m);
	}

	@Override
	public PetSitter searchSitterStatus(PetSitter pst) {
		return dao.searchSitterStatus(sqlSession,pst);
	}

	@Override
	public ArrayList<MessageVO> getChatList(Member loginUser) {
		return dao.getChatList(sqlSession,loginUser);
	}

	@Override
	public MessageVO getNewChat(MessageVO c) {
		return dao.getNewChat(sqlSession,c);
	}

	@Override
	public ArrayList<PetSitter> getSitterList() {
		return dao.getSitterList(sqlSession);
	}

	@Override
	public ArrayList<MessageVO> selectChatList(MessageVO p) {
		return dao.selectChatList(sqlSession, p);
	}

	@Override
	public PetSitter selectSitterbySocial(Member m) {
		return dao.selectSitterbySocial(sqlSession, m);
	}

	@Override
	public ArrayList<MessageVO> getSitterChatList(PetSitter sitterUser) {
		return dao.getSitterChatList(sqlSession,sitterUser);
	}

	@Override
	public Member selectMaster(Member m) {
		return dao.selectMaster(sqlSession,m);
	}
	public LocalDateTime getRestrictedUntil(int userNo) {
		return dao.getRestrictedUntil(sqlSession,userNo);
	}

	@Override
	public int chatUpload(MessageVO msg) {
		return dao.chatUpload(sqlSession,msg);
	}

	@Override
	public int chatRead(MessageVO message) {
		return dao.chatRead(sqlSession, message);
	}

	@Override
	public int saveChat(MessageVO msg) {
		return dao.saveChat(sqlSession,msg);
	}

	@Override
	public int deleteChat(MessageVO msg) {
		return dao.deleteChat(sqlSession,msg);
	}
}
