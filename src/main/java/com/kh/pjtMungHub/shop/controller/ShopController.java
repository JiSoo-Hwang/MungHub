package com.kh.pjtMungHub.shop.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pjtMungHub.common.model.vo.PageInfo;
import com.kh.pjtMungHub.common.template.Pagination;
import com.kh.pjtMungHub.member.model.vo.Member;
import com.kh.pjtMungHub.shop.model.service.ShopService;
import com.kh.pjtMungHub.shop.model.vo.Answer;
import com.kh.pjtMungHub.shop.model.vo.Attachment;
import com.kh.pjtMungHub.shop.model.vo.Brand;
import com.kh.pjtMungHub.shop.model.vo.Cart;
import com.kh.pjtMungHub.shop.model.vo.Category;
import com.kh.pjtMungHub.shop.model.vo.Customer;
import com.kh.pjtMungHub.shop.model.vo.Favorite;
import com.kh.pjtMungHub.shop.model.vo.MonthlyTally;
import com.kh.pjtMungHub.shop.model.vo.POrderInfo;
import com.kh.pjtMungHub.shop.model.vo.ParameterVo;
import com.kh.pjtMungHub.shop.model.vo.Point;
import com.kh.pjtMungHub.shop.model.vo.Product;
import com.kh.pjtMungHub.shop.model.vo.ProductDetail;
import com.kh.pjtMungHub.shop.model.vo.Question;
import com.kh.pjtMungHub.shop.model.vo.Review;
import com.kh.pjtMungHub.shop.model.vo.ReviewReply;
import com.kh.pjtMungHub.shop.model.vo.ScorePercent;
import com.kh.pjtMungHub.shop.model.vo.ShipInfo;



@Controller
public class ShopController {

	
	@Autowired
	private ShopService shopService;
	
	@GetMapping("list.sp")
	public ModelAndView ShopList(ModelAndView mv) {
		
		ArrayList<Product> pList = shopService.selectProductList("Y");
		
		ArrayList<Attachment> atList=new ArrayList<>();
		
			for(int i=0; i<pList.size();i++) {
				ParameterVo parameter= ParameterVo.builder()
						.justifying("cheak")
						.productNo(pList.get(i).getProductNo())
						.build();
				ArrayList<Review> cheak = shopService.selectReviewList(parameter);
				
				
				parameter= ParameterVo.builder().
						justifying("product").
						fileLev(0).
						number(pList.get(i).getProductNo())
						.build();
				
				Attachment at=shopService.selectAttachment(parameter);
				
				atList.add(at);
				if(!cheak.isEmpty()) {
					int reviewCount=shopService.selectReviewCount(pList.get(i).getProductNo());
					double reviewScoreAvg=shopService.selectScoreAvg(pList.get(i).getProductNo());
					pList.get(i).setReviewCount(reviewCount);
					pList.get(i).setReviewTScore(reviewScoreAvg);
				}
			}
		ArrayList<Attachment> mainSlide=shopService.selectMainSlide();
		mv.addObject("atList",atList);
		mv.addObject("pList", pList);
		mv.addObject("mainSlide",mainSlide);
		
		mv.setViewName("shop/shopListView");
	
		
		return mv;
	}
	
	@GetMapping("notPosted.sp")
	public ModelAndView notPostedList(ModelAndView mv) {
		
		ArrayList<Product> pList = shopService.selectProductList("N");
		
		mv.addObject("notPostList","N");
		mv.addObject("pList",pList);
		mv.setViewName("/shop/shopListView");
		return mv;
	}
	
	@PostMapping("delete.sp")
	@ResponseBody
	public int deleteProductData(int productNo,HttpSession session) {
		
		ParameterVo parameter=ParameterVo.builder()
				.justifying("product")
				.number(productNo)
				.build();
		
		ArrayList<Attachment> atList=shopService.selectAttachmentList(parameter);
		
		for(int i=0;i<atList.size();i++) {
			String deleteFile= "resources/uploadFiles/shopFile/productFile/"+atList.get(i).getType()+"/"+atList.get(i).getChangeName();
			File f= new File(session.getServletContext().getRealPath(deleteFile));
			f.delete();
		}
		
		int result=shopService.deleteProductData(productNo);
		
		
		
		return result;
		
	}
	
	@GetMapping("updateDetailInfo/{productNo}")
	public ModelAndView updateDetailInfo(ModelAndView mv,
										@PathVariable int productNo) {

		ProductDetail pDetail=shopService.selectProdcutInfo(productNo);
		ParameterVo parameter=ParameterVo.builder().justifying("pDetail").number(pDetail.getDetailNo()).build();
		ArrayList<Attachment> detailAtList=shopService.selectAttachmentList(parameter);
		Product p = shopService.selectProductDetail(productNo);
		mv.addObject("dAtList",detailAtList);
		mv.addObject("pDetail",pDetail);
		mv.addObject("p",p);
		mv.setViewName("shop/updateDetailInfo");
		return mv;
	}
	
	@GetMapping("insertDetailInfo/{productNo}")
	public ModelAndView insertDetailInfo(ModelAndView mv,
										@PathVariable int productNo) {
		mv.addObject("productNo",productNo);
		mv.setViewName("shop/insertDetailInfo");
		return mv;
	}
	@PostMapping("insertDetailInfo.sp")
	public ModelAndView insertDetailInfo(ModelAndView mv,
										ProductDetail pd,
										MultipartFile[] upfile,
										HttpSession session) {
		
		
		ArrayList<Attachment> atList=new ArrayList<>();
			for(int i=0;i<upfile.length;i++) {
				
				String fileType=upfile[i].getOriginalFilename();
				int index = fileType.lastIndexOf(".");
				String extension = fileType.substring( index+1 ).toLowerCase();
				String type="";
				
				
				if(extension.equals("avi")||
				   extension.equals("mov")||
				   extension.equals("mp4")||
				   extension.equals("wmv")||
				   extension.equals("asf")||
				   extension.equals("mkv")) {
					
						type="video";
					}else if(extension.equals("jpeg")||
							 extension.equals("jpg")||
							 extension.equals("png")||
							 extension.equals("gif")) {
						type="image";
					}else {
						type="file";
					}
					
					
					String changeName = saveFile(upfile[i],session,"productDetail",type);
					
					Attachment at=Attachment.builder().
							fileLev(i).
							originName(upfile[i].getOriginalFilename()).
							changeName(changeName).
							fileJustify("pDetail").
							filePath("/pjtMungHub/resources/uploadFiles/shopFile/productDetail/"+type+"/").
							type(type).
							build();
					
					atList.add(at);
				
				
			}
			
			
			ParameterVo fileParameter=ParameterVo.builder()
					.atList(atList)
					.justifying("pDetail")
					.build();
			
			int result=shopService.insertDetailInfo(pd,fileParameter);
		
		
		mv.setViewName("redirect:detail.sp/"+pd.getProductNo());
		return mv;
	}
	
