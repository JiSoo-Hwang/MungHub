<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대시보드</title>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
   <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }
        .sidebar {
            height: 100vh;
            background-color: #343a40;
            color: white;
            padding-top: 20px;
            position: fixed;
            width: 220px;
        }
        .sidebar a {
            color: white;
            padding: 15px;
            text-decoration: none;
            display: block;
            font-weight: bold;
        }
        .sidebar a:hover {
            background-color: #495057;
        }
        .main-content {
            margin-left: 240px;
            padding: 20px;
        }
        .card-custom {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        .card-header-custom {
            background-color: #5a67d8;
            color: white;
            padding: 10px;
            border-radius: 8px 8px 0 0;
        }
        .chart {
            height: 300px;
        }
        .stat-icon {
            font-size: 1.5rem;
        }
        .stat-icon.positive {
            color: green;
        }
        .stat-icon.negative {
            color: red;
        }
        
        
        .card a{
        text-decoration: none;
        color : black;
        }
    </style>
</head>
<body>
<%@include file="../common/header.jsp" %>
    <div class="sidebar">
        <h4 class="text-center">물품관리</h4>
        <a href="/pjtMungHub/adminPage/dashBoard">대시보드</a>
        <a href="/pjtMungHub/adminPage/orderControll">주문 관리</a>
        <a href="/pjtMungHub/adminPage/productControll">제품 관리</a>
        <a href="/pjtMungHub/adminPage/customerControll">고객 관리</a>
        <a href="/pjtMungHub/adminPage/eventControll">이벤트 관리</a>
    </div>

    <div class="main-content">
  <div class="container mt-5">
  <h1 class="text-center mb-4">제품 관리 관리자 페이지</h1>
  
  
  <div class="row justify-content-center py-5">
  <!-- 판매량 순위 -->
  <div class="card mb-4 col col-md-5 mx-3">
    <div class="card-header">
      <h2>제품 판매량 순위 TOP 5</h2>
    </div>
    <div class="card-body">
      <h5>가장 높은 상품</h5>
      <ul id="highest-selling">
      </ul>
      <h5>가장 저조한 상품</h5>
      <ul id="lowest-selling">
      </ul>
    </div>
  </div>

  <!-- 브랜드 판매량 순위 -->
  <div class="card col col-md-5 mx-3">
    <div class="card-header">
      <h2>브랜드 판매량 순위 TOP5</h2>
    </div>
    <div class="card-body">
    	<h5>가장 높은 브랜드</h5>
      <ul id="high-brand-ranking">
      </ul>
      <h5>가장 낮은 브랜드</h5>
      <ul id="low-brand-ranking">
      	
      </ul>
    </div>
  </div>
</div>

<div class="row justify-content-center py-5">
  <!-- 매출 순위 -->
  <div class="card mb-4 col col-md-5 mx-3">
    <div class="card-header">
      <h2>제품 매출 순위 TOP 5</h2>
    </div>
    <div class="card-body">
      <h5>가장 높은 상품</h5>
      <ul id="highest-selling-sal">
      </ul>
      <h5>가장 저조한 상품</h5>
      <ul id="lowest-selling-sal">
      </ul>
    </div>
  </div>

  <!-- 브랜드 매출 순위 -->
  <div class="card col col-md-5 mx-3">
    <div class="card-header">
      <h2>브랜드 매출 순위 TOP5</h2>
    </div>
    <div class="card-body">
    	<h5>가장 높은 브랜드</h5>
      <ul id="high-brand-ranking-sal">
      </ul>
      <h5>가장 낮은 브랜드</h5>
      <ul id="low-brand-ranking-sal">
      	
      </ul>
    </div>
  </div>
</div>
  
  <div align="center">
  <button class="btn btn-primary mb-3" onclick="location.href='/pjtMungHub/insert.sp'">신제품 등록</button>
  <button class="btn btn-info mb-3" data-bs-toggle="modal" data-bs-target="#categoryModal">카테고리 관리</button>
  </div>
  
  <div class="modal fade" id="categoryModal" tabindex="-1" aria-labelledby="categoryModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">카테고리 관리</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
       <div class="form-group">
       		<label for="categoryName">카테고리 추가</label>
            <input type="text" class="form-control" id="categoryName">
            <br>
             <button type="button" class="btn btn-primary" onclick="insertCategory()">추가</button>
            <hr>
            <label for="categoryUpdateSelect">카테고리 수정</label>
            <select class="form-select my-3" id="categoryUpdateSelect">
			</select>
			<label for="categoryUpdateName">수정할 이름</label>
            <input type="text" class="form-control" id="categoryUpdateName">
            <br>
            <button type="button" class="btn btn-warning" onclick="updateCategory()">수정</button>
            <button type="button" class="btn btn-danger" onclick="deleteCategory()">삭제</button>
       </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
  
  
  
  <!-- 제품 리스트 테이블 -->
  <div class="card mb-4">
    <div class="card-header">
      <h2>제품 리스트
       <input type="radio" class="btn-check" name="productOrderBy" value="PRODUCT_NO" id="product1" onclick="selectProductList(1)" autocomplete="off" checked>
	  <label class="btn btn-secondary" for="product1">번호</label>
	  <input type="radio" class="btn-check" name="productOrderBy" value="PRODUCT_NAME" id="product2" onclick="selectProductList(1)" autocomplete="off">
	<label class="btn btn-secondary" for="product2">제품명</label>
	<input type="radio" class="btn-check" name="productOrderBy" value="BRAND_NAME" id="product3" onclick="selectProductList(1)" autocomplete="off">
	<label class="btn btn-secondary" for="product3">브랜드명</label>
      <input type="radio" class="btn-check" name="productOrderBy" value="PRICE" id="product4" onclick="selectProductList(1)" autocomplete="off">
	<label class="btn btn-secondary" for="product4">가격</label>
	<input type="radio" class="btn-check" name="productOrderBy" value="SALES_COUNT" id="product5" onclick="selectProductList(1)" autocomplete="off">
	<label class="btn btn-secondary" for="product5">판매율</label>
	
	<input type="checkbox" class="btn-check" id="pDesc" autocomplete="off" onclick="selectProductList(1)" checked>
	<label class="btn btn-outline-primary" for="pDesc">역순</label>
	
	<input type="checkbox" class="btn-check" id="notPostedP" autocomplete="off" onclick="selectProductList(1)">
	<label class="btn btn-outline-danger" for="notPostedP">게시중단상품</label>
	<select class="form-select my-3" id="category" onchange="selectProductList(1)">
	<option selected value='0'>전체(카테고리)</option>
	</select>
      </h2>
    </div>
    <div class="card-body">
      <table class="table table-bordered">
        <thead>
          <tr>
            <th>제품 ID</th>
            <th>제품명</th>
            <th>브랜드</th>
            <th>카테고리</th>
            <th>가격</th>
            <th>판매율</th>
            <th>관리</th>
          </tr>
        </thead>
        <tbody id="product-list">
          <!-- 여기에 제품 정보가 동적으로 추가될 예정 -->
        </tbody>
      </table>
    </div>
      <div class="card-footer" id="pagination">
      
  </div>
    
  </div>
  
  <script>
  
  $(function(){
	  selectTopSalesProduct();
	  selectTopSalesBrand();
	  selectProductList(1);
	  selectBrandList();
	  selectCategory();
	  
  });
  
  function selectCategory(){
	  $.ajax({
		  url : "/pjtMungHub/selectCategory.sp",
		  success:function(result){
			  var str="<option selected value='0'>전체(카테고리)</option>";
			  var str2="";
			  for (var i = 0; i < result.length; i++) {
				str+="<option value='"+result[i].categoryNo+"'>"+result[i].categoryName+"</option>"
				str2+="<option value='"+result[i].categoryNo+"'>"+result[i].categoryName+"</option>"
			
			  }
			  
			  $("#category").html(str);
			  $("#categoryUpdateSelect").html(str2);
		  },error:function(){
			  console.log("통신오류");
		  }
	  });
  }
  
  function insertCategory(){
	  if($("#categoryName").val()!=""){
		  
	  
	  $.ajax({
		  url : "/pjtMungHub/insertCategory.sp",
		  type : "post",
		  data: {categoryName : $("#categoryName").val() },
		  success:function(result){
			  alert("카테고리가 추가되었습니다.");
			  selectCategory();
		  },error:function(){
			  console.log("통신오류");
		  }
	  	
	  });
	  }else{
		  alert("카테고리 명을 입력해 주세요");
	  }
  }
  
  function updateCategory(){
	  if($("#categoryUpdateName").val()!=""){
		  
	  
	  $.ajax({
		 url : "/pjtMungHub/updateCategory.sp",
		 type: "post",
		 data : {categoryName : $("#categoryUpdateName").val(),
			 	 categoryNo : $("#categoryUpdateSelect option:selected").val()},
		success: function(result){
			alert("수정이 완료되었습니다.");
			selectCategory();
		},error: function(){
			console.log("통신오류");
		}
	  	
	  });
	  }else{
		  alert("수정할 이름을 입력해주세요.");
	  }
  }
  
  function deleteCategory(){
	  if(confirm("해당 카테고리와 연동된 데이터가 같이 삭제됩니다. 정말 지우시겠습니까?")){
		  
	  
	  $.ajax({
			 url : "/pjtMungHub/deleteCategory.sp",
			 type: "post",
			 data : {categoryNo : $("#categoryUpdateSelect option:selected").val()},
			success: function(result){
				alert("삭제가 완료되었습니다.");
				selectCategory();
			},error: function(){
				console.log("통신오류");
			}
		  	
		  });
		  }
		  }
  
  
  
  
  function selectTopSalesProduct(){
	  $.ajax({
		  url : "/pjtMungHub/selectTopSalesProduct.sp",
		  success : function(result){
			  
			  var str="";
			  for (var i = 0; i < result.pList.length; i++) {
				
			  str += "<li><a href='/pjtMungHub/detail.sp/"+result.pList[i].productNo+"'>"
			  +(i+1)+"위: 품번["+result.pList[i].productNo+"] "+result.pList[i].productName+"</a> ("+result.pList[i].salesCount+")</li>";
			  
			       		
			}
			  
			  $("#highest-selling").html(str);
			  
			  str="";
			  
			  for (var i = 0; i < result.lowList.length; i++) {
				
				  str += "<li><a href='/pjtMungHub/detail.sp/"+result.lowList[i].productNo+"'>"
				  +(i+1)+"위: 품번["+result.lowList[i].productNo+"] "+result.lowList[i].productName+"</a> ("+result.lowList[i].salesCount+")</li>";
				  
				  
			}
			  
			  $("#lowest-selling").html(str);
			  
			  str="";
			  for (var i = 0; i < result.highSal.length; i++) {
			
				  var price=result.highSal[i].price;
				  var discount=result.highSal[i].discount;
				  
				  var totalPrice=price-(price/discount);
				  
			  str += "<li><a href='/pjtMungHub/detail.sp/"+result.highSal[i].productNo+"'>"
			  +(i+1)+"위: 품번["+result.highSal[i].productNo+"] "+result.highSal[i].productName+"</a>" 
			  +" ("+result.highSal[i].salesCount*totalPrice+"원)</li>";
			  
			       		
			}
			  
			  $("#highest-selling-sal").html(str);
			  
			  str="";
			  
			  for (var i = 0; i < result.lowSal.length; i++) {

				  var price=result.lowSal[i].price;
				  var discount=result.lowSal[i].discount;
				  
				  var totalPrice=price-(price/discount);
				  
				
				  
			  str += "<li><a href='/pjtMungHub/detail.sp/"+result.lowList[i].productNo+"'>"
			  +(i+1)+"위: 품번["+result.lowSal[i].productNo+"] "+result.lowSal[i].productName+"</a>" 
			  +" ("+result.lowSal[i].salesCount*totalPrice+"원)</li>";
				  
			}
			  
			  $("#lowest-selling-sal").html(str);
			  
		  },
		  error : function(){
			  console.log("통신오류");
		  }
		  
	  });
  }
  
  function selectTopSalesBrand(){
	  $.ajax({
		  url : "/pjtMungHub/selectTopSalesBrand.sp",
		  success : function(result){
			  var str="";
			  
			  
			  for (var i = 0; i < result.pList.length; i++) {
					
				  str += "<li>"+(i+1)+"위: 코드["+result.pList[i].brandCode+"] "
				  +result.pList[i].brandName 
				  +"("+result.pList[i].brandSalesCount+")</li>";
				  
				       		
				}
			  
			 
			  $("#high-brand-ranking").html(str);
			 str=""; 
			  
			  for (var i = 0; i < result.lowList.length; i++) {
					
				  str += "<li>"+(i+1)+"위: 코드["+result.lowList[i].brandCode+"] "
				  +result.pList[i].brandName 
				  +"("+result.lowList[i].brandSalesCount+")</li>";
				       		
				}
			  
			  $("#low-brand-ranking").html(str);
			  str="";
			  
			  for (var i = 0; i < result.highSal.length; i++) {
					
				  str += "<li>"+(i+1)+"위: 코드["+result.highSal[i].brandCode+"] "
				  +result.pList[i].brandName 
				  +"("+result.highSal[i].brandSales+"원)</li>";
				       		
				}
			  
			  $("#high-brand-ranking-sal").html(str);
			  str="";
			  
			  for (var i = 0; i < result.lowSal.length; i++) {
					
				  str += "<li>"+(i+1)+"위: 코드["+result.lowSal[i].brandCode+"] "
				  +result.pList[i].brandName 
				  +"("+result.lowSal[i].brandSales+"원)</li>";
				       		
				}
			  
			  $('#low-brand-ranking-sal').html(str);
			  str="";
		  },error : function(){
			  console.log("통신오류");
		  }
	  });
  }
  
  
  
  function selectProductList(num){
	  var desc="";
	  var justifying="Y";
	  if($("#pDesc").is(':checked')){
		  desc="desc";
	  }
	  if($("#notPostedP").is(':checked')){
		  justifying="N";
	  }
	 var categoryNo=$("#category option:selected").val();
	 
	 
	 $.ajax({
		 url: "/pjtMungHub/productList.sp",
		 data : {orderBy : $("input:radio[name='productOrderBy']:checked").val()+desc,
			 	justifying : justifying,
			 	currentPage : num,
			 	categoryNo : categoryNo},
		 success : function(result){
			 var str="";
			 var pagination="";
			 
			 for (var i = 0; i < result.pList.length; i++) {
				 
				 var price=result.pList[i].price;
				 var discount=result.pList[i].discount;
				 var totalPrice=price-(price/discount);
				 str+="<tr>"
			        +"<td>"+result.pList[i].productNo+"</td>"
			        +"<td>"+result.pList[i].productName+"</td>"
			        +"<td>"+result.pList[i].brandName+"</td>"
			        +"<td>"+result.pList[i].categoryName+"</td>"
			        +"<td>"+totalPrice+"</td>"
			        +"<td>"+result.pList[i].salesCount+"</td>"
			        +"<td>"
			        +"<button class='btn btn-warning btn-sm' onclick='location.href=`/pjtMungHub/update.sp/"+result.pList[i].productNo+"`'>수정</button>";
			        if(justifying=='N'){
			       	str+="<button class='btn btn-primary btn-sm' onclick='convertPost("+result.pList[i].productNo+",`Y`)'>상품개시</button>";	
			        }else{
			        	
			        str+="<button class='btn btn-danger btn-sm' onclick='convertPost("+result.pList[i].productNo+",`N`)'>개시중단</button>";
			        }
			        str+"</td>"
			        +"</tr>";
			}
			 		
			 pagination+="<nav>"
					+"<ul class='pagination justify-content-center'>";
					if(result.pi.currentPage>1){
						pagination+="<li class='page-item'><button class='page-link' onclick='selectProductList("+(result.pi.currentPage-1)+")'>이전</button></li>";
					}
					for (var i = 1; i <= result.pi.endPage; i++) {
						if(result.pi.currentPage==i){
							pagination+="<li class='page-item disabled'><button class='page-link'>"+i+"</button></li>"
						}else{
							pagination+="<li class='page-item'><button class='page-link' onclick='selectProductList("+i+")'>"+i+"</button></li>"
						}
					}
					
					if(result.pi.currentPage<result.pi.maxPage){
						if(result.pi.maxPage>0){
							
						pagination+="<li class='page-item'><button class='page-link' onclick='selectProductList("+(result.pi.currentPage+1)+")'>다음</button></li>"
						}
					}
					pagination+=" </ul></nav>";
			 
			 
				$("#product-list").html(str);
				$("#pagination").html(pagination);
		 },error : function(){
			 console.log("통신오류")
		 }
	 })
  }
  
  
  function convertPost(num,justifying){
	  $.ajax({
		  url : "/pjtMungHub/convertProductPost.sp",
		  type : "post",
		  data : {productNo : num,
			  justifying : justifying},
		  success : function(result){
			  selectProductList(1);
		  },error : function(){
			  console.log("통신완료");
		  }
	  });
  }
  
  function selectBrandList(){
	  
	  var desc="";
	  if($("#bDesc").is(':checked')){
		  desc="desc";
	  }
	  
	  $.ajax({
		  url : "/pjtMungHub/brandList.sp",
		  data:{orderBy : $("input:radio[name='brandOrderBy']:checked").val()+desc,
			 	},
		  success : function(result){
			  var str="";
			  for(var i=0; i<result.length;i++){
				  str+="<tr>"
			         +"<td>"+result[i].brandCode+"</td>"
			         +"<th><img class='img-fluid' src='"+result[i].logo+"' style='max-height:300px'></th>"
			         +"<td>"+result[i].brandName+"</td>"
			         +"<td>"+result[i].brandSalesCount+"</td>"
			         +"<td>"+result[i].brandSales+"</td>"
			         +"<td>"
			         +"<button class='btn btn-warning btn-sm' data-toggle='modal' data-target='#updateBrandModal' onclick='changeUpdateModal("+result[i].brandCode+")'>수정</button>"
			         +"</td>"
			         +"</tr>";

			         

			  }
			  $("#brand-list").html(str);	  
		  },error: function(){
			  console.log("통신오류");
		  }
		  
	  })
	  
  }
  
  function changeUpdateModal(num){
	  $.ajax({
		  url : "/pjtMungHub/selectBrandOne.sp",
		  data : {brandCode : num},
		  success : function(result){
			  
			  $("#newLogoImg").attr("src",result.logo);
			  $("#newBrandName").val(result.brandName);
			  $("#oldLogo").attr("href",result.logo);
			  $("#updateBtn").attr("onclick","updateBrand("+num+")")
			  
		  },error : function(){
			  console.log("통신오류");
		  }
	  });
  }
  
  function updateBrand(num){
	  
	  if($("#newBrandName").val()!=""){
			
				
	   var requestData = {
	  brandName : $("#newBrandName").val(),
	  brandCode : num}

	    var formData = new FormData();
		formData.append("upfile", $("#reupfile")[0].files[0]);
		formData.append("brand",  new Blob([JSON.stringify(requestData)], {type: "application/json"}));
	  
	  
	  $.ajax({
		  url : "/pjtMungHub/updateBrand.sp",
		  type : "post",
		  contentType: false, // 필수 : x-www-form-urlencoded로 파싱되는 것을 방지
		  processData: false,  // 필수: contentType을 false로 줬을 때 QueryString 자동 설정됨. 해제
		  data : formData,
		  success: function(result){
			  $("#updateBrandModal").modal('hide');
			  selectBrandList();
			  alert("수정이 완료되었습니다.");
		  },error: function(){
			  console.log("통신오류");
		  }
	  				
	  });
			}else{
				alert("브랜드명을 입력해주세요.");
			}
  }
  
  
  
  </script>  
   <div align="center">
  <button class="btn btn-secondary mb-3" data-toggle="modal" data-target="#addBrandModal">새로운 브랜드 등록</button>
  </div>
  <div class="card mb-4">
    <div class="card-header">
      <h2>브랜드 리스트
      <input type="radio" class="btn-check" name="brandOrderBy" value="BRAND_CODE" onclick="selectBrandList()" id="brand1" autocomplete="off">
	  <label class="btn btn-secondary" for="brand1">번호</label>
	  <input type="radio" class="btn-check" name="brandOrderBy"	value="BRAND_NAME" onclick="selectBrandList()" id="brand2" autocomplete="off">
	<label class="btn btn-secondary" for="brand2">브랜드명</label>
	<input type="radio" class="btn-check" name="brandOrderBy" value="BRAND_SALES" onclick="selectBrandList()" id="brand3" autocomplete="off">
	<label class="btn btn-secondary" for="brand3">판매율</label>
	<input type="radio" class="btn-check" name="brandOrderBy" value="BRAND_SALES_COUNT" onclick="selectBrandList()" id="brand4" autocomplete="off">
	<label class="btn btn-secondary" for="brand4">매출</label>
	
	<input type="checkbox" class="btn-check" id="bDesc" autocomplete="off" onclick="selectBrandList()" checked>
	<label class="btn btn-outline-primary" for="bDesc">역순</label>
</h2>
    </div>
    <div class="card-body">
      <table class="table table-bordered">
        <thead>
          <tr>
            <th>브랜드 코드</th>
            <th>브랜드 로고</th>
            <th>브랜드명</th>
            <th>판매율</th>
            <th>매출</th>
            <th>관리</th>
          </tr>
        </thead>
        <tbody id="brand-list">
          
          
        </tbody>
      </table>
    </div>
  </div>

</div>


<!-- 새로운 브랜드 등록 모달 -->
<div class="modal fade" id="addBrandModal" tabindex="-1" role="dialog" aria-labelledby="addBrandModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addBrandModalLabel">새로운 브랜드 등록</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <div class="form-group">
            <label for="brandName">브랜드명</label>
            <input type="text" class="form-control" id="brandName">
            <br>
            <div class="py-5" align="center">
            <img class="img-fluid" id="logoImg" onclick="logo()" style="max-height:300px; min-height:100px; min-width:100px; border:1px solid black">
            </div>
            <br>
           <label for="upfile">로고 업로드</label>
            <input type="file" id="upfile" name="upfile" accept='image/*' onchange="loadFile(this)">
          </div>
          <button type="button" class="btn btn-primary" onclick="insertBrand()">등록</button>
      </div>
    </div>
  </div>
</div>
</div>


<div class="modal fade" id="updateBrandModal" tabindex="-1" role="dialog" aria-labelledby="updateBrandModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="updateBrandModalLabel">업데이트</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <div class="form-group">
            <label for="newBrandName">브랜드명</label>
            <input type="text" class="form-control" id="newBrandName">
            <br>
            <div class="py-5" align="center">
            <img class="img-fluid" id="newLogoImg" onclick="newLogo()" style="max-height:300px; min-height:100px; min-width:100px; border:1px solid black">
            </div>
            <br>
           <label for="reupfile">로고 업로드</label>
            <input type="file" id="reupfile" name="reupfile" accept='image/*' onchange="newLoadFile(this)">
            <br><a id="oldLogo" download>이전로고 다운로드</a>
          </div>
          <button type="button" class="btn btn-primary" id="updateBtn">수정</button>
      </div>
    </div>
  </div>
</div>

<script>
function logo(){
	$("#upfile").click();
}

function newLogo(){
	$("#reupfile").click();
}

function loadFile(inputFile){
	if(inputFile.files.length==1){
		var reader = new FileReader();
		
		reader.readAsDataURL(inputFile.files[0]);
		
		reader.onload =function(e){
				$("#logoImg").attr("src",e.target.result);
			}
		}else{
			$("#logoImg").attr("src",null);
	}
}

function newLoadFile(inputFile){
	if(inputFile.files.length==1){
		var reader = new FileReader();
		
		reader.readAsDataURL(inputFile.files[0]);
		
		reader.onload =function(e){
				$("#newLogoImg").attr("src",e.target.result);
			}
		}else{
			$("#newLogoImg").attr("src",null);
	}
}


function insertBrand(){
	
	if($("#brandName").val()!=""){
		
		if($("#upfile").val()!=null){
			
			   var requestData = {
					   brandName : $("#brandName").val()}

			    var formData = new FormData();
			    formData.append("upfile", $("#upfile")[0].files[0]);
			    formData.append("brandName",  new Blob([JSON.stringify(requestData)], {type: "application/json"}));
	
	
	$.ajax({
		url : "/pjtMungHub/insertBrand.sp",
		type : "post",
		contentType: false, // 필수 : x-www-form-urlencoded로 파싱되는 것을 방지
	    processData: false,  // 필수: contentType을 false로 줬을 때 QueryString 자동 설정됨. 해제
		data : formData,
		success : function(result){
			$("#brandName").val("");
			$("#addBrandModal").modal('hide');
			alert("브랜드 정보가 입력되었습니다.");
			selectBrandList();
		},error : function(){
			console.log("통신오류");
		}
	
		
	});
		}else{
			alert("로고를 설정해주세요.");
		}
	
}else{
	alert("브랜드를 입력해주세요.");
}
}	


</script>




<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


</body>
</html>