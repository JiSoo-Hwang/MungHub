package com.kh.pjtMungHub.shop.model.vo;

import java.util.ArrayList;

import com.kh.pjtMungHub.common.model.vo.PageInfo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ParameterVo {

	private ArrayList<Attachment> atList;
	private Attachment at;
	private String justifying;
	private int number;
	
	private String[] items;
	private int userNo;
	private int productNo;
	private int amount;
	private int categoryNo;

	private int star;
	private int currentPage;
	
	private int fileLev;
	
	private ArrayList<Integer> checkedItem;
	
	private PageInfo pi;
	
	private String orderBy;
	private String desc;
}