	@PostMapping("updateDetailInfo.sp")
	public ModelAndView updateDetailInfo(ModelAndView mv,
										ProductDetail pd,
										MultipartFile[] upfile,
										HttpSession session) {
		
		
		ParameterVo parameter=ParameterVo.builder()
				.justifying("pDetail")
				.number(pd.getDetailNo())
				.build();
		
		ArrayList<Attachment> deleteAtList=shopService.selectAttachmentList(parameter);
		for (int i = 0; i < deleteAtList.size(); i++) {
			String deleteFile= "resources/uploadFiles/shopFile/productDetail/"+deleteAtList.get(i).getType()+"/"+deleteAtList.get(i).getChangeName();
			File f=new File(session.getServletContext().getRealPath(deleteFile));
			f.delete();
			parameter.setFileLev(i);
			shopService.deleteAttachment(parameter);
		}

		ArrayList<Attachment> atList=new ArrayList<>();
			for(int i=0;i<upfile.length;i++) {
				
				String fileType=upfile[i].getOriginalFilename();
				int index = fileType.lastIndexOf(".");
				String extension = fileType.substring( index+1 ).toLowerCase();
				String type="";
				
				
				if(extension.equals("avi")||
				   extension.equals("mov")||
				   extension.equals("mp4")||
				   extension.equals("wmv")||
				   extension.equals("asf")||
				   extension.equals("mkv")) {
					
						type="video";
					}else if(extension.equals("jpeg")||
							 extension.equals("jpg")||
							 extension.equals("png")||
							 extension.equals("gif")) {
						type="image";
					}else {
						type="file";
					}
					
					
					String changeName = saveFile(upfile[i],session,"productDetail",type);
					
					Attachment at=Attachment.builder().
							fileLev(i).
							originName(upfile[i].getOriginalFilename()).
							changeName(changeName).
							fileJustify("pDetail").
							filePath("/pjtMungHub/resources/uploadFiles/shopFile/productDetail/"+type+"/").
							type(type).
							build();
					
					atList.add(at);
				
				
			}
		
		
		
		ParameterVo fileParameter=ParameterVo.builder()
				.atList(atList)
				.justifying("pDetail")
				.number(pd.getDetailNo())
				.build();
		
		int result=shopService.updateDetailInfo(pd,fileParameter);
		
		mv.setViewName("redirect:/detail.sp/"+pd.getProductNo());
		return mv;
	}
			
	
	
	
	@GetMapping("detail.sp/{productNo}")
	public ModelAndView ShopDetail(@PathVariable int productNo,
									ModelAndView mv,
									HttpSession session) {
		
		Product p=shopService.selectProductDetail(productNo);
		ArrayList<Product> pList = shopService.selectProductList("Y"); 
		ParameterVo parameter = ParameterVo.builder().justifying("product").number(productNo).build();
		ArrayList<Attachment> atList= shopService.selectAttachmentList(parameter);
		ArrayList<ScorePercent> percent=shopService.selectScorePercent(productNo);

		ParameterVo parameter2=ParameterVo.builder().justifying("best").productNo(productNo).build();
		ArrayList<Review> bestReviewTop4=shopService.selectReviewList(parameter2);
		
		ArrayList<ArrayList<Attachment>> reviewAt=new ArrayList<>();
		ArrayList<Attachment> rAtList=new ArrayList<>();
		ParameterVo parameter3;
		ArrayList<Attachment> detailAtList=new ArrayList<>();
		for (int i = 0; i < bestReviewTop4.size(); i++) {
			
			parameter3=ParameterVo.builder().justifying("review").number(bestReviewTop4.get(i).getReviewNo()).build();
			
			rAtList=shopService.selectAttachmentList(parameter3);
			reviewAt.add(rAtList);
		}
		
		if(!bestReviewTop4.isEmpty()) {
			
			p.setReviewCount(shopService.selectReviewCount(productNo));
			p.setReviewTScore(shopService.selectScoreAvg(productNo));
		}
		
		for (int i = 0; i < pList.size(); i++) {
			parameter2.setProductNo(pList.get(i).getProductNo());
			ArrayList<Review> ReviewCheak=shopService.selectReviewList(parameter2);
			if(!ReviewCheak.isEmpty()) {
				int recomendScore =pList.get(i).getProductNo();
				pList.get(i).setReviewTScore(shopService.selectScoreAvg(recomendScore));
				
			}else {
				pList.get(i).setReviewTScore(0);
			}
			
		}
		
		ArrayList<Category> questionCategoryList=shopService.selectQuestionCategory();
		
		ProductDetail pDetail=shopService.selectProdcutInfo(productNo);
		if(pDetail!=null) {
			
			parameter3=ParameterVo.builder().justifying("pDetail").number(pDetail.getDetailNo()).build();
			detailAtList=shopService.selectAttachmentList(parameter3);
		}
		
		Member loginUser=(Member) session.getAttribute("loginUser");
		ArrayList<POrderInfo> oList=new ArrayList<>();
		ArrayList<Integer> orderItemArr=new ArrayList<>();
		if(loginUser!=null) {
		oList=shopService.selectOrderListComplete(loginUser.getUserNo(),"배송완료");
		if(oList!=null) {
			
		
			for(int i=0; i<oList.size();i++) {
				String[] items=oList.get(i).getItems().split(",");
				
				int[] itemsArr= Arrays.stream(items)
						.mapToInt(Integer::parseInt)
						.toArray();	
				for(int k=0; k<itemsArr.length;k++) {
					orderItemArr.add(itemsArr[i]);
				}
				
			}
				
			}
		}
		
		mv.addObject("orderItemArr",orderItemArr);
		mv.addObject("pDetail",pDetail);
		mv.addObject("dAtList",detailAtList);
		mv.addObject("cList",questionCategoryList);
		mv.addObject("rAtList",reviewAt);
		mv.addObject("best4Review",bestReviewTop4);
		mv.addObject("percent",percent);
		mv.addObject("atList",atList);
		mv.addObject("pList", pList);
		mv.addObject("p",p);
		mv.setViewName("shop/shopDetailView");
		
		return mv;
	}
	@GetMapping("selectFavorite.sp")
	@ResponseBody
	public boolean selectFavorite(Favorite favor) {
		
		ParameterVo parameter = ParameterVo.builder()
				.userNo(favor.getUserNo())
				.productNo(favor.getProductNo())
				.justifying("Y")
				.build();
		
		Favorite fav=shopService.selectFavorite(parameter);
		
		if(fav==null) {
			parameter.setJustifying("N");
			Favorite deleteFav=shopService.selectFavorite(parameter);
			if(deleteFav!=null) {
				shopService.convertFavorite(favor);
			}
			return false;
		}else {
			return true;
		}
		
	}
	
