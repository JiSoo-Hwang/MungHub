package com.kh.pjtMungHub.shop.model.service;

import java.util.ArrayList;
import java.util.HashMap;

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

public interface ShopService {

	ArrayList<Product> selectProductList(String status);


	Product selectProductDetail(int productNo);


	int insertProduct(Product p, ParameterVo fileParameter);


	ArrayList<Category> selectCategory();


	ArrayList<Brand> selectBrand(String orderBy);


	int addCart(Cart c);


	ArrayList<Cart> selectCartList(int userNo);


	int removeCartItem(ParameterVo parameter);


	int updateCartAmount(ParameterVo parameter);


	int insertShipInfo(ShipInfo s);


	ArrayList<ShipInfo> selectShipInfoList(int userNo);


	int changeShipInfo(ShipInfo s);


	ArrayList<Cart> selectCartItemList(ParameterVo parameter);


	ShipInfo selectShipInfo(int userNo);


	POrderInfo selectOrder(String merchantUid);


	int insertOrderInfo(POrderInfo orderInfo);


	ArrayList<POrderInfo> selectOrderList(int userNo);


	int removeShipInfo(ShipInfo s);


	int selectCartCount(int userNo);


	int stopItemPost(ParameterVo parameter);


	ArrayList<Attachment> selectAttachmentList(ParameterVo parameter);


	int deleteProductData(int productNo);


	int updateAttachment(ParameterVo parameter);


	int updateProduct(Product p);



	int deleteAttachment(ParameterVo parameter);


	Favorite selectFavorite(ParameterVo parameter);


	int convertFavorite(Favorite favor);


	int insertReview(Review review, ParameterVo fileParameter);


	int selectReviewCount(int productNo);


	ArrayList<ScorePercent> selectScorePercent(int productNo);


	double selectScoreAvg(int productNo);



	ArrayList<Review> selectReviewList(ParameterVo parameter2);


	Attachment selectAttachment(ParameterVo parameter);


	ArrayList<Favorite> selectFavoriteList(ParameterVo parameter);


	int updateSalesCount(ArrayList<Product> pList);


	ArrayList<ReviewReply> selectReviewReplyList(int reviewNo);


	int insertReviewReply(ReviewReply reply);


	int deleteReply(int replyNo);


	int reviewLike(Review r);


	int selectLikeCount(Review r);


	ArrayList<Category> selectQuestionCategory();


	ArrayList<Question> selectQuestionList(int productNo, PageInfo pi);


	int selectQuestionCount(int productNo);


	Answer selectAnswer(int questionNo);


	Question selectQuestionDetail(int questionNo);


	int insertQuestion(Question q);


	Review selectReview(Review r);


	int updateReview(Review review, ParameterVo fileParameter);


	int updatePoint(Point point);


	Point selectPoint(int userNo);


	ProductDetail selectProdcutInfo(int productNo);


	int insertDetailInfo(ProductDetail pd, ParameterVo fileParameter);


	int updateDetailInfo(ProductDetail pd, ParameterVo fileParameter);


	ArrayList<POrderInfo> selectOrderListControll(String string, PageInfo pi);


	int selectOrderCount(String category);


	int convertOrderProcess(POrderInfo p);


	ArrayList<POrderInfo> selectOrderListComplete(int userNo, String category);


	ArrayList<Product> selectTopSalesProduct(String orderBy);


	ArrayList<Brand> selectTopSalesBrand(String orderBy);


	int selectProductCount(ParameterVo parameter);


	ArrayList<Product> selectProductListControll(ParameterVo parameter, PageInfo pi);


	int insertBrand(String brandName, ParameterVo fileParameter);


	Brand selectBrandOne(int brandCode);


	int updateBrand(Brand brand, ParameterVo fileParameter);


	int insertCategory(String categoryName);


	int updateCategory(Category c);


	int deleteCategory(int categoryNo);


	ArrayList<Customer> selectTopBuyer();


	ArrayList<Customer> selectTopSpenders();


	ArrayList<Customer> selectCustomerList();


	ArrayList<Question> selectQuestionListControll();


	ArrayList<Question> selectQuestionListUser(int userNo);


	int replyInquiry(Answer a);


	MonthlyTally selectMonthlyTally(HashMap<String, String> map);


	MonthlyTally selectMonthlyTallyCount(HashMap<String, String> map);


	ArrayList<Attachment> selectMainSlide();


	int insertMain(ParameterVo fileParameter);



}
