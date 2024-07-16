<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${pet.petName } 댕댕이의 웨딩플래너 신청 페이지입니다.</title>
<style>
#wed_form {
	margin: 50px;
}

#upFile {
	display: none;
}

textarea {
	width: 70%;
	resize: none;
}
ul {
	list-style: none;
}

li {
	float: left;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="form_area">

		<form method="post" action="apply.wd" enctype="multipart/form-data">
 			<input type="hidden" name="partnerNo" value="${matchingPet}"> 
			<input type="hidden" name="userNo" value="${loginUser.userNo }">
			<ul>
				<li>
					<div class="container mt-3" id="wed_upFile">
						<div class="card img-fluid" style="width: 500px">
							<img class="card-img-top" src="" alt="" style="width: 100%">
							<div class="card-img-overlay">

								<p class="card-text">강아지 사진을 올려주세요!</p>
								<input type="file" name="upFile" id="upFile" onchange="loadImg(this,1);" required></input> <label
									for="upFile"><img
									src="/pjtMungHub/resources/uploadFiles/kindergarten/css/dogPhotoIcon.png"
									alt="" style="width: 500px"></label>

							</div>
						</div>
					</div>
				</li>
				<li>
					<table class="table table-hover" id="wed_form">
						<thead>
							<tr>
								<th>이름</th>
								<c:choose>
								<c:when test="${empty petList }">
								<td>등록된 반려견이 없습니다...! 반려견 등록부터 해볼까요૮ ˆﻌˆ ა?</td>
								</c:when>
								<c:otherwise>
								<td>
								<select name="petNo" id="petNo">
								<option id="defaultOption">반려견을 선택해주세요</option>
								<c:forEach items="${petList }" var="p">
								<option value="${p.petNo }">${p.petName }</option>
								</c:forEach>
								</select>
									</td>
								</c:otherwise>
								</c:choose>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>견종</th>
								<td><input name="breed" id="breed" readonly></td>
							</tr>
							<tr>
								<th>나이</th>
								<td><input name="petAge" id="petAge" readonly></td>
							</tr>
							<tr>
								<th>성별</th>
								<td><input name="gender" id="gender" readonly></td>
							</tr>
							<tr>
								<th>몸무게</th>
								<td><input name="weight" id="weight" readonly></td>
							</tr>
							<tr> 
							<th>혈통 </th>
							<td> <input type="text" name="pedigree">
							<button type="button" class="btn btn-primary" data-bs-toggle="popover" title="이건 뭔가요?" data-bs-content="강아지의 혈통을 적어주세요(모르면 '모름'이라고 적으셔도 무방합니다^^)">?</button>
							</td>
							</tr>
							<tr>
								<th>필수접종여부</th>
								<td>
									<ul style="list-style-type: none">
										<li><input class="form-check-input" type="checkbox"
											id="vac1"> <label
											class="form-check-label" for="vac1" data-bs-toggle="tooltip" title="모든 백신접종이 체크되어야 신청버튼이 활성화됩니다 :)">종합백신</label></li>
										<li><input class="form-check-input" type="checkbox"
											id="vac2"> <label
											class="form-check-label" for="vac2">코로나장염</label></li>
										<li><input class="form-check-input" type="checkbox"
											id="vac3"> <label
											class="form-check-label" for="vac3">켄넬코프</label></li>
										<li><input class="form-check-input" type="checkbox"
											id="vac4"> <label
											class="form-check-label" for="vac4">광견병</label></li>
										<li><input class="form-check-input" type="checkbox"
											id="vac5"> <label
											class="form-check-label" for="vac5">인플루엔자</label>
											</li>
									</ul>
								</td>
							</tr>
							<tr>
							<th>접종 증명서 첨부</th>
							<td> 
							<input type="file" multiple name="vacCert" required>
							</td>
							</tr>
							<tr>
								<th>만남방식</th>
								<td>
								<select name="meetingMethod" required>
								<!-- 이부분 변경할 것 -->
									<option value="상대방이 방문">상대방 댕댕이가 방문</option>
									<option value="우리가 방문">우리가 댕댕이를 찾아가기</option>
								</select>
								</td>
							</tr>
							<tr>
								<th>소개</th>
								<td><textarea rows="4" cols="50" name="petIntro"></textarea></td>
							</tr>
							<tr>
								<th>특이사항</th>
								<td><textarea rows="4" cols="50" name="petNote"></textarea></td>
							</tr>
							<tr>
								<td></td>
								<td style="text-align: center;">
									<a href="wedList.wd" class="btn btn-outline-primary">목록으로</a>
									<button type="submit" class="btn btn-outline-success" data-bs-toggle="tooltip" title="모든 백신접종이 체크되어야 신청버튼이 활성화됩니다 :)" disabled>신청하기</button>
								</td>
							</tr>
						</tbody>

					</table>
				</li>
			</ul>
		</form>
	</div>
	<script>
function loadImg(inputFile,num) {
	if(inputFile.files.length==1){
		var reader = new FileReader();
		reader.readAsDataURL(inputFile.files[0]);
		reader.onload = function (e) {
			switch (num) {
			case 1:
				$("label>img").attr("src",e.target.result);
				break;
			}
		}
	}else{
		switch (num) {
		case 1:
			$("label>img").attr("src","/pjtMungHub/resources/uploadFiles/kindergarten/css/dogPhotoIcon.png");
			break;
		}
	}
}
$(function () {
	$("input[class='form-check-input']").on('change', function() {
	var checkNum = $("input[class='form-check-input']:checked").length;
		if(checkNum==5){
			$("button[type='submit']").prop("disabled",false);
		}else{
			$("button[type='submit']").prop("disabled",true);
		}
	});
});

$("#petNo").change(function () {
	var petNo = $(this).val();
	$.ajax({
		url:"${pageContext.request.contextPath}/getPetInfo.wd",
		type: "get",
		data:{petNo:petNo},
		success: function (pet) {
			var gender = pet.petGender;
			if(gender=="${partnerPet.petGender}"){
				alert("성별이 같은 강아지는 매칭 신청이 불가합니다8ㅅ8");
				$("#defaultOption").prop("selected",true);
				$("#breed").val("");
				$("#petAge").val("");
				$("#weight").val("");
			}else{
			$("#breed").val(pet.breed);
			$("#petAge").val(pet.petAge);
			$("#weight").val(pet.weight);
			switch (gender) {
			case 'M':
				$("#gender").val('왕자님');
				break;
			case 'F':
				$("#gender").val('공주님');
				break;
			}
			}
		},
		error: function () {
			console.log("반려견 정보 불러오기 실패");
		}
	});
	
});
/* 혈통 관련 안내 팝업 */
var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
  return new bootstrap.Popover(popoverTriggerEl)
})
	</script>
</body>
</html>