	@GetMapping("selectFavoriteList.sp")
	@ResponseBody
	public ArrayList<Favorite> selectFavoriteList(int userNo) {
		
		ParameterVo parameter = ParameterVo.builder()
				.userNo(userNo)
				.justifying("N")
				.build();
		
		ArrayList<Favorite> deleteFav=shopService.selectFavoriteList(parameter);
		
		if(deleteFav!=null) {
			
			for (int i = 0; i < deleteFav.size(); i++) {
				shopService.convertFavorite(deleteFav.get(i));
			}
		}
		parameter.setJustifying("Y");
		ArrayList<Favorite> fav=shopService.selectFavoriteList(parameter);
		
		return fav;
		
		}
		
	
	
	@PostMapping("subscribe.sp")
	@ResponseBody
	public int subscribe(Favorite favor) {
		
		int result=shopService.convertFavorite(favor);
		
		return result;
	}
	
	
	@GetMapping("update.sp/{productNo}")
	public ModelAndView updateProduct(@PathVariable int productNo, ModelAndView mv) {
		
		Product p=shopService.selectProductDetail(productNo);
	
		ParameterVo parameter=ParameterVo.builder().justifying("product").number(p.getProductNo()).build();
		
		ArrayList<Category> c=shopService.selectCategory();
		ArrayList<Brand> b=shopService.selectBrand("");
		ArrayList<Attachment> atList=shopService.selectAttachmentList(parameter);
		
		mv.addObject("c",c);
		mv.addObject("b",b);
		mv.addObject("atList",atList);
		mv.addObject("p",p);
		mv.setViewName("shop/shopUpdateView");
		return mv;
	}
	
	@PostMapping("update.sp")
	public String updateProduct(Product p
							,MultipartFile[] upfile
							,HttpSession session) {
		
		boolean flag= false;
		String deleteFile= "";
		String changeName="";
		
		ParameterVo parameter=ParameterVo.builder()
				.justifying("product")
				.number(p.getProductNo())
				.build();
		
		ArrayList<Attachment> atList=shopService.selectAttachmentList(parameter);
		ArrayList<Attachment> uploadList=new ArrayList<>();
		
		for(int i=0; i<upfile.length; i++) {
		if(!upfile[i].getOriginalFilename().equals("")) {
			
			String fileType=upfile[i].getOriginalFilename();
			int index = fileType.lastIndexOf(".");
			String extension = fileType.substring( index+1 ).toLowerCase();
			String type="";
			
			
			if(extension.equals("avi")||
			   extension.equals("mov")||
			   extension.equals("mp4")||
			   extension.equals("wmv")||
			   extension.equals("asf")||
			   extension.equals("mkv")) {
				
					type="video";
					
	  }else if(extension.equals("jpeg")||
		       extension.equals("jpg")||
			   extension.equals("png")||
			   extension.equals("gif")) {
					
		  		type="image";
		  		
		  }else{
			  
					type="file";
				}
			
				
				changeName = saveFile(upfile[i],session,"productFile",type);
				
				if(atList.size()>i) {
					flag = true;
					deleteFile= "resources/uploadFiles/shopFile/productFile/"+atList.get(i).getType()+"/"+atList.get(i).getChangeName();
					if(flag) {
						File f= new File(session.getServletContext().getRealPath(deleteFile));
						f.delete();
						
						flag= false;
					}
					
				}
				
				Attachment at=Attachment.builder().
						fileLev(i).
						originName(upfile[i].getOriginalFilename()).
						changeName(changeName).
						fileJustify("product").
						filePath("/pjtMungHub/resources/uploadFiles/shopFile/productFile/"+type+"/").
						productNo(p.getProductNo()).
						type(type).
						build();
				changeName="";
				
				uploadList.add(at);
			}
		}
	    parameter.setAtList(uploadList);
		int result = shopService.updateAttachment(parameter);
		int result2 = shopService.updateProduct(p);
		
		
		
		return "redirect:/detail.sp/"+p.getProductNo();
			
	}
	
	@PostMapping("deleteAttachment.sp")
	@ResponseBody
	public int deleteAttachment(Attachment at,HttpSession session) {
		
		ParameterVo parameter= ParameterVo.builder().
				justifying("product").
				fileLev(at.getFileLev()).
				number(at.getProductNo())
				.build();
		
		Attachment target = shopService.selectAttachment(parameter);
		String deleteFile= "resources/uploadFiles/shopFile/productFile/"+target.getType()+"/"+target.getChangeName();
		
		File f= new File(session.getServletContext().getRealPath(deleteFile));
		f.delete();
		
		
		int result=shopService.deleteAttachment(parameter);
		
		return result;
	}
	
	@GetMapping("insert.sp")
	public ModelAndView shopInsertForm(ModelAndView mv) {
		
		ArrayList<Category> c=shopService.selectCategory();
		ArrayList<Brand> b=shopService.selectBrand("");
		mv.addObject("c",c);
		mv.addObject("b",b);
		mv.setViewName("shop/insertProductView");
		
		
		return mv;
	}
	
	
	@PostMapping("insert.sp")
	public ModelAndView shopInsert(Product p,
								   ModelAndView mv,
								   MultipartFile[] upfile,
								   HttpSession session) {
		ArrayList<Attachment> atList=new ArrayList<>();
	
		for(int i=0;i<upfile.length;i++) {
			
			String fileType=upfile[i].getOriginalFilename();
			int index = fileType.lastIndexOf(".");
			String extension = fileType.substring( index+1 ).toLowerCase();
			String type="";
			
			
			if(extension.equals("avi")||
			   extension.equals("mov")||
			   extension.equals("mp4")||
			   extension.equals("wmv")||
			   extension.equals("asf")||
			   extension.equals("mkv")) {
				
					type="video";
				}else if(extension.equals("jpeg")||
						 extension.equals("jpg")||
						 extension.equals("png")||
						 extension.equals("gif")) {
					type="image";
				}else {
					type="file";
				}
				
				
				String changeName = saveFile(upfile[i],session,"productFile",type);
				
				Attachment at=Attachment.builder().
						fileLev(i).
						originName(upfile[i].getOriginalFilename()).
						changeName(changeName).
						fileJustify("product").
						filePath("/pjtMungHub/resources/uploadFiles/shopFile/productFile/"+type+"/").
						type(type).
						build();
				
				atList.add(at);
			
			
		}
		
		
		ParameterVo fileParameter=ParameterVo.builder()
				.atList(atList)
				.justifying("product")
				.build();
		
		int result=shopService.insertProduct(p,fileParameter);
		
		if(result>0) {
			
			session.setAttribute("message", "등록성공");
			mv.setViewName("redirect:/list.sp");
			
			return mv;
		}else {
			for(int i=0;i<atList.size();i++) {
				String deleteFile=atList.get(i).getFilePath()+atList.get(i).getChangeName();
				new File(session.getServletContext().getRealPath(deleteFile)).delete();
			}
			session.setAttribute("message","등록실패");
			mv.setViewName("redirect:/insert.sp");
			
			return mv;
		}
		
	}
	
