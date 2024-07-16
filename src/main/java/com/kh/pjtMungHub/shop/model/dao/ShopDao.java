package com.kh.pjtMungHub.shop.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.pjtMungHub.common.model.vo.PageInfo;
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

@Repository
public class ShopDao {

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ArrayList<Product> selectProductList(SqlSessionTemplate sqlSession, String status) {
		return (ArrayList)sqlSession.selectList("shopMapper.selectList",status);
	}

	public Product selectProductDetail(SqlSessionTemplate sqlSession, int productNo) {
		return sqlSession.selectOne("shopMapper.selectDetail",productNo);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ArrayList<Category> selectCategory(SqlSessionTemplate sqlSession) { //product insert GetMapping시 조회
		return (ArrayList)sqlSession.selectList("shopMapper.selectCategory");
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ArrayList<Brand> selectBrand(SqlSessionTemplate sqlSession, String orderBy) { //product insert GetMapping시 조회
		return (ArrayList)sqlSession.selectList("shopMapper.selectBrand",orderBy);
	}
	
	public int insertProduct(SqlSessionTemplate sqlSession, Product p) {
		return sqlSession.insert("shopMapper.insertProduct",p);
	}

	public int insertAttachment(SqlSessionTemplate sqlSession, ParameterVo fileParameter) { //product
		return sqlSession.insert("shopMapper.insertAttachment",fileParameter);
	}

	public int addCart(SqlSessionTemplate sqlSession, Cart c) {
		// TODO Auto-generated method stub
		return sqlSession.insert("shopMapper.addCart",c);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ArrayList<Cart> selectCartList(SqlSessionTemplate sqlSession, int userNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("shopMapper.selectCartList",userNo);
	}

	public int removeCartItem(SqlSessionTemplate sqlSession,ParameterVo parameter) {
		// TODO Auto-generated method stub
		return sqlSession.delete("shopMapper.removeCartItem",parameter);
	}

	public int updateCartAmount(SqlSessionTemplate sqlSession, ParameterVo parameter) {
		// TODO Auto-generated method stub
		return sqlSession.update("shopMapper.updateCartAmount",parameter);
	}
	
	public int chooseShipInfo(SqlSessionTemplate sqlSession, ShipInfo s) {
		// TODO Auto-generated method stub
		return sqlSession.update("shopMapper.chooseShipInfo",s);
	}

	public int insertShipInfo(SqlSessionTemplate sqlSession, ShipInfo s) {
		// TODO Auto-generated method stub
		return sqlSession.insert("shopMapper.insertShipInfo",s);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ArrayList<ShipInfo> selectShipInfoList(SqlSessionTemplate sqlSession, int userNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("shopMapper.selectShipInfoList", userNo);
	}

	public int changeShipInfo(SqlSessionTemplate sqlSession, ShipInfo s) {
		// TODO Auto-generated method stub
		return sqlSession.update("shopMapper.changeShipInfo",s);
	}
	
	public int removeShipInfo(SqlSessionTemplate sqlSession, ShipInfo s) {
		// TODO Auto-generated method stub
		return sqlSession.delete("shopMapper.removeShipInfo",s);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ArrayList<Cart> selectCartItemList(SqlSessionTemplate sqlSession, ParameterVo parameter) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("shopMapper.selectCartItemList",parameter);
	}

	public ShipInfo selectShipInfo(SqlSessionTemplate sqlSession, int userNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("shopMapper.selectShipInfo",userNo);
	}
	public ShipInfo selectShipInfo2(SqlSessionTemplate sqlSession, int userNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("shopMapper.selectShipInfo2",userNo);
	}

	

	public int insertOrderInfo(SqlSessionTemplate sqlSession, POrderInfo orderInfo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("shopMapper.insertOrderInfo",orderInfo);
	}

	public POrderInfo selectOrder(SqlSessionTemplate sqlSession, String merchantUid) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("shopMapper.selectOrder",merchantUid);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ArrayList<POrderInfo> selectOrderList(SqlSessionTemplate sqlSession, int userNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("shopMapper.selectOrderList",userNo);
	}

	public Integer selectCartCount(SqlSessionTemplate sqlSession, int userNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("shopMapper.selectCartCount",userNo);
	}

	public int stopItemPost(SqlSessionTemplate sqlSession, ParameterVo parameter) {
		// TODO Auto-generated method stub
		return sqlSession.update("shopMapper.stopItemPost",parameter);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ArrayList<Attachment> selectAttachmentList(SqlSessionTemplate sqlSession, ParameterVo parameter) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("shopMapper.selectAttachmentList",parameter);
	}

	public int deleteProductData(int productNo, SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.delete("shopMapper.deleteProductData",productNo);
	}

	public int updateAttachment(SqlSessionTemplate sqlSession, ParameterVo parameter) {
		// TODO Auto-generated method stub
		return sqlSession.update("shopMapper.updateAttachment",parameter);
	}

	public int updateProduct(SqlSessionTemplate sqlSession, Product p) {
		// TODO Auto-generated method stub
		return sqlSession.update("shopMapper.updateProduct",p);
	}

	public int deleteAttachment(SqlSessionTemplate sqlSession, ParameterVo parameter) {
		// TODO Auto-generated method stub
		return sqlSession.delete("shopMapper.deleteAttachment",parameter);
	}

	public int rearrangeAttachment(SqlSessionTemplate sqlSession, ParameterVo parameter) {
		// TODO Auto-generated method stub
		return sqlSession.update("shopMapper.rearrangeAttachment",parameter);
	}

	public Favorite selectFavorite(ParameterVo parameter, SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("shopMapper.selectFavorite",parameter);
	}

	public int convertFavorite(Favorite favor, SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.insert("shopMapper.convertFavorite",favor);
	}

	public int insertReview(SqlSessionTemplate sqlSession, Review review) {
		// TODO Auto-generated method stub
		return sqlSession.insert("shopMapper.insertReview",review);
	}

	public Integer selectReviewCount(SqlSessionTemplate sqlSession, int productNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("shopMapper.selectReviewCount",productNo);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ArrayList<ScorePercent> selectScorePercent(SqlSessionTemplate sqlSession, int productNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("shopMapper.selectScorePercent",productNo);
	}

	public double selectScoreAvg(SqlSessionTemplate sqlSession, int productNo) {
		// TODO Auto-generated method stub
		return (double)sqlSession.selectOne("shopMapper.selectScoreAvg",productNo);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ArrayList<Review> selectReviewList(SqlSessionTemplate sqlSession, ParameterVo param) {
		// TODO Auto-generated method stub
		if(param.getPi()!=null) {
			
			PageInfo pi= param.getPi();
			
			int limit = pi.getBoardLimit();
			int offset = (pi.getCurrentPage()-1)*limit;
			
			RowBounds rowBounds = new RowBounds(offset,limit);
			return (ArrayList)sqlSession.selectList("shopMapper.selectReviewList",param,rowBounds);
		}else {
			return (ArrayList)sqlSession.selectList("shopMapper.selectReviewList",param);
		}
		
	}

	public Attachment selectAttachment(SqlSessionTemplate sqlSession, ParameterVo parameter) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("shopMapper.selectAttachment",parameter);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ArrayList<Favorite> selectFavoriteList(ParameterVo parameter, SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("shopMapper.selectFavoriteList",parameter);
	}

	public int updateSalesCount(ArrayList<Product> pList, SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.update("shopMapper.updateSalesCount",pList);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ArrayList<ReviewReply> selectReviewReplyList(int reviewNo, SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("shopMapper.selectReviewReplyList",reviewNo);
	}

	public int insertReviewReply(SqlSessionTemplate sqlSession, ReviewReply reply) {
		// TODO Auto-generated method stub
		return sqlSession.insert("shopMapper.insertReviewReply",reply);
	}

	public int deleteReply(SqlSessionTemplate sqlSession, int replyNo) {
		// TODO Auto-generated method stub
		return sqlSession.delete("shopMapper.deleteReply",replyNo);
	}

	public int reviewLike(SqlSessionTemplate sqlSession, Review r) {
		// TODO Auto-generated method stub
		return sqlSession.insert("shopMapper.reviewLike",r);
	}

	public int updateLikeCount(SqlSessionTemplate sqlSession, Review r) {
		// TODO Auto-generated method stub
		return sqlSession.update("shopMapper.updateLikeCount",r);
	}

	public Integer selectLikeCount(SqlSessionTemplate sqlSession, Review r) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("shopMapper.selectLikeCount",r);
	}

	public int deleteLike(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.delete("shopMapper.deleteLike");
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ArrayList<Category> selectQuestionCategory(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("shopMapper.selectQuestionCategory");
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ArrayList<Question> selectQuestionList(SqlSessionTemplate sqlSession, int productNo, PageInfo pi) {
		// TODO Auto-generated method stub
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		
		RowBounds rowBounds = new RowBounds(offset,limit);
		return (ArrayList)sqlSession.selectList("shopMapper.selectQuestionList",productNo,rowBounds);
	}

	public Integer selectQuestionCount(SqlSessionTemplate sqlSession, int productNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("shopMapper.selectQuestionCount",productNo);
	}

	public Answer selectAnswer(SqlSessionTemplate sqlSession, int questionNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("shopMapper.selectAnswer",questionNo);
	}

	public int updateQuestionStatus(SqlSessionTemplate sqlSession, int questionNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("shopMapper.updateQuestionStatus",questionNo);
		
	}

	public Question selectQuestionDetail(SqlSessionTemplate sqlSession, int questionNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("shopMapper.selectQuestionDetail",questionNo);
	}

	public int insertQuestion(SqlSessionTemplate sqlSession, Question q) {
		// TODO Auto-generated method stub
		return sqlSession.insert("shopMapper.insertQuestion",q);
	}

	public Review selectReview(SqlSessionTemplate sqlSession, Review r) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("shopMapper.selectReview",r);
	}

	public int updateReview(SqlSessionTemplate sqlSession, Review review) {
		// TODO Auto-generated method stub
		return sqlSession.update("shopMapper.updateReview",review);
	}

	public int updatePoint(SqlSessionTemplate sqlSession, Point point) {
		// TODO Auto-generated method stub
		return sqlSession.update("shopMapper.updatePoint",point);
	}

	public Point selectPoint(SqlSessionTemplate sqlSession, int userNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("shopMapper.selectPoint",userNo);
	}

	public ProductDetail selectProductInfo(SqlSessionTemplate sqlSession, int productNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("shopMapper.selectProductInfo",productNo);
	}

	public int insertDetailInfo(SqlSessionTemplate sqlSession, ProductDetail pd) {
		// TODO Auto-generated method stub
		return sqlSession.insert("shopMapper.insertDetailInfo",pd);
	}

	public int updateDetailInfo(SqlSessionTemplate sqlSession, ProductDetail pd) {
		// TODO Auto-generated method stub
		return sqlSession.update("shopMapper.updateDetailInfo",pd);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ArrayList<POrderInfo> selectOrderListControll(SqlSessionTemplate sqlSession, String category, PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		
		return (ArrayList)sqlSession.selectList("shopMapper.selectOrderListControl",category,rowBounds);
	}

	public Integer selectOrderCount(String category, SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("shopMapper.selectOrderCount",category);
	}

	public int convertOrderProcess(SqlSessionTemplate sqlSession, POrderInfo p) {
		// TODO Auto-generated method stub
		return sqlSession.update("shopMapper.convertOrderProcess",p);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ArrayList<POrderInfo> selectOrderListComplete(POrderInfo p, SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("shopMapper.selectOrderListComplte",p);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ArrayList<Product> selectTopSalesProduct(SqlSessionTemplate sqlSession, String orderBy) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("shopMapper.selectTopSalesProdcut",orderBy);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ArrayList<Brand> selectTopSalesBrand(SqlSessionTemplate sqlSession, String orderBy) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("shopMapper.selectTopSalesBrand",orderBy);
	}

	public int updateBrandSalesCount(SqlSessionTemplate sqlSession, ArrayList<Brand> bList) {
		// TODO Auto-generated method stub
		return sqlSession.update("shopMapper.updateBrandSalesCount",bList);
	}

	public int updateBrandSales(SqlSessionTemplate sqlSession, ArrayList<Brand> bList) {
		// TODO Auto-generated method stub
		return sqlSession.update("shopMapper.updateBrandSales",bList);
	}

	public Integer selectProductCount(SqlSessionTemplate sqlSession, ParameterVo parameter) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("shopMapper.selectProductCount",parameter);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ArrayList<Product> selectProductListControll(ParameterVo parameter, PageInfo pi, SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		
			
			int limit = pi.getBoardLimit();
			int offset = (pi.getCurrentPage()-1)*limit;
			
			RowBounds rowBounds = new RowBounds(offset,limit);
		
		
		return (ArrayList)sqlSession.selectList("shopMapper.selectProductControll",parameter,rowBounds);
	}

	public int insertBrand(String brandName, SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.insert("shopMapper.insertBrand",brandName);
	}

	public Brand selectBrandOne(int brandCode, SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("shopMapper.selectBrandOne", brandCode);
	}

	public int updateBrand(SqlSessionTemplate sqlSession, Brand brand) {
		// TODO Auto-generated method stub
		return sqlSession.update("shopMapper.updateBrand",brand);
	}

	public int insertCategory(SqlSessionTemplate sqlSession, String categoryName) {
		// TODO Auto-generated method stub
		return sqlSession.insert("shopMapper.insertCategory",categoryName);
	}

	public int updateCategory(SqlSessionTemplate sqlSession, Category c) {
		// TODO Auto-generated method stub
		return sqlSession.update("shopMapper.updateCategory",c);
	}

	public int deleteCategory(SqlSessionTemplate sqlSession, int categoryNo) {
		// TODO Auto-generated method stub
		return sqlSession.delete("shopMapper.deleteCategory",categoryNo);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ArrayList<Customer> selectTopBuyer(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("shopMapper.selectTopBuyer");
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ArrayList<Customer> selectTopSpenders(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("shopMapper.selectTopSpenders");
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ArrayList<Customer> selectCustomerList(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("shopMapper.selectCustomerList");
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ArrayList<Question> selectQuestionListControll(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("shopMapper.selectQuestionListControll");
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ArrayList<Question> selectQuestionListUser(int userNo, SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("shopMapper.selectQuestionListUser",userNo);
	}

	public int replyInquiry(Answer a, SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.insert("shopMapper.replyInquiry",a);
	}

	public int updateQustionStatus(int questionNo, SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.update("shopMapper.updateQustionStatus",questionNo);
	}

	public MonthlyTally selectMonthlyTally(HashMap<String, String> map, SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("shopMapper.selectMonthlyTally",map);
	}

	public MonthlyTally selectMonthlyTallyCount(HashMap<String, String> map, SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("shopMapper.selectMonthlyTallyCount",map);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ArrayList<Attachment> selectMainSlide(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("shopMapper.selectMainSlide");
	}






	


}
