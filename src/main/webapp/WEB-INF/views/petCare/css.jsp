<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>즐길거리</title>
    <style>
        .card-title {
            font-size: 1.25rem;
            margin-bottom: 0.5rem;
        }
        .card-subtitle {
            font-size: 1rem;
            color: #6c757d;
        }
        .hos-title {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }
        .hos-subtitle {
            font-size: 1.25rem;
            color: #6c757d;
        }
        .card-rating {
            display: flex;
            align-items: center;
            margin-top: 0.5rem;
        }
        .custom-padding {
            padding-left: 1%;
            padding-right: 1%;
        }
        .custom-row {
            margin-left: -5%;
            margin-right: -5%;
        }
        .card-img-top {
            width: auto;
            height: 300px; /* 원하는 높이로 설정 */
            object-fit: cover;
        }
        .sitter-card {
		    justify-content: center; /* 수평 중앙 정렬 */
		    align-items: center;     /* 수직 중앙 정렬 */
		}
		.card-03 {
		    justify-content: center;
		    align-items: center;
		    height: 100vh; /* 페이지 전체 높이에 맞추기 위해 */
		  }        

    </style>
</head>
<body>
<%@include file="/WEB-INF/views/common/header.jsp" %>

    <div class="container my-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>돌보미(케어) 서비스 Best</h2>
        </div>
        <div class="row custom-row">
	        <div class="col-md-4 mb-4 custom-padding">
	        	<div class="card-01">
	        	
	        		<!-- 펫시터 -->
	        	
	        	</div>
	        </div>
            <div class="col-md-4 mb-4 custom-padding">
                <div class="card-02">
                   
                   <!-- 하우스 -->
                   
                </div>
            </div>
            <div class="col-md-4 mb-4 custom-padding" id="hosCss">
                <div class="card-03">
                
                	<!-- 동물병원 -->
                    
                </div>
            </div>
        </div>
    </div>

    <script>
    	$(function(){
    		mainSitter();
    		mainHouse();
    		mainHospital();
    	});
    	
    	function mainSitter(){
    		$.ajax({
    			url: "mainSitter.re",
    			success: function(result){
    				var str = "";
    				str += "<form class='sitter-card' action='shortSitter.re' method='get'>" 
    		            + "<img src='/pjtMungHub/" + result.filePath + result.originName + "' class='card-img-top'>"
    		            + "<div class='card-body'>"
    		            + "<h5 class='card-title'>" + result.petSitterName + "</h5>"
    		            + "<h6 class='card-subtitle mb-2 text-muted'>" + result.introduce + "</h6>"
    		            + "<h6 class='card-subtitle mb-2 text-muted'>자신있는 반려견 : " + result.dogKeyword + "</h6>"
    		            + "<input type='hidden' name='petSitterNo' value='" + result.petSitterNo + "'>"
    		            + "<input type='hidden' name='petSitterName' value='" + result.petSitterName + "'>"
    		            + "<input type='hidden' name='introduce' value='" + result.introduce + "'>"
    		            + "<input type='hidden' name='dogKeyword' value='" + result.dogKeyword + "'>"
    		            + "<input type='hidden' name='typeKeyword' value='" + result.typeKeyword + "'>"
    		            + "<input type='hidden' name='phone' value='" + result.phone + "'>"
    		            + "<input type='hidden' name='originName' value='" + result.originName + "'>"
    		            + "<input type='hidden' name='filePath' value='" + result.filePath + "'>"
    		            + "<button type='submit' class='btn btn-primary' id='resBtn'>펫시터 선택</button>"
    		            + "</div>"
    		            + "</form>";
    				$('.card-01').html(str);	
    			},
    			error: function(){
    				console.log('통신실패');
    			}
    		});
    	}
    	
    	function mainHouse(){
    		$.ajax({
    			url: "mainHouse.re",
    			success: function(result){
    				
    				var str = "";
    				str += "<form class='sitter-card' action='detailHouse.re' method='get'>" 
    		            + "<img src='/pjtMungHub/" + result.filePath + result.originName01 + "' class='card-img-top'>"
    		            + "<div class='card-body'>"
    		            + "<h5 class='card-title'>" + result.introductionSummary + "</h5>"
    		            + "<h6 class='card-subtitle mb-2 text-muted'>" + result.introductionDetailed + "</h6>"
    		            + "<h6 class='card-subtitle mb-2 text-muted'>가능한 펫크기 : " + result.petTypeNo + "</h6>"
    		            + "<input type='hidden' name='houseNo' value='" + result.houseNo + "'>"
    		            + "<button type='submit' class='btn btn-primary' id='resBtn'>이집으로 결정했어!!</button>"
    		            + "</div>"
    		            + "</form>";
    				$('.card-02').html(str);	
    			},
    			error: function(){
    				console.log('통신실패');
    			}
    		});
    	}
    	
    	function mainHospital(){
    		$.ajax({
    			url: "mainHospital.re",
    			success: function(result){
    				
    				var location = result.hosAddress.substring(0,7);
    				console.log(result);
    				console.log(location);
    				
    				var str = "";
    				str += "<form class='sitter-card' action='hospital.re' method='get'>" 
    		            + "<div class='card-body'>"
    		            + "<h4 class='hos-title'>병원이름: " + result.hosName + "</h4>"
    		            + "<h5 class='hos-subtitle mb-2 text-muted'>대표지역 : " + location + "</h5>"
    		            + "<h5 class='hos-subtitle mb-2 text-muted'>병원 연락처 : " + result.hosPhone + "</h5>"
    		            + "<h5 class='hos-subtitle mb-2 text-muted'>병원 상세주소 : " + result.hosAddress + "</h5>"
    		            + "<input type='hidden' name='hosName' value='" + result.hosName + "'>"
    		            + "<input type='hidden' name='hosPhone' value='" + result.hosPhone + "'>"
    		            + "<input type='hidden' name='hosAddress' value='" + result.hosAddress + "'>"
    		            + "<button type='submit' class='btn btn-primary' id='resBtn'>병원 접수하러 가기</button>"
    		            + "</div>"
    		            + "</form>";
    				$('.card-03').html(str);	
    			}
    		});
    	}
    
    </script>
    
    
    
    
</body>
</html>