	@PostMapping("stopPost.sp")
	public ModelAndView stopItemPost(ModelAndView mv,
									@RequestParam int productNo,
									@RequestParam String justifying) {		
		ParameterVo parameter = ParameterVo.builder()
				.justifying(justifying)
				.productNo(productNo)
				.build();
		
		int result = shopService.stopItemPost(parameter);
		
		if(result>0) {
			mv.setViewName("redirect:/list.sp");
			return mv;
		}else {
			mv.setViewName("redirect:/shopListDetail.sp"+productNo);
			return mv;
		}
	}
	
	@GetMapping("cart.sp")
	public String cart() {
		
		return "shop/shoppingCart";
	}
	
	@ResponseBody
	@GetMapping(value="cartList.sp",produces="application/json;charset=UTF-8")
	public ArrayList<Cart> cartList(int userNo) {
		
		ArrayList<Cart> cList = shopService.selectCartList(userNo);
	
		return cList;
	}
	@ResponseBody
	@PostMapping("updateCartAmount.sp")
	public int updateCartAmount(@RequestParam int productNo
								,@RequestParam int userNo
								,@RequestParam int amount) {
						
		ParameterVo parameter = ParameterVo.builder()
				.productNo(productNo)
				.userNo(userNo)
				.amount(amount)
				.build();
		
		int result=shopService.updateCartAmount(parameter);
		
		return result;
	}
	
	@PostMapping("addCart.sp")
	@ResponseBody
	public int addCart(Cart c) {
		
		int result=shopService.addCart(c);
		
		return result;
	}
	
	@PostMapping("removeCartItem.sp")
	@ResponseBody
	public int removeCartItem(@RequestParam String[] items,@RequestParam int userNo) {
		
		ParameterVo parameter = ParameterVo.builder()
				.items(items)
				.userNo(userNo)
				.build();
		
		int result=shopService.removeCartItem(parameter);
		
		return result;
	}
	
	@GetMapping("cartCount.sp")
	@ResponseBody
	public int selectCartCount (@RequestParam int userNo) {
		
		int result=shopService.selectCartCount(userNo);
		
		return result;
	}
	
	@PostMapping("order.sp")
	public ModelAndView productOrder(ModelAndView mv ,
			@RequestParam ArrayList<Integer> chooseOrNot,
			@RequestParam int userNo) {
		Point p =shopService.selectPoint(userNo);
		
		if(p==null) {
			p=Point.builder().userNo(userNo).point(0).build();
			int pointUpdate=shopService.updatePoint(p);
		}
		
		ParameterVo parameter = ParameterVo.builder()
				.userNo(userNo)
				.checkedItem(chooseOrNot)
				.build();
		
		int totalPrice=0;
		
		ArrayList<Cart> orderList = shopService.selectCartItemList(parameter);
		String itemList="";
		String itemsNo="";
		String itemsQuantity="";
		ShipInfo shipInfo = shopService.selectShipInfo(userNo);
		for(int i=0;i<orderList.size();i++) {
			
			int price=orderList.get(i).getPrice();
			int discount=orderList.get(i).getDiscount();
			int amount=orderList.get(i).getAmount();
			
			if(i<orderList.size()-1) {
				itemList+=orderList.get(i).getProductName()+",";
				itemsNo+=orderList.get(i).getProductNo()+",";
				itemsQuantity+=orderList.get(i).getAmount()+",";
			}else {
				itemList+=orderList.get(i).getProductName(); //마지막에 추가되는 상품뒤에는 구분자 붙이지 않는 조건문
				itemsNo+=orderList.get(i).getProductNo();
				itemsQuantity+=orderList.get(i).getAmount();
			}
			
			totalPrice+=(price-(price/discount)*amount);
		}
		mv.addObject("point",p);
		mv.addObject("itemsNo",itemsNo);
		mv.addObject("itemsQuantity",itemsQuantity);
		mv.addObject("itemList",itemList);
		mv.addObject("totalPrice",totalPrice);
		mv.addObject("shipInfo",shipInfo);
		mv.addObject("orderList",orderList);
		mv.setViewName("shop/orderPage");
		return mv;
	}
	
	@PostMapping("insertOrderInfo.sp")
	@ResponseBody
	public int insertOrderInfo(POrderInfo orderInfo) {
		
		ArrayList<Product> pList=new ArrayList<>();
		int result=shopService.insertOrderInfo(orderInfo);
		String[] itemArr= orderInfo.getItems().split(",");
		String[] itemQuantityArr=orderInfo.getItemsQuantity().split(",");
		for (int i = 0; i < itemArr.length; i++) {
			Product p =shopService.selectProductDetail(Integer.parseInt(itemArr[i]));
			p.setQuantity(Integer.parseInt(itemQuantityArr[i]));
			pList.add(p);
		}
		int result2=shopService.updateSalesCount(pList);
		
		
		return result;
	}
	
	@GetMapping("orderConfirm/{merchantUid}")
	public ModelAndView orderConfirm(@PathVariable String merchantUid,ModelAndView mv) {
		
		POrderInfo orderInfo = shopService.selectOrder(merchantUid);
		
		String itemList =orderInfo.getItems();
		String itemQuantity =orderInfo.getItemsQuantity();
		
		String[] itemListArr = itemList.split(",");
		String[] itemQuantityArr = itemQuantity.split(",");
		ArrayList<Product> pList=new ArrayList<>();
		for (int i = 0; i < itemListArr.length; i++) {
			int productNo=Integer.parseInt(itemListArr[i]);
			Product p = shopService.selectProductDetail(productNo);
			p.setQuantity(Integer.parseInt(itemQuantityArr[i]));
			pList.add(p);
		}
		
		mv.addObject("pList",pList);
		mv.addObject("orderInfo",orderInfo);
		mv.setViewName("shop/orderConfirm");
		
		return mv;
	}
	
