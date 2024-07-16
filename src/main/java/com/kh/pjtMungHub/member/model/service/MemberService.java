package com.kh.pjtMungHub.member.model.service;

import java.util.ArrayList;

import org.springframework.web.socket.TextMessage;

import com.kh.pjtMungHub.chatting.vo.MessageVO;
import com.kh.pjtMungHub.common.model.vo.PetPhoto;
import com.kh.pjtMungHub.kindergarten.model.vo.Kindergarten;
import java.time.LocalDateTime;
import com.kh.pjtMungHub.member.model.vo.Member;
import com.kh.pjtMungHub.member.model.vo.Message;
import com.kh.pjtMungHub.pet.model.vo.Breed;
import com.kh.pjtMungHub.pet.model.vo.Pet;
import com.kh.pjtMungHub.petcare.model.vo.PetSitter;

public interface MemberService {

	Member loginMember(Member m);
	Member searchId(Member m);
	int changePw(Member m);
	int insertMember(Member m);
	int insertTeacher(Member m);
	Member checkId(Member m);
	ArrayList<Pet> selectPetList(Member m);
	PetPhoto selectPetPhoto(Pet p);
	ArrayList<Kindergarten> selectKindList(Kindergarten kind);
	ArrayList<Breed> selectBreedList();
	ArrayList<Message> selectMessageList(Member m,int i);
	int msgCount(Member m);
	int getPhotoNo();
	int insertPetPhoto(PetPhoto petPhoto);
	int insertPet(Pet p);
	Pet selectPetByNo(Pet p);
	int updatePet(Pet p);
	int updateMember(Member m);
	ArrayList<Member> searchUser(Member m);
	ArrayList<Kindergarten> myKind(Member m);
	ArrayList<Member> searchTeacherByKind(Kindergarten k);
	int acceptTeacher(Member m);
	int notTeacher(Member m);
	int newMaster(Member m);
	int deletePhoto(Pet p);
	int updateMsg(Message msg);
	int sendMsg(Message msg);
	Member socialMember(Member m);
	int disableUser(Member m);
	int enableMember(Member m);
	boolean isUserRestricted(int userNo);
	int restrictUser(int userNo,int days);
	PetSitter searchSitterStatus(PetSitter pst);
	ArrayList<MessageVO> getChatList(Member loginUser);
	MessageVO getNewChat(MessageVO c);
	ArrayList<PetSitter> getSitterList();
	ArrayList<MessageVO> selectChatList(MessageVO p);
	PetSitter selectSitterbySocial(Member m);
	ArrayList<MessageVO> getSitterChatList(PetSitter sitterUser);
	Member selectMaster(Member m);
	LocalDateTime getRestrictedUntil(int userNo);
	int chatUpload(MessageVO msg);
	int chatRead(MessageVO msg);
	int saveChat(MessageVO msg);
	int deleteChat(MessageVO msg);
}
