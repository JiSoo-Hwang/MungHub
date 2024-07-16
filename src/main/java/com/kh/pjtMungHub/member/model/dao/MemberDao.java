package com.kh.pjtMungHub.member.model.dao;

import java.util.ArrayList;
import org.apache.ibatis.session.RowBounds;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.pjtMungHub.chatting.vo.MessageVO;
import com.kh.pjtMungHub.common.model.vo.PetPhoto;
import com.kh.pjtMungHub.kindergarten.model.vo.Kindergarten;
import com.kh.pjtMungHub.member.model.vo.Member;
import com.kh.pjtMungHub.member.model.vo.Message;
import com.kh.pjtMungHub.pet.model.vo.Breed;
import com.kh.pjtMungHub.pet.model.vo.Pet;
import com.kh.pjtMungHub.petcare.model.vo.PetSitter;

@Repository
public class MemberDao {

	public Member loginMember(SqlSessionTemplate sqlSession, Member m) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("memberMapper.loginMember",m);
	}
	
	public Member searchId(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.searchId",m);
	}
	public int changePw(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.changePw",m);
	}

	public Member checkId(SqlSessionTemplate sqlSession, Member m) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("memberMapper.checkId",m);
	}
	
	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.insertMember", m);
	}
	
	public int insertTeacher(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.insertTeacher", m);
	}
	
	public ArrayList<Pet> selectPetList(SqlSessionTemplate sqlSession, Member m){
		return (ArrayList)sqlSession.selectList("memberMapper.selectPetList",m);
	}

	public PetPhoto selectPetPhoto(SqlSessionTemplate sqlSession, Pet p) {
		return sqlSession.selectOne("memberMapper.selectPetPhoto", p);
	}

	public ArrayList<Kindergarten> selectKindList(SqlSessionTemplate sqlSession,Kindergarten kind) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectKindList",kind);
	}

	public ArrayList<Breed> selectBreedList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectBreedList");
	}

	public ArrayList<Message> selectMessageList(SqlSessionTemplate sqlSession, Member m, int i) {
		RowBounds rb = new RowBounds((i-1)*15,15);

		return (ArrayList)sqlSession.selectList("memberMapper.selectMessageList",m);
	}

	public int msgCount(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.msgCount",m);
	}

	public int getPhotoNo(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("memberMapper.getPhotoNo");
	}

	public int insertPetPhoto(SqlSessionTemplate sqlSession, PetPhoto petPhoto) {
		return sqlSession.insert("memberMapper.insertPetPhoto", petPhoto);
	}

	public int insertPet(SqlSessionTemplate sqlSession, Pet p) {
		return sqlSession.insert("memberMapper.insertPet", p);
	}

	public Pet selectPetByNo(SqlSessionTemplate sqlSession, Pet p) {
		return sqlSession.selectOne("memberMapper.selectPetByNo",p);
	}

	public int updatePet(SqlSessionTemplate sqlSession, Pet p) {
		return sqlSession.update("memberMapper.updatePet", p);
	}

	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.updateMember",m);
	}

	public ArrayList<Member> searchUser(SqlSessionTemplate sqlSession, Member m) {
		return (ArrayList)sqlSession.selectList("memberMapper.searchUser",m);
	}

	public ArrayList<Kindergarten> myKind(SqlSessionTemplate sqlSession, Member m) {
		return (ArrayList)sqlSession.selectList("memberMapper.myKind",m);
	}

	public ArrayList<Member> searchTeacherByKind(SqlSessionTemplate sqlSession, Kindergarten k) {
		return (ArrayList)sqlSession.selectList("memberMapper.searchTeacherByKind", k);
	}

	public int acceptTeacher(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.acceptTeacher", m);
	}

	public int notTeacher(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.notTeacher",m);
	}

	public int newMaster(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.newMaster", m);
	}
	
	public int deletePhoto(SqlSessionTemplate sqlSession, Pet p) {
		return sqlSession.update("memberMapper.deletePhoto", p);
	}

	public int updateMsg(SqlSessionTemplate sqlSession, Message msg) {
		return sqlSession.update("memberMapper.checkMsg", msg);
	}

	public int sendMsg(SqlSessionTemplate sqlSession, Message msg) {
		return sqlSession.insert("memberMapper.sendMsg",msg);
	}

	public Member socialMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.socialMember",m);
	}

	public int disableUser(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.disableUser", m);
	}

	public int enableMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.enableUser",m);
	}
	
	public boolean isUserRestricted(SqlSessionTemplate sqlSession,int userNo) {
		return sqlSession.selectOne("memberMapper.isUserRestricted",userNo);
	}

	public int restrictUser(SqlSessionTemplate sqlSession, int userNo, int days) {
		Map<String,Object>params = new HashMap<String, Object>();
		params.put("userNo", userNo);
		params.put("days",days);
		return sqlSession.update("memberMapper.restrictUser",params);
	}

	public PetSitter searchSitterStatus(SqlSessionTemplate sqlSession, PetSitter pst) {
		PetSitter result=sqlSession.selectOne("memberMapper.searchSitterStatus", pst);
		return result;
	}

	public ArrayList<MessageVO> getChatList(SqlSessionTemplate sqlSession, Member loginUser) {
		return (ArrayList)sqlSession.selectList("memberMapper.getChatList", loginUser);
	}

	public MessageVO getNewChat(SqlSessionTemplate sqlSession, MessageVO c) {
		return sqlSession.selectOne("memberMapper.getNewChat",c);
	}

	public ArrayList<PetSitter> getSitterList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("memberMapper.getSitterList");
	}

	public ArrayList<MessageVO> selectChatList(SqlSessionTemplate sqlSession, MessageVO p) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectChatList",p);
	}

	public PetSitter selectSitterbySocial(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.selectSitterbySocial",m);
	}

	public ArrayList<MessageVO> getSitterChatList(SqlSessionTemplate sqlSession, PetSitter sitterUser) {
		return (ArrayList)sqlSession.selectList("memberMapper.getSitterChatList",sitterUser);
	}

	public Member selectMaster(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.selectMaster",m);
	}


	public LocalDateTime getRestrictedUntil(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("memberMapper.getRestrictedUntil",userNo);
	}

	public int chatUpload(SqlSessionTemplate sqlSession, MessageVO msg) {
		System.out.println("dao 오나?");
		return sqlSession.insert("memberMapper.chatUpload", msg);
	}

	public int chatRead(SqlSessionTemplate sqlSession, MessageVO message) {
		return sqlSession.update("memberMapper.chatRead", message);
	}

	public int saveChat(SqlSessionTemplate sqlSession, MessageVO msg) {
		return sqlSession.update("memberMapper.saveChat",msg);
	}

	public int deleteChat(SqlSessionTemplate sqlSession, MessageVO msg) {
		return sqlSession.update("memberMapper.deleteChat", msg);
	}
}