	@GetMapping("orderList/{userNo}")
	public ModelAndView orderInfoList(ModelAndView mv,@PathVariable int userNo) {
		
		ArrayList<POrderInfo> orderList = shopService.selectOrderList(userNo);
		
		mv.addObject("orderList",orderList);
		mv.setViewName("shop/orderList");
		return mv;
	}
	@GetMapping("orderDetail/{merchantUid}")
	public ModelAndView orderInfoDetail(ModelAndView mv,@PathVariable String merchantUid) {
		
		POrderInfo order = shopService.selectOrder(merchantUid);
		
		String[] items=order.getItems().split(",");
		String[] itemQuantity=order.getItemsQuantity().split(",");
		
		ArrayList<Product> itemList=new ArrayList<>();
		
		for(int i=0;i< items.length;i++) {
			int item=Integer.parseInt(items[i]);
			
			Product p=shopService.selectProductDetail(item);
			
			itemList.add(p);
		}
		
		mv.addObject("itemList",itemList);
		mv.addObject("itemQuantity",itemQuantity);
		mv.addObject("order",order);
		mv.setViewName("shop/orderDetail");
		
		return mv;
	}
	
	@PostMapping("insertShipInfo.sp")
	@ResponseBody
	public int insertShipInfo(ShipInfo s) {
		
		int result = shopService.insertShipInfo(s);
		
		return result;
	}
	
	@GetMapping("selectShipInfoList.sp")
	@ResponseBody
	public ArrayList<ShipInfo> selectShipInfoList(@RequestParam int userNo){
		
		ArrayList<ShipInfo> sList = shopService.selectShipInfoList(userNo);
		
		return sList;
	}
	
	@PostMapping("changeShipInfo.sp")
	@ResponseBody
	public int changeShipInfo(ShipInfo s) {
		
		int result =shopService.changeShipInfo(s);
		
		return result;
	}
	
	@PostMapping("removeShipInfo.sp")
	@ResponseBody
	public int removeShipInfo(ShipInfo s) {
		
		int result =shopService.removeShipInfo(s);
		
		return result;
	}
	
	@GetMapping("selectReivew.sp")
	@ResponseBody
	public Review selectReivew(Review r) {
		
		Review result=shopService.selectReview(r);
		
		return result;
	}
	
	@PostMapping("insertReview.sp")
	@ResponseBody
	public int insertReview(@RequestPart(value="review")Review review,
							@RequestPart(value="uploadFile",required=false) MultipartFile[] upfile,
							HttpSession session) {
		ArrayList<Attachment> atList=new ArrayList<>();
		Attachment at=new Attachment();
		
		if(upfile!=null) {
		for (int i=0;i< upfile.length;i++) {
			
		
				
				String fileType=upfile[i].getOriginalFilename();
				int index = fileType.lastIndexOf(".");
				String extension = fileType.substring( index+1 ).toLowerCase();
				String type="";
				
				if(extension.equals("avi")||
				   extension.equals("mov")||
				   extension.equals("mp4")||
				   extension.equals("wmv")||
				   extension.equals("asf")||
				   extension.equals("mkv")) {
							
				   type="video";
				   
		  }else if(extension.equals("jpeg")||
				   extension.equals("jpg")||
				   extension.equals("png")||
				   extension.equals("gif")) {
			  
				   type="image";
		     }else{
			       type="file";
			}
				
				String changeName = saveFile(upfile[i],session,"reviewFile",type);
				
				at=Attachment.builder().
						fileLev(0).
						originName(upfile[i].getOriginalFilename()).
						changeName(changeName).
						fileJustify("review").
						filePath("/pjtMungHub/resources/uploadFiles/shopFile/reviewFile/"+type+"/").
						type(review.getType()).
						build();
				
				atList.add(at);
			}
			
			
			
		}
		ParameterVo fileParameter=ParameterVo.builder()
				.atList(atList)
				.justifying("review")
				.build();
		
		int result=shopService.insertReview(review,fileParameter);
		
		Point point= Point.builder().userNo(review.getUserNo()).point(150).build();
		int pointUpdate=shopService.updatePoint(point);
				
		return result;
	}
	
	@PostMapping("updateReview.sp")
	@ResponseBody
	public int updateReview(@RequestPart(value="review")Review review,
							@RequestPart(value="uploadFile",required=false) MultipartFile[] upfile,
							HttpSession session) {
		
		ArrayList<Attachment> atList=new ArrayList<>();
		Attachment at=new Attachment();
		
		ParameterVo parameter=ParameterVo.builder()
				.justifying("review")
				.number(review.getReviewNo())
				.build();
		ArrayList<Attachment> deleteAtList=shopService.selectAttachmentList(parameter);
		for (int i = 0; i < deleteAtList.size(); i++) {
			String deleteFile= "resources/uploadFiles/shopFile/reviewFile/"+deleteAtList.get(i).getType()+"/"+deleteAtList.get(i).getChangeName();
			File f=new File(session.getServletContext().getRealPath(deleteFile));
			f.delete();
			parameter.setFileLev(i);
			shopService.deleteAttachment(parameter);
		}
		
		if(upfile!=null) {
		for (int i=0;i< upfile.length;i++) {
			
		
				
				String fileType=upfile[i].getOriginalFilename();
				int index = fileType.lastIndexOf(".");
				String extension = fileType.substring( index+1 ).toLowerCase();
				String type="";
				
				if(extension.equals("avi")||
				   extension.equals("mov")||
				   extension.equals("mp4")||
				   extension.equals("wmv")||
				   extension.equals("asf")||
				   extension.equals("mkv")) {
							
				   type="video";
				   
		  }else if(extension.equals("jpeg")||
				   extension.equals("jpg")||
				   extension.equals("png")||
				   extension.equals("gif")) {
			  
				   type="image";
		     }else{
			       type="file";
			}
				
				String changeName = saveFile(upfile[i],session,"reviewFile",type);
				
				at=Attachment.builder().
						fileLev(0).
						originName(upfile[i].getOriginalFilename()).
						changeName(changeName).
						fileJustify("review").
						filePath("/pjtMungHub/resources/uploadFiles/shopFile/reviewFile/"+type+"/").
						type(review.getType()).
						build();
				atList.add(at);
			}
			
			
			
		}
		ParameterVo fileParameter=ParameterVo.builder()
				.atList(atList)
				.justifying("review")
				.number(review.getReviewNo())
				.build();
		
		int result=shopService.updateReview(review,fileParameter);
		
		
		return result;
	}
	
