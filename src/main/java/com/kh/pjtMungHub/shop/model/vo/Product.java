package com.kh.pjtMungHub.shop.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product {

	private int productNo;
	private String productName;
	private String status;
	private int salesCount;
	private int price;
	private int discount;
	private int categoryNo;
	private int brandCode;
	private String brandName;
	private String categoryName;
	
	private String attachment;
	private int reviewCount;
	private double reviewTScore;
	
	private int quantity;
}
