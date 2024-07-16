<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원정보</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3dcfbff0a780d5171a2a2f039fc60ac0&libraries=services,clusterer,drawing"></script>
	<style>
		#result tbody td span{
			cursor: pointer;
		}
		th, .nowrap {
			white-space: nowrap;
		}
		
		#reserBtn, #updateBtn{
			margin-right: 2%;
		}
		#searchBtn{
			margin-left: 2%;
		}
	
	</style>

</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp" %>
	<input type="hidden" id="userNo" value="${loginUser.userNo }">
	
	<!--  스크롤 연습용이었음.
 	<form action="mapInfo.ho">
        <button type="submit">전송</button>
    </form>
    -->
    
    <div>
        <pre>${reviewText}</pre>
    </div>

    <div>
        <pre>${reviewHtml}</pre>
    </div>

    <div class="container mt-4">
        <h1 class="text-center">경기도 동물병원</h1>
        <div class="d-flex mb-3">
            <button id="reserBtn" class="btn btn-primary nowrap">나의 예약내역</button>
            <select id="location"  class="ms-2 form-select">
                <option value="41820">가평군</option>
                <option value="41280">고양시</option>
                <option value="41290">과천시</option>
                <option value="41210">광명시</option>
                <option value="41610">광주시</option>
                <option value="41310">구리시</option>
                <option value="41410">군포시</option>
                <option value="41570">김포시</option>
                <option value="41360">남양주시</option>
                <option value="41250">동두천시</option>
                <option value="41190">부천시</option>
                <option value="41130">성남시</option>
                <option value="41110">수원시</option>
                <option value="41390">시흥시</option>
                <option value="41270">안산시</option>
                <option value="41550">안성시</option>
                <option value="41170">안양시</option>
                <option value="41630">양주시</option>
                <option value="41830">양평군</option>
                <option value="41670">여주시</option>
                <option value="41800">연천군</option>
                <option value="41370">오산시</option>
                <option value="41460">용인시</option>
                <option value="41430">의왕시</option>
                <option value="41150">의정부시</option>
                <option value="41500">이천시</option>
                <option value="41480">파주시</option>
                <option value="41220">평택시</option>
                <option value="41650">포천시</option>
                <option value="41450">하남시</option>
                <option value="41590">화성시</option>
            </select>
       		<button id="searchBtn" class="btn btn-success nowrap">검색</button>
        </div>

        <table class="table table-bordered" id="result">
            <thead class="table-dark">
                <tr>
                    <th>지역명</th>
                    <th>사업장명</th>
                    <th>전화번호</th>
                    <th>도로명주소</th>
                    <th>소재지지번주소</th>
                    <th>카카오 제공정보</th>
                </tr>
            </thead>
            <tbody>
                <!-- 병원 리스트가 여기에 삽입됩니다 -->
            </tbody>
        </table>
    </div>
	
	<br><br>

	<script>
	
		$(function() {
		    $('#searchBtn').on('click', function() {
		        var location = $('#location').val();
		        $.ajax({
		            url: "hospitalList.ho",
		            data: {
		                location: location
		            },
		            type: "GET",
		            dataType: "xml", // 반환 타입을 xml로 지정
		            success: function(result) {
		                var rows = $(result).find('row'); // XML 응답에서 row 요소를 찾음
		                var str = "";
		                
		                rows.each(function(index, row) {
		                    if ($(row).find("BSN_STATE_DIV_CD").text() == '1' && $(row).find("REFINE_ROADNM_ADDR").text() != '') { // 정상영업 코드 '1'만, 주소없는 업체 X
		                        
		                    	var address = $(row).find("REFINE_LOTNO_ADDR").text();
		                    	var locPhone = $(row).find("LOCPLC_FACLT_TELNO").text();
		                    
		                        str += "<tr>" 
		                            + "<td><span>" + $(row).find("SIGUN_NM").text() + "</span></td>"
		                            + "<td><span>" + $(row).find("BIZPLC_NM").text() + "</span></td>"
		                            + "<td><span class='phone'>" + (locPhone ? locPhone : '') + "</span></td>"
		                            + "<td><span>" + $(row).find("REFINE_ROADNM_ADDR").text() + "</span></td>"
		                            + "<td><span>" + $(row).find("REFINE_LOTNO_ADDR").text() + "</span></td>"
		                            + "<td data-address='" + address + "'><span></span></td>" // 카카오 제공정보 셀, 주소를 data 속성에 저장
		                            + "</tr>";
		                    }
		                });
	
		                $('#result tbody').html(str); // 결과를 테이블 본문에 삽입
		                console.log('통신 성공');
		                
		                // 각 행에 대해 지도 API 호출
		                $('#result tbody tr').each(function(index, element) {
		                    var address = $(element).find('td:last').data('address'); //공공데이터에서 가져온 주소값
		                    getCompanyInfoByAddress(address, element); //지도 api에 전달할 값들을 매개변수로
		                });
		                rowCilck(); //클릭 이벤트
		            },
		            error: function() {
		                console.log('통신 실패 ㅠㅠ');
		            }
		        });
		    });
		    
		//나의 예약내역
		var userNo = $('#userNo').val();
		$('#reserBtn').click(function(){
			
			$.ajax({
				url : "hospitalChk.re",
				data : {userNo : userNo},
				success : function(result){
					var str = "";
					
					result.forEach(function(list){
						str += "<tr>" 
							+ "<input type='hidden' class='hosReNo' value='" + list.hosReNo + "'/>"
                            + "<td><span>" + list.hosAddress.substring(0,8)  + "</span></td>"
                            + "<td><span>" + list.hosName + "</span></td>"
                            + "<td><span>" + list.hosPhone  + "</span></td>"
                            + "<td><span>" + list.hosAddress + "</span></td>"
                            + "<td><span>" + list.hosAddress + "</span></td>"
                            + "<td>"
                            + "<button id='deleteBtn' class='btn btn-danger nowrap' onclick='location.href=\"hospitalDelete.re?hosReNo=" + list.hosReNo + "\"'>삭제</button>"                            + "</td>" 
                            + "</tr>";
					});
					$('#result tbody').html(str); // 결과를 테이블 본문에 삽입
                   },
				error : function(){
					console.log('통신실패');
				}
			});
		});		    
		
		$(document).on('click', '#result tbody td span', function() {
		    var row = $(this).closest('tr'); //closest: 가장 가까운 조상요소
		    var hosReNo = row.find('.hosReNo').val();

		    if (hosReNo) {
		    	location.href="hospitalChkView.re?hosReNo="+hosReNo;
		    } else {
		        var hosName = row.find('td:nth-child(2) span').text();
		        var hosPhone = row.find('td:nth-child(3) span').text();
		        var hosAddress = row.find('td:nth-child(4) span').text();

		        // encodeURIComponent: 전달값을 조금 더 정확하게 전달해줌
		        var url = "hospital.re?hosName=" + encodeURIComponent(hosName) + "&hosPhone=" + encodeURIComponent(hosPhone) + "&hosAddress=" + encodeURIComponent(hosAddress);
		        location.href = url;
		    }
		});
	
		// 카카오 지도 API를 사용하여 특정 주소의 업체 정보를 가져오는 함수
		function getCompanyInfoByAddress(dataAddress, rowElement) {
		    var geocoder = new kakao.maps.services.Geocoder();
		    // 주소로 좌표를 검색합니다
		    geocoder.addressSearch(dataAddress, function(result, status) {
		        if (status === kakao.maps.services.Status.OK) {
		            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		            var ps = new kakao.maps.services.Places();
	
		            // 해당 좌표의 업체 정보를 검색합니다
		            ps.keywordSearch(dataAddress, function(data, status, pagination) {
		                if (status === kakao.maps.services.Status.OK) {
		                    updateKakaoInfo(data, rowElement);
		                } else {
		                    console.log('업체 정보를 찾을 수 없습니다.');
		                }
		            }, {location: coords, radius: 50});
		        } else {
		            console.log('주소를 찾을 수 없습니다.');
		        }
		    });
		}
		// 업체 정보를 화면에 표시하는 함수
		function updateKakaoInfo(data, rowElement) {
		    var kakaoInfo = rowElement.cells[rowElement.cells.length - 1]; // 마지막 셀을 가리킵니다
	
		    if (data.length > 0) {
		        var kakaoData = data[0]; // 첫 번째 결과만 사용
		        var phoneCell = $(rowElement).find('td:nth-child(3) span'); //공공데이터에서 가져온 연락처
		        if (!phoneCell.text()) { // 가 비어있다면
		            phoneCell.text(kakaoData.phone ? kakaoData.phone : '없음'); //지도 api에서 가져온 연락처로 채우기, 도 없으면 '없음'으로
		        }
		        kakaoInfo.innerHTML = '<p>업체명: ' + kakaoData.place_name 
		                            + '<br>주소: ' + kakaoData.address_name 
		                            + '<br>전화번호: ' + (kakaoData.phone ? kakaoData.phone : '없음') 
		                            + '<br>카테고리: ' + kakaoData.category_name 
		                            + '<br>URL: ' + (kakaoData.place_url ? '<a href="' + kakaoData.place_url + '" target="_blank">바로가기</a>' : '없음') + '</p>';
		    } else {
		        kakaoInfo.innerHTML = '<p>카카오 제공정보가 없습니다.</p>';
		    }
		}

	});
		
		
		/* json 형태로 받아올 경우
		$('#test').on('click',function(){
			$.ajax({
				url : "hospitalList.ho",
				success : function(result){
					var items = result.reponse.body.items;
					var str = "";
					
					for(var i=0; i<items.length; i++){
						var item = items[i];
						str += "<tr>"
							+ "<td>" + item.BIZPLC_NM + "</td>"
							+ "</tr>"
					}
					$('#result tobdy').html(str);
					console.log('통신성공')
				},
				error : function(){
					console.log('통신실패 ㅠㅠ')
				}
			});
		});
		*/
	</script>
</body>
</html>