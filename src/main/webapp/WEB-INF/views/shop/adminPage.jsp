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
<div>
    <div class="sidebar">
        <h4 class="text-center">대시보드</h4>
        <a href="/pjtMungHub/adminPage/dashBoard">대시보드</a>
        <a href="/pjtMungHub/adminPage/orderControll">주문 관리</a>
        <a href="/pjtMungHub/adminPage/productControll">제품 관리</a>
        <a href="/pjtMungHub/adminPage/customerControll">고객 관리</a>
        <a href="/pjtMungHub/adminPage/eventControll">이벤트 관리</a>
    </div>

    <div class="main-content">
        <div class="container mt-4">
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card-custom">
                        <div class="card-body text-center">
                            <h6 class="card-title">상점 방문수</h6>
                            <h3>350,897</h3>
                            <p class="text-success"><span class="stat-icon positive">▲</span> 3.48% 지난달 대비</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card-custom">
                        <div class="card-body text-center">
                            <h6 class="card-title">신규 주문고객</h6>
                            <h3>2,356</h3>
                            <p class="text-danger"><span class="stat-icon negative">▼</span> 3.48% 지난주 대비</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card-custom">
                        <div class="card-body text-center">
                            <h6 class="card-title">판매량</h6>
                            <h3>924</h3>
                            <p class="text-danger"><span class="stat-icon negative">▼</span> 1.10% 어제 대비</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card-custom">
                        <div class="card-body text-center">
                            <h6 class="card-title">성과</h6>
                            <h3>49.65%</h3>
                            <p class="text-success"><span class="stat-icon positive">▲</span> 12% 지난달 대비</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-8">
                    <div class="card-custom">
                        <div class="card-header-custom">
                            <h6 class="m-0">매출 값</h6>
                            <div class="btn-group btn-group-sm float-end" role="group" aria-label="Basic example">
                                <button type="button" class="btn btn-light">월간</button>
                                <button type="button" class="btn btn-light">주간</button>
                            </div>
                        </div>
                        <div class="card-body">
                            <canvas id="sales-chart" class="chart bg-light"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card-custom">
                        <div class="card-header-custom">
                            <h6 class="m-0">총 주문 수</h6>
                        </div>
                        <div class="card-body">
                            <canvas id="orders-chart" class="chart bg-light"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



<script>
	var january=${month.january};
	var feburary=${month.feburary};
	var march=${month.march};
	var april=${month.april};
	var may=${month.may};
	var june=${month.june};
	var july=${month.july};
	var august=${month.august};
	var september=${month.september};
	var october=${month.october};
	var november=${month.november};
	var december=${month.december};
	
    document.addEventListener('DOMContentLoaded', function () {
        // Sales Chart
        const salesCtx = document.getElementById('sales-chart').getContext('2d');
        const salesChart = new Chart(salesCtx, {
            type: 'line',
            data: {
                labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                datasets: [{
                    label: '매출(원)',
                    data: [january, feburary, march, april, may, june, july, august, september, october, november, december],
                    backgroundColor: 'rgba(90, 103, 216, 0.2)',
                    borderColor: 'rgba(90, 103, 216, 1)',
                    borderWidth: 2,
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        
    	var januaryC=${monthCount.january};
    	var feburaryC=${monthCount.feburary};
    	var marchC=${monthCount.march};
    	var aprilC=${monthCount.april};
    	var mayC=${monthCount.may};
    	var juneC=${monthCount.june};
    	var julyC=${monthCount.july};
    	var augustC=${monthCount.august};
    	var septemberC=${monthCount.september};
    	var octoberC=${monthCount.october};
    	var novemberC=${monthCount.november};
    	var decemberC=${monthCount.december};
        
        
        
        // Orders Chart
        const ordersCtx = document.getElementById('orders-chart').getContext('2d');
        const ordersChart = new Chart(ordersCtx, {
            type: 'bar',
            data: {
                labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                datasets: [{
                    label: '주문 수',
                    data: [januaryC, feburaryC, marchC, aprilC, mayC, juneC, julyC, augustC, septemberC, octoberC, novemberC, decemberC],
                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 2
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                },
                responsive: true,
                maintainAspectRatio: false
            }
        });
    });
</script>

</body>
</html>