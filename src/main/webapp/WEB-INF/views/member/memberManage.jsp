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
	.userPhone{
		width:150px;		
	}.userEmail{
		width:200px;
	}
	.statusYN{
		width:60px;
	}
	tbody td{
		text-align:center;
	}
	.not-center{
		padding-left:8px;
		text-align:left;
	}
	tbody tr{
		border-bottom:1px solid lightGray;
	}
	.search-member{
		border-radius:5px;
		background-color:#FFEAE3;
	}
	.search-member>*{
		margin-left:10px;
		margin-top:10px;
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
			<div class="manage-board">
				<h3>게시글 관리</h3>
			</div>
			<div class="manage-member">
				<div class="search-member">
					<h5>회원 검색</h5>
					<input type="text" id="searchUserId" placeholder="찾고 싶은 회원의 아이디를 입력하세요"><button onclick="searchUserId();">검색</button>
					<div class="member-list" hidden="true">
						<table class="search-result" >
							<thead>
								<tr>
									<th>아이디</th>
									<th>이름</th>
									<th class="userPhone">휴대폰 번호</th>
									<th class="userEmail">이메일 주소</th>
									<th class="statusYN">반려견 유무</th>
									<th class="statusYN">활성화 유무</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	<script>
		function searchUserId(){
			var userId="%"+$("#searchUserId").val();
			userId+="%";
			$.ajax({
				url:"searchUser.me",
				data:{
					userId:userId
				},
				success:function(result){
					var text="";
					if(result!=null){
						for(var i in result){
							text+="<tr>"
								+"<td hidden='true'>"+result[i].userNo+"</td>"
								+"<td hidden='true'>"+result[i].userGrade+"</td>"
								+"<td class='not-center'>"+result[i].userId+"</td>"
								+"<td>"+result[i].name+"</td>"
								+"<td>"+result[i].phone+"</td>"
								+"<td class='not-center'>"+result[i].email+"</td>"
								+"<td>"+result[i].petYN+"</td>"
								+"<td>"+result[i].status+"</td>"
								+"<td><button data-bs-toggle='modal' data-bs-target='#disableModal' onclick='return false;'>활동 정지</button>"
								+"<tr>";
						}
					}else{
						text+="<tr>"
							+"<td colspan='7'>"+"해당하는 회원이 없습니다."+"</td>"
							+"</tr>";
					}
						$(".search-result tbody").html(text);
				},
				error:function(){
					console.log("통신오류");
				}
			})
			$(".member-list").attr("hidden",false);
		}
		$(".search-result").on("click","button",function(){
			var userNo=$(this).parent().siblings().eq(0).text();
			var userGrade=$(this).parent().siblings().eq(1).text();
			var userId=$(this).parent().siblings().eq(2).text();
			$(".disable-data>input[name=userNo]").val(userNo);
			$(".disable-data>input[name=userGrade]").val(userGrade);
			$(".disable-data>input[name=userId]").val(userId);
			$(".gradeCheck").attr("hidden",true);
			$(".disableTime>input[type=radio]").each(function(){
				$(this).prop("checked",false);
			})
		})
	</script>
	<div class="modal fade" id="disableModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">회원 활동 정지</h4>
					<button type="button" class="close" data-bs-dismiss="modal">&times;</button>
				</div>		
				<form action="disableMember.me" method="post">
				<!-- Modal body -->
					<div class="modal-body">
						<div class="disable-data">
							<input type="hidden" name="userNo">
							<input type="hidden" name="userGrade">
							<div class="gradeCheck" hidden="true"></div>
							<label for="userId">아이디 :</label>
							<input type="text" name="userId" readonly><br>
							<label for="">정지 기간 :</label>
							<div class="disableTime">
								<input type="radio" id="day" value="1" name="disable">
								<label for="day">1일</label> &nbsp;&nbsp;
								<input type="radio" id="week" value="7" name="disable">
								<label for="week">7일</label> &nbsp;&nbsp;
								<input type="radio" id="month" value="30" name="disable">
								<label for="month">30일</label> &nbsp;&nbsp;
							</div>
						</div>
					</div>
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger">확인</button>
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script>
		$(".disableTime>input[type=radio]").on("change",function(){
			var userGrade=$("input[name=userGrade]").val();
			if(userGrade>0){
				if(${loginuser.userGrade}<2){
					$(".gradeCheck").text("해당 회원은 선생님 등급의 회원입니다. 정지 요청 시 관리자에게 문의 바랍니다.").css("color","red");
					$(".gradeCheck").attr("hidden",false);
					$(".modal-footer>button[type=submit]").attr("disabled",true);
				}
			}
		})
		
	</script>
</body>
</html>