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
        <h4 class="text-center">이벤트 관리</h4>
        <a href="/pjtMungHub/adminPage/dashBoard">대시보드</a>
        <a href="/pjtMungHub/adminPage/orderControll">주문 관리</a>
        <a href="/pjtMungHub/adminPage/productControll">제품 관리</a>
        <a href="/pjtMungHub/adminPage/customerControll">고객 관리</a>
        <a href="/pjtMungHub/adminPage/eventControll">이벤트 관리</a>
    </div>

    <div class="main-content">
   <!--  <div id="mainEventSlideIndicators" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
  </div>
  <div class="carousel-inner" id="mainEventSlide">
    <div class="carousel-item active">
      <img src="..." class="d-block w-100" style="min-height:400px;" alt="...">
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div> -->
    <form action="/pjtMungHub/insertMainSlide.sp" method="post" enctype="multipart/form-data">
    <label for="upfile">메인 슬라이드</label>
    <input type="file" id="upfile" name="upfile" multiple>
    <button type="submit" class="btn btn-primary">수정</button>
    </form>
    
    <script>
    
   /*  function loadImg(file){
    	
    } */
    
    
   /*  function selectMainSlide(){
    	
    
    $.ajax({
    	url : "/pjtMungHub/selectMainSlide.sp",
    	success: function(result){
    		if(result!=null){
    			
    		var str="";
    		var indicator="";
    		for (var i = 0; i < result.length; i++) {
    			if(i==0){
    			str+="<div class='carousel-item active'>
    		    +"<img src="+result[i].filePath+result[i].changeName+" class='d-block w-100'>"
    		    +"</div>";
    			indicator+="<button type='button' data-bs-target='#mainEventSlideIndicators' data-bs-slide-to='0' class='active' aria-current='true' aria-label='Slide 1'></button>";
    			}else{
    			str+="<div class='carousel-item'>"
    		    +"<img src="+result[i].filePath+result[i].changeName+" class='d-block w-100'>"
    		    +"</div>";
    			indicator+=" <button type='button' data-bs-target='#mainEventSlideIndicators' data-bs-slide-to="+i+" aria-label=Slide "+(i+1)+"'></button>";
    			}
    			
    			
				
			}
    		
    		
    		$("#mainEventSlideIndicators").html(indicator);
    		$("#mainEventSlide").html(str);
    		}
    		
    		
    		
    	},error:function(){
    		console.log("통신오류");
    	}
    });
    } */
    
    
    
    </script>
    
</div>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>