	@GetMapping("reviewListAll.sp/{productNo}")
	public ModelAndView selectReviewListAll(ModelAndView mv
								,@PathVariable int productNo
								,@RequestParam(value="currentPage", 
									    required = false, defaultValue="1")
										int currentPage) {
		
		int listCount=shopService.selectReviewCount(productNo);
		int pageLimit=10;
		int boardLimit= 20;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		
		Product p=shopService.selectProductDetail(productNo);
		p.setReviewCount(shopService.selectReviewCount(productNo));
		p.setReviewTScore((double)shopService.selectScoreAvg(productNo));
		ArrayList<ScorePercent> percent=shopService.selectScorePercent(productNo);
		mv.addObject("pi",pi);
		mv.addObject("currentPage",currentPage);
		mv.addObject("percent",percent);
		mv.addObject("p",p);
		mv.setViewName("shop/selectReviewAll");
		
		return mv;
	}
	
	
	@SuppressWarnings("unchecked")
	@GetMapping("reviewList.sp")
	@ResponseBody
	public JSONArray selectReviewList(ParameterVo param) {
		
		if(param.getCurrentPage()!=0) {
			
			int listCount=shopService.selectReviewCount(param.getProductNo());
			int pageLimit=10;
			int boardLimit= 20;
			
			PageInfo pi = Pagination.getPageInfo(listCount, param.getCurrentPage(), pageLimit, boardLimit);
			
			param.setPi(pi);
		}
		
		ArrayList<Review> rList=shopService.selectReviewList(param);
		
		JSONArray reviewJArr=new JSONArray();
		
		for (int i = 0; i < rList.size(); i++) {
			ParameterVo parameter2=ParameterVo.builder()
					.justifying("review")
					.number(rList.get(i).getReviewNo())
					.build();
			ArrayList<Attachment> atList= shopService.selectAttachmentList(parameter2);
			
			JSONObject jobj=new JSONObject();
			jobj.put("atList", atList);
			jobj.put("reviewNo", rList.get(i).getReviewNo());
			jobj.put("reviewContent", rList.get(i).getReviewContent());
			jobj.put("userNo", rList.get(i).getUserNo());
			jobj.put("userName", rList.get(i).getUserName());
			jobj.put("productNo", rList.get(i).getProductNo());
			jobj.put("createDate", rList.get(i).getCreateDate());
			jobj.put("likeCount", rList.get(i).getLikeCount());
			jobj.put("score", rList.get(i).getScore());
			
			reviewJArr.add(jobj);
			
		}
		return reviewJArr;
	}
	
	
	@GetMapping("selectReviewCount.sp")
	@ResponseBody
	public int selectReviewCount(int productNo) {
		int result=shopService.selectReviewCount(productNo);
		return result;
	}
	
	@GetMapping("reviewReplyList.sp")
	@ResponseBody
	public ArrayList<ReviewReply> selectReviewReplyList(int reviewNo) {
		
		ArrayList<ReviewReply> rList = shopService.selectReviewReplyList(reviewNo);
		
		if(!rList.isEmpty()) {
			
			return rList;
		}else {
			return null;
		}
	}
	
	@PostMapping("insertReviewReply.sp")
	@ResponseBody
	public int insertReviewReply(ReviewReply reply) {
		
		
		int result=shopService.insertReviewReply(reply);
		
		return result;
	}
	
	@PostMapping("deleteReply.sp")
	@ResponseBody
	public int deleteReply(int replyNo) {
		
		int result=shopService.deleteReply(replyNo);
		
		return result;
	}
	
	@PostMapping("reviewLike.sp")
	@ResponseBody
	public int reviewLike(Review r) {
		
		int result=shopService.reviewLike(r);
		
		
		int likeCount=shopService.selectLikeCount(r);
		
		return likeCount;
	}
	
	
	@SuppressWarnings("unchecked")
	@GetMapping("questionList.sp")
	@ResponseBody
	public JSONObject selectQuestionList(int productNo,int currentPage){
		
		int listCount=shopService.selectQuestionCount(productNo);
		int pageLimit=10;
		int boardLimit= 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Question> qList=shopService.selectQuestionList(productNo,pi);
		
		
		Answer answer=new Answer(); 
		for (int i = 0; i < qList.size(); i++) {
			answer=shopService.selectAnswer(qList.get(i).getQuestionNo());
			if(answer!=null) {
				qList.get(i).setAnswerStatus("Y");
			}else {
				qList.get(i).setAnswerStatus("N");
			}
		}
		
		
		JSONObject jobj=new JSONObject();
		
		
		jobj.put("qList", qList);
		jobj.put("pi", pi);
		
		return jobj;
	}
	
	@GetMapping("qnaPage.sp/{questionNo}")
	public ModelAndView qnaPage(ModelAndView mv,@PathVariable int questionNo) {
		
		Question q=shopService.selectQuestionDetail(questionNo);
		Answer a =shopService.selectAnswer(questionNo);
		
		mv.addObject("q",q);
		mv.addObject("a",a);
		mv.setViewName("shop/qnaPage");
		return mv;
	}
	
	@PostMapping("insertQuestion.sp")
	@ResponseBody
	public int insertQuestion(Question q) {
		
		int result=shopService.insertQuestion(q);
		
		
		return result;
	}
	
	@PostMapping("updatePoint.sp")
	@ResponseBody
	public int updatePoint(Point p) {
		int result=shopService.updatePoint(p);
		return result;
	}
	
	
	
	@GetMapping("adminPage/dashBoard")
	public ModelAndView adminPage(ModelAndView mv) {
		
		Calendar now = Calendar.getInstance();
		int year = now.get(Calendar.YEAR);
		String startDate = Integer.toString(year)+"-01-01";
		String endDate = Integer.toString(year)+"-12-31";
		HashMap<String, String> map=new HashMap<>();
		map.put("start", startDate);
		map.put("end", endDate);
		MonthlyTally Mon=shopService.selectMonthlyTally(map);
		MonthlyTally MonCount=shopService.selectMonthlyTallyCount(map);
		mv.addObject("month",Mon);
		mv.addObject("monthCount",MonCount);
		mv.setViewName("shop/adminPage");
		return mv;
	}
	
