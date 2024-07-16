<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	thead th{
		width:100px;
		border:2px solid black;
		text-align:center;
	}
	.teacherPhone,.teacherKind{
		width:150px;
	}
	.teacher-new-area,.teacher-area{
		border-radius:5px;
		background-color:#FFEAE3;
		margin-top:15px;
		margin-bottom:20px;
		overflow: auto;
	}
	table{
		margin-left:10px;
		margin-top:10px;
	}
	h3{
		color:#492F10;
		
	}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div class="totalArea">
	<div class="mypage-left">
		<%@ include file="/WEB-INF/views/member/memberSideBar.jsp" %>
	</div>
	<div class="mypage-main">
		<div class="manage-main">
			<div class="manage-new-teacher">
				<h3>신규 선생님 관리</h3>
				<div class="teacher-new-area">
					<table class="newTeacher">
						<thead>
							<tr>
								<th>이름</th>
								<th>아이디</th>
								<th class="teacherPhone">휴대폰번호</th>
								<th class="teacherKind">유치원 이름</th>
								<th>가입일자</th>
								<th>관리</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${newCount>0}">
									<c:forEach items="${tList}" var="t">
										<c:if test="${t.status eq 'N'}">
											<tr>
												<td>${t.name}</td>
												<td>${t.userId}</td>
												<td>${t.phone}</td>
												<td>${t.kindName}</td>
												<td>${t.joinDate}</td>
												<td><button onclick="accept(${t.userNo})">승인</button><button onclick="cancel(${t.userNo});">취소</button></td>
											</tr>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr><td colspan="6"> 신규 등록된 선생님이 없습니다.</td></tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
			
			<div class="manage-teacher">
				<h3>기존 선생님 관리</h3>
				<div class="teacher-area">
					<table>
						<thead>
							<tr>
								<th>이름</th>
								<th>아이디</th>
								<th class="teacherPhone">휴대폰번호</th>
								<th class="teacherKind">유치원 이름</th>
								<th>가입일자</th>
								<th>관리</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${tList}" var="t">
								<c:if test="${t.status eq 'Y' }">
									<tr>
										<td>${t.name}</td>
										<td>${t.userId}</td>
										<td>${t.phone}</td>
										<td>${t.kindName}</td>
										<td>${t.joinDate}</td>
										<td><button onclick="newMaster(${t.userNo},'${t.kindName}');">위임</button><button onclick="calcel(${t.userNo});">해제</button></td>
									</tr>
								</c:if>						
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	</div>
	<script>
		function accept(value){
			var result=confirm("소속 선생님의 정보가 맞습니까?");
			if(result){
				location.href="acceptTeacher.me?userGrade=1&&userNo="+value;
			}
		}
		
		function cancel(value){
			var result=confirm("소속 선생님의 정보가 아닙니까?");
			if(result){
				location.href="notTeacher.me?userGrade=0&&userNo="+value;
			}
		}
		function newMaster(value1,value2){
			var result=confirm("해당 선생님께 원장 권한을 위임하시겠습니까? 위임 선택 시 자동으로 로그아웃됩니다.")
			if(result){
				location.href="newMaster.me?userGrade=2&&userNo="+value1+"&&kindName="+value2;
			}
		}
	</script>

</body>
</html>