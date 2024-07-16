<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.Date, java.text.SimpleDateFormat"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String formattedDate = sdf.format(today);
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3dcfbff0a780d5171a2a2f039fc60ac0&libraries=services,clusterer,drawing"></script>
<!-- fullcalender -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js"></script>


<title>집 소개 및 예약</title>
<style>
	@font-face {
        font-family: 'MangoDdobak-B';
        src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2405-3@1.1/MangoDdobak-B.woff2') format('woff2');
        font-weight: 700;
        font-style: normal;
	}
	body{
        font-family: arial,sans-serif;
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    .all-container{
    	margin-left: 10%;
    	margin-right: 10%;
        padding: 20px;
    }
    h2{
        margin-top: 20px;
        font-size: 24px;
        border-bottom: 2px solid #000;
        padding-bottom: 10px;
    }
    section{
    	margin-bottom : 5%;
    }
    /* 이미지 슬라이더 */
    .slider {
    	width : 600px;
    	height : 400px;
    	position : relative; /* 위치의 기준을 잡아줌*/
    	overflow: hidden; /* 초과한 요소는 잘라내서 보여주지 않음*/
    	margin : 0 auto;
    	margin-bottom : 5%;
    }
    .slide {
    	position : absolute;
    	top : 0;
    	left : 0;
    	width : 100%;
    	height : 100%;
    	/* 투명도와 전환효과를 제어하는 속성*/
    	opacity : 0; /* 0투명, 1불투명*/
    	transition : opacity 1s ease-in-out; /* opacity 의 효과를 부드럽게 전환해줌*/
    }
    .slide.active{
    	opacity : 1;
    }
    .prev, .next {
    	position : absolute;
    	top : 50%;
    	transform : translateY(-50%); /* 2D 또는 3D 변환효과 적용, 수직으로 50%*/
    	font-size : 40px;
    	font-weight : bold;
    	color : white;
    	padding : 10px;
    	cursor : pointer;
    	
    	z-index : 1; /* 버튼이 이미지 위에 위치하도록*/
    	opacity : 1;
    	overflow : visible; /* 초과하는 내용을 잘라내지 않고 유지*/
    	border : none;
    	background : transparent; /* 배경을 투명하게 */
    }
    .prev {
    	left : 20px;
    }
    .next {
    	right : 20px;
    }
    
    .introduction p{
        font-size: 16px;
    }
    
    .review{
    	border: 2px solid pink;
    	border-radius: 5px;
    	max-width: 1000px;
    	margin : 0 auto;
    	padding: 20px;
    	margin-bottom: 10%;
    }
    .review-header {
            display: flex; /* Flexbox로 설정하여 같은 줄에 배치 */
            justify-content: space-between; /* 요소들을 양쪽 끝에 배치 */
            align-items: center; /* 요소들을 수직 중앙에 정렬 */
            margin-bottom: 20px;
     }
    .review-list{
    	padding: 10px;
    	diplay:flex;
    	flex-direction: column; /* 아이템을 세로로 배치*/
    }
    .review-item{
    	diplay: flex;
    	/*align-items: center; /* 수직 중앙정렬 */
    	justify-content: space-between;
    	margin-bottom: 20px;
    	padding: 20px;
    	border: 1px solid black;
    	border-radius: 5px;
    	box-shadow: 0 0 10px rgba(0,0,0,0.1); /* 아이템 그림자효과*/
    }
    .review-item img{
    	width: 200px;
    	height: auto;
    	margin-right: 20px;
    	border-radius: 5px;
    	
    }
    .review-content{
    	flex: 1; /* 남은 공간을 모두 차지하도록*/
    }
    .review-content .userName{
    	font-weight: bold;
    	margin-bottom: 10px;
    }
    .review-content .date{
    	color: #888; /* 연회색 */
    	margin-bottom: 10px;
    }
    .review-content .reviewText{
    	font-size: 16px;
    }
    
    
    .certificate{
    	display: flex;
        flex-wrap: wrap; /*한줄에 다 안들어 갈때 다음줄로 이동*/
    }
    .certificate-item{
         flex: 1;
        min-width: 100px;
        text-align: center;
        margin: 10px;
    }
    .certificate-item img{
        width: 100px;
        height: auto;
        margin-right: 20px;
    }
    .environment .tags{
        margin-top: 10px;
    }
    .tags span{
        display: inline-block;
        background-color: #f1f1f1;
        padding: 5px 10px;
        margin-right: 10px;
        margin-bottom: 10px;
        border-radius: 5px;
        font-size: 14px;
    }
    .service-list{
        display: flex;
        flex-wrap: wrap; 
    }
    .service-item{
        flex: 1;
        min-width: 100px;
        text-align: center;
        margin: 10px;
    }
    .service-item img{
        width: 100px;
        height: auto;
    }

    .reservation-btn{
        display:block;
        width:100%;
        padding: 10px;
        background-color: #007bff;
        color: #fff;
        border: none;
        font-size: 16px;
        margin-top: 20px;
        cursor: pointer;
    }
    
    .pricing-container {
        display: flex;
        flex-wrap: wrap; 
        justify-content: space-between;
    }
    .pricing-item {
        min-width: 100px;
        text-align: center;
        margin: 10px;
        flex: 1;
        margin-right: 20px;
    }
    .pricing-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    .pricing-table th, .pricing-table td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: center;
        font-family: 'MangoDdobak-B', sans-serif;
        font-size: 20px;
    }
    .pricing-table td{
    	cursor:pointer;
    }
    .pricing-table th {
        background-color: #f1f1f1;
    }
    .selected-row {
	    background-color: #ffcc00 !important;
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

</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp" %>
	<input type="hidden" id="formattedDate" value="<%=formattedDate %>">
	
	<form action="enrollHouse.re" method="post">
		<input type="hidden" id="houseNo" name="houseNo" value="${house.houseNo }"> <!-- houseNo -->
		<input type="hidden" id="endDate" name="javaDate" value=""> <!-- "endDate" -->
		<input type="hidden" id="stayNo" name="stayNo" value=""> <!-- stayNo -->
		<input type="hidden" id="userId" name="userId" value="${loginUser.userNo }"> <!-- userId -->
	
		<div class="all-container">
			<section class="slider">
	            <button class="prev">◁</button>
	            
	            <div class="slide">
	            	<img src="${house.filePath }${house.originName01 }" style="width: 100%; heigth: auto;">
	            </div>
	            <div class="slide">
	            	<img src="${house.filePath }${house.originName02 }" style="width: 100%; heigth: auto;">
	            </div>
	            <div class="slide">
	            	<img src="${house.filePath }${house.originName03 }" style="width: 100%; heigth: auto;">
	            </div>
	            
	            <button class="next">▷</button>
	        </section>
	        
	<script>
		//============== 이미지 슬라이더 ================
		$(function(){
			var slides = $('.slide');
			var currentSlide = 0; //현재 활성화된 슬라이드의 인덱스
			
			slides.eq(currentSlide).addClass('active'); //페이지 로드시 첫이미지 바로 보여주기
			setTimeout(function(){ //6초마다 다음 이미지 슬라이드
				var slideInterval = setInterval(nextSlide,6000);
			},0);
			function nextSlide(){
				slides.eq(currentSlide).removeClass('active');
				currentSlide = (currentSlide + 1) % slides.length;
				slides.eq(currentSlide).addClass('active');
			}
			function prevSlide(){
				slides.eq(currentSlide).removeClass('active');
				currentSlide = (currentSlide -1 + slides.length) % slides.length; 
				slides.eq(currentSlide).addClass('active');
			}
			$('.next').click(function(e){
				e.preventDefault(); //기본동작 방지 (내장객체, click,subnit 등의 기본동작을 취소시킴)
				nextSlide();
			});
			$('.prev').click(function(e){
				e.preventDefault();
				prevSlide();
			});
		});
	</script>
		
	        <section class="introduction">
	            <h2>보금자리 소개</h2>
	            <p>${house.introductionDetailed }</p>
	        </section>
	        
	        <section class="review">
	             <div class="review-header">
	             	<h2>고객들의 후기</h2> <span class="pagingArea"></span>
	             </div>
	             <div class="review-list">
	             
	             </div>
	        </section>
	
			<h2>인증정보</h2>
			<section class="certificate">
				<c:forEach var="c" items="${cer }">
						<div class="certificate-item">
							<img src="${c.filePath }${c.originName}" alt="인증사진">
			            	<p>${c.certificationName }</p>
						</div>
				</c:forEach>
		    </section>
		    
		    <section class="environment">
		        <h2>환경정보</h2>
		        <div class="tags">
		        	<c:forEach var="e" items="${env }">
		        		<span>${e.environmentName}</span>
		        	</c:forEach>
		        </div>
		    </section>
		
		    <section class="location">
		        <h2>위치</h2>
		        <p>주소 : ${house.houseAddress }</p>
		        <div id="houseLocation" style="width:100%;height:200px;"></div>
		    </section>
		
		    <section class="location">
		        <h2>인근 병원정보</h2>
		        <p>${house.nearbyHospital }</p>
		        <div id="hospitalLocation" style="width:100%;height:200px;"></div>
		    </section>
		
		    <section class="services">
		    	<h2>지원가능 서비스</h2>
		        <div class="service-list">
		        	<c:forEach var="s" items="${sup }">
		        		<div class="service-item">
			                <img src="${s.filePath }${s.originName}" alt="${s.supplyGuideName }">
			                <p>${s.supplyGuideName }</p>
		            	</div>
		        	</c:forEach>
		        </div>
		    </section>
	        
	        <h2>인증정보</h2>
			<section class="certificate">
				<c:forEach var="c" items="${cer }">
						<div class="certificate-item">
							<img src="${c.filePath }${c.originName}" alt="인증사진">
			            	<p>${c.certificationName }</p>
						</div>
				</c:forEach>
		    </section>
	
	        <section class="pricing">
			    <h2>예약하기</h2>
			    <div class="pricing-container">
			        <div class="pricing-item">
			            <table class="pricing-table">
			            <h5>서비스를 선택해주세요.</h5>
			                <thead>
			                    <tr>
			                        <th>숙박일정</th>
			                        <th>요금</th>
			                    </tr>
			                </thead>
			                <tbody>
			                    <c:forEach var="p" items="${price}">
			                         <tr class="click-row" name="amount" value="${p.price }">
			                            <td>${p.stayName}</td>
			                            <td>${p.price}</td>
			                        </tr>
			                    </c:forEach>
			                </tbody>
			            </table>
			        </div>
			        <div class="pricing-item">
			            <div id="calendar"></div>
			        </div>
		            <div class="pricing-item">
		            <h4>예약확인</h4>
			            견주님 성함 : <input type="text" id="userName" name="petOwnerName" value="${loginUser.name }" style="width:200px;" readonly required> <br>
			            견주님 연락처 : <input type="text" id="phone" name="phone" value="${loginUser.phone }" style="width:200px;" required> <br>
			            돌보미 주소 : <input type="text" id="inputHouseAddress" name="address" value="${house.houseAddress }" style="width:250px;" readonly> <br>
			            예약 날짜 : <input type="text" id="inputDate" name="inputDate" style="width:200px;" readonly required> <br>
			            숙박 일정 : <input type="text" id="inputEndDate"  style="width:200px;" readonly required> <br>
			            예상 요금 : <input type="text" id="inputAmount" name="totalAmount" style="width:200px;" readonly required> <br><br>
			            <h5>*요청사항(필수입력)*</h5> 
			            <textarea name="caution" id="caution" rows="4" cols="60" placeholder="돌봄 유의사항을 꼭!! 적어주세요." style="resize: none;" required></textarea>
			        </div>
			    </div>
			</section>
	        <button type="submit" class="reservation-btn">예약하고 결제페이지로</button>
		</div>
	</form>
      
      <br><br>
      
	<c:forEach var="r" items="${reList}" varStatus="status">
	    <input type="hidden" class="reservation-id" value="${r.reservationHouseNo}">
	    <input type="hidden" class="disabled-date" value="${r.startDate}">
	    <input type="hidden" class="disabled-start" value="${r.startDate}">
	    <input type="hidden" class="disabled-end" value="${r.endDate}">
	</c:forEach>
	<input type="hidden" id="totalReservations" value="${fn:length(reList)}">


    
    <script>
    //=============== 지도 api ========================
	    $(function(){
	    	setTimeout(function(){
	    		
	    	longReview();
	    	},2500);
	    	
			implementMap('houseLocation','${house.houseAddress}');
			setTimeout(function(){ 
				implementMap('hospitalLocation','${house.nearbyHospital}');
	        }, 2000);
		});
    
	    function implementMap(containerId,inputAddress){
			var mapContainer = document.getElementById(containerId), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 4 // 지도의 확대 레벨
		    };  
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
			
			// 주소로 좌표를 검색합니다
			geocoder.addressSearch(inputAddress, function(result, status) {
			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {
			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords
			        });
			        // 인포윈도우로 장소에 대한 설명을 표시합니다
			        var infowindow = new kakao.maps.InfoWindow({
			            content: '<div style="width:150px;font-size:10px;text-align:center;padding:0px 0;">'+inputAddress+'</div>'
			        });
			        infowindow.open(map, marker);
			        setTimeout(function(){ 
			        	map.relayout();
			        	// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				        map.setCenter(coords);
			        }, 1000);
			    }
			});    
			
		};
		
		//============= 요금표 ===================
		var stayNo = "";//숙박일정 숫자화
		$(function(){
			$('.click-row').on('click',function(){
				$('.click-row').removeClass('selected-row');
				$(this).addClass('selected-row');
				
				var inputEndDate = $(this).children().eq(0).text();
				var inputAmount = parseInt($(this).children().eq(1).text());
				stayNo = parseInt(inputEndDate.substring(0,1));
				$('#inputEndDate').val(inputEndDate);
				$('#inputAmount').val(inputAmount);
				$('#stayNo').val(stayNo);
			});
		});
		
		//============== 달력 ===================
		$(document).ready(function() {
		    var disabledDates = [];
		    
		    // 예약 정보를 배열에 추가
		    $('.reservation-id').each(function(index) {
		        var reservation = {
		            reservationId: $(this).val(),
		            start: $('.disabled-start').eq(index).val(),
		            end: $('.disabled-end').eq(index).val()
		        };
		        disabledDates.push(reservation);
		    });
		    
		    console.log('예약불가 날짜들:', disabledDates);

		    // disabledDates 배열을 평탄화하여 모든 날짜를 포함하는 단일 배열 생성
		    var allDisabledDates = disabledDates.flatMap(date => {
		        const dates = [];
		        let currentDate = new Date(date.start);
		        const endDate = new Date(date.end);

		        while (currentDate <= endDate) {
		            dates.push(new Date(currentDate));
		            currentDate.setDate(currentDate.getDate() + 1);
		        }

		        return dates;
		    });

		    console.log('평탄화 작업한 배열:', allDisabledDates);

		    var formattedDate = $('#formattedDate').val(); // 오늘 날짜 기준
		    var calendarEl = $('#calendar')[0];
		    var calendar = new FullCalendar.Calendar(calendarEl, {
		        initialView: 'dayGridMonth',
		        locale: 'ko', // 한글 로케일 설정
		        headerToolbar: {
		            left: '',
		            center: 'title',
		            right: 'prev,next'
		        },
		        validRange: { // 오늘 날짜 이전 막아주기
		            start: formattedDate
		        },
		        selectAllow: function(selectInfo) {
		            var selectedDate = new Date(selectInfo.startStr);

		            return !allDisabledDates.some(disabledDate => {
		                return selectedDate.getTime() === disabledDate.getTime();
		            });
		        },
		        events: allDisabledDates.map(date => ({
		            start: date.toISOString().split('T')[0],
		            end: date.toISOString().split('T')[0],
		            allDay: true,
		            display: 'background',
		            backgroundColor: '#ff9f89' // 예약된 날짜 배경 색상 설정
		        })),
		        dateClick: function(info) {
		            var selectedDate = new Date(info.dateStr);
		            var isDisabled = allDisabledDates.some(disabledDate => {
		                return selectedDate.getTime() === disabledDate.getTime();
		            });

		            if (isDisabled) {
		                alert('이미 예약된 날짜입니다. 다른 날짜를 선택하세요.');
		                return;
		            }

		            $('#inputDate').val(info.dateStr);

		            var fullEndDate = new Date(info.dateStr); // fullCalendar의 선택한 날짜 값을 Date로 형변환
		            fullEndDate.setDate(fullEndDate.getDate() + stayNo); // 숙박 날짜 더해주기
		            var endDate = fullEndDate.toISOString().split('T')[0]; // 날짜 형태로 바꿔주기
		            $('#endDate').val(endDate);

		            // 스타일
		            $('.fc-daygrid-day').removeClass('fc-day-selected'); // 모든 셀 표시 제거
		            $(info.dayEl).addClass('fc-day-selected'); // 클릭된 날짜만 표시
		        }
		    });

		    setTimeout(function() {
		        calendar.render();
		    }, 3000);
		});
		
		//============= 고객 후기 비동기통신 ===============
		 var houseNo = $('#houseNo').val();
			 function longReview(){
				 $.ajax({
			 		url : "longReview.re",
			 		data : {houseNo : houseNo},
			 		success : function(result){
			 			var reviewList = result.reviewList;
			 			var pi = result.pi;
			 			var reviewStr = "";
			 			for(var i=0; i<reviewList.length; i++){
			 				reviewStr += "<div class='review-item'>"
				 	                + "<img src='" + reviewList[i].filePath + reviewList[i].originName01 + "' alt='강쥐이미지'>"
				 	                + "<img src='" + reviewList[i].filePath + reviewList[i].originName02 + "' alt='강쥐이미지'>"
				 	                + "<img src='" + reviewList[i].filePath + reviewList[i].originName03 + "' alt='강쥐이미지'>"
				 	                + "<img src='" + reviewList[i].filePath + reviewList[i].originName01 + "' alt='강쥐이미지'>"
				 	                + "<div class='review-content'>"
				 	                + "<div class='userName'>" + reviewList[i].userNo + "</div>"
				 	                + "<div class='date'>" + reviewList[i].reviewDate + "</div>"
				 	                + "<div class='reviewText'>" + reviewList[i].reviewContent + "</div>"
				 	                + "</div>"
				 	                + "</div><br><br>";
			 			}
			 			
			 			var pagination = "<ul class='pagination'>"
			 			
			 			// 이전버튼
			            if (pi.currentPage == 1) {
			                pagination += "<li class='page-item disabled'><a class='page-link' href='#'>◀</a></li>";
			            } else {
			                pagination += "<li class='page-item'><a class='page-link' href='#' onclick='goToPage(" + (pi.currentPage - 1) + ")'>◀</a></li>";
			            }
			            // 페이징번호 반복문
			            for (var p = pi.startPage; p <= pi.endPage; p++) {
			                pagination += "<li class='page-item'><a class='page-link' href='#' onclick='goToPage(" + p + ")'>" + p + "</a></li>";
			            }
			            // 다음버튼
			            if (pi.currentPage == pi.maxPage) {
			                pagination += "<li class='page-item disabled'><a class='page-link' href='#'>▶</a></li>";
			            } else {
			                pagination += "<li class='page-item'><a class='page-link' href='#' onclick='goToPage(" + (pi.currentPage + 1) + ")'>▶</a></li>";
			            }
			 			$('.review-list').html(reviewStr);
			 			$('.pagingArea').html(pagination);
			 			console.log('통신성공');
			 		},
			 		error : function(){
			 			console.log('통신실패');
			 		}
				 });
			 };
	 	//page 넘버마다 onclick 이벤트를 사용하여 비동기로 페이징이동
		function goToPage(page) {
		    $.ajax({
		    	url : "longReview.re",
		 		data : {
		 			houseNo : houseNo,
		 			currentPage : page
		 		},
		 		success : function(result){
		 			var reviewList = result.reviewList;
		 			var pi = result.pi;
		 			var reviewStr = "";
		 			for(var i=0; i<reviewList.length; i++){
		 				reviewStr += "<div class='review-item'>"
			 	                + "<img src='" + reviewList[i].filePath + reviewList[i].originName01 + "' alt='강쥐이미지'>"
			 	                + "<img src='" + reviewList[i].filePath + reviewList[i].originName02 + "' alt='강쥐이미지'>"
			 	                + "<img src='" + reviewList[i].filePath + reviewList[i].originName03 + "' alt='강쥐이미지'>"
			 	                + "<img src='" + reviewList[i].filePath + reviewList[i].originName01 + "' alt='강쥐이미지'>"
			 	                + "<div class='review-content'>"
			 	                + "<div class='userName'>" + reviewList[i].userNo + "</div>"
			 	                + "<div class='date'>" + reviewList[i].reviewDate + "</div>"
			 	                + "<div class='reviewText'>" + reviewList[i].reviewContent + "</div>"
			 	                + "</div>"
			 	                + "</div><br><br>";
		 			}

		            var pagination = "<ul class='pagination'>";

		            // 이전버튼
		            if (pi.currentPage == 1) {
		                pagination += "<li class='page-item disabled'><a class='page-link' href='#'>◀</a></li>";
		            } else {
		                pagination += "<li class='page-item'><a class='page-link' href='#' onclick='goToPage(" + (pi.currentPage - 1) + ")'>◀</a></li>";
		            }
		            // 페이징번호 반복문
		            for (var p = pi.startPage; p <= pi.endPage; p++) {
		                pagination += "<li class='page-item'><a class='page-link' href='#' onclick='goToPage(" + p + ")'>" + p + "</a></li>";
		            }
		            
		            // 다음버튼
		            if (pi.currentPage == pi.maxPage) {
		                pagination += "<li class='page-item disabled'><a class='page-link' href='#'>▶</a></li>";
		            } else {
		                pagination += "<li class='page-item'><a class='page-link' href='#' onclick='goToPage(" + (pi.currentPage + 1) + ")'>▶</a></li>";
		            }
		            pagination += "</ul>";

		            $('.review-list').html(reviewStr);
		 			$('.pagingArea').html(pagination);
		            console.log('통신성공!!');
		        },
		        error: function() {
		            console.log('통신실패ㅠㅠ');
		        }
		    });
		}
    </script>
	
</body>
</html>