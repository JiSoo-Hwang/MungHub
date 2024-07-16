<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	.left-sidebar{
		margin-left: 10px;
	}
	.left-sidebar>ul{
		list-style-type:none;
		background-color:#F4D3D3;
		width:220px;
		margin:0;
		padding:0;
		border-radius:3px;
		text-align:center;
		height:auto;
		position:fixed;
	}
	.sidebar-title>h3{
		line-height: 200%;
	}
	.sidebar-link{
		background-color:#FFEAE3;
		margin:8px;
	}
	.sidebar-link>a{
		text-decoration:none;
		font-size:18px;
		line-height:180%;
		color: #492F10;
	}
		div .left, .right{
		display:inline-block;
		margin-top:10px;
		border:0;
		padding:0;
	}
	.left{
		width:300px;
		position:relative;
		overflow:hidden;
		height:100%;
		margin-right:100px;
	}
	.left>img{
		position:absolute;
		transform: translate(0%, 0%);
		width:auto;
		height:300px;
	}
	.right{
		position:absolute;
		transform: translate(0%, 0%);
		height:100%;
	}
	.totalArea>div{
		display:inline-block;
		height:100%;
		position:relative;
		float:left;
	}

	.totalArea{
		width:100%;
		height:100%;
		position:absolute;
	}
	.mypage-left{
		width:20%;
	}
	.mypage-main{
		width:70%;
	}
	.mypage-main>div{
		width:100%;
		margin-bottom:5px;
	}
	h3{
		color:#492F10;
	}
</style>
<body>
<div class="left-sidebar">
	<ul>
		<li class="sidebar-title"><h3>마이페이지</h3></li>
		<li class="sidebar-link">
			<a href="myPage.me">개인 정보 확인 / 수정</a>
		</li>
		<li class="sidebar-link">
			<a href="updatePet.me">반려견 정보 추가 / 수정</a>
		</li>
		<li class="sidebar-link">
			<a href="">연계 쇼핑몰 주문 이력</a>
		</li>
		<li class="sidebar-link">
			<a href="msg.me?currentPage=1">쪽지 / 쿠폰함 보기</a>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
		</li>
		<c:if test="${loginUser.userGrade ge 1}">
			<li class="sidebar-link">		
				<a href="manage.me">회원 관리</a>
			</li>
			<c:if test="${loginUser.userGrade ge 2}">
			<li class="sidebar-link">
					<a href="manageTeacher.me">선생님 관리</a>
				</li>
			<li class="sidebar-link">
					<a href='regList2.do?userNo=${loginUser.userNo}'>상담 요청 리스트</a>
				</li>
			</c:if>
		</c:if>
	</ul>
</div>


</body>
</html>