<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<meta charset="UTF-8">
<title>MUNGHUBSHOPDETAIL</title>
<style>



.review-detail {
	cursor:pointer;
}

.dl-table-group {
	width: 100%;
	display: table;
	table-layout: fixed;
	border-top: 1px solid #EDEDED;
	margin-top: 20px;
	padding-top: 8px;
}

.dl-row {
	display: table-row;
}

.dl-table-group .dl-row>dt {
	display: table-cell;
	vertical-align: top;
	width: 100px;
	padding: 12px 0;
	color: #666;
}

.dl-table-group .dl-row>dd {
	display: table-cell;
	position: relative;
	vertical-align: top;
	padding: 12px 0;
	color: #333;
}

.review-img-top4 {
	float: left;
	width: 100px;
}

.btn-review-all {
	float: right;
	text-decoration: none;
	color: gray;
}

.btn-review-all:hover {
	text-decoration: none;
	color: gray;
}

tbody {
	border: 1px solid lightgray;
}

.detail-tag p {
	padding: 10px;
	margin-right: 10px;
	color: gray
}

.detail-content p {
	padding: 10px;
	margin-right: 10px
}

.progress {
	width: 80%;
	float: right;
}

.score {
	width: 20%;
	display: block;
	float: left;
}

.qna {
	top: 0px;
	float: right;
	position: relative;
}

.qna a {
	font-size: 14px;
}

h2 {
	width: 50%;
}

.answerd {
	text-align: center !important;
}

.answerd> p {
	color: orange !important;
	margin-bottom:0 !important;
}

.wating-answer {
	text-align: center !important;
}

.wating-answer p {
	color: gray !important;
}

.question-list>td a {
	text-decoration: none !important;
	color: gray !important;
}

.question-list>td button {
	text-decoration: none !important;
	color: gray !important;
	border: 0px;
}
#favor{
 transition : transform 0.3s ease-in-out;
}
#favor:hover{
	transform: scale(1.2);
}

.star-rating {
      display: flex;
    }

    .star {
      appearance: none;
      padding: 1px;
    }

    .star::after {
      content: '☆';
      color: #F2D106;
      font-size: 30px;
    }

    .star:hover::after,
    .star:has(~ .star:hover)::after,
    .star:checked::after,
    .star:has(~ .star:checked)::after {
      content: '★';
    }

    .star:hover ~ .star::after {
      content: '☆';
    }
    
      
    .media-container {
         display: flex;
         overflow-x: auto;
     }
     .media-container video,
     .media-container img,
     .media-container .embed-responsive {
         flex: 0 0 auto;
         margin-right: 10px;
     }
    
  
.review-star {width:100px; }
.review-star,.review-star span {display:inline-block; height:24px; overflow:hidden; background:url(/pjtMungHub/resources/uploadFiles/shopFile/productFile/common/star.png)no-repeat; }
.review-star span{background-position:left bottom; line-height:0; vertical-align:top; }

