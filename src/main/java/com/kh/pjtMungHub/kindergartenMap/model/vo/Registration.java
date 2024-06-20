package com.kh.pjtMungHub.kindergartenMap.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Registration {
private int reservNo;//	RESERV_NO
private int kindNo;//	KIND_NO
private String kindName; //KIND_NAME
private String petNo;//	PET_NO
private String userNo;//	USER_NO
private Date visitDate;//	VISIT_DATE
private String petIntro;//	PET_INTRO
private String petNote;//	PET_NOTE
private String approval;//	APPROVAL
}