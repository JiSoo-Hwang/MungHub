<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>필터화 시키는 페이지</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 주소 api -->

<style>
	#formBody{
      margin: 20% 20% 15% 15%;
    }
	.form-section {
      margin-bottom: 2rem;
    }
    .form-section h5 {
      margin-bottom: 1rem;
    }
    /* 시간선택 css */
    .str-btn{
        width: 100px;
        height: 50px;
        border: 2px solid #ccc;
        margin: 5px;
        transition: background-color 0.3s, color 0.3s;
    }
	.str-btn.selected {
	  background-color: #28a745;
	  color: white;
	}
	.str-btn.active {
	  background-color: lightblue;
	  color: white;
	}
	
	/* 소요시간 CSS  */
    .duration-btn-group , .petType-btn-group {
        display: flex;
        justify-content: space-around;
        margin-top: 20px;
    }
    .duration-btn , .petType-btn {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        border: 2px solid #ccc;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 16px;
        background-color: white;
        transition: background-color 0.3s, color 0.3s;
    }
	.duration-btn.selected, .petType-btn.selected {
	   background-color: skyblue;
	   color: white;
	 }
	 .duration-btn.active, .petType-btn.active {
	   background-color: lightblue;
	   color: white;
	 }
    .duration-btn span , petType-btn span {
        display: block;
        font-size: 14px;
    }
    .duration-btn.best::after {
        content: 'BEST';
        display: block;
        font-size: 10px;
        color: #007bff;
        margin-top: 5px;
    }
    .petType-btn.best::after {
        content: 'BEST';
        display: block;
        font-size: 10px;
        color: #007bff;
        margin-top: 5px;
    }
    .btn-reserve {
        background-color: skyblue;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
    }
    .btn-reserve:hover {
        background-color: #0056b3;
    }
    
    /* 시팅용품 */
    .items-row {
	    display: flex;
	    flex-wrap: wrap;
	    justify-content: space-around;
	    align-items: center;
	}
	
	.item {
	    display: flex;
	    flex-direction: column;
	    align-items: center;
	    margin: 10px;
	    text-align: center;
	    flex-basis: calc(33.333% - 20px); /* 각 아이템이 부모 너비의 1/3씩 차지하도록 설정합니다 */
   		max-width: calc(33.333% - 20px); /* 최대 너비를 부모 너비의 1/3로 설정합니다 */
	}
	
	.item img {
	    margin-bottom: 8px;
	}
    
</style>

