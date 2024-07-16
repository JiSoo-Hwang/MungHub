<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<meta charset="UTF-8">
<title>MUNGHUBSHOP</title>
<style>
@import url("https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css");

.card{
cursor: pointer;
}

.card-img-top{
position : relative;
 display: block;
 height: 300px; 
 width: 200px;
 filter: brightness(1);
 transition: 0.3s;
}
.card-img-top:hover{
 filter: brightness(0.7);
}


.star-rating {width:100px; }
.star-rating,.star-rating span {display:inline-block; height:24px; overflow:hidden; background:url(resources/uploadFiles/shopFile/productFile/common/star.png)no-repeat; }
.star-rating span{background-position:left bottom; line-height:0; vertical-align:top; }

</style>
</head>
<body>

<%@ include file="../common/header.jsp" %>

<div class="container">


<div align="right" class="py-5">
<a class="btn btn-outline-dark position-relative me-2" href="cart.sp"><i class="bi bi-cart3">
</i> 장바구니 
<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" 
id="cart-count"></span></a>
<a href="/pjtMungHub/orderList/${loginUser.userNo }" class="btn btn-secondary">주문 내역 보기</a>
</div>

<div class="jumbotron">
<div id="carouselExampleIndicators" class="carousel slide">
  <div class="carousel-indicators">
   <c:forEach items="${mainSlide }" var="main" varStatus="i">
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${i.index }" <c:if test="${i.index eq 0 }">class="active" aria-current="true"</c:if> aria-label="Slide ${i.count }"></button>
   </c:forEach>
  </div>
  <div class="carousel-inner">
  <c:forEach items="${mainSlide }" var="main" varStatus="i">
    <div class="carousel-item <c:if test="${i.index eq 0 }"> active</c:if>">
      <img src="${main.filePath }${main.changeName}" class="d-block w-100 img-fluid" alt="...">
    </div>
  </c:forEach>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
</div>

<script>
$(function(){
	console.log("${mainSlide}");
	$.ajax({
		url : "/pjtMungHub/cartCount.sp",
		data : {userNo : "${loginUser.userNo}"},
		success : function(result){
			if(result!=0){
				
			$("#cart-count").text(result)
			}
		},
		error : function(){
			console.log("통신오류")
		}
	});
});
</script>





<c:if test="${loginUser.userGrade > 0 }">
<div id="adminMenu" align="center">
<a class="btn btn-info" href="/pjtMungHub/adminPage/dashBoard">관리자 페이지</a>
<a class="btn btn-primary" href="/pjtMungHub/insert.sp">상품등록</a>
<c:choose>
<c:when test="${empty notPostList}">
<a class="btn btn-warning" href="/pjtMungHub/notPosted.sp">상품게시중단목록</a>
</c:when>
<c:otherwise>
<a class="btn btn-secondary" href="/pjtMungHub/list.sp">상품게시목록</a>
</c:otherwise>
</c:choose>
</div>
</c:if>
<div class="row align-items-center">
<c:forEach items="${pList }" var="p" varStatus="status">
<div class="col-lg-3 my-3 ">
	<div class="card" onclick="location.href='detail.sp/${p.productNo}'">
	<div>
	<c:choose>
	<c:when test="${atList[status.index].type eq 'video' }">
		<video class="card-img-top img-fluid" src="${atList[status.index].filePath }${atList[status.index].changeName}" autoplay loop></video>
	</c:when>
	<c:otherwise>
	<img class="card-img-top img-fluid" src="${atList[status.index].filePath }${atList[status.index].changeName}">
	</c:otherwise>
	</c:choose>
	</div>
	<div class="card-body" style="width:250px;">
		<h5 class="card-title">${p.productName }</h5>
				<div class="wrap-star">
			    <div class='star-rating'>
			        <span style ="width: <fmt:formatNumber type="number" maxFractionDigits="0" value="${p.reviewTScore * 20}" />%"></span>
			    </div>
				</div>
			<span>(<fmt:formatNumber type="number" maxFractionDigits="0" value="${p.reviewCount }" />)</span>
		<br> 
		<del><fmt:formatNumber type="number" maxFractionDigits="0" value="${p.price}" /></del>
		<fmt:formatNumber type="number" maxFractionDigits="0" value="${p.price -(p.price/p.discount)}" />

		<strong style="color:rgb(250, 58, 14)">${p.discount }%</strong>
		
		<button class="btn btn-outline-dark flex-shrink-0" type="button" 
		name="proventBubbling" id="favor${p.productNo }" 
		onclick="convertFavor(${p.productNo});">
		<i class="bi bi-heart"></i>
		</button>
	</div> 
	</div>
</div>
</c:forEach>
</div>
</div>
<c:if test="${not empty loginUser }">
<script>

function selectFavor(){
	
	$.ajax({
		url : "/pjtMungHub/selectFavoriteList.sp",
		data : { userNo:${loginUser.userNo}
				 },
		success : function (result){
			for(var i=0; result.length; i++){
			$("#favor"+result[i].productNo).html("<i class='bi bi-heart-fill' style='color:red'></i>");
				
			}
		},
		error:function(){
			console.log("통신오류");
		}
		
	});
	}


function convertFavor(num){
	 
	 $.ajax({
		 url : "/pjtMungHub/subscribe.sp",
		 type : "post",
		 data : { userNo:${loginUser.userNo}
	 			,productNo : num
			 	  },
		success : function(result){
			$("#favor"+num).html("<i class='bi bi-heart'></i>");
			selectFavor();
		},
		error : function(){
			console.log("통신오류");
		}
	 });
}

$(function(){
		
	selectFavor();
	
	
	

 });
 
	$("button[name=proventBubbling]").click(function(e){
			e.stopPropagation();
			selectFavor();
		});



</script>
</c:if>

<br> <br>
</body>
</html>