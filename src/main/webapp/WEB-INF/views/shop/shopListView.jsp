<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
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

</style>
</head>
<body>

<%@ include file="../common/header.jsp" %>

<div class="container">
<div class="jumbotron">
<h1>애견용품</h1>
</div>
<c:forEach items="${pList }" var="p">
<div class="col-3">
<div class="card" onclick="location.href='detail.sp/${p.productNo}'">
	<div>
	<img class="card-img-top" src="resources/shopFile/16-ageing-12-b1-ne.jpg">
	</div>
	<div class="card-body">
		<h5 class="card-title">${p.productName }</h5>
		<del><fmt:formatNumber type="number" maxFractionDigits="0" value="${p.price}" /></del>
		<br> 
		<fmt:formatNumber type="number" maxFractionDigits="0" value="${p.price -(p.price/p.discount)}" />

		<strong style="color:rgb(250, 58, 14)">${p.discount }%</strong>
		
	</div> 
	</div>
</div>
</c:forEach>
</div>


<br> <br>
</body>
</html>