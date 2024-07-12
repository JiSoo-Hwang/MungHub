<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.Date, java.text.SimpleDateFormat"%>
<%
	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String formattedDate = sdf.format(today);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 예약 페이지</title>

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js">
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import listPlugin from '@fullcalendar/list';
</script> <!-- fullcalender -->

 <style>
        body {
            font-family: 'Arial', sans-serif;
            padding: 20px;
        }

        .container {
            background-color: #fff3e0;
            padding: 20px;
            border: 2px solid #ffa726;
            border-radius: 10px;
        }

        .h4, .h5 {
            color: #ef6c00;
            margin-bottom: 20px;
        }

        .sitter-info, .pet-info {
            background-color: #ffecb3;
            padding: 10px;
            border: 1px solid #ffa726;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .sitterFont {
            font-weight: bold;
            margin-top: 10px;
        }

        .popular-style {
            font-style: italic;
        }

        .str-btn, .petType-btn {
            background-color: #ffecb3;
            border: 1px solid #ffa726;
            color: #ef6c00;
            margin: 5px;
            padding: 20px 40px;
            border-radius: 5px;
            font-size: 1.2em;
            width: 100%;
        }

        .str-btn:hover, .petType-btn:hover {
            background-color: #ffb74d;
            color: #ffffff;
        }
        
        .str-btn.selected, .petType-btn.selected {
            background-color: #ffb74d;
            color: #ffffff;
        }

        .pet-info-all {
            background-color: #fff3e0;
            padding: 10px;
            border: 1px solid #ffa726;
            border-radius: 10px;
            flex: 1;
        }

        textarea {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ffa726;
            resize: none;
        }

        .reservation-btn {
            background-color: #ef6c00;
            border: none;
            padding: 15px 0;
            color: #ffffff;
            border-radius: 5px;
            margin-top: 20px;
            width: 100%;
            font-size: 1.5em;
        }

        .reservation-btn:hover {
            background-color: #d84315;
        }

        #preview {
            margin-top: 10px;
            max-width: 100%;
            height: auto;
            border: 1px solid #ffa726;
            border-radius: 5px;
        }

        .calendar-time-container {
            display: flex;
            justify-content: space-between;
        }

        .calendar-container {
            flex: 1;
            margin-right: 20px;
        }
        
        #calendar {
            cursor: pointer;
        }
        
        .fc-daygrid-day:hover {
            cursor: pointer;
        }
        
        .fc-day-selected {
            background-color: #ffcc00 !important;
        }

        .time-container {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .info-container {
            display: flex;
            justify-content: space-between;
        }

        .info-container .sitter-info {
            flex: 1;
            margin-right: 20px;
        }

        .info-container .sitter-info:last-child {
            margin-right: 0;
        }

        .pet-type-container {
            display: flex;
            justify-content: space-between;
        }

        .three-section-container {
            display: flex;
            justify-content: space-between;
            gap: 20px;
        }

        .three-section-container > div {
            flex: 1;
        }

        .row {
            display: flex;
            flex-wrap: wrap;
        }

        .col-md-3 {
            flex: 0 0 25%;
            max-width: 25%;
        }
        
        #hosName,#hosPhone,#hosAddress {
        	font-color: gray;
        }
        
    </style>
</head>
<body>
    <%@include file="/WEB-INF/views/common/header.jsp" %>
    <input type="hidden" id="formattedDate" value="<%=formattedDate %>">
    