	@GetMapping("adminPage/orderControll")
	public ModelAndView orderControll(ModelAndView mv) {
		
		mv.setViewName("shop/orderController");
		return mv;
	}
	
	
	@SuppressWarnings("unchecked")
	@GetMapping("selectOrderInfoList.sp")
	@ResponseBody
	public JSONObject selectOrderInfo(String category,int currentPage) {
		
		int allListCount=shopService.selectOrderCount("전체");
		int prepareListCount=shopService.selectOrderCount("상품준비중");
		int ongoingListCount=shopService.selectOrderCount("배송중");
		int completeListCount=shopService.selectOrderCount("배송완료");
		int cancelListCount=shopService.selectOrderCount("취소");
		int exchangeListCount=shopService.selectOrderCount("교환");
		int recallListCount=shopService.selectOrderCount("환불");
		
		
		
		int listCount=shopService.selectOrderCount(category);
		int pageLimit=10;
		int boardLimit= 30;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		
		ArrayList<POrderInfo> oList=shopService.selectOrderListControll(category,pi);
		
		
		
		
		if(!oList.isEmpty()) {
			int [] itemsArr=null;
			int [] itemsQuantityArr=null;
		for (int i = 0; i < oList.size(); i++) {
			String[] items=oList.get(i).getItems().split(",");
			String[] itemsQuantity=oList.get(i).getItemsQuantity().split(",");
			ArrayList<Product> pList=new ArrayList<>();

			itemsArr= Arrays.stream(items)
							.mapToInt(Integer::parseInt)
							.toArray();		
			itemsQuantityArr=Arrays.stream(itemsQuantity)
									.mapToInt(Integer::parseInt)
									.toArray();
			
			oList.get(i).setItemsArr(itemsArr);
			oList.get(i).setItemsQuantityArr(itemsQuantityArr);
		
			for(int k=0; k<itemsArr.length;k++) {
				Product p=shopService.selectProductDetail(itemsArr[k]);
				pList.add(p);
			}
			oList.get(i).setPList(pList);
		}
	
		
		}
		
		
	
		
		JSONObject jobj=new JSONObject();
		
		jobj.put("pi",pi);
		jobj.put("oList", oList);
		jobj.put("total", allListCount);
		jobj.put("prepare", prepareListCount);
		jobj.put("ongoing", ongoingListCount);
		jobj.put("complete", completeListCount);
		jobj.put("cancel", cancelListCount);
		jobj.put("exchange", exchangeListCount);
		jobj.put("recall", recallListCount);
		return jobj;
	}
	
	@PostMapping("convertProcess.sp")
	@ResponseBody
	public int convertOrderProcess(POrderInfo p) {
		
		int result=shopService.convertOrderProcess(p);
		
		return result;
	}
	
	
	
	@GetMapping("adminPage/productControll")
	public ModelAndView productControll(ModelAndView mv) {
		
		mv.setViewName("shop/productController");
		return mv;
	}
	
	@SuppressWarnings("unchecked")
	@GetMapping("selectTopSalesProduct.sp")
	@ResponseBody
	public JSONObject selectTopSalesProduct(){
		ArrayList<Product> highList=shopService.selectTopSalesProduct("highest");
		ArrayList<Product> lowList=shopService.selectTopSalesProduct("lowest");
		ArrayList<Product> highSalList=shopService.selectTopSalesProduct("highestSal");
		ArrayList<Product> lowSalList=shopService.selectTopSalesProduct("lowestSal");
		JSONObject jobj=new JSONObject();
		
		jobj.put("pList", highList);
		jobj.put("lowList", lowList);
		jobj.put("highSal", highSalList);
		jobj.put("lowSal", lowSalList);
		
		return jobj;
	}
	
	@SuppressWarnings("unchecked")
	@GetMapping("selectTopSalesBrand.sp")
	@ResponseBody
	public JSONObject selectTopSalesBrand(){
		
		ArrayList<Brand> highList=shopService.selectTopSalesBrand("highest");
		ArrayList<Brand> lowList=shopService.selectTopSalesBrand("lowest");
		ArrayList<Brand> highSalList=shopService.selectTopSalesBrand("highestSal");
		ArrayList<Brand> lowSalList=shopService.selectTopSalesBrand("lowestSal");
		JSONObject jobj=new JSONObject();
		
		jobj.put("pList", highList);
		jobj.put("lowList", lowList);
		jobj.put("highSal", highSalList);
		jobj.put("lowSal", lowSalList);
		
		
		return jobj;
	}
	
	@GetMapping("brandList.sp")
	@ResponseBody
	public ArrayList<Brand> selectBrandList(String orderBy){
		
		ArrayList<Brand> bList=shopService.selectBrand(orderBy);
		return bList;
	}
	
	@PostMapping("insertBrand.sp")
	@ResponseBody
	public int insertBrand(@RequestPart(value="upfile")MultipartFile upfile,
			@RequestPart(value="brandName") Brand brandName,
			HttpSession session) {
		
		String changeName=saveFile(upfile, session, "brandLogo", "image");
		
		ArrayList<Attachment> atList=new ArrayList<>();
		Attachment at=new Attachment();
		at=Attachment.builder().
				fileLev(0).
				originName(upfile.getOriginalFilename()).
				changeName(changeName).
				fileJustify("brand").
				filePath("/pjtMungHub/resources/uploadFiles/shopFile/brandLogo/image/").
				type("image").
				build();
		
		atList.add(at);
		
		
		ParameterVo fileParameter=ParameterVo.builder()
				.atList(atList)
				.justifying("brand")
				.build();
		int result=shopService.insertBrand(brandName.getBrandName(),fileParameter);
		
		return result;
	}
	
	@PostMapping("updateBrand.sp")
	@ResponseBody
	public int updateBrand(@RequestPart(value="upfile",required=false)MultipartFile upfile,
			@RequestPart(value="brand") Brand brand,
			HttpSession session) {
		
		Attachment at=new Attachment();
		ArrayList<Attachment> atList=new ArrayList<>();
		if(upfile!=null) {
			
			ParameterVo parameter= ParameterVo.builder().
					justifying("brand").
					fileLev(0).
					number(brand.getBrandCode())
					.build();
			
			at=shopService.selectAttachment(parameter);
			
			String deleteFile= "resources/uploadFiles/shopFile/brandLogo/"+at.getType()+"/"+at.getChangeName();
			File f= new File(session.getServletContext().getRealPath(deleteFile));
			f.delete();
			
			
			String changeName=saveFile(upfile, session, "brandLogo", "image");
			
			at=Attachment.builder().
					fileLev(0).
					originName(upfile.getOriginalFilename()).
					changeName(changeName).
					fileJustify("brand").
					filePath("/pjtMungHub/resources/uploadFiles/shopFile/brandLogo/image/").
					type("image").
					build();
			
			atList.add(at);
		}
		
		
		
		ParameterVo fileParameter=ParameterVo.builder()
				.atList(atList)
				.justifying("brand")
				.number(brand.getBrandCode())
				.build();
		int result=shopService.updateBrand(brand,fileParameter);
		
		return result;
	}
	
	
	
	@GetMapping("selectBrandOne.sp")
	@ResponseBody
	public Brand selectBrandOne(int brandCode) {
		Brand b=shopService.selectBrandOne(brandCode);
		
		return b;
	}
	
