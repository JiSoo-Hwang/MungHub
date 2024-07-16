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
    </style>
</head>
<body>
<%@include file="../common/header.jsp" %>
    <div class="sidebar">
        <h4 class="text-center">주문관리</h4>
        <a href="/pjtMungHub/adminPage/dashBoard">대시보드</a>
        <a href="/pjtMungHub/adminPage/orderControll">주문 관리</a>
        <a href="/pjtMungHub/adminPage/productControll">제품 관리</a>
        <a href="/pjtMungHub/adminPage/customerControll">고객 관리</a>
        <a href="/pjtMungHub/adminPage/eventControll">이벤트 관리</a>
    </div>

    <div class="main-content">
       <div align="center" class="py-5">
	<h1>주문 관리</h1>
	</div>
    <div class="container">
    
    <div align="center">
     <button class="btn btn-outline-secondary btn-lg mx-3" id="totalbtn" onclick="selectOrderInfoList('전체',1)">전체()</button>
    <button class="btn btn-outline-secondary btn-lg mx-3" id="preparebtn" onclick="selectOrderInfoList('상품준비중',1)">상품준비중()</button>
    <button class="btn btn-outline-secondary btn-lg mx-3" id="ongoingbtn" onclick="selectOrderInfoList('배송중',1)">배송중()</button>
    <button class="btn btn-outline-secondary btn-lg mx-5" id="completebtn" onclick="selectOrderInfoList('배송완료',1)">배송완료()</button>
    
    <div class="btn-group" role="group" aria-label="Basic outlined example">
    <button class="btn btn-outline-secondary btn-lg" id="cancelbtn" onclick="selectOrderInfoList('취소',1)">취소요청()</button>
    <button class="btn btn-outline-secondary btn-lg" id="changebtn" onclick="selectOrderInfoList('교환',1)">교환요청()</button>
    <button class="btn btn-outline-secondary btn-lg" id="recallbtn" onclick="selectOrderInfoList('환불',1)">환불요청()</button>
    </div>
    </div>
    
    <div id="tableDiv">
    <table class="table caption-top py-5">
  <caption id="listCategory">전체목록</caption>
  <thead>
    <tr>
   	 <th>선택</th>
       <th scope="col">주문번호</th>
		 <th scope="col">배달진행상황</th>
		 <th scope="col">주문목록</th>
		 <th scope="col">주문총수량</th>
		 <th scope="col">총결제액</th>
		 <th scope="col">유저번호</th>
		 <th scope="col">결제일</th>
		 <th scope="col">갱신일</th>
		 <th scope="col">요구사항</th>
		 <th scope="col">주소</th>
		 <th scope="col">수취인</th>
		 <th scope="col">전화번호 </th>
    </tr>
  </thead>
  <tbody id="orderList">
  
  </tbody>
</table>
</div>

	<div id="pagenationDiv">
	
	</div>

    </div>
</div>
<script>

