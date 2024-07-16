package com.kh.pjtMungHub.petcare.model.vo;

import java.sql.Date;
import java.util.HashMap;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Payment {
    private String paymentId; 
    private String pgName; 
    private String userNo;
    private String userName; 
    private String userId; 
    private String amount; 
    private String phone; 
    private String address; 
    private Date paymentDate; 
    private String paymentMethod; 
    private String productName;
    private int paymentStatus; 
    private String statusName; 
    private String differentNo;
    private String reservationNo;
    private String reservationHouseNo;
    private HashMap<String,String> customData;
}
