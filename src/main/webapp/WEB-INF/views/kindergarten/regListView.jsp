<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
th {
	text-align: center;
}

td {
	text-align: center;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="container mt-3">
		<table class="table">
			<thead>
				<tr>
					<th>상담 예약 날짜</th>
					<th>예약 유치원</th>
					<th>승인 여부</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty regList}">
						<tr>
							<td></td>
							<td>예약 내역이 없습니다! 지금 가까운 유치원을 찾아보세요!</td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td><a href="map.do" class="btn btn-outline-success">유치원
									지도 보러 가기</a></td>
							<td></td>
						</tr>
					</c:when>
				</c:choose>
				<!-- 승인 된 예약은 초록색 행으로 출력 -->
				<c:forEach items="${regList}" var="r">
					<c:choose>
						<c:when test="${r.approval == 'Y' }">
							<tr class="table-success">
								<td>${r.visitDate }</td>
								<td class="kindName">${r.kindName }</td>
								<td style="color: blue;">승인</td>
							</tr>
						</c:when>
						<c:otherwise>
							<!-- 대기중인 예약은 회색 행으로 출력 -->
							<tr class="table-secondary">
								<td>${r.visitDate }</td>
								<td>${r.kindName }</td>
								<td>대기중&ensp; <a href="updateReg.do?reservNo=${r.reservNo }" class="btn btn-primary">신청수정</a>&ensp;
									<button class="btn btn-secondary cancelBtn">예약철회</button>
									<input type="hidden" value="${r.reservNo }">
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<script>
		$(function() {
			$(".cancelBtn").click(function() {
				if (confirm("정말 상담을 취소하시겠습니까?")) {
					var reservNo = $(this).siblings(':eq(1)').val();
					location.href="deleteReg.do?reservNo="+reservNo;
				} else {
					return false;
				}
			});
		});
	</script>
</body>
</html>



















