<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.Date, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>노필터 예약화면</title>
<!-- fullcalender -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js"></script>
	<style>
	
		.form-group{
			margin : 5% 10% 10% 10%;
		}
		
		.container{
			display : flex;
			justify-content : space-between;
		}
		
		.calendar-container,
	    .sitter-list-container {
	      width: 48%; /* Adjust the width as necessary */
	      margin-left : 5%;
	      margin-right : 5%;
	    }
	    .sitter-list-container {
	    	border : solid 1px black;
	    }
	     
		
		/* 펫시터 리스트 css */
		.sitterFont ,.sitter-phone{
			font-weight : bold;
		}
		.sitter-phone{
			margin-left : 10%;
			border: 2px solid black;
			padding : 5%;
		}
		
	    .sitter-card {
	        border: 1px solid #ddd;
	        padding: 20px;
	        margin: 10px 0;
	        display: flex;
	        align-items: center;
	    }
	    .sitter-info {
	        flex: 1;
	        padding : 5%;
	    }
	    .sitter-photo {
	        width: 100px;
	        height: 100px;
	        border-radius: 50%;
	        object-fit: cover;
	        margin-left: 20px;
	    }
	    .popular-style {
	        color: #ff4081;
	        font-weight: bold;
	    }
	    
	    
	    .reservation-btn {
	        background-color: #007bff;
	        color: white;
	        border: none;
	        padding: 10px 20px;
	        border-radius: 5px;
	        cursor: pointer;
	    }
	    .reservation-btn:hover {
	        background-color: #0056b3;
	    }
	    /* 달력 */
	    #calendar {
	    	max-width : 600px;
        	margin : 0 auto;
	    }
	    .fc-daygrid-day:hover {
	        cursor: pointer;
	    }
	    .fc-daygrid-day.fc-day-selected {
	        background-color: skyblue !important;
	    }
	
	
		/* 시간선택 css */
	    .str-btn {
	        width: 100px;
	        height: 50px;
	        border: 2px solid #ccc;
	        margin: 5px;
	        transition: background-color 0.1s, color 0.1s;
	    }
	    .str-btn.selected {
	        background-color: #28a745;
	        color: white;
	    }
	    /* 펫크기 버튼 그림조절  */
	    .petType-btn img {
		    width: 100%; 
		    height: 100%; 
		}
		
		/* 소요시간 / 펫크기  */
	    .duration-btn-group ,.petType-btn-group {
	        display: flex;
	        justify-content: space-around;
	        margin-top: 20px;
	    }
	    .duration-btn{
	        width: 80px;
	        height: 80px;
	        border-radius: 50%;
	        border: 2px solid #ccc;
	        display: flex;
	        align-items: center;
	        justify-content: center;
	        font-size: 16px;
	        background-color: white;
	        transition: background-color 0.3s, color 0.3s;
	    }
	    .petType-btn {
	        width: 130px;
	        height: 130px;
	        border: 2px solid #ccc;
	        border-radius: 5px;
	        display: flex;
	        align-items: center;
	        justify-content: center;
	        cursor: pointer;
	        background-color: #f9f9f9;
	        transition: background-color 0.3s, color 0.3s;
	    }
	    .petType-btn:hover , .duration-btn:hover , .str-btn:hover {
	    background-color: #e0e0e0; /* 호버 시 배경색 변경 */
		}
		
		.petType-btn.active {
		    background-color: #c0c0c0; /* 클릭 시 배경색 변경 */
		    border-color: #808080; /* 클릭 시 테두리 색 변경 */
		}
	    .duration-btn.selected , .petType-btn.selected {
	        background-color: #007bff;
	        color: white;
	    }
	    .duration-btn span ,.petType-btn span {
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
	</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp" %>

	<div class="form-group">
		<form action="shortSencond.re" method="get">
			<input type="hidden" id="visitDate" name="visitDate" value=""> <!-- visitDate  -->	
			<input type="hidden" id="startTime" name="startTime" value=""> <!-- startTime  -->	
			<input type="hidden" id="duration" name="duration" value=""> <!-- duration  -->	
			<input type="hidden" id="endTime" name="endTime" value=""> <!-- endTime  -->	
		    <input type="hidden" id="petTypeNo" name ="petTypeNo" value="${at.petTypeNo }">
			<input type="hidden" name="petSitterNo" value="${petSitter.petSitterNo }">
		
		<h4>원하시는 날짜를 골라주세요.</h4>
		<div class="container">
			<div id="calendar" class="calendar-container">
				<!-- fullCalendar -->
			</div>
			
			<div class="sitter-list-container"  id="sitterListContainer">
	       		<h4>현재 선택한 펫시터 정보</h4>
				  <div class="sitter-info">
				    <h4>${petSitter.petSitterName }</h4>
				    <p>${petSitter.introduce }</p>
				    <div class="sitterFont">가장 많이 만나본 반려견</div>
				    <p class="popular-style">${petSitter.dogKeyword }</p>
				    <div class="sitterFont">자신 있는 펫크기</div>
				    <p class="popular-style">${petSitter.typeKeyword }</p>
				    
				    
				  </div>
				  <div class="sitter-p">
				  	<span>
				  		<img src="/pjtMungHub/${petSitter.filePath }${petSitter.originName }" class="sitter-photo">
				  	</span>
				  	<span class="sitter-phone">
				  		연락처 : 
				  		${petSitter.phone }
				  	</span>
				  
				  </div>
				  
    	   </div>
		</div>
	       <div class="" id="startTime">방문시간을 선택해주세요. 
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
	  	  <h5>돌봄시간을 선택해주세요.</h5>
	    	 <div class="duration-btn-group" id="duration">
	          <button type="button" class="duration-btn" value="100">60분</button>
	          <button type="button" class="duration-btn" value="200">120분</button>
	          <button type="button" class="duration-btn" value="300">180분</button>
	          <button type="button" class="duration-btn" value="400">240분</button>
	  	  	</div>
	  	  <h5>반려견 유형을 선택해주세요.</h5>
	  	  <div class="petType-btn-group" id="petType">
	          <button type="button" class="petType-btn" value="1">
	          	<img alt="소형" src="/pjtMungHub/resources/uploadFiles/sittingSupplies/001.png">
	          </button>
	          <button type="button" class="petType-btn" value="2">
	          	<img alt="중형" src="/pjtMungHub/resources/uploadFiles/sittingSupplies/002.png">
	          </button>
	          <button type="button" class="petType-btn" value="3">
	          	<img alt="대형" src="/pjtMungHub/resources/uploadFiles/sittingSupplies/003.png">
	          </button>
	  	  </div>
	  	  
	  	  <button type="submit" class="reservation-btn">예약페이지로</button>
	  	  
	  	</form>
   </div>
   
   <!-- 펫시터의 스케줄 필터링 -->
   <c:forEach var="d" items="${disabledPlan }">
		<input type="hidden" class="reservation-id" value="${d.reservationId}">
		<input type="hidden" class="disabled-date" value="${d.visitDate}">
		<input type="hidden" class="disabled-start" value="${d.startTime}">
		<input type="hidden" class="disabled-end" value="${d.endTime}">
	</c:forEach>
	
	<script>
		$('.reservation-btn').on('click',function(){
			var inputStartTime = parseInt($(".str-btn.selected").val(),10);
			var inputDuration = parseInt($(".duration-btn.selected").val(),10);
			var plusEndTime = (inputStartTime + inputDuration).toString();
			var petTypeNo = $(".petType-btn.selected").val();
			
			if(inputStartTime && inputDuration && plusEndTime && petTypeNo){
				$('#startTime').val(inputStartTime);
				$('#duration').val(inputDuration);
				$('#endTime').val(plusEndTime);
				$('#petTypeNo').val(petTypeNo);
			}else{
				event.preventDefault(); //위 사항이 모두 입력되지 않으면 폼제출 방지
				alert('세부사항을 전부 입력해주세요.');
			}
		});
		//============== 달력 ===================
		 $(document).ready(function() {
			    var disabledDates = [];
			    
			    // 예약 정보를 배열에 추가
			    $('.reservation-id').each(function(index) { //index : 현재 반복중인 요소
			      var reservation = {
			        reservationId: $(this).val(),
			        date: $('.disabled-date').eq(index).val(), //동일한 인덱스의 값을 가져옴
			        start: parseInt($('.disabled-start').eq(index).val(), 10),
			        end: parseInt($('.disabled-end').eq(index).val(), 10)
			      };
			      disabledDates.push(reservation); //reservation 객체를 disabledDates [] 에 추가
			    });
			    
			    console.log(disabledDates);
			    

			    // FullCalendar 설정
			    var calendarEl = document.getElementById('calendar');
			    var preToday = new Date();
	            var today = new Date(preToday.getTime() - (preToday.getTimezoneOffset() * 60000)).toISOString().split('T')[0];
			    var calendar = new FullCalendar.Calendar(calendarEl, {
			      initialView: 'dayGridMonth',
			      locale: 'ko',
			      headerToolbar: {
			          left: '',
			          center: 'title',
			          right: 'prev,next'
			        },
			      validRange:{ //오늘날짜 이전 막아주기
			        	start : today
			      },
			      dateClick: function(info) {
			            var selectedDate = info.dateStr;
			            $('#visitDate').val(selectedDate);

			            // 모든 날짜에 스타일 제거
			            $('.fc-daygrid-day').removeClass('fc-day-selected');
			            
			            // 선택된 날짜에 스타일 추가
			            var selectedDayEl = document.querySelector('[data-date="' + selectedDate + '"]');
			            if (selectedDayEl) {
			                selectedDayEl.classList.add('fc-day-selected');
			            }

			            // 선택된 날짜와 예약정보가 동일한 날짜인지 확인
			            var reservations = disabledDates.filter(function(reservation) {
			                return reservation.date === selectedDate;
			            });

			            // 해당 예약 시간 범위 내의 버튼을 비활성화
			            $('.str-btn').removeAttr('disabled'); // 먼저 모든 버튼을 활성화
			            reservations.forEach(function(reservation) {
			                $('.str-btn').filter(function() {
			                    var value = parseInt($(this).val(), 10);
			                    var reservationStart = parseInt(reservation.start, 10);
			                    var reservationEnd = parseInt(reservation.end, 10);
			                    
			                    return value >= reservationStart && value < reservationEnd;
			                }).attr('disabled', true);
			            });
			        }
			    });
			    
			    setTimeout(function() {
			        calendar.render();
			        
			      		//페이지 로드시 오늘날짜 선택
			        	function selectToday(){
			        		// new Date() 형태가 2024-07-01T12:34:56.789Z 와 같이 나오기 때문에
					        // toISOString () 로 위에 값을 문자열로 변환
					        // 'T' 를 기준으로 split 분리한 뒤 0번째 배열에 해당하는 2024-07-01 을 가져옴.
					        var today = new Date().toISOString().split('T')[0];
					        var todayElement = document.querySelector('[data-date="' + today + '"]');
					        if(todayElement){
					        	todayElement.classList.add('fc-day-selected');
					        	//오늘 날짜가 선택되고,dateClick 적용되게 trigger 설정
					        	//dateClick 함수가 date: new Date(), dateStr: today 둘다 사용하기 때문에 둘다 적어야함. (만약의 오류까지 대비)
					        	calendar.trigger('dateClick',{ date: new Date(), dateStr: today });
					        }
			        	}
			    selectToday(); 
			    }, 500);
			    
			  //버튼 클릭시 활성화/비활성화
				$(".duration-btn, .str-btn, .petType-btn").on("click", function() {
	                $(this).siblings().removeClass("selected");
	                $(this).addClass("selected");
	            });
		});
	</script>
</body>
</html>





