<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	.petInfo-main, .pet-info{
		margin-left:15px;
		overflow:auto;
	}
	.petInfo, .newPet-member, .newPet-new{
		position:relative;
		height:310px;
		background-color:#FFEAE3;
		border-radius:5px;
	}
	.pet-info{
		height:800px;
	}
	.petPhoto{
		width:300px;
	}
	.right{
		font-size: 120%;
		line-height: 230%;
	}
	.right>*{
		margin-left:10px;
	}
	.newPetBanner{
		cursor:pointer;
	}
</style>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp" %>
	<div class="totalArea">
	<div class="mypage-left">
		<%@include file="/WEB-INF/views/member/memberSideBar.jsp" %>
	</div>
	<div class="mypage-main">
		<div class="petInfo-main">
			<c:if test="${empty petList&&loginUser.petYN eq 'Y'}">
				<div class="newPet-new">
					<%@ include file="/WEB-INF/views/member/memberPetEnrollForm.jsp" %>
				</div>
			</c:if>
			<c:if test="${not empty petList}">
				<h3>기존 반려견 정보 수정하기</h3>
				<div class="info-area">
					<div class="info-right">
						<c:forEach items="${petList}" var="pet">
							<div class="petInfo">
								<c:forEach items="${petPhotoList}" var="photo">
									<c:if test="${photo.photoNo eq pet.photoNo}">
										<div class="petPhoto left">
											<img src=".${photo.filePath}" width="auto" height="300px" >
										</div>
									</c:if>
								</c:forEach>
								<div class="petInfo right">
									<input type="hidden" name="petNo" value="${pet.petNo}">
									<label for="">이름 : ${pet.petName}</label><br>
									<label for="">품종 : <c:forEach items="${breed}" var="b">${b.breedId eq pet.breed ? b.breedName:''}</c:forEach>${empty pet.breed ? '비밀':''}</label><br>
									<label for="">나이 : ${pet.petAge} 살</label><br>
									<label for="">성별 : ${pet.petGender eq 'M' ? '왕자님':'공주님'}</label><br>
									<label for="weight">몸무게 : ${pet.weight} kg</label><br>
									<button type="button" data-bs-toggle="modal" data-bs-target="#petModal">수정하기</button><br><br>
								</div>
							</div><br>
						</c:forEach>
					</div>
				</div>
			</c:if>
			<c:if test="${not empty petList||loginUser.petYN eq 'N'}">
				<h3 class="newPetBanner" onclick="newPetInput();">지금 새 가족을 등록해 보세요!</h3>
			<div class="newPet-member" hidden="true">
				<%@ include file="/WEB-INF/views/member/memberPetEnrollForm.jsp"%>
			</div>
			</c:if>
		</div>
	</div>
	</div>
	<script>
		function newPetInput(){
			if($(".newPet-member").attr("hidden")){				
				$(".newPet-member").attr("hidden",false);
			}
		}
		$(".petInfo>button").on("click",function(){
			var petNo= $(this).siblings("input[type=hidden]").val();
			$.ajax({
				url:"selectPet.me",
				data:{
					petNo:petNo
				},
				success:function(p){
					$(".selected-pet-info>#petNo").val(p.petNo);
					$(".selected-pet-info>#petName").val(p.petName);
					$(".selected-pet-info>#petAge").val(p.petAge);
					$(".selected-pet-info option").each(function(){
						if($(this).val()==p.breed){
							$(this).prop("selected",true);
						}
					});
					$(".selected-pet-info>#breed").val(p.breed);
					$(".selected-pet-info>#pet-age").text(p.petAge+" 살");
					$(".selected-pet-info>#weight").val(p.weight);
					$(".selected-pet-info>#photoNo").val(p.photoNo);
					$(".selected-pet-info>input[type=radio]").each(function(){
						if(p.petGender=$(this).val()){
							$(this).prop("checked",true);
						}else{
							$(this).prop("checked",false);							
						}
					})
					$.ajax({
						url:"selectPetPhoto.me",
						data:{
							photoNo:p.photoNo
						},
						success:function(photo){
							$(".selected-pet-info>input[type=file]").prop("src",'.'+photo.filePath);
						},
						error:function(){
							console.log("사진미스");
						}
					})
					
				}
			})

		})

	</script>
	<div class="modal fade" id="petModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">반려견 정보 수정</h4>
					<button type="button" class="close" data-bs-dismiss="modal">&times;</button>
				</div>		
				<form action="updatePetStat.me" method="post" enctype="multipart/form-data">
				<!-- Modal body -->
					<div class="modal-body">
						<div class="selected-pet-photo">
							<img width="250" height="200">
						</div>
						<div class="selected-pet-info">
							<label for="breed">품종</label>
							<select name="breed">
								<option value="">비밀(해당하는 품종이 없거나 믹스견인 경우 선택해 주세요)</option>
								<c:forEach items="${breed}" var="b">
									<option value="${b.breedId}">${b.breedName}</option>
								</c:forEach>
							</select><br>
							<input type="hidden" id="ownerNo" name="ownerNo" value="${loginUser.userNo}">
							<input type="hidden" id="petNo" name="petNo">
							<input type="hidden" id="photoNo" name="photoNo">
							<label for="petName">이름 : </label>
							<input type="text" id="petName" name="petName"><br>
							<label for="">나이 : </label> <span id="pet-age"></span><br>
							<input type="range" id="petAge" name="petAge" min="0" step="1" max="18"><br>
							<label for="">성별 : </label>
							<input type="radio" id="F" name="petGender" value="M">
							<label for="M">왕자님</label>
							<input type="radio" id="M" name="petGender" value="F">
							<label for="F">공주님</label><br>
							<label for="weight">몸무게 : </label>
							<input type="number" id="weight" name="weight" step="0.1"> kg<br>
							<label for="photo">반려견 사진 자랑(1장만!)</label>
							<input type="file" name="reUpFile" onchange="loadImg(this);">	
						</div>
					</div>	
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger" >반려견 등록</button>
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script>
	function loadImg(inputFile){
		var trg=$(".selected-pet-photo");
		if(inputFile.files.length==1){
			var reader = new FileReader();
			reader.readAsDataURL(inputFile.files[0]);
			reader.onload=function(e){
				trg.children().attr("src",e.target.result);
				trg.attr("hidden",false);
			}
		}else{
			trg.children().attr("src",null);
			trg.attr("hidden",true);
		}
	}
	$(".selected-pet-info>#petAge").on("change",function(){
		var age=$(".selected-pet-info>#petAge").val();
		age+=" 살";
		$(".selected-pet-info>#pet-age").text(age);
	})
	</script>
</body>
</html>