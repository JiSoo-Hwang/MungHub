package com.kh.pjtMungHub.petcare.model.vo;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reservation {
    private int reservationId; // RESERVATION_ID NUMBER PRIMARY KEY
    private String address; // ADDRESS VARCHAR2(200) NOT NULL
    private String phone; // PHONE VARCHAR2(20) NOT NULL
    private Date visitDate; // VISIT_DATE DATE NOT NULL
    private Timestamp visitTime; // VISIT_TIME TIMESTAMP NOT NULL
    private Date reservationDate; // RESERVATION_DATE DATE DEFAULT SYSDATE NOT NULL
    private String caution; // CAUTION VARCHAR2(2000) NOT NULL
    private String petName; // PET_NAME VARCHAR2(200) NOT NULL
    private String status; // STATUS NUMBER DEFAULT 1 NOT NULL
    private String userNo; // USER_NO NUMBER NOT NULL
    private String duration; // DURATION NUMBER NOT NULL
    private String petType; // PET_TYPE NUMBER NOT NULL
    private String petPhotoNo; // PET_PHOTO_NO NUMBER
    private String paymentStatus; // PAYMENT_STATUS NUMBER NOT NULL
    private int totalAmount; // TOTAL_AMOUNT NUMBER NOT NULL
}
