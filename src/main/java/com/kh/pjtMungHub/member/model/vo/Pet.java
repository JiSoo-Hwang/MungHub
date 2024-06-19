package com.kh.pjtMungHub.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Pet {
private int petNo;//	PET_NO
private String breedId;//	BREED_ID
private String ownerNo;//	OWNER_NO
private String petName;//	PET_NAME
private int petAge;//	PET_AGE
private String petGender;//	PET_GENDER
private double weight;//	WEIGHT
private int photoNo;//	PHOTO_NO
}