</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp" %>
	
	<div class="contatiner mt-5" id="formBody">
	<h3>단기돌봄 예약페이지</h3>
	<br><br>
    <form action="enroll.re" method="post" enctype="multipart/form-data">
    <!-- 다음페이지로 보내야 하지만 form에서 입력되지 못할 값들 -->
	    <input type="hidden" name ="visitDate" value="${at.visitDate }">
	    <input type="hidden" name ="startTime" value="${at.startTime }">
	    <input type="hidden" name ="duration" value="${at.duration }">
	    <input type="hidden" name ="endTime" value="${at.endTime }">
	    <input type="hidden" name ="petSitterNo" value="${at.petSitterNo }">
	    <input type="hidden" name ="petTypeNo" value="${at.petTypeNo }">
	    <input type="hidden" name ="priceName" value="${at.priceName }">
	    <input type="hidden" name ="totalPrice" value="${at.totalPrice }">
	    <input type="hidden" name ="userNo" value="${loginUser.userNo }">

      <!--방문장소-->
      <div class="form-section">
        <h5>어디로 방문할까요?</h5>
        
        <div class="form-group">
            성함 <input type="text" class="form-control" name="petOwnerName" id="petOwnerName" placeholder="견주님 성함" style="width:300px;" required>
            	<label for="userInfo"><input type="checkbox" id="userInfo"> 기존 회원정보 사용</label>
        </div> 
        <div class="form-group">
            연락처 <input type="text" class="form-control" name="phone" id="phone" placeholder="연락받을 전화번호" style="width:300px;" required>
        </div>
        <!-- Button trigger modal -->
		<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
		 주소 신규입력
		</button>
		<div class="form-group">
            회원가입 주소 <input type="text" class="form-control" name="address" id="address" value="인천광역시 OO동" style="width:500px;" required>
        </div>
        <script>
	        $(document).ready(function(){
	        	var chkName = '${loginUser.name}';
	        	var chkPhone = '${loginUser.phone}';
	        	var chkAddress = '${loginUser.address}';
	        	
	        	$('#userInfo').change(function() {
	                if($(this).is(':checked')) {
	                	$('#petOwnerName').val(chkName);
	                	$('#phone').val(chkPhone);
	                	$('#address').val(chkAddress);
	                } else {
	                	$('#petOwnerName').val('');
	                	$('#phone').val('');
	                	$('#address').val('');
	                }
	            });
	        });
        </script>
		
		<!-- Modal -->
		<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="staticBackdropLabel">주소입력창</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <input type="text" id="sample6_postcode" placeholder="우편번호">
				<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
				<input type="text" id="sample6_address" placeholder="주소" style="width:400px;"><br>
				<input type="text" id="sample6_detailAddress" placeholder="상세주소" style="width:300px;">
				<input type="text" id="sample6_extraAddress" placeholder="참고항목">
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		        <button type="button" class="btn btn-primary" id="resetBtn">초기화</button>
		        <button type="button" class="btn btn-primary" id="inputBtn">입력완료</button>
		      </div>
		    </div>
		  </div>
		</div>
      </div>
	
      <!-- 날짜,시간확인 -->
      <div class="form-section">
          <h5>방문 날짜와 시간, 돌봄시간, 반려견 유형을 확인해주세요.</h5><br>
          <p>(일정 변경은 이전 페이지에서 가능합니다.)</p> <button class="homeBtn" onclick="location.href='sitter.re'">예약 초기화면으로 돌아가기</button>
          
          <div class="form-group">
              <h5>방문날짜</h5>
              <input type="date" class="form-control" value="${at.visitDate }" name="visitDate" id="visitDate" disabled>
          </div>
          
          <div class="form-group">
              <h5>방문시간</h5>
                <div class="" id="startTime">
                <br> 
	                <button type="button" class="str-btn" value="1000">10:00</button>
	                <button type="button" class="str-btn" value="1100">11:00</button>
	                <button type="button" class="str-btn" value="1200">12:00</button>
	                <button type="button" class="str-btn" value="1300">13:00</button>
	                <button type="button" class="str-btn" value="1400">14:00</button>
	                <button type="button" class="str-btn" value="1500">15:00</button>
	                <button type="button" class="str-btn" value="1600">16:00</button>
	                <button type="button" class="str-btn" value="1700">17:00</button>
           		</div>
           		
           	 <h5>돌봄시간</h5>
	             <div class="duration-btn-group" id="duration"> 
	             <br>
	                <button type="button" class="duration-btn" value="100">60분</button>
	                <button type="button" class="duration-btn" value="200">120분</button>
	                <button type="button" class="duration-btn" value="300">180분</button>
	                <button type="button" class="duration-btn" value="400">240분</button>
	             </div>
	         <h5>반려견 유형</h5>
               	 <div class="petType-btn-group" id="petType">
                    <button type="button" class="petType-btn" name="petType" value="1">소형</button>
                    <button type="button" class="petType-btn" name="petType" value="2">중형</button>
                    <button type="button" class="petType-btn" name="petType" value="3">대형</button>
               	 </div>
          </div>
      </div>
	
      <!--펫 정보 (이름,사진,요청사항) -->
      <div class="form-section">
	        <h5>반려동물의 정보를 입력해주세요.</h5>
	        <div class="form-group">
	          	<label for="petName">이름<input type="text" class="form-control" name="petName" id="petName" placeholder="반려동물의 이름을 적어주세요." style="width:300px;" required></label>
	          	<br>
	          	<label for="upfile">첨부파일</label>
	          	<input type="file" onchange="readURL(this);" class="form-control" name="upfile" id="upfile" style="width:500px;">
	          	<br>
	          	<img id="preview" style="width:300px;" />
	          	<br>
	          	<label for="caution">요청사항</label>
	          	<br>
	          	<textarea name="caution" id="caution" rows="4" cols="60" placeholder="돌봄 유의사항을 꼭!! 적어주세요." style="resize: none;" required></textarea>
	        </div>
      </div>
	
      <!-- 펫시팅 용품 준비안내 (차후 상품판매로 연결예정)-->
      <h5>펫시팅 용품을 준비해주세요.</h5>
      <div class="items-row mt-4">
          <div class="item">
            <img src="/pjtMungHub/resources/uploadFiles/sittingSupplies/food.png" width="100" height="120" alt="사료">
          </div>
          <div class="item">
            <img src="/pjtMungHub/resources/uploadFiles/sittingSupplies/snack.png" width="100" height="120" alt="간식">
          </div>
          <div class="item">
            <img src="/pjtMungHub/resources/uploadFiles/sittingSupplies/toy.png" width="100" height="120" alt="장난감">
          </div>
          <div class="item">
            <img src="/pjtMungHub/resources/uploadFiles/sittingSupplies/line.png" width="100" height="120" alt="목줄">
          </div>
          <div class="item">
            <img src="/pjtMungHub/resources/uploadFiles/sittingSupplies/identification.png" width="100" height="120" alt="인식표">
          </div>
          <div class="item">
            <img src="/pjtMungHub/resources/uploadFiles/sittingSupplies/comb.png" width="100" height="120" alt="빗">
          </div>
          <div class="item">
            <img src="/pjtMungHub/resources/uploadFiles/sittingSupplies/tissues.png" width="100" height="120" alt="티슈">
          </div>
          <div class="item">
            <img src="/pjtMungHub/resources/uploadFiles/sittingSupplies/pad.png" width="100" height="120" alt="배변패드">
          </div>
      </div>
      
      <br>
      <button type="submit">예약완료 결제하기로 이동</button>
    </form>
  	</div>	
  	
  	<br><br>
  	
  	<script>
  		$(function(){
  			//모든버튼 비활성화
  			$("#startTime .str-btn").prop("disabled",true);
  			$("#duration .duration-btn").prop("disabled",true);
  			$("#petType .petType-btn").prop("disabled",true);
  			
  			//? 쿼리스트링에서 필요한 데이터만 뽑아오기
  			function getQueryParam(param){
  				var urlParams = new URLSearchParams(window.location.search);
  				return urlParams.get(param);
  			}
  			var startTime = getQueryParam("startTime");
  			var duration = getQueryParam("duration");
  			var petTypeNo = getQueryParam("petTypeNo");
  			
  			//넘어온 값이 맞다면 button을 변수 지정해서 특정 button만 활성화 시키기
  			if(startTime){
  				var startTimeButton = $('.str-btn[value="'+ startTime + '"]');
  				if(startTimeButton){
  					startTimeButton.prop('disabled',false).addClass('active');
  				}
  			}
  			if(duration){
  				var durationButton = $('.duration-btn[value="'+ duration +'"]');
  				if(durationButton){
  					durationButton.prop('disabled',false).addClass('active');
  				}
  			}
  			if(petTypeNo){
  				var petTypeBtn = $('.petType-btn[value="'+ petTypeNo +'"]');
  				if(petTypeBtn){
  					petTypeBtn.prop('disabled',false).addClass('active');
  				}
  			}
  		});
  		
  		//주소 api
  		function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("sample6_extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("sample6_extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample6_postcode').value = data.zonecode;
	                document.getElementById("sample6_address").value = addr; 
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("sample6_detailAddress").focus();
	                
	                //주소창에 값을 넣어주는 버튼
	               $('#inputBtn').click(function(){
	            	   var fullAddress = addr+'  '+document.getElementById("sample6_detailAddress").value;
	            	   $('#address').val(fullAddress);
	            	 //값을 보낸 후 모달창 닫아주기
						$("#staticBackdrop").modal('hide'); 
	               });
	            }
	        }).open();
    	}
		//주소 입력창 초기화 버튼  		
  		$("#resetBtn").click(function(){ 
			$("#sample6_postcode").val('');
			$("#sample6_address").val('');
			$("#sample6_detailAddress").val('');
			$("#sample6_extraAddress").val('');
		});
		
		//첨부파일 미리보기
	function readURL(input) {
	  if (input.files && input.files[0]) {
	    var reader = new FileReader();
	    reader.onload = function(e) {
	      document.getElementById('preview').src = e.target.result;
	    };
	    reader.readAsDataURL(input.files[0]);
	  } else {
	    document.getElementById('preview').src = "";
	  }
	}
  	
  	</script>
		
	
		
		
		
		
		

</body>
</html>