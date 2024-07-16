<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>결제내역</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .order-header {
            font-size: 24px;
            font-weight: bold;
            color: #28a745;
            text-align: center;
            margin-bottom: 20px;
        }
        .order-info, .order-details, .payment-info, .order-summary {
            margin-bottom: 20px;
        }
        .order-info p, .order-details p, .payment-info p, .order-summary p {
            margin: 5px 0;
            font-size: 16px;
        }
        .order-info p strong, .order-summary p strong, .payment-info p strong {
            display: inline-block;
            width: 150px;
            color: #343a40;
        }
        .order-summary {
            font-size: 18px;
            font-weight: bold;
            border-top: 1px solid #ddd;
            padding-top: 20px;
        }
        .btn-order-details {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
        }
        .btn-order-details:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <%@include file="/WEB-INF/views/common/header.jsp" %>
    <input type="hidden" id="paymentId" value="${p.paymentId }">

    <div class="container order-completion">
        <div class="order-header">주문 완료 되었습니다</div>
        <div class="order-info">
            <p><strong>주문번호:</strong> ${p.paymentId }</p>
            <p><strong>견주님 성함:</strong> ${p.userName }</p>
            <p><strong>연락드릴 번호:</strong> ${p.phone }</p>
            <p><strong>방문주소:</strong> ${p.address }</p>
        </div>
        <div class="order-summary">
            <p><strong>주문금액:</strong> ${p.amount }</p>
            <p><strong>쿠폰할인:</strong> 0원</p>
        </div>
        <div class="payment-info">
            <strong>결제상태:</strong> <input type="text" id="statusName" value="" style="border:none;">
             <p><strong>결제방법:</strong> card </p>
            <p><strong>결제일:</strong> ${p.paymentDate }</p>
        </div>
        <div class="text-center">
            <button class="btn-order-details" onclick="location.href='/pjtMungHub/'">메인으로 돌아가기</button>
        </div>
    </div>
    
    <script>
    	$(function(){
    		statusName();
    	});
    	
    	function statusName(){
    		
    		var paymentId = $('#paymentId').val();
    		
    		$.ajax({
    			url: "statusName.re",
    			data: {paymentId : paymentId},
    			success: function(result){
    				
    				console.log(result.statusName);
    				
    				$('#statusName').val(result.statusName);
    			},
    			error: function(){
    				console.log('통신오류');
    			}
    		});
    	}
    
    </script>
    
    
    
    
</body>
</html>