function selectOrderInfoList(category,currentPage){
	

	$.ajax({
		url: "/pjtMungHub/selectOrderInfoList.sp",
		data: {category : category,
				currentPage : currentPage},
		success: function(result){
			var str="";
			var pagenationDiv="";
			
			var itemTotalCount=0;
			
			var total=result.total;
			var prepare=result.prepare;
			var ongoing=result.ongoing;
			var complete=result.complete;
			var cancel=result.cancel;
			var exchange=result.exchange;
			var recall=result.recall;
			
			$("#totalbtn").text("전체("+total+")");
			$("#preparebtn").text("상품준비중("+prepare+")");
			$("#ongoingbtn").text("배송중("+ongoing+")");
			$("#completebtn").text("배송완료("+complete+")");
			$("#cancelbtn").text("취소("+cancel+")");
			$("#changebtn").text("교환("+exchange+")");
			$("#recallbtn").text("환불("+recall+")");
			
			
			var prepare='상품준비중';
			var ongoing='배송중';
			var complete='배송완료';
			var cancel='취소';
			var exchange='교환';
			var recall='환불';
			
			if(result!=null){
				for (var i = 0; i < result.oList.length; i++) {
					itemTotalCount=0;
				str+="<tr>";
				if (result.oList[i].process=='상품준비중') {
				str+="<th scope='row'>"
				+"<div class='btn-group' role='group'>"
			    +"<button type='button' class='btn btn-primary dropdown-toggle' data-bs-toggle='dropdown' aria-expanded='false'>"
			    +result.oList[i].process
			    +"</button>"
			    +"<ul class='dropdown-menu'>"
			    +"<li><button class='dropdown-item' onclick='convertProcess(`"+ongoing+"`,`"+result.oList[i].merchantUid+"`)'>배송중</button></li>"
			    +"<li><button class='dropdown-item' onclick='convertProcess(`"+complete+"`,`"+result.oList[i].merchantUid+"`)'>배송완료</button></li>"
			    +"<li><button class='dropdown-item' onclick='convertProcess(`"+cancel+"`,`"+result.oList[i].merchantUid+"`)'>취소</button></li>"
			    +"<li><button class='dropdown-item' onclick='convertProcess(`"+exchange+"`,`"+result.oList[i].merchantUid+"`)'>교환</button></li>"
			    +"<li><button class='dropdown-item' onclick='convertProcess(`"+recall+"`,`"+result.oList[i].merchantUid+"`)'>환불</button></li>"
			    +"</ul>"
			    +"</div>";
				}else if(result.oList[i].process=='배송중'){
				str+="<th scope='row'>"
				+"<div class='btn-group' role='group'>"
			    +"<button type='button' class='btn btn-warning dropdown-toggle' data-bs-toggle='dropdown' aria-expanded='false'>"
			    +result.oList[i].process
			    +"</button>"
			    +"<ul class='dropdown-menu'>"
			    +"<li><button class='dropdown-item' onclick='convertProcess(`"+prepare+"`,`"+result.oList[i].merchantUid+"`)'>상품준비중</button></li>"
			    +"<li><button class='dropdown-item' onclick='convertProcess(`"+complete+"`,`"+result.oList[i].merchantUid+"`)'>배송완료</button></li>"
			    +"<li><button class='dropdown-item' onclick='convertProcess(`"+cancel+"`,`"+result.oList[i].merchantUid+"`)'>취소</button></li>"
			    +"<li><button class='dropdown-item' onclick='convertProcess(`"+exchange+"`,`"+result.oList[i].merchantUid+"`)'>교환</button></li>"
			    +"<li><button class='dropdown-item' onclick='convertProcess(`"+recall+"`,`"+result.oList[i].merchantUid+"`)'>환불</button></li>"
			    +"</ul>"
			    +"</div>";

				}else if(result.oList[i].process=='배송완료'){
				str+="<th scope='row'>"
				+"<div class='btn-group' role='group'>"
			    +"<button type='button' class='btn btn-success dropdown-toggle' data-bs-toggle='dropdown' aria-expanded='false'>"
			    +result.oList[i].process
			    +"</button>"
			    +"<ul class='dropdown-menu'>"
			    +"<li><button class='dropdown-item' onclick='convertProcess(`"+prepare+"`,`"+result.oList[i].merchantUid+"`)'>상품준비중</button></li>"
			    +"<li><button class='dropdown-item' onclick='convertProcess(`"+ongoing+"`,`"+result.oList[i].merchantUid+"`)'>배송중</button></li>"
			    +"<li><button class='dropdown-item' onclick='convertProcess(`"+cancel+"`,`"+result.oList[i].merchantUid+"`)'>취소</button></li>"
			    +"<li><button class='dropdown-item' onclick='convertProcess(`"+exchange+"`,`"+result.oList[i].merchantUid+"`)'>교환</button></li>"
			    +"<li><button class='dropdown-item' onclick='convertProcess(`"+recall+"`,`"+result.oList[i].merchantUid+"`)'>환불</button></li>"
		        +"</ul>"
			    +"</div>";
				}else if(result.oList[i].process=='취소'){
					str+="<th scope='row'>"
						+"<div class='btn-group' role='group'>"
					    +"<button type='button' class='btn btn-dark dropdown-toggle' data-bs-toggle='dropdown' aria-expanded='false'>"
					    +result.oList[i].process
					    +"</button>"
					    +"<ul class='dropdown-menu'>"
					    +"<li><button class='dropdown-item' onclick='convertProcess(`"+prepare+"`,`"+result.oList[i].merchantUid+"`)'>상품준비중</button></li>"
					    +"<li><button class='dropdown-item' onclick='convertProcess(`"+ongoing+"`,`"+result.oList[i].merchantUid+"`)'>배송중</button></li>"
					    +"<li><button class='dropdown-item' onclick='convertProcess(`"+complete+"`,`"+result.oList[i].merchantUid+"`)'>배송완료</button></li>"
					    +"<li><button class='dropdown-item' onclick='convertProcess(`"+exchange+"`,`"+result.oList[i].merchantUid+"`)'>교환</button></li>"
					    +"<li><button class='dropdown-item' onclick='convertProcess(`"+recall+"`,`"+result.oList[i].merchantUid+"`)'>환불</button></li>"
				        +"</ul>"
					    +"</div>";
				}else if(result.oList[i].process=='교환'){
					str+="<th scope='row'>"
						+"<div class='btn-group' role='group'>"
					    +"<button type='button' class='btn btn-dark dropdown-toggle' data-bs-toggle='dropdown' aria-expanded='false'>"
					    +result.oList[i].process
					    +"</button>"
					    +"<ul class='dropdown-menu'>"
					    +"<li><button class='dropdown-item' onclick='convertProcess(`"+prepare+"`,`"+result.oList[i].merchantUid+"`)'>상품준비중</button></li>"
					    +"<li><button class='dropdown-item' onclick='convertProcess(`"+ongoing+"`,`"+result.oList[i].merchantUid+"`)'>배송중</button></li>"
					    +"<li><button class='dropdown-item' onclick='convertProcess(`"+complete+"`,`"+result.oList[i].merchantUid+"`)'>배송완료</button></li>"
					    +"<li><button class='dropdown-item' onclick='convertProcess(`"+cancel+"`,`"+result.oList[i].merchantUid+"`)'>취소</button></li>"
					    +"<li><button class='dropdown-item' onclick='convertProcess(`"+recall+"`,`"+result.oList[i].merchantUid+"`)'>환불</button></li>"
				        +"</ul>"
					    +"</div>";
				}else if(result.oList[i].process=='환불'){
					str+="<th scope='row'>"
						+"<div class='btn-group' role='group'>"
					    +"<button type='button' class='btn btn-danger dropdown-toggle' data-bs-toggle='dropdown' aria-expanded='false'>"
					    +result.oList[i].process
					    +"</button>"
					    +"<ul class='dropdown-menu'>"
					    +"<li><button class='dropdown-item' onclick='convertProcess(`"+prepare+"`,`"+result.oList[i].merchantUid+"`)'>상품준비중</button></li>"
					    +"<li><button class='dropdown-item' onclick='convertProcess(`"+ongoing+"`,`"+result.oList[i].merchantUid+"`)'>배송중</button></li>"
					    +"<li><button class='dropdown-item' onclick='convertProcess(`"+complete+"`,`"+result.oList[i].merchantUid+"`)'>배송완료</button></li>"
					    +"<li><button class='dropdown-item' onclick='convertProcess(`"+cancel+"`,`"+result.oList[i].merchantUid+"`)'>취소</button></li>"
					    +"<li><button class='dropdown-item' onclick='convertProcess(`"+exchange+"`,`"+result.oList[i].merchantUid+"`)'>교환</button></li>"
				        +"</ul>"
					    +"</div>";	
				
				}
				
				str+="<td>"+result.oList[i].merchantUid+"</td>"
				+"<td>"+result.oList[i].process+"</td>"
				+"<td>";
				for (var k = 0; k < result.oList[i].itemsArr.length; k++) {
					
				str+="<a href='/pjtMungHub/detail.sp/"+result.oList[i].itemsArr[k]+"'>"
				+"[품번 : "+result.oList[i].itemsArr[k]+"] "+result.oList[i].plist[k].productName+"</a> "
				+result.oList[i].itemsQuantityArr[k]+"개<br>";
				itemTotalCount+=result.oList[i].itemsQuantityArr[k];
				}
				str+="</td>"
				+"<td>"+itemTotalCount+"</td>"
				+"<td>"+result.oList[i].totalPrice.toLocaleString("ko-KR")+" 원</td>"
				+"<td>"+result.oList[i].userNo+"</td>"
				+"<td>"+formatDate(result.oList[i].payDate)+"</td>"
				+"<td>"+formatDate(result.oList[i].updateDay)+"</td>";
				if(result.oList[i].messageString!=null){
				str+="<td>"+result.oList[i].messageString+"</td>";
					
				}else{
				str+="<td>없음</td>";
				}
				str+="<td>"+result.oList[i].address+"</td>"
				+"<td>"+result.oList[i].recipient+"</td>"
				+"<td>"+result.oList[i].phone+"</td>"
				+"</tr>";
				}
				$("#orderList").html(str);
				
				
				pagenationDiv+="<nav>"
					+"<ul class='pagination justify-content-center'>";
					if(result.pi.currentPage>1){
						pagenationDiv+="<li class='page-item'><button class='page-link' onclick='selectOrderInfoList("+category+","+(result.pi.currentPage-1)+")'>이전</button></li>";
					}
					for (var i = 1; i <= result.pi.endPage; i++) {
						if(result.pi.currentPage==i){
							pagenationDiv+="<li class='page-item disabled'><button class='page-link'>"+i+"</button></li>"
						}else{
							pagenationDiv+="<li class='page-item'><button class='page-link' onclick='selectOrderInfoList("+category+","+i+")'>"+i+"</button></li>"
						}
					}
					
					if(result.pi.currentPage<result.pi.maxPage){
						if(result.pi.maxPage>0){
							
							pagenationDiv+="<li class='page-item'><button class='page-link' onclick='selectOrderInfoList("+category+","+(result.pi.currentPage+1)+")'>다음</button></li>"
						}
					}
					pagenationDiv+=" </ul></nav>";
				
				
				
				$("#pagenationDiv").html(pagenationDiv);
				
			}else{
				$("#tableDiv").html("<h1>조회된 내용이 없습니다.</h1>");
			}},
			error:function(){
				console.log("통신오류");
			}
			
			
			
			
		
	});
}

$(function(){
	selectOrderInfoList("전체",1);
});


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

function convertProcess(status,imp){
	$.ajax({
		url: "/pjtMungHub/convertProcess.sp",
		type : "post",
		data : { process : status,
				merchantUid : imp},
		success : function(result){
			
			selectOrderInfoList(status,1);
		},error:function(){
			
			console.log("통신오류");
		}
	
	
	});
	
	
	
}

</script>
</body>
</html>