hosReNo=0, userNo=1, petOwnerName=어두민, ownerPhone=00000000, 
hosName=가평축산농협 동물병원, hosPhone=031-582-4111, hosAddress=경기도 가평군 가평읍 가화로 55-17, 
reDate=2024-07-19, reTime=1400, petName=멍뭉이, petKind=웰시코기, petBirthDay=2024-07-18, 
petGender=여, neutralization=아니오, specialNotes=qqqqqqqqq, petTypeNo=중형, petTypeName=null, 
symptom=구토,기침, 
originName=2.png, changeName=resources/uploadFiles/hospital/2024071210212373920.png, 
diseaseName=파보바이러스, 홍역, 전염성 기관지염, 렙토스피라증, 장염, 심장사상충증, status=null, updateDay=null)


    
    

    <div class="container">
        
        <form action="hospitalEnrollUp.re" method="post" enctype="multipart/form-data">
            <input type="text" id="hosReNo" name="hosReNo" value="${hosRe.hosReNo }">
            <input type="hidden" id="userNo" name="userNo" value="${loginUser.userNo }">
            기존날짜 <input type="text" id="preReDate" name="preReDate" value="${hosRe.reDate }"> <!-- 예약한날짜 -->
            <input type="hidden" id="reDate" name="reDate" value=""> <!-- 업데이트 날짜 -->
            기존시간 <input type="text" id="preReTime" name="preReTime" value="${hosRe.reTime }">
            <input type="hidden" id="reTime" name="reTime" value="">
            기존 펫타입<input type="text" id="prePetType" name="prePetType" value="${hosRe.petTypeNo }">
            <input type="hidden" id="petTypeNo" name="petTypeNo" value="">
            기존 예상병명<input type="text" id="preSymptom" value="${hosRe.symptom }">
            기존 성별<input type="text" id="prePetGender" value="${hosRe.petGender }">
            기존 중성화<input type="text" id="preNeutralization" value="${hosRe.neutralization }">
            기존 파일경로<input type="text" name="changeName" value="${hosRe.changeName }">
            <input type="hidden" name="diseaseName" value="${hosRe.diseaseName }">
            
            <h4 class="h4">접수증</h4>
            <div class="info-container mb-3">
                <div class="sitter-info">
                    <h5 class="h5">보호자의 정보를 입력해주세요.</h5>
                    <label for="ownerName">성명:</label>
                    <input type="text" id="ownerName" name="petOwnerName" class="form-control" value="${hosRe.petOwnerName }" placeholder="필히 적어주세요." required>
                    <label for="ownerPhone">연락처:</label>
                    <input type="text" id="ownerPhone" name="ownerPhone" class="form-control" value="${hosRe.ownerPhone }" placeholder="필히 적어주세요." required>
                </div>
                <div class="sitter-info">
                    <h5 class="h5">병원 정보 확인란</h5>
                    <label for="hosName">병원 이름:</label>
                    <input type="text" id="hosName" name="hosName" value="${hosRe.hosName }" class="form-control" readonly>
                    <label for="hosPhone">연락처:</label>
                    <input type="text" id="hosPhone" name="hosPhone" value="${hosRe.hosPhone }" class="form-control" readonly>
                    <label for="hosAddress">주소:</label>
                    <input type="text" id="hosAddress" name="hosAddress" value="${hosRe.hosAddress }" class="form-control" readonly>
                </div>
            </div>
            
            <h5 class="h5">방문날짜와 시간을 선택해주세요.</h5>
            <div class="calendar-time-container mb-3">
                <div id="calendar" class="calendar-container">
                    <!-- fullCalendar -->
                </div>
                
                <div class="time-container" id="startTime">
                    <h5 class="h5">방문시간을 선택해주세요.</h5>
                    <button type="button" class="str-btn" value="1000">10:00</button>
                    <button type="button" class="str-btn" value="1100">11:00</button>
                    <button type="button" class="str-btn" value="1200">12:00</button>
                    <button type="button" class="str-btn" value="1300">13:00</button>
                    <button type="button" class="str-btn" value="1400">14:00</button>
                    <button type="button" class="str-btn" value="1500">15:00</button>
                    <button type="button" class="str-btn" value="1600">16:00</button>
                    <button type="button" class="str-btn" value="1700">17:00</button>
                </div>
            </div>
            
            <div class="three-section-container mb-3">
                <div class="sitter-info">
                    <h5 class="h5">반려동물 정보</h5>
                    <label for="petName">이름:</label>
                    <input type="text" id="petName" name="petName" value="${hosRe.petName }" class="form-control">
                    <label for="petKind">견종:</label>
                    <input type="text" id="petKind" name="petKind" value="${hosRe.petKind }" class="form-control">
                    <label for="petBirthDay">생년월일:</label>
                    <input type="date" id="petBirthDay" name="petBirthDay" value="${hosRe.petBirthDay }" class="form-control">
                    <label for="petGender">성별:</label>
                    <select id="petGender" name="petGender" class="form-select">
                        <option value="남">수컷</option>
                        <option value="여">암컷</option>
                    </select>
                    <label for="neutralization">중성화 여부:</label>
                    <select id="neutralization" name="neutralization" class="form-select">
                        <option value="예">O</option>
                        <option value="아니오">X</option>
                    </select>
                    <label for="specialNotes">특이사항:</label>
                    <textarea id="specialNotes" name="specialNotes" rows="3" style="resize:none;" class="form-control">${hosRe.specialNotes }</textarea>
                </div>
                <div class="time-container">
                    <h5 class="h5">반려견 유형을 선택해주세요.</h5>
                    <button type="button" class="petType-btn" value="1">소형</button>
                    <button type="button" class="petType-btn" value="2">중형</button>
                    <button type="button" class="petType-btn" value="3">대형</button>
                </div>
                <div class="pet-info-all">
                    <h5 class="h5">증상을 선택해주세요. (복수 선택 가능)</h5>
                    <div class="row">
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="구토" id="symptom1" name="symptom">
						        <label class="form-check-label" for="symptom1">구토</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="혈변" id="symptom2" name="symptom">
						        <label class="form-check-label" for="symptom2">혈변</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="탈수" id="symptom3" name="symptom">
						        <label class="form-check-label" for="symptom3">탈수</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="열" id="symptom4" name="symptom">
						        <label class="form-check-label" for="symptom4">열</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="기침" id="symptom5" name="symptom">
						        <label class="form-check-label" for="symptom5">기침</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="콧물" id="symptom6" name="symptom">
						        <label class="form-check-label" for="symptom6">콧물</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="눈곱" id="symptom7" name="symptom">
						        <label class="form-check-label" for="symptom7">눈곱</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="공격성" id="symptom8" name="symptom">
						        <label class="form-check-label" for="symptom8">공격성</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="마비" id="symptom9" name="symptom">
						        <label class="form-check-label" for="symptom9">마비</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="경련" id="symptom10" name="symptom">
						        <label class="form-check-label" for="symptom10">경련</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="재채기" id="symptom11" name="symptom">
						        <label class="form-check-label" for="symptom11">재채기</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="발열" id="symptom12" name="symptom">
						        <label class="form-check-label" for="symptom12">발열</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="황달" id="symptom13" name="symptom">
						        <label class="form-check-label" for="symptom13">황달</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="신부전" id="symptom14" name="symptom">
						        <label class="form-check-label" for="symptom14">신부전</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="관절염" id="symptom15" name="symptom">
						        <label class="form-check-label" for="symptom15">관절염</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="무기력증" id="symptom16" name="symptom">
						        <label class="form-check-label" for="symptom16">무기력증</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="식욕부진" id="symptom17" name="symptom">
						        <label class="form-check-label" for="symptom17">식욕부진</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="설사" id="symptom18" name="symptom">
						        <label class="form-check-label" for="symptom18">설사</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="복통" id="symptom19" name="symptom">
						        <label class="form-check-label" for="symptom19">복통</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="체중감소" id="symptom20" name="symptom">
						        <label class="form-check-label" for="symptom20">체중감소</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="복부팽창" id="symptom21" name="symptom">
						        <label class="form-check-label" for="symptom21">복부 팽창</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="피로" id="symptom22" name="symptom">
						        <label class="form-check-label" for="symptom22">피로</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="호흡곤란" id="symptom23" name="symptom">
						        <label class="form-check-label" for="symptom23">호흡곤란</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="관절통증" id="symptom24" name="symptom">
						        <label class="form-check-label" for="symptom24">관절통증</label>
						    </div>
						</div>
						<div class="col-md-3">
						    <div class="form-check">
						        <input class="form-check-input symptom-checkbox" type="checkbox" value="출혈" id="symptom25" name="symptom">
						        <label class="form-check-label" for="symptom25">출혈</label>
						    </div>
						</div>

                    </div>
                    <br>
                    <label for="upfile" style="font-size:16px; font-weight:bold;">사진첨부</label>
                    <input type="file" onchange="readURL(this);" name="upfile" id="upfile" class="form-control">
                    <img id="preview" src="${hosRe.changeName }" alt="Image Preview">
                </div>
            </div>

            <button type="submit" class="reservation-btn" id="reBtn">예약변경완료</button>
        </form>
    </div>	
	<br><br>
   
	<script>
		//form 으로 전송 못한 데이터
		$('#reBtn').on('click',function(){
			var inputReTime = $('.str-btn.selected').val();
			var inputPetType = $('.petType-btn.selected').val();
			
			$('#reTime').val(inputReTime);
			$('#petTypeNo').val(inputPetType);
		});
	
		//버튼 클릭시 활성화/비활성화
		document.addEventListener('DOMContentLoaded', function() {
	        $(".str-btn, .petType-btn").on("click", function() {
	            $(this).siblings().removeClass("selected");
	            $(this).addClass("selected");
	        });
	    });
		//첨부파일 미리보기
		function readURL(input){
				//input.files : 선택된 파일을 나타내는 FileList 객체
				//input.files[0] : 첫번째 선택된 파일
			if(input.files && input.files[0]){
				var reader = new FileReader(); //파일의 내용을 URL 로 읽음.
				reader.onload = function(e){ //파일 호출이 완료되면 
					document.getElementById('preview').src = e.target.result; //데이터 URL을 나타냄
				};
				//선택된 파일을 데이터URL 로 읽는 메서드,base64 인코딩된 문자열로 표현함
				reader.readAsDataURL(input.files[0]);
			}else{
				document.getElementById('preview').src = "";
			}
		}
	
		//============== 달력 ===================
		$(function() {
			var reDate =  $('#preReDate').val();//예약한 날짜 기준
			var formattedDate = $('#formattedDate').val(); //오늘날짜기준
		    var calendarEl = $('#calendar')[0];
		    var calendar = new FullCalendar.Calendar(calendarEl, {
		        initialView: 'dayGridMonth',
		        locale: 'ko', // 한글 로케일 설정
		        headerToolbar: {
                    left: '',
                    center: 'title',
                    right: 'prev,next'
                },
		        validRange:{ //오늘날짜 이전 막아주기
		        	start : formattedDate
		        },
		        defaultDate: formattedDate,
		        dateClick: function(info) {
		            //스타일
		            $('.fc-daygrid-day').removeClass('fc-day-selected'); //모든셀 표시제거
		            $(info.dayEl).addClass('fc-day-selected'); //클릭된 날짜만 표시
		            
		            //선택한 날짜 hidden 으로
		            var selectedDate = new Date(info.dateStr);
		            var reDate = selectedDate.toISOString().split('T')[0];
		            $('#reDate').val(reDate);
		        }
		    });
		    setTimeout(function() {
		    	
		        calendar.render();
		        
		     // 기존 정보 자동선택
		     // 예약날짜
	            var todayEl = $('.fc-daygrid-day[data-date="' + reDate + '"]');
	            todayEl.addClass('fc-day-selected');
	            $('#reDate').val(reDate);
	            
	         // 예약시간
	         	var preReTime = $('#preReTime').val();
	         	var firstStrBtn = $('.str-btn[value="'+ preReTime +'"]');
	         	firstStrBtn.addClass('selected');
	         	$('#reTime').val(preReTime);
	         
	         // 펫크기
	         	var prePetType = $('#prePetType').val();
	         	var firstPetBtn = $('.petType-btn[value="'+ prePetType +'" ]');
	         	firstPetBtn.addClass('selected');
	         	$('#petType').val(prePetType);
	         
	         // 성별
	         	var prePetGender = $('#prePetGender').val();
	         	$('#petGender').val(prePetGender);
	         // 중성화
	         	var preNeutralization = $('#preNeutralization').val();
	         	$('#neutralization').val(preNeutralization);
	         	
	         // 증상 체크박스
	         	var preSymptom = $('#preSymptom').val();
	         	var splitSymptom = preSymptom.split(',');
	         	splitSymptom.forEach(function(symptom){
	         		console.log(symptom);
	         		$('.symptom-checkbox[value="' + symptom + '"]').prop('checked',true);
	         	});
	         	
		    }, 500);
		});
	</script>
</body>
</html>