	@GetMapping("selectCategory.sp")
	@ResponseBody
	public ArrayList<Category> selectCategory(){
		
		ArrayList<Category> cList=shopService.selectCategory();
		return cList;
	}
	
	@PostMapping("insertCategory.sp")
	@ResponseBody
	public int insertCategory(String categoryName) {
		int result=shopService.insertCategory(categoryName);
		return result;
	}
	
	@PostMapping("updateCategory.sp")
	@ResponseBody
	public int updateCategory(Category c) {
		int result=shopService.updateCategory(c);
		return result;
	}
	@PostMapping("deleteCategory.sp")
	@ResponseBody
	public int deleteCategory(int categoryNo) {
		int result=shopService.deleteCategory(categoryNo);
		
		return result;
	}
	@SuppressWarnings("unchecked")
	@GetMapping("productList.sp")
	@ResponseBody
	public JSONObject selectProductListControll(String orderBy,String justifying,int currentPage,int categoryNo){
		
		
		ParameterVo parameter=new ParameterVo();
		
		parameter.setJustifying(justifying);
		parameter.setOrderBy(orderBy);
		parameter.setCategoryNo(categoryNo);
		
		int listCount=shopService.selectProductCount(parameter);
		int pageLimit=10;
		int boardLimit= 20;
		
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

		ArrayList<Product> pList=shopService.selectProductListControll(parameter,pi);
		
		JSONObject jobj=new JSONObject();
		
		jobj.put("pList", pList);
		jobj.put("pi", pi);
		
		return jobj;
	}
	
	@PostMapping("convertProductPost.sp")
	@ResponseBody
	public int convertProductPost(int productNo,String justifying) {
		
		ParameterVo parameter = ParameterVo.builder()
				.justifying(justifying)
				.productNo(productNo)
				.build();
		
		
		
		int result=shopService.stopItemPost(parameter);
		
		return result;
	}
	
	@GetMapping("adminPage/customerControll")
	public ModelAndView customerControll(ModelAndView mv) {
		
		mv.setViewName("shop/customerController");
		return mv;
	}
	
	
	@GetMapping("adminPage/eventControll")
	public ModelAndView eventControll(ModelAndView mv) {
		
		mv.setViewName("shop/eventControll");
		return mv;
	}
	
	
	@GetMapping("TopBuyer.sp")
	@ResponseBody
	public ArrayList<Customer> selectTopBuyer(){
		ArrayList<Customer> cList=shopService.selectTopBuyer();
		return cList;
	}
	
	@GetMapping("TopSpenders.sp")
	@ResponseBody
	public ArrayList<Customer> selectTopSpenders(){
		ArrayList<Customer> cList=shopService.selectTopSpenders();
		return cList;
	}
	@GetMapping("customerList.sp")
	@ResponseBody
	public ArrayList<Customer> selectCustomerList(){
		ArrayList<Customer> cList=shopService.selectCustomerList();
		return cList;
	}
	@GetMapping("inquiryList.sp")
	@ResponseBody
	public ArrayList<Question> selectInquiryList(){
		ArrayList<Question> qList=shopService.selectQuestionListControll();
		return qList;
	}
	
	@GetMapping("selectUserQuestion.sp")
	@ResponseBody
	public ArrayList<Question> selectUserQuestion(int userNo){
		
		ArrayList<Question> qList=shopService.selectQuestionListUser(userNo);
		
		return qList;
	}
	
	@GetMapping("selectInquiry.sp")
	@ResponseBody
	public Question selectInquiry(int questionNo) {
		Question q=shopService.selectQuestionDetail(questionNo);
		
		return q;
	}
	
	@PostMapping("replyInquiry.sp")
	@ResponseBody
	public int replyInquiry(Answer a) {
		
		int result=shopService.replyInquiry(a);
		
		return result;
	}
	
	@GetMapping("selectMainSlide.sp")
	@ResponseBody
	public ArrayList<Attachment> selectMainSlide(){
		
		ArrayList<Attachment> aList=shopService.selectMainSlide();
		
		return aList;
	}
	
	
	@PostMapping("insertMainSlide.sp")
	public String insertMainSlide(MultipartFile[] upfile,HttpSession session) {
		
		
		ParameterVo parameter=ParameterVo.builder()
				.justifying("main")
				.build();
		
		ArrayList<Attachment> atList=shopService.selectAttachmentList(parameter);
		
		for(int i=0;i<atList.size();i++) {
			String deleteFile= "resources/uploadFiles/shopFile/main/"+atList.get(i).getType()+"/"+atList.get(i).getChangeName();
			File f= new File(session.getServletContext().getRealPath(deleteFile));
			f.delete();
		}
		
		atList=new ArrayList<>();
		for(int i=0;i<upfile.length;i++) {
			
			String fileType=upfile[i].getOriginalFilename();
			int index = fileType.lastIndexOf(".");
			String extension = fileType.substring( index+1 ).toLowerCase();
			String type="";
			
			
			if(extension.equals("avi")||
			   extension.equals("mov")||
			   extension.equals("mp4")||
			   extension.equals("wmv")||
			   extension.equals("asf")||
			   extension.equals("mkv")) {
				
					type="video";
				}else if(extension.equals("jpeg")||
						 extension.equals("jpg")||
						 extension.equals("png")||
						 extension.equals("gif")) {
					type="image";
				}else {
					type="file";
				}
				
				
				String changeName = saveFile(upfile[i],session,"main",type);
				
				Attachment at=Attachment.builder().
						fileLev(i).
						originName(upfile[i].getOriginalFilename()).
						changeName(changeName).
						fileJustify("main").
						filePath("/pjtMungHub/resources/uploadFiles/shopFile/main/"+type+"/").
						type(type).
						build();
				
				atList.add(at);
			
			
		}
		
		
		ParameterVo fileParameter=ParameterVo.builder()
				.atList(atList)
				.justifying("main")
				.build();
		
		int result=shopService.insertMain(fileParameter);
		
		
		return "redirect:list.sp";
	}
	
	
	public String saveFile(MultipartFile upfile
						  ,HttpSession session
						  ,String category
						  ,String type) {
		
		String originName = upfile.getOriginalFilename();
		String currentTime= new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		String ext=originName.substring(originName.lastIndexOf("."));
		int ranNum=(int)(Math.random()*90000+10000);
		String changeName = currentTime+ranNum+ext;
		String savePath= session.getServletContext().getRealPath("/resources/uploadFiles/shopFile/"+category+"/"+type+"/");
		
		try {
			upfile.transferTo(new File(savePath+changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return changeName;
		
	}
	
	
	
	
}
