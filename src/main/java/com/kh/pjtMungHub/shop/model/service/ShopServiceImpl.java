package com.kh.pjtMungHub.shop.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.pjtMungHub.common.model.vo.PageInfo;
import com.kh.pjtMungHub.shop.model.dao.ShopDao;
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

@Service
public class ShopServiceImpl implements ShopService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ShopDao shopDao;
	
	@Override
	public ArrayList<Product> selectProductList(String status) {
		
		return shopDao.selectProductList(sqlSession,status);
	}

	@Override
	public Product selectProductDetail(int productNo) {
		// TODO Auto-generated method stub
		return shopDao.selectProductDetail(sqlSession,productNo);
	}

	@Override
	public ArrayList<Category> selectCategory() {
		// TODO Auto-generated method stub
		return shopDao.selectCategory(sqlSession);
	}
	
	@Override
	public ArrayList<Brand> selectBrand(String orderBy) {
		// TODO Auto-generated method stub
		return shopDao.selectBrand(sqlSession,orderBy);
	}


	@Override
	@Transactional
	public int insertProduct(Product p, ParameterVo fileParameter) {

		int result=shopDao.insertProduct(sqlSession, p);
		
		int result2=shopDao.insertAttachment(sqlSession, fileParameter);
		
		return result*result2;
	}

	@Override
	public int addCart(Cart c) {
		// TODO Auto-generated method stub
		return shopDao.addCart(sqlSession,c);
	}

	@Override
	public ArrayList<Cart> selectCartList(int userNo) {
		// TODO Auto-generated method stub
		return shopDao.selectCartList(sqlSession,userNo);
	}

	@Override
	public int removeCartItem(ParameterVo parameter) {
		// TODO Auto-generated method stub
		return shopDao.removeCartItem(sqlSession,parameter);
	}

	@Override
	public int updateCartAmount(ParameterVo parameter) {
		// TODO Auto-generated method stub
		return shopDao.updateCartAmount(sqlSession,parameter);
	}

	@Override
	@Transactional
	public int insertShipInfo(ShipInfo s) {
		// TODO Auto-generated method stub
		
		int result1= shopDao.chooseShipInfo(sqlSession,s);
		int result2 = shopDao.insertShipInfo(sqlSession,s);
		return result1*result2;
	}

	@Override
	public ArrayList<ShipInfo> selectShipInfoList(int userNo) {
		// TODO Auto-generated method stub
		return shopDao.selectShipInfoList(sqlSession,userNo);
	}



	@Override
	public ArrayList<Cart> selectCartItemList(ParameterVo parameter) {
		// TODO Auto-generated method stub
		return shopDao.selectCartItemList(sqlSession,parameter);
	}

	@Override
	public ShipInfo selectShipInfo(int userNo) {
		// TODO Auto-generated method stub
		return shopDao.selectShipInfo(sqlSession, userNo);
	}

	@Override
	public POrderInfo selectOrder(String merchantUid) {
		// TODO Auto-generated method stub
		return shopDao.selectOrder(sqlSession, merchantUid);
	}

	@Override
	@Transactional
	public int insertOrderInfo(POrderInfo orderInfo) {
		
		int result = shopDao.insertOrderInfo(sqlSession,orderInfo);
		
		ParameterVo parameter =ParameterVo.builder().
				items(orderInfo.getItems().split(",")).
				userNo(orderInfo.getUserNo()).
				build();
		
		int result2= shopDao.removeCartItem(sqlSession, parameter);
		
		return result*result2;
	}

	@Override
	public ArrayList<POrderInfo> selectOrderList(int userNo) {
		// TODO Auto-generated method stub
		return shopDao.selectOrderList(sqlSession,userNo);
	}

	@Override
	public int removeShipInfo(ShipInfo s) {
		// TODO Auto-generated method stub
		
		int result=shopDao.removeShipInfo(sqlSession, s);
		
		
		ShipInfo s2=shopDao.selectShipInfo2(sqlSession, s.getUserNo());
			
		int result2=shopDao.changeShipInfo(sqlSession, s2);
		return result*result2;	
				
	}
	
	@Override
	public int changeShipInfo(ShipInfo s) {
		// TODO Auto-generated method stub
		return shopDao.changeShipInfo(sqlSession,s);
	}

	@Override
	public int selectCartCount(int userNo) {
		// TODO Auto-generated method stub
		Integer result=shopDao.selectCartCount(sqlSession,userNo);
		if(result!=null) {
			return result;
		}else {
			return 0;
		}
	}

	@Override
	public int stopItemPost(ParameterVo paremeter) {
		// TODO Auto-generated method stub
		return shopDao.stopItemPost(sqlSession,paremeter);
	}

	@Override
	public ArrayList<Attachment> selectAttachmentList(ParameterVo parameter) {
		// TODO Auto-generated method stub
		return shopDao.selectAttachmentList(sqlSession,parameter);
	}

	@Override
	public int deleteProductData(int productNo) {
		// TODO Auto-generated method stub
		return shopDao.deleteProductData(productNo,sqlSession);
	}

	@Override
	public int updateAttachment(ParameterVo parameter) {
		// TODO Auto-generated method stub
		return shopDao.updateAttachment(sqlSession,parameter);
	}

	@Override
	public int updateProduct(Product p) {
		// TODO Auto-generated method stub
		return shopDao.updateProduct(sqlSession,p);
	}

	@Override
	@Transactional
	public int deleteAttachment(ParameterVo parameter) {
		int result = shopDao.deleteAttachment(sqlSession, parameter);
		int result2= shopDao.rearrangeAttachment(sqlSession,parameter);
		return result*result2;
	}

	@Override
	public Favorite selectFavorite(ParameterVo parameter) {
		// TODO Auto-generated method stub
		return shopDao.selectFavorite(parameter,sqlSession);
	}

	@Override
	public int convertFavorite(Favorite favor) {
		// TODO Auto-generated method stub
		return shopDao.convertFavorite(favor,sqlSession);
	}

	@Override
	@Transactional
	public int insertReview(Review review, ParameterVo fileParameter) {
		// TODO Auto-generated method stub
		int result2=1;
		int result=shopDao.insertReview(sqlSession, review);
		if(!fileParameter.getAtList().isEmpty()) {
			
			result2=shopDao.insertAttachment(sqlSession, fileParameter);
		}
		return result*result2;
	}
	
	@Override
	@Transactional
	public int updateReview(Review review, ParameterVo fileParameter) {
		// TODO Auto-generated method stub
		int result2=1;
		int result=shopDao.updateReview(sqlSession,review);
		if(!fileParameter.getAtList().isEmpty()) {
			result2=shopDao.updateAttachment(sqlSession, fileParameter);
		}
		return result*result2;
	}

	@Override
	public int selectReviewCount(int productNo) {
		// TODO Auto-generated method stub
		Integer result= shopDao.selectReviewCount(sqlSession,productNo);
		
		if(result==null) {
			result=0;
		}
		
		
		return result;
	}

	@Override
	public ArrayList<ScorePercent> selectScorePercent(int productNo) {
		// TODO Auto-generated method stub
		return shopDao.selectScorePercent(sqlSession,productNo);
	}

	@Override
	public double selectScoreAvg(int productNo) {
		// TODO Auto-generated method stub
		return shopDao.selectScoreAvg(sqlSession,productNo);
	}

	@Override
	public ArrayList<Review> selectReviewList(ParameterVo parameter2) {
		// TODO Auto-generated method stub
		return shopDao.selectReviewList(sqlSession,parameter2);
	}

	@Override
	public Attachment selectAttachment(ParameterVo parameter) {
		// TODO Auto-generated method stub
		return shopDao.selectAttachment(sqlSession,parameter);
	}

	@Override
	public ArrayList<Favorite> selectFavoriteList(ParameterVo parameter) {
		// TODO Auto-generated method stub
		return shopDao.selectFavoriteList(parameter, sqlSession);
	}

	@Override
	@Transactional
	public int updateSalesCount(ArrayList<Product> pList) {
		// TODO Auto-generated method stub
		int result=shopDao.updateSalesCount(pList,sqlSession);
		ArrayList<Brand> bList=shopDao.selectBrand(sqlSession,"");
		int result2=shopDao.updateBrandSalesCount(sqlSession,bList);
		int result3=shopDao.updateBrandSales(sqlSession, bList);
		
		return result*result2*result3;
	}

	@Override
	public ArrayList<ReviewReply> selectReviewReplyList(int reviewNo) {
		// TODO Auto-generated method stub
		return shopDao.selectReviewReplyList(reviewNo,sqlSession);
	}

	@Override
	public int insertReviewReply(ReviewReply reply) {
		// TODO Auto-generated method stub
		return shopDao.insertReviewReply(sqlSession,reply);
	}

	@Override
	public int deleteReply(int replyNo) {
		// TODO Auto-generated method stub
		return shopDao.deleteReply(sqlSession,replyNo);
	}

	@Override
	@Transactional
	public int reviewLike(Review r) {
		// TODO Auto-generated method stub
		int result=shopDao.reviewLike(sqlSession,r);
		int deleteN=shopDao.deleteLike(sqlSession);
		Integer count=shopDao.selectLikeCount(sqlSession, r);
		if(count!=null) {
			r.setLikeCount(count);
		}else {
			r.setLikeCount(0);
		}
		int updateLikeCount=shopDao.updateLikeCount(sqlSession,r);
		return result*deleteN*updateLikeCount;
	}

	@Override
	public int selectLikeCount(Review r) {
		// TODO Auto-generated method stub
		Integer count=shopDao.selectLikeCount(sqlSession,r);
		if(count==null) {
			count=0;
		}
		return count;
	}

	@Override
	public ArrayList<Category> selectQuestionCategory() {
		// TODO Auto-generated method stub
		return shopDao.selectQuestionCategory(sqlSession);
	}

	@Override
	public ArrayList<Question> selectQuestionList(int productNo,PageInfo pi) {
		// TODO Auto-generated method stub
		return shopDao.selectQuestionList(sqlSession,productNo,pi);
	}

	@Override
	public int selectQuestionCount(int productNo) {
		// TODO Auto-generated method stub
		Integer count=shopDao.selectQuestionCount(sqlSession,productNo);
		if(count!=null) {
			return count;
		}else {
			
			return 0;
		}
		
	}

	@Override
	public Answer selectAnswer(int questionNo) {
		// TODO Auto-generated method stub
		Answer result=shopDao.selectAnswer(sqlSession,questionNo);
		if(result!=null) {
		int update=shopDao.updateQuestionStatus(sqlSession,questionNo);
		}
		return result;
	}

	@Override
	public Question selectQuestionDetail(int questionNo) {
		// TODO Auto-generated method stub
		return shopDao.selectQuestionDetail(sqlSession, questionNo);
	}

	@Override
	public int insertQuestion(Question q) {
		// TODO Auto-generated method stub
		return shopDao.insertQuestion(sqlSession,q);
	}

	@Override
	public Review selectReview(Review r) {
		// TODO Auto-generated method stub
		return shopDao.selectReview(sqlSession, r);
	}

	@Override
	public int updatePoint(Point point) {
		// TODO Auto-generated method stub
		return shopDao.updatePoint(sqlSession,point);
	}

	@Override
	public Point selectPoint(int userNo) {
		// TODO Auto-generated method stub
		return shopDao.selectPoint(sqlSession,userNo);
	}

	@Override
	public ProductDetail selectProdcutInfo(int productNo) {
		// TODO Auto-generated method stub
		return shopDao.selectProductInfo(sqlSession,productNo);
	}

	@Override
	@Transactional
	public int insertDetailInfo(ProductDetail pd,ParameterVo fileParameter) {
		// TODO Auto-generated method stub
		int result2=1;
		int result=shopDao.insertDetailInfo(sqlSession,pd);
		if(!fileParameter.getAtList().isEmpty()) {
			
			result2=shopDao.insertAttachment(sqlSession, fileParameter);
		}
		return result*result2;
	}

	@Override
	public int updateDetailInfo(ProductDetail pd, ParameterVo fileParameter) {
		int result2=1;
		int result=shopDao.updateDetailInfo(sqlSession,pd);
		if(!fileParameter.getAtList().isEmpty()) {
			result2=shopDao.updateAttachment(sqlSession, fileParameter);
		}
		return result*result2;

	}

	@Override
	public ArrayList<POrderInfo> selectOrderListControll(String category,PageInfo pi) {
		// TODO Auto-generated method stub
		return shopDao.selectOrderListControll(sqlSession,category,pi);
	}

	@Override
	public int selectOrderCount(String category) {
		// TODO Auto-generated method stub
		Integer result=shopDao.selectOrderCount(category,sqlSession);
		if(result!=null) {
			
			return result;
		}else {
			return 0;
		}
	}

	@Override
	public int convertOrderProcess(POrderInfo p) {
		// TODO Auto-generated method stub
		return shopDao.convertOrderProcess(sqlSession,p);
	}

	@Override
	public ArrayList<POrderInfo> selectOrderListComplete(int userNo, String category) {
		// TODO Auto-generated method stub
		POrderInfo p= new POrderInfo();
		p.setUserNo(userNo);
		p.setProcess(category);
		return shopDao.selectOrderListComplete(p,sqlSession);
	}

	@Override
	public ArrayList<Product> selectTopSalesProduct(String orderBy) {
		// TODO Auto-generated method stub
		return shopDao.selectTopSalesProduct(sqlSession,orderBy);
	}

	@Override
	public ArrayList<Brand> selectTopSalesBrand(String orderBy) {
		// TODO Auto-generated method stub
		ArrayList<Brand> bList=shopDao.selectBrand(sqlSession,"");
		int result=shopDao.updateBrandSales(sqlSession, bList);
		int result2=shopDao.updateBrandSalesCount(sqlSession, bList);
		return shopDao.selectTopSalesBrand(sqlSession,orderBy);
	}

	@Override
	public int selectProductCount(ParameterVo parameter) {
		// TODO Auto-generated method stub
		Integer result =shopDao.selectProductCount(sqlSession,parameter);
		if(result!=null) {
			return result;
		}else {
			return 0;
		}
		
	}

	@Override
	public ArrayList<Product> selectProductListControll(ParameterVo parameter, PageInfo pi) {
		// TODO Auto-generated method stub
		return shopDao.selectProductListControll(parameter,pi,sqlSession);
	}


	@Override
	@Transactional
	public int insertBrand(String brandName, ParameterVo fileParameter) {
		int result=shopDao.insertBrand(brandName,sqlSession);
		int result2=shopDao.insertAttachment(sqlSession, fileParameter);
		return result*result2;

	}

	@Override
	public Brand selectBrandOne(int brandCode) {
		// TODO Auto-generated method stub
		return shopDao.selectBrandOne(brandCode,sqlSession);
	}

	@Override
	@Transactional
	public int updateBrand(Brand brand, ParameterVo fileParameter) {
		// TODO Auto-generated method stub
		int result2=1;
		int result= shopDao.updateBrand(sqlSession, brand);
		if(!fileParameter.getAtList().isEmpty()) {
			
			result2=shopDao.updateAttachment(sqlSession, fileParameter);
		}
		return result*result2;
	}

	@Override
	public int insertCategory(String categoryName) {
		// TODO Auto-generated method stub
		return shopDao.insertCategory(sqlSession,categoryName);
	}

	@Override
	public int updateCategory(Category c) {
		// TODO Auto-generated method stub
		return shopDao.updateCategory(sqlSession,c);
	}

	@Override
	public int deleteCategory(int categoryNo) {
		// TODO Auto-generated method stub
		return shopDao.deleteCategory(sqlSession,categoryNo);
	}

	@Override
	public ArrayList<Customer> selectTopBuyer() {
		// TODO Auto-generated method stub
		return shopDao.selectTopBuyer(sqlSession);
	}

	@Override
	public ArrayList<Customer> selectTopSpenders() {
		// TODO Auto-generated method stub
		return shopDao.selectTopSpenders(sqlSession);
	}

	@Override
	public ArrayList<Customer> selectCustomerList() {
		// TODO Auto-generated method stub
		return shopDao.selectCustomerList(sqlSession);
	}

	@Override
	public ArrayList<Question> selectQuestionListControll() {
		// TODO Auto-generated method stub
		return shopDao.selectQuestionListControll(sqlSession);
	}

	@Override
	public ArrayList<Question> selectQuestionListUser(int userNo) {
		// TODO Auto-generated method stub
		return shopDao.selectQuestionListUser(userNo,sqlSession);
	}

	@Override
	@Transactional
	public int replyInquiry(Answer a) {
		// TODO Auto-generated method stub
		int result=shopDao.replyInquiry(a,sqlSession);
		int result2=shopDao.updateQustionStatus(a.getQuestionNo(),sqlSession);
		return result*result2;
	}

	@Override
	public MonthlyTally selectMonthlyTally(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return shopDao.selectMonthlyTally(map,sqlSession);
	}

	@Override
	public MonthlyTally selectMonthlyTallyCount(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return shopDao.selectMonthlyTallyCount(map, sqlSession);
	}

	@Override
	public ArrayList<Attachment> selectMainSlide() {
		// TODO Auto-generated method stub
		return shopDao.selectMainSlide(sqlSession);
	}

	@Override
	public int insertMain(ParameterVo fileParameter) {
		// TODO Auto-generated method stub
		return shopDao.updateAttachment(sqlSession, fileParameter);
	}
	

}
