<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대시보드</title>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
   <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }
        .sidebar {
            height: 100vh;
            background-color: #343a40;
            color: white;
            padding-top: 20px;
            position: fixed;
            width: 220px;
        }
        .sidebar a {
            color: white;
            padding: 15px;
            text-decoration: none;
            display: block;
            font-weight: bold;
        }
        .sidebar a:hover {
            background-color: #495057;
        }
        .main-content {
            margin-left: 240px;
            padding: 20px;
        }
        .card-custom {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        .card-header-custom {
            background-color: #5a67d8;
            color: white;
            padding: 10px;
            border-radius: 8px 8px 0 0;
        }
        .chart {
            height: 300px;
        }
        .stat-icon {
            font-size: 1.5rem;
        }
        .stat-icon.positive {
            color: green;
        }
        .stat-icon.negative {
            color: red;
        }
    </style>
</head>
<body>
<%@include file="../common/header.jsp" %>
    <div class="sidebar">
        <h4 class="text-center">고객관리</h4>
        <a href="/pjtMungHub/adminPage/dashBoard">대시보드</a>
        <a href="/pjtMungHub/adminPage/orderControll">주문 관리</a>
        <a href="/pjtMungHub/adminPage/productControll">제품 관리</a>
        <a href="/pjtMungHub/adminPage/customerControll">고객 관리</a>
        <a href="/pjtMungHub/adminPage/eventControll">이벤트 관리</a>
    </div>

    <div class="main-content">
    <div class="container mt-5">
  <h1 class="text-center mb-4">고객 관리 관리자 페이지</h1>
  
   <!-- 가장 많은 상품을 구매한 유저 순위 -->
  <div class="row justify-content-center py-5">
  <div class="card mb-4 col col-md-5 mx-3">
    <div class="card-header">
      <h2>고객 판매량 순위 TOP5</h2>
    </div>
    <div class="card-body">
      <ul id="top-buyers">
      </ul>
    </div>
  </div>

  <!-- 가장 비싼 값을 지불한 유저 순위 -->
  <div class="card mb-4 col col-md-5 mx-3">
    <div class="card-header">
      <h2>고객 매출 순위</h2>
    </div>
    <div class="card-body">
      <ul id="top-spenders">
      </ul>
    </div>
  </div>
</div>
  
  <script>
  $(function(){
	  selectTopBuyer();
	  selectTopSpenders();
	  selectCustomerList();
	  selectInquiry();
  });
  function selectTopBuyer(){
	  $.ajax({
		  url : "/pjtMungHub/TopBuyer.sp",
		  success: function(result){
			  var str="";
				 
				 for (var i = 0; i < result.length; i++) {
					str+="<li>"+(i+1)+"위: "+result[i].userName+" ("+result[i].buyerCount.toLocaleString('ko-KR')+"개)</li>"
				}
				 
				 $("#top-buyers").html(str)
		  },error:function(){
			  console.log("통신오류");
		  }
	  })
  }
  
  function selectTopSpenders(){
	  $.ajax({
		  url : "/pjtMungHub/TopSpenders.sp",
		  success:function(result){
			 var str="";
			 
			 for (var i = 0; i < result.length; i++) {
				str+="<li>"+(i+1)+"위: "+result[i].userName+" ("+result[i].spendCount.toLocaleString('ko-KR')+"원)</li>"
			}
			 
			 $("#top-spenders").html(str)
		  },error:function(){
			  console.log("통신오류");
		  }
	  });
  }
  
  
  </script>
  
  
  <!-- 고객 리스트 테이블 -->
  <div class="card mb-4">
    <div class="card-header">
      <h2>고객 리스트</h2>
    </div>
    <div class="card-body">
      <table class="table table-bordered">
        <thead>
          <tr>
            <th>고객 ID</th>
            <th>고객명</th>
            <th>구매한 상품 수</th>
            <th>총 지불 금액(배송비 포함)</th>
            <th>상담 내역</th>
          </tr>
        </thead>
        <tbody id="customer-list">
          <!-- 여기에 고객 정보가 동적으로 추가될 예정 -->
        </tbody>
      </table>
    </div>
  </div>

	<script>
	
		function selectCustomerList(){
			$.ajax({
				url: "/pjtMungHub/customerList.sp",
				success : function(result){
					var str="";
					for (var i = 0; i < result.length; i++) {
						str+="<tr>"
				         +"<td>"+result[i].userNo+"</td>"
				         +"<td>"+result[i].userName+"</td>"
				         +"<td>"+result[i].buyerCount.toLocaleString('ko-KR')+"개</td>"
				         +"<td>"+result[i].spendCount.toLocaleString('ko-KR')+"원</td>"
				         +"<td>"
				         +"<button class='btn btn-info btn-sm' data-toggle='modal' data-target='#viewInquiryModal' onclick='changeSearchModal("+result[i].userNo+")'>상담 보기</button>"
				         +"</td>"
				         +"</tr>";
					}
					$("#customer-list").html(str);
				},error:function(){
					console.log("통신오류");
				}
			})
		}
	
	
	</script>


  <!-- 고객 문의글 테이블 -->
  <div class="card mb-4">
    <div class="card-header">
      <h2>고객 문의글</h2>
    </div>
    <div class="card-body">
      <table class="table table-bordered">
        <thead>
          <tr>
            <th>문의글 ID</th>
            <th>고객명</th>
            <th>문의 내용</th>
            <th>답변 상태</th>
            <th>관리</th>
          </tr>
        </thead>
        <tbody id="inquiry-list">
          <!-- 여기에 문의글 정보가 동적으로 추가될 예정 -->
        </tbody>
      </table>
    </div>
  </div>
</div>

<script>
function selectInquiry(){
	$.ajax({
		url : "/pjtMungHub/inquiryList.sp",
		success : function(result){
			var str="";
			for (var i = 0; i < result.length; i++) {
				str+="<tr>"
		        +"<td>"+result[i].questionNo+"</td>"
		        +"<td>"+result[i].userName+"</td>"
		        +"<td>"+result[i].content+"</td>"
		        +"<td>"+result[i].answerStatus+"</td>"
		        +"<td>"
		        +"<button class='btn btn-primary btn-sm' data-toggle='modal' data-target='#replyInquiryModal' onclick='changeInquiryModal("+result[i].questionNo+")'>답변하기</button>"
		        +"</td>"
		        +"</tr>";
			}
			$("#inquiry-list").html(str);
		},error:function(){
			console.log("통신오류");
		}
	});
}

</script>

<!-- 상담 내용 보기 모달 -->
<div class="modal fade" id="viewInquiryModal" tabindex="-1" role="dialog" aria-labelledby="viewInquiryModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="viewInquiryModalLabel">상담 내용</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       <table class="table table-bordered">
        <thead>
          <tr>
            <th>문의글 ID</th>
            <th>고객명</th>
            <th>문의 내용</th>
            <th>답변 상태</th>
            <th>관리</th>
          </tr>
        </thead>
        <tbody id="inquiry-list-user">
          <!-- 여기에 문의글 정보가 동적으로 추가될 예정 -->
        </tbody>
      </table>
      </div>
    </div>
  </div>
</div>
<script>
function changeSearchModal(num){
	$.ajax({
		url : "/pjtMungHub/selectUserQuestion.sp",
		data : {userNo : num },
		success : function(result){
			str="";
			for (var i = 0; i < result.length; i++) {
				str+="<tr>"
		        +"<td>"+result[i].questionNo+"</td>"
		        +"<td>"+result[i].userName+"</td>"
		        +"<td>"+result[i].content+"</td>"
		        +"<td>"+result[i].answerStatus+"</td>"
		        +"<td>"
		        +"<button class='btn btn-primary btn-sm' data-toggle='modal' data-target='#replyInquiryModal' onclick='changeInquiryModal("+result[i].questionNo+")'>답변하기</button>"
		        +"</td>"
		        +"</tr>";
			}
			if(str==""){
				str+="<div align='center'><h1>조회결과가 없습니다.</h1><div>"
			}
			$("#inquiry-list-user").html(str);
			
		},error : function(){
			console.log("통신오류");
		}
	
	});
}


</script>
<!-- 상담 답변 모달 -->
<div class="modal fade" id="replyInquiryModal" tabindex="-1" role="dialog" aria-labelledby="replyInquiryModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="replyInquiryModalLabel">상담 답변</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <div class="form-group">
          <p id="question"></p>
            <label for="inquiryReply">답변 내용</label>
            <textarea class="form-control" id="inquiryReply" rows="3" required></textarea>
          </div>
          <button type="button" id="answerBtn" class="btn btn-primary">답변 보내기</button>
      </div>
    </div>
  </div>
</div>
<script>
function changeInquiryModal(num){
	$.ajax({
		url : "/pjtMungHub/selectInquiry.sp",
		data : {questionNo : num},
		success : function(result){
			$("#question").text(result.content);
			$("#answerBtn").attr("onclick","replyInquiry("+result.questionNo+")")
			
		},error : function(){
			console.log("통신오류");
		}
	});
}

function replyInquiry(num){
	$.ajax({
		url : "/pjtMungHub/replyInquiry.sp",
		type : "post",
		data : {content : $("#inquiryReply").val(),
				userNo : ${loginUser.userNo},
				questionNo : num},
		success:function(result){
			alert("답변이 완료되었습니다.")
		},error:function(){
			console.log("통신오류");
		}
		
	});
}

</script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</div>

</body>
</html>