.btn-div button{
margin-right: 10px;
}
.reviewReply{
padding: 4px;
border-bottom : 1px solid lightgray;
}
.bi-hand-thumbs-up-fill{
color: purple;
}
</style>
</head>
<body>

	<%@ include file="../common/header.jsp"%>
	
	<section class="py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="row gx-4 gx-lg-5 align-items-center">
				<div class="col-md-6">
					
					<div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-ride="carousel">
  <div class="carousel-indicators">
  <c:forEach items="${atList }" var="at" varStatus="status">
    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="${status.index }" <c:if test="${status.index eq 0 }">class="active" aria-current="true"</c:if> aria-label="Slide ${status.count }"></button>
  </c:forEach>
  </div>
					  <div class="carousel-inner" style="height:800px;">
  					<c:forEach items="${atList }" var="at" varStatus="status">
					    <div class="carousel-item <c:if test="${status.index eq 0 }">active</c:if>"  data-bs-interval="10000">
					    	<input type="hidden" value="${status.index }">
					    	<c:choose>
					    		<c:when test="${at.type eq 'video' }">
					    	<video src="${at.filePath }${at.changeName}" class="d-block w-100"style="height: 100%;" autoplay loop></video>
					    		</c:when>
					    		<c:otherwise>
					      <img src="${at.filePath }${at.changeName}" class="d-block w-100" style="height: 100%">
					    		</c:otherwise>
					    	</c:choose>
					    </div>
				</c:forEach>
					  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
				<c:if test="${loginUser.userGrade >0 }">
				<button type="button" class="btn btn-outline-danger" id="deleteSlide"><i class="bi bi-trash3"></i>현재 슬라이드 삭제</button>
				
				<script>
				$(function(){
					$("#deleteSlide").click(function(){
						var currentSlide = $(".active").children("input:hidden").val();
						if(currentSlide!=0){
							
						
 						$.ajax({
							url : "/pjtMungHub/deleteAttachment.sp",
 							type : "post",
							data : {productNo : ${p.productNo},
 									fileLev : currentSlide},
 							success: function(result){
 								alert("삭제가 완료되었습니다.");
 								location.href="/pjtMungHub/detail.sp/"+${p.productNo};
 							},
 							error: function(){
 								console.log("통신오류");
 							}
 						});
						}else{
							alert("첫번째 슬라이드는 지울 수 없습니다.");
						}
					});
				});
				
				</script>
				
				</c:if>
				
				
				
				</div>
				<div class="col-md-6">
					<h1 class="display-5 fw-bolder">${p.productName}</h1>
					<div class="fs-5 mb-3 mb-5">
						<h3>
							<del style="color: gray">
								<fmt:formatNumber type="number" maxFractionDigits="0"
									value="${p.price}" />
								원
							</del>
						</h3>
						<h2>
							<fmt:formatNumber type="number" maxFractionDigits="0"
								value="${p.price -(p.price/p.discount)}" />
							원 <strong style="color: rgb(250, 58, 14)">${p.discount }%</strong>
						</h2>

						<!-- 별점 -->
				<div class="wrap-star">
			    <div class='review-star'>
			        <span style ="width: <fmt:formatNumber type="number" maxFractionDigits="0" value="${p.reviewTScore * 20}" />%"></span>
			    </div>
				</div>
				 <span>(<fmt:formatNumber
								type="number" maxFractionDigits="0" value="${p.reviewCount }" />)
						</span>
						<div></div>
					</div>
					<div class="d-flex justify-content-end">
						<input class="form-control text-center me-3" id="inputQuantity"
							type="number" min="1" max="99" value="1" style="max-width: 4rem" onkeyup="minusChk()">
						&nbsp;&nbsp;
						<button class="btn btn-outline-dark flex-shrink-0" id="addCart" type="button">
							<i class="bi bi-bag-plus-fill"></i>&nbsp; 장바구니 추가
						</button>
						&nbsp;
						<button class="btn btn-outline-dark flex-shrink-0" type="button" id="favor">
							<i class="bi bi-heart"></i>
						</button>
					</div>
	<c:choose>
	<c:when test="${not empty loginUser }">

	<div class="toast-container position-fixed p-5 bottom-0 end-0">
	  <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="false">
	    <div class="toast-header">
	    <i class="bi bi-cart-plus-fill" style="color:blue"></i>&nbsp;
	      <strong class="me-auto"> 장바구니 담기 성공</strong>
	      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
	    </div>
	    <div class="toast-body">
	     	장바구니로 이동하시겠습니까?
	     	 <div class="mt-2 pt-2 border-top">
      <button type="button" class="btn btn-primary btn-sm" onclick="location.href='/pjtMungHub/cart.sp'">바로가기</button>
      <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="toast">닫기</button>
    </div>
	    </div>
	  </div>
	</div>
	
	<script>
	function minusChk(){
		var value=$("#inputQuantity").val();
		if(value<1){
			$("#inputQuantity").val("1");
		}
		
		if(value>99){
			$("#inputQuantity").val("99");
		}
		
	}
	
	function selectFavor(){
		
		$.ajax({
			url : "/pjtMungHub/selectFavorite.sp",
			data : { userNo:${loginUser.userNo},
					 productNo : ${p.productNo}},
			success : function (result){
				if(result){
				$("#favor").html("<i class='bi bi-heart-fill' style='color:red'></i>");
				
				}else{
					$("#favor").html("<i class='bi bi-heart'></i>");
					
				}
			},
			error:function(){
				console.log("통신오류");
			}
			
		});
		}
	
	$(function(){
			
		selectFavor();
		
	 $("#favor").click(function(){
		 
			 $.ajax({
				 url : "/pjtMungHub/subscribe.sp",
				 type : "post",
				 data : { userNo:${loginUser.userNo},
					 	  productNo : ${p.productNo}},
				success : function(result){
					selectFavor();
				},
				error : function(){
					console.log("통신오류");
				}
			 });
		
		 
		 
	 });
		
		$("#addCart").click(function(){
			
			
			
			var productNo =  "${p.productNo}";
			var amount = $("#inputQuantity").val();
			var userNo = "${loginUser.userNo}";
			
	$.ajax({
		url : "/pjtMungHub/addCart.sp",
		type : "post",
		 data: {
				productNo : "${p.productNo}"
				,amount : $("#inputQuantity").val()
				,userNo : "${loginUser.userNo}"
		},
		success: function(result){
			
			
			const toast = new bootstrap.Toast($('#liveToast'));
			toast.show();
			  
			
			
		},
		error: function(){
			console.log("통신실패");
		}
	 });
	});
		

	});	

	
	</script>
	</c:when>
	<c:otherwise>
	<script>
	$(function(){
		
	$("#addCart").click(function(){
		alert("로그인 이후에 이용해주세요.");
	});
	
	 $("#favor").click(function(){
		 alert("로그인 이후에 이용해주세요.");
	 });
	
	
	});
	</script>
	</c:otherwise>
	</c:choose>
	

					<div class="dl-table-group">
						<dl class="dl-row">
							<dt>판매량</dt>
							<dd>
								<strong><fmt:formatNumber type="number"
										maxFractionDigits="0" value="${p.salesCount}" /></strong>
							</dd>
						</dl>
						<dl class="dl-row">
							<dt>배송안내</dt>
							<dd>
								<div class="div-way-box-v2">
									<h4>무료배송</h4>
									<p>30,000원이상 구매 시 무료 배송(기본배송료 2,500원)</p>
									<h4>추가비용 지역</h4>
									<p>제주도 추가 배송비 1,500원</p>
								</div>
							</dd>
						</dl>
						<dl class="dl-row">
							<dt>적립혜택</dt>
							<dd>
								<strong style="color:red"><fmt:formatNumber type="number"
										maxFractionDigits="0"
										value="${(p.price -(p.price/p.discount))/200}" />P</strong> 적립
							</dd>
						</dl>
					</div>
				</div>
			</div>
		<div align="right">
		
		<c:if test="${loginUser.userGrade > 0 }">
		<form action="/pjtMungHub/stopPost.sp" method="post">
		<input type="hidden" value="${p.productNo }" name="productNo">
		<c:if test="${p.status eq 'Y' }">
		<input type="hidden" value="N" name="justifying">
		<button type="submit" class="btn btn-danger">상품게시중단</button>
		</c:if>
		<c:if test="${p.status eq 'N' }">
		<input type="hidden" value="Y" name="justifying">
		<button type="submit" class="btn btn-primary">상품게시</button>
		<button type="button" class="btn btn-danger" id="delete">상품정보삭제</button>
		<script type="text/javascript">
			$(function(){
				$("#delete").click(function(){
					
						if(confirm("해당 물품 데이터와 연결된 장바구니,주문내역 데이터도 사라집니다.\n 정말 삭제하시겠습니까?")){
				$.ajax({
					url: "/pjtMungHub/delete.sp",
					type: "post",
					data : {productNo : ${p.productNo}},
					success : function(result){
					
								alert("물품삭제완료");
								location.href="/pjtMungHub/notPosted.sp";
							
					},
					error : function(){
						console.log("통신실패");
					
					}
						});
					}
					});
				});
			
		</script>
		</c:if>
		</form>
		<a class="btn btn-info" href="/pjtMungHub/update.sp/${p.productNo }">상품 정보 업데이트</a>
		</c:if>
		</div>
		</div>
			
	</section>
	<hr>
	<section class="py-5">

		<div class="container">
			<h4>베스트 리뷰 (${p.reviewCount })</h4>
			<c:if test="${p.reviewCount ne 0 }">
			<a href="/pjtMungHub/reviewListAll.sp/${p.productNo}" class="btn-review-all"><span>전체리뷰보기</span><i
				class="bi bi-caret-right-fill"></i> </a> <br>
			</c:if>
			<div class="row align-items-center mt-3 ml-3 mr-3">
				<c:forEach items="${best4Review}" var="r" varStatus="i">
					<div class="col-md-3 mx-3 review-detail" data-bs-toggle="modal" data-bs-target="#reviewDetailModal${r.reviewNo }">
						<div class="review-content">
						<div class="media-container">
						<c:forEach items="${rAtList[i.index] }" var="rAt">
						<c:if test="${rAt.type eq 'image' }">
						<img src="${rAt.filePath }${rAt.changeName}" class="img-fluid">
						</c:if>
						<c:if test="${rAt.type eq 'video' }">
						<video src="${rAt.filePath }${rAt.changeName}" style="max-height: 300px;" controls></video>
						</c:if>
						</c:forEach>
						</div>
	          
							<div class="wrap-star">
						    <div class='review-star'>
						        <span style ="width: ${r.score*20}%"></span>
						       
						    </div>
							</div>
							&nbsp;<span id="likeCountB${r.reviewNo }">${r.likeCount }</span> &nbsp;<i class="bi bi-hand-thumbs-up-fill"></i>
							<br> 
							<small class="text-muted">${r.userName }</small> 
							<small class="text-muted">${r.createDate }</small>
							
						</div>
						<p>${r.reviewContent }</p>
					</div>
					
		<div class="modal fade" id="reviewDetailModal${r.reviewNo }" 
			data-bs-backdrop="static" data-bs-keyboard="false" 
			tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="staticBackdropLabel">리뷰 보기</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
			      <div class="modal-body">
			      	<div class="media-container">
			      <c:forEach items="${rAtList[i.index] }" var="rAt">
			      		<c:choose>
					    		<c:when test="${rAt.type eq 'video' }">
					    	<video src="${rAt.filePath }${rAt.changeName}" class="d-block img-fluid"style="max-height:300px;"  autoplay loop></video>
					    		</c:when>
					    		<c:otherwise>
					      <img src="${rAt.filePath }${rAt.changeName}" class="d-block img-fluid" style="max-height:300px;" >
					    		</c:otherwise>
					    	</c:choose>
					</c:forEach>
			      	</div>
							
					<div class="wrap-star">
						    <div class='review-star'>
						        <span style ="width: ${r.score*20}%"></span>
						    </div>
							</div>
					<div class="row align-items-center justify-content-center">
					<div class="col-sm-10">
					<small class="text-muted">${r.userName }</small>
					 <small class="text-muted">${r.createDate }</small>
				  <p>${r.reviewContent }</p>
					</div>
					<div class="col-sm-1" id="likeCount${r.reviewNo }" align="center">
					${r.likeCount }
					</div>
				  <button class='btn btn-primary col-sm-1' style="max-height:40px" onclick="like(${r.reviewNo})"><i class='bi bi-hand-thumbs-up'></i></button>
					</div>
					<div class="row align-items-center justify-content-center py-2">
					<hr>
					<textarea class="col-sm-9 mx-2" id="replyContent${r.reviewNo }" rows="5" cols="5" style="resize:none"></textarea>
	              <button class='btn btn-secondary col-sm-2' style="max-height:40px;" onclick="insertReply(${r.reviewNo })"><p style="font-size:0.8em; margin-bottom:0;">댓글작성</p></button>
					</div>
					<hr>
					
					<div id="reviewReply${r.reviewNo }" class="mb-3">
					</div>
					<c:choose>
					<c:when test="${not empty loginUser }">
					
					<script>
					
					$(function(){
						
						$.ajax({
							url : "/pjtMungHub/reviewReplyList.sp",
							data : { reviewNo : ${r.reviewNo}},
							success : function(result){
								var str="";
								if(result!=null){
									for (var i=0; i<result.length; i++) {
									str+="<div class='reviewReply row'>"
										+"<div class='col-10'>"
										+"<div><small style='color:gray'>"+result[i].userName+" "+formatDate(result[i].createDate)+"</small></div>"
										+"<div>"+result[i].replyContent+"</div>"
										+"</div>";
										if(result[i].userNo==${loginUser.userNo}){
											
										str+="<div class='col-1'>"
										+"<button style='background-color:transparent;border:0px;'"
										+"onclick='deleteReply("+result[i].replyNo+","+result[i].reviewNo+")'>"
										+"<i class='bi bi-x-lg'></i></button>";
										}
										str+="</div>"
										+"</div>";
									}
									$("#reviewReply${r.reviewNo }").html(str);
									
								}
							},
							error : function(){
								console.log("통신오류");	
							}
							
						});
						});
			
					</script>
					</c:when>
					<c:otherwise>
					<script>
					
					$(function(){
						
						$.ajax({
							url : "/pjtMungHub/reviewReplyList.sp",
							data : { reviewNo : ${r.reviewNo}},
							success : function(result){
								var str="";
								if(result!=null){
									for (var i=0; i<result.length; i++) {
									str+="<div class='reviewReply row'>"
										+"<div class='col-10'>"
										+"<div><small style='color:gray'>"+result[i].userName+" "+result[i].createDate+"</small></div>"
										+"<div>"+result[i].replyContent+"</div>"
										+"</div>"
										+"</div>"
										+"</div>";
									}
									$("#reviewReply${r.reviewNo }").html(str);
									
								}
							},
							error : function(){
								console.log("통신오류");	
							}
							
						});
						});
					
					</script>
					</c:otherwise>
					</c:choose>
					
						</div>
						
		       </div>
		       
	          	</div>
	          </div>
				</c:forEach>
				
				
				<c:if test="${not empty loginUser }">
				<script>
				function selectReplyList(num){
					$.ajax({
						url : "/pjtMungHub/reviewReplyList.sp",
						data : { reviewNo : num},
						success : function(result){
							var str="";
							if(result!=null){
								for (var i=0; i<result.length; i++) {
									str+="<div class='reviewReply row'>"
										+"<div class='col-10'>"
										+"<div><small style='color:gray'>"+result[i].userName+" "+result[i].createDate+"</small></div>"
										+"<div>"+result[i].replyContent+"</div>"
										+"</div>";
										if(result[i].userNo==${loginUser.userNo}){
											
										str+="<div class='col-1'>"
										+"<button style='background-color:transparent;border:0px;'"
										+"onclick='deleteReply("+result[i].replyNo+","+result[i].reviewNo+")'>"
										+"<i class='bi bi-x-lg'></i></button>";
										}
										str+="</div>"
										+"</div>";
									}
								$("#reviewReply"+num).html(str);
								
							}
						},
						error : function(){
							console.log("통신오류");	
						}
						
					});
				}
				
				
				
				
				
				function deleteReply(replyNo,reviewNo){
					$.ajax({
						url : "/pjtMungHub/deleteReply.sp",
						type : "post",
						data : {replyNo : replyNo},
						success : function(result){
							selectReplyList(reviewNo);
						},error : function(){
							console.log("통신오류");
						}
						
					});
				}
				
				
				function insertReply(num){
					
					var replyContent = $("#replyContent"+num).val();
					$.ajax({
						url : "/pjtMungHub/insertReviewReply.sp",
						type : "post",
						data : { reviewNo : num,
								 userNo : ${loginUser.userNo},
								 replyContent : replyContent },
						success : function(result){
							$("#replyContent"+num).val("");
							selectReplyList(num);
							
						},error : function(){
							console.log("통신오류");
						}
					
						
					});
					
				}
				
				function like(num){
					$.ajax({
						url : "/pjtMungHub/reviewLike.sp",
						type : "post",
						data : {userNo : ${loginUser.userNo},
								reviewNo : num},
						success : function(result){
							console.log(result);
							$("#likeCount"+num).text(result);
							$("#likeCountB"+num).text(result);
							selectReview();
							
							},error : function(){
							console.log("통신오류");
						}
					});
				}
				function likeModal(num){
					$.ajax({
						url : "/pjtMungHub/reviewLike.sp",
						type : "post",
						data : {userNo : ${loginUser.userNo},
								reviewNo : num},
						success : function(result){
							console.log(result);
							$("#likeCountT"+num).text(result);
							$("#likeCount"+num).text(result);
							$("#likeCountB"+num).text(result);
							$("#likeCountTmodal"+num).text(result);
							
							},error : function(){
							console.log("통신오류");
						}
					});
				}
				
				</script>
			</c:if>
			
			<c:if test="${empty loginUser }">
			<script>
			function like(num){
				alert("로그인 이후에 이용해주세요.");
			}
			function insertReply(num){
				alert("로그인 이후에 이용해주세요.")
			}
			</script>
			
			</c:if>
			
				
			</div>
		</div>
	</section>
	<section class="py-5">
		<div class="container">
			<h4>추천상품</h4>

			<div class="row row-cols-2 align-items-center mt-3 ml-3 mr-3">

				<c:forEach var="plist" items="${pList }" begin="1" end="4">
					<div class="col-sm-5 my-3 ">
						<div class="card"
							onclick="location.href='/pjtMungHub/detail.sp/${plist.productNo}'">
							<div>
								<img class="card-img-top" src="${plist.attachment }">
							</div>
							<div class="card-body" style="width: 250px;">
								<h5 class="card-title">${plist.productName }</h5>
									<div class="wrap-star">
								    <div class='review-star'>
								        <span style ="width: <fmt:formatNumber type="number" maxFractionDigits="0" value="${plist.reviewTScore * 20}" />%"></span>
								    </div>
									</div>
								<del>
									<fmt:formatNumber type="number" maxFractionDigits="0"
										value="${plist.price}" />
								</del>
								<fmt:formatNumber type="number" maxFractionDigits="0"
									value="${plist.price -(plist.price/plist.discount)}" />

								<strong style="color: rgb(250, 58, 14)">${plist.discount }%</strong>

							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>

	<section class="py-5">
		<div class="container">

			<ul class="nav nav-tabs nav-fill">
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="#detail-section01">상품상세정보</a></li>
				<li class="nav-item"><a class="nav-link"
					href="#detail-section02">상품리뷰</a></li>
				<li class="nav-item"><a class="nav-link"
					href="#detail-section03">상품문의</a></li>
			</ul>
		</div>
	</section>

			
	<section class="py-5">
		<div class="container" id="detail-section01">
			<h4>상품 설명</h4>
							<c:if test="${not empty loginUser and loginUser.userGrade>0 }">
								<c:choose>
								<c:when test="${not empty pDetail}">
								<div align="center">
									<a href="/pjtMungHub/updateDetailInfo/${p.productNo }" class="btn btn-warning">상품 상세정보 수정</a>
								</div>
								</c:when>
								<c:otherwise>
								<div align="center">
									<a href="/pjtMungHub/insertDetailInfo/${p.productNo }" class="btn btn-primary">상품 상세정보 작성</a>
								</div>
								</c:otherwise>
								</c:choose>
								</c:if>
		<c:if test="${not empty pDetail}">
			<table class="mt-5 py-5" align="center" style="border: 1px solid lightgray">
			
				<tbody>
					<tr>
						<td class="detail-tag">
							<p>품명 및 모델명</p>
						</td>
						<td class="detail-content">
							<p>${p.productName }</p>
						</td>
					</tr>
					<tr>
						<td class="detail-tag">
							<p>제조국 또는 원산지</p>
						</td>
						<td class="detail-content">
							<p>${pDetail.originContry }</p>
						</td>
					</tr>
					<tr>
						<td class="detail-tag">
							<p>제조자/수입자</p>
						</td>
						<td class="detail-content">
							<p>${pDetail.manufacturer }</p>
						</td>
					</tr>
					<tr>
						<td class="detail-tag">
							<p>소비자 상담관련 전화번호</p>
						</td>
						<td class="detail-content">
							<p>${pDetail.phone }</p>
						</td>
					</tr>
					<tr>
						<td class="detail-tag">
							<p>유통기한</p>
						</td>
						<td class="detail-content">
							<p>${pDetail.expireDate }</p>
						</td>
					</tr>
					<tr>
						<td class="detail-tag">
							<p>권장연령</p>
						</td>
						<td class="detail-content">
							<p>${pDetail.recommendedAge }</p>
						</td>
					</tr>
					<tr>
						<td class="detail-tag">
							<p>중량</p>
						</td>
						<td class="detail-content">
							<p>${pDetail.weight }</p>
						</td>
					</tr>
					<tr>
						<td class="detail-tag">
							<p>원료구성</p>
						</td>
						<td class="detail-content">
							<p>${pDetail.ingredient }</p>
						</td>
					</tr>
					<tr>
						<td class="detail-tag">
							<p>성분구성</p>
						</td>
						<td class="detail-content">
							<p>${pDetail.component }</p>
						</td>
					</tr>
				</tbody>

			</table>
			
			<div class="row py-5 justify-content-center" align="center">
			<c:forEach items="${dAtList }" var="dAt">
			      		<c:choose>
					    		<c:when test="${dAt.type eq 'video' }">
					    		<div class="col-sm-10">
					    	<video src="${dAt.filePath }${dAt.changeName}" class="img-fluid" style="width:100%" controls></video>
					    		</div>
					    		</c:when>
					    		<c:otherwise>
					    		<div class="col-sm-10">
					      <img src="${dAt.filePath }${dAt.changeName}" class="img-fluid" style="width:100%" >
					     			 </div>
					    		</c:otherwise>
					    	</c:choose>
					</c:forEach>
			</div>
		</c:if>
		
		<c:if test="${empty pDetail}">
		<div align="center" class='py-5'>
		<h1>작성대기중</h1>
		</div>
		</c:if>

		</div>
	</section>

	<section class="py-5">
		<div class="container">

			<ul class="nav nav-tabs nav-fill">
				<li class="nav-item"><a class="nav-link"
					href="#detail-section01">상품상세정보</a></li>
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="#detail-section02">상품리뷰</a></li>
				<li class="nav-item"><a class="nav-link"
					href="#detail-section03">상품문의</a></li>
			</ul>
		</div>
	</section>

	<div class="container" id="detail-section02">
		<h2>구매후기</h2>
		<div align="right" id="reviewBtnDiv">
		<button type="button" class="btn btn-primary position-relative" 
		<c:if test="${not empty loginUser }"> data-bs-toggle="modal" data-bs-target="#reviewModal"</c:if>
		id="reviewButton"> 
	<span class="position-absolute top-0 start-0 translate-middle badge rounded-pill bg-danger">
    <span class="visually-hidden">point alert</span> <small>작성 시 150P 적립!</small>
  </span>리뷰작성</button>
		</div>
		
		<c:if test="${empty loginUser }">
			<script>
			$(function(){
				$("#reviewButton").click(function(){
					alert("로그인 이후에 이용해 주세요.");
				});
			});
			
			</script>
		
		</c:if>
		
		
		<c:if test="${not empty loginUser }">
		
		<div class="modal fade" id="reviewModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="staticBackdropLabel">리뷰 쓰기</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		          <div class="mb-3">
	            <label for="review_writer" class="col-form-label">작성자:</label>
	            <p>${loginUser.name }</p>
	          </div>
	          <div class="mb-3">
	          <div class="star-rating">
			    <input type="radio" class="star" name="rate" value="1">
			    <input type="radio" class="star" name="rate" value="2">
			    <input type="radio" class="star" name="rate" value="3">
			    <input type="radio" class="star" name="rate" value="4">
			    <input type="radio" class="star" name="rate" value="5" checked>
			  </div>
	       
          	</div>
	          <div class="mb-3">
	            <label for="content" class="col-form-label">후기내용 :</label>
	            <textarea class="form-control" id="content"></textarea>
	            <label for="fileFlag" class="col-form-label">파일 첨부여부</label>
	            <input type="checkbox" id="fileFlag">
          </div>
				<script>
				
				$(function(){
					$("#file-insert").hide();
					
					$("#fileFlag").click(function(){
						
						if($("#fileFlag").is(":checked")){
							$("#file-insert").show();
						}else{
							$("#file-insert").hide();
						}
					});
					
					$.ajax({
						url: "/pjtMungHub/selectReivew.sp",
						data: {productNo : ${p.productNo},
							   userNo : ${loginUser.userNo}},
						success:function(result){
							if(result!=null && result!=""){
							var	str="";
							var btnDiv="";
							str+="<button type='button' class='btn btn-secondary'"
							+"data-bs-toggle='modal' data-bs-target='#reviewModal'"
							+"id='reviewButton'>리뷰수정</button>";
							
							btnDiv+="<button type='button'" 
							+"class='btn btn-secondary'" 
							+"data-bs-dismiss='modal'>취소</button>"
							+"<button type='button' class='btn btn-warning' onclick='reviewUpdate("+result.reviewNo+")'>수정하기</button>"
							$("#reviewBtnDiv").html(str);
							$("#reviewOption").html(btnDiv);
							}
							
						},error:function(){
							console.log("통신오류");
						}
					
						
					});
					
					
				});
				
				
					
				
				</script>          
           <div class="mb-3" id="file-insert">
          <ul class="nav nav-tabs nav-fill">
			  <li class="nav-item">
			    <button class="nav-link active" aria-current="page" id="insertPhoto">사진</button>
			  </li>
			  <li class="nav-item">
			    <button class="nav-link" aria-current="page" id="insertVideo">동영상</button>
			  </li>
			  </ul>
		  
		  	<div id="file">
		  		<img onclick='photo()' src="/pjtMungHub/resources/uploadFiles/common/css/MUNGHUB_logo.png" width="100%" id='loadedFile'>
				<input type='file' accept='image/*' id="uploadFile" onchange='loadFile(this)'>		  	
		  		<input type='hidden' value='image' id='type'>
		  	</div>
		  	</div>
		      </div>
		      <div class="modal-footer" id="reviewOption">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		        <button type="button" class="btn btn-primary" id="review-write">작성하기</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		
		<script>
		function photo(){
			$("#uploadFile").click();
		}
		
		function loadFile(inputFile){
			if(inputFile.files.length==1){
				var reader = new FileReader();
				
				reader.readAsDataURL(inputFile.files[0]);
				
				reader.onload =function(e){
						$("#loadedFile").attr("src",e.target.result);
						$("#loadedFile").removeAttr("poster");
					}
				}else{
					$("#loadedFile").attr("src",null);
			}
		}	
		
		$(function(){
			console.log("${orderItemArr}");
			var str="";
			$("#insertVideo").click(function(){
				$("#insertVideo").attr("class","nav-link active");
				$("#insertPhoto").attr("class","nav-link");
				str+="<video src='...' poster='/pjtMungHub/resources/uploadFiles/common/css/MUNGHUB_logo.png' width='100%' id='loadedFile' controls></video>";
				str+="<input type='file' accept='video/*' id='uploadFile' onchange='loadFile(this)'>";
				str+="<input type='hidden' value='video' id='type'>"
				$("#file").html(str);
				str="";
			});
			
			$("#insertPhoto").click(function(){
				$("#insertPhoto").attr("class","nav-link active");
				$("#insertVideo").attr("class","nav-link");
				str+="<img onclick='photo()' src='/pjtMungHub/resources/uploadFiles/common/css/MUNGHUB_logo.png' width='100%' id='loadedFile'>";
				str+="<input type='file' accept='image/*' id='uploadFile' onchange='loadFile(this)'>";
				str+="<input type='hidden' value='picture' id='type'>"
				$("#file").html(str);
				str="";
			
			
			});
			
			$("#review-write").click(function(){
			
				const dupArr=${orderItemArr};
				const set = new Set(dupArr);
				const uniqueArr = [...set];
				
				var flag=false;
				
				for (var i = 0; i < uniqueArr.length; i++) {
					if(uniqueArr[i]==${p.productNo}){
						flag=true;
					}
					
				}
				
				if(flag){
			
				if($("#content").val()!=""){
					
				
				
				    var requestData = {userNo : ${loginUser.userNo},
							productNo : ${p.productNo},
							reviewContent : $("#content").val(),
							score : $("input[name='rate']:checked").val(),
							type : $("#type").val()}

				    var formData = new FormData();
				    formData.append("uploadFile", $("#uploadFile")[0].files[0]);
				    formData.append("review", new Blob([JSON.stringify(requestData)], {type: "application/json"}));
				
				
				$.ajax({
					url : "/pjtMungHub/insertReview.sp",
					type : "post",
					contentType: false, // 필수 : x-www-form-urlencoded로 파싱되는 것을 방지
				    processData: false,  // 필수: contentType을 false로 줬을 때 QueryString 자동 설정됨. 해제
					data : formData,
					success : function(result){
						$('#reviewModal').modal('hide');
						alertify
						  .alert("작성이 완료되었습니다.", function(){
						    alertify.success('마일리지가 적립되었습니다. 150P+');
						    selectReview();
						  });
					},error : function(){
						console.log("통신 오류");
					}
					
					
				});
			}else{
				alert("리뷰 내용을 작성해주세요.");
			}
				}else{
					alert("제품을 수령받으신 이후에 작성하실 수 있습니다.");
				}
			});
			
			
			
		});
		
		function reviewUpdate(num){
			
		if($("#content").val()!=""){
			
		
		    var requestData = {userNo : ${loginUser.userNo},
					productNo : ${p.productNo},
					reviewContent : $("#content").val(),
					score : $("input[name='rate']:checked").val(),
					type : $("#type").val(),
					reviewNo : num}

		    var formData = new FormData();
		    formData.append("uploadFile", $("#uploadFile")[0].files[0]);
		    formData.append("review", new Blob([JSON.stringify(requestData)], {type: "application/json"}));
		
		
		$.ajax({
			url : "/pjtMungHub/updateReview.sp",
			type : "post",
			contentType: false, // 필수 : x-www-form-urlencoded로 파싱되는 것을 방지
		    processData: false,  // 필수: contentType을 false로 줬을 때 QueryString 자동 설정됨. 해제
			data : formData,
			success : function(result){
				$('#reviewModal').modal('hide');
				alertify
				  .alert("수정이 완료되었습니다.", function(){
				    selectReview();
				  });
			},error : function(){
				console.log("통신 오류");
			}
			
			
				});
		}else{
			alert("리뷰내용을 작성해주세요.");
		}
			}
		
				
		</script>
		
		</c:if>
		

		<div class="py-5" align="center">
			<div class="row row-cols-2 align-items-center mt-3 ml-3 mr-3">
				<div class="col-sm-5">
					<h2>
						<fmt:formatNumber type="number" maxFractionDigits="1"
							value="${p.reviewTScore}" />
					</h2>
					<div class="star-wrap">
					<div class="review-star" align="left">
					<span style="width: ${p.reviewTScore*20}%"></span>
					</div>
					</div>
					
					 <span>총 <fmt:formatNumber type="number"
							maxFractionDigits="0" value="${p.reviewCount }" />건
					</span><br> <span style="color: gray">만족도 ${percent[0].percent}%</span>
				</div>
				<div class="col-sm-5">
				<c:forEach begin="0" end="4" varStatus="index">
				
					<div class="score">${5-index.index }점</div>
					<div class="progress my-1">
					<c:forEach begin="0" end="4" varStatus="i">
					<c:if test="${5-index.index eq percent[i.index].score }">
						<div class="progress-bar bg-warning" role="progressbar"
							style="width: ${percent[i.index].percent }%" aria-valuenow="75" aria-valuemin="0"
							aria-valuemax="100"></div>
					</c:if>
					</c:forEach>
					</div>
					<br>
				</c:forEach>
				</div>
			</div>
		</div>
		<h4>
			전체후기 <span id="totalReviewCount"><fmt:formatNumber type="number"
					maxFractionDigits="0" value="${p.reviewCount }" />건</span>
		</h4>

		<hr>
		
		<script type="text/javascript">
		
		
		   //날짜 포맷 변환 함수
        function formatDate(datetime) {
            //문자열 날짜 데이터를 날짜객체로 변환
            const dateObj = new Date(datetime);
            // 그냥은 못 가져오니까 Date 객체에 담는다 
           //그러면 string 으로 받을수 있다
 
            //날짜객체를 통해 각 날짜 정보 얻기
            let year = dateObj.getFullYear();
            //1월이 0으로 설정되어있음.
            let month = dateObj.getMonth() + 1;
            let day = dateObj.getDate();
            (month < 10) ? month = '0' + month: month;
            (day < 10) ? day = '0' + day: day;
            return year + "-" + month + "-" + day;
        }

		
		
		$(function(){
			selectReview();
		});
		
		function selectReview(){
			var str="";
			$.ajax({
				url: "/pjtMungHub/reviewList.sp",
				data : {productNo : ${p.productNo},
						justifying : $("input[name='orderBy']:checked").val(),
						star : 0,
						amount : 10
						},
					
			success : function(result){
					
					var modal="";
					for (var i = 0; i < result.length; i++) {
					var img="";
						for (var k = 0; k < result[i].atList.length; k++) {
						if(result[i].atList[k].type=='video'){
						img+="<video src='"+result[i].atList[k].filePath+result[i].atList[k].changeName+"' style='max-height: 300px;' controls/>";
						}else{
							
				 		img+="<img src='"+result[i].atList[k].filePath+result[i].atList[k].changeName+"' class='img-fluid' style='max-height: 300px;'>";
						}
				 			
						}
					str+="<div class='col-10 mb-4' >"
	                +"<div class='card'>"
	                +"<div class='media-container p-3'>"
	                +img
	                +"</div>"
	                +"<div class='card-body'>"
	                +"<h5 class='card-title'>"+result[i].userName+"</h5>"
	                +"<div class='wrap-star'>"
				    +"<div class='review-star'>"
				    +"<span style ='width: "+(result[i].score*20)+"%'></span>"
				    +"</div>"
					+"</div>"
	                +"<h6 class='card-subtitle mb-2 text-muted'>"+formatDate(result[i].createDate)+"</h6>"
	                +"<p class='card-text'>"+result[i].reviewContent+"</p>"
	                +"<div class='btn-div' align='right'>"
	                +"<span class='mx-3' id='likeCountT"+result[i].reviewNo+"'>"+result[i].likeCount+"</span>"
	                +"<button class='btn btn-primary' onclick='like("+result[i].reviewNo+")'><i class='bi bi-hand-thumbs-up'></i></button>"
	                +"<button class='btn btn-secondary' data-bs-toggle='modal' data-bs-target='#reviewDetailModal"+result[i].reviewNo+"'>댓글보기</button>"
	                +"</div>"
	                +"</div>"
	                +"</div>"
		            +"</div>"
					+"</div>";
					
					modal+="<div class='modal fade' id='reviewDetailModal"+result[i].reviewNo+"'" 
					+"data-bs-backdrop='static' data-bs-keyboard='false'"
					+"tabindex='-1' aria-labelledby='staticBackdropLabel' aria-hidden='true'>"
					+"<div class='modal-dialog'>"
					+"<div class='modal-content'>"
					+"<div class='modal-header'>"
					+"<h1 class='modal-title fs-5' id='staticBackdropLabel'>리뷰 보기</h1>"
					+"<button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close'></button>"
					+"</div>"
					+"<div class='modal-body'>"
					+"<div class='media-container'>"
					+img      
					+"</div>"
					+"<div class='wrap-star'>"
					+"<div class='review-star'>"
					+"<span style ='width: "+(result[i].score*20)+"%'></span>"
					+"</div>"
					+"</div>"
					+"<div class='row align-items-center justify-content-center'>"
					+"<div class='col-sm-10'>"
					+"<small class='text-muted'>"+result[i].userName+"</small>"
					+"<small class='text-muted'>"+formatDate(result[i].createDate)+"</small>"
					+"<p>"+result[i].reviewContent+"</p>"
					+"</div>"
					+"<div class='col-sm-1' id='likeCountTmodal"+result[i].reviewNo+"' align='center'>"
					+result[i].likeCount
					+"</div>"
					+"<button class='btn btn-primary col-sm-1' style='max-height:40px' onclick='likeModal("+result[i].reviewNo+")'><i class='bi bi-hand-thumbs-up'></i></button>"
					+"</div>"
					+"<div class='row align-items-center justify-content-center py-2'>"
					+"<hr>"
					+"<textarea class='col-sm-9 mx-2' id='replyContent"+result[i].reviewNo+"' rows='5' cols='5' style='resize:none'></textarea>"
				    +"<button class='btn btn-secondary col-sm-2' style='max-height:40px;' onclick='insertReply("+result[i].reviewNo+")'><p style='font-size:0.8em; margin-bottom:0;'>댓글작성</p></button>"
					+"</div>"
					+"<hr>"
					+"<div id='reviewReply"+result[i].reviewNo+"' class='pb-3'>"
					+"</div>"
					+"</div>"
					+"</div>"
					+"</div>"
					+"</div>";
					}
					if(str!=""){
						
					str+="<a class='btn btn-info' href='/pjtMungHub/reviewListAll.sp/${p.productNo}'>전체 리뷰보기</a>";
					}else{
						str+="<h1 align='center' class='py-5'>리뷰가 없습니다.</h1>"
					}
					$("#review_area").html(str+modal);
					
					$.ajax({
						url : "/pjtMungHub/selectReviewCount.sp",
						data : {productNo : ${p.productNo}},
						success : function(result){
							
						$("#totalReviewCount").text(result);
						},error : function(){
							console.log("통신오류");
						}
						
					});
				},
				error: function(){
					console.log("통신오류");
				}
			});
				
			
		};
			
		
		
		</script>
	<div class="container mt-5">
	<div align="right">
	<label for="topRate">추천순</label><input type="radio" id="topRate" name="orderBy" value="topRate" checked onclick="selectReview()">
	<label for="latest">최신순</label><input type="radio" id="latest" name="orderBy" value="latest" onclick="selectReview()">
	</div>
	<div class='row justify-content-center mt-3' id='review_area'>
	</div>
	</div>
</div>
	<section class="py-5">
		<div class="container" id="detail-section03">

			<ul class="nav nav-tabs nav-fill">
				<li class="nav-item"><a class="nav-link"
					href="#detail-section01">상품상세정보</a></li>
				<li class="nav-item"><a class="nav-link"
					href="#detail-section02">상품리뷰</a></li>
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="#detail-section03">상품문의</a></li>
			</ul>
		</div>


	</section>

	<div class="container" id="detail-section03">
		<h2>
			상품문의 <span id="questionCount" style="color: gray; font-size: 16px;">()</span>
		</h2>

		<hr>
		<div class="d-grid gap-2 d-md-block qna">
			<a href="" class="btn btn-outline-secondary flex-shrink-0">1:1 문의하기</a> 
			<button type="button" class="btn btn-outline-dark flex-shrink-0"
			data-bs-toggle="modal" data-bs-target="#insertQuestionModal">상품 문의하기</button>
		</div>

			<div class="modal fade" id="insertQuestionModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		  <div class="modal-dialog modal-sm modal-dialog-centered">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="staticBackdropLabel">문의하기</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body" align="center">
		      <div class="py-2">
		      <select id="category">
		      	<c:forEach items="${cList }" var="c">
		      		<option value="${c.categoryNo }">${c.categoryName }</option>
		      	</c:forEach>
		      </select>
		      <label for="openStatus">비밀글</label><input type="checkbox" id="openStatus" checked>
		      </div>
		        <textarea rows="10" cols="30" id="Qcontent"></textarea>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		        <button type="button" onclick="insertQuestion()" class="btn btn-primary">작성</button>
		      </div>
		    </div>
		  </div>
		</div>


		<c:if test="${not empty loginUser }">
		<script>
			function insertQuestion(){
				var openStatus="";
				if($("#openStatus").is(":checked")){
				openStatus='N';
				}else{
				openStatus='Y';
				}
			$.ajax({
				url: "/pjtMungHub/insertQuestion.sp",
				type : "post",
				data : {userNo : ${loginUser.userNo}
						,content: $("#Qcontent").val()
						,productNo : ${p.productNo}
						,categoryNo : $("#category option:selected").val()
						,openStatus : openStatus
						},
				success : function(result){
					selectQuestionList(1);
					
					

					alertify
					  .alert("문의글 작성완료","문의가 완료되었습니다. 최대한 빨리 답변할 수 있도록 노력하겠습니다.");
					$('#insertQuestionModal').modal('hide');
				},error : function(){
					console.log("통신오류");
				}
					
			});
		}
		</script>
		</c:if>
		
		<c:if test="${empty loginUser }">
		<script>
		function insertQuestion(){
			alert("로그인 이후에 이용해주세요.");
		}
		</script>
		
		</c:if>


		<table class="table table-borderless" id="question-area">
		</table>
		
		<div align="center" id="pagination-container"></div>
	</div>
	
	<script>
		function noAuth(){
			alert("해당 문의를 조회할 권한이 없습니다.");
		}	
	
	
		function selectQuestionList(num){
			$.ajax({
				url: "/pjtMungHub/questionList.sp",
				data : {productNo : ${p.productNo},
						currentPage : num},
				success : function(result){
					var str="";
					var pagination="";
					var userNo="${loginUser.userNo}";
					for (var i = 0; i < result.qList.length; i++) {
						str+="<tr class='question-list'>";
						if(result.qList[i].answerStatus=='Y'){
						str+="<td class='answerd'><p>답변완료</p></td>";
						}else{
						str+="<td class='wating-answer'><p>답변대기</p></td>";
						}
						
						if(result.qList[i].openStatus=='N'){
						  if(${loginUser.userGrade>0}){
							  
							  str+="<td><a href='/pjtMungHub/qnaPage.sp/"+result.qList[i].questionNo+"'>["+result.qList[i].categoryName+"]입니다.";
							  str+="<i class='bi bi-lock-fill'></i>";
						  }else{
							if(${empty loginUser}){
							str+="<td><button type='button' onclick='noAuth()'>["+result.qList[i].categoryName+"]입니다.<i class='bi bi-lock-fill'></i></button>";
							}else if(userNo!=result.qList[i].userNo){
							str+="<td><button type='button' onclick='noAuth()'>["+result.qList[i].categoryName+"]입니다.<i class='bi bi-lock-fill'></i></button>";
							}else{
							str+="<td><a href='/pjtMungHub/qnaPage.sp/"+result.qList[i].questionNo+"'>["+result.qList[i].categoryName+"]입니다.";
							str+="<i class='bi bi-lock-fill'></i>";
							}
							
						  }
						}else{
							str+="<td><a href='/pjtMungHub/qnaPage.sp/"+result.qList[i].questionNo+"'>["+result.qList[i].categoryName+"]입니다.";
							str+="<i class='bi bi-unlock'></i>";
						}
						str+="</td>"
						+"<td>"+result.qList[i].userName+"</td>"
						+"<td>"+formatDate(result.qList[i].createDate)+"</td>"
						+"</tr>";
					}
					
					pagination+="<nav>"
					+"<ul class='pagination justify-content-center'>";
					if(result.pi.currentPage>1){
						pagination+="<li class='page-item'><button class='page-link' onclick='selectQuestionList("+(result.pi.currentPage-1)+")'>이전</button></li>";
					}
					for (var i = 1; i <= result.pi.endPage; i++) {
						if(result.pi.currentPage==i){
							pagination+="<li class='page-item disabled'><button class='page-link'>"+i+"</button></li>"
						}else{
							pagination+="<li class='page-item'><button class='page-link' onclick='selectQuestionList("+i+")'>"+i+"</button></li>"
						}
					}
					
					if(result.pi.currentPage<result.pi.maxPage){
						if(result.pi.maxPage>0){
							
						pagination+="<li class='page-item'><button class='page-link' onclick='selectQuestionList("+(result.pi.currentPage+1)+")'>다음</button></li>"
						}
					}
					pagination+=" </ul></nav>";
					
					$("#questionCount").text("("+result.pi.listCount+")");
					$("#question-area").html(str);
					$("#pagination-container").html(pagination);
				},error : function(){
					console.log("통신오류");
				}
			});
		}
		
		$(function(){
			selectQuestionList(1);
		})
	
	</script>


	<br>
	<br>
</body>
</html>