<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <!-- BootStrap 및 jQuery cdn 시작 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- Latest compiled and minified CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Popper JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- BootStrap 및 jQuery cdn 끝 -->
     <!-- alertify css 커스터마이징 시작 -->
    <script src="https://cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css" rel="stylesheet">
	
	<!-- include summernote css/js-->
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>


<script>
	alertify.defaults = {
		// dialogs defaults
		autoReset : true,
		basic : false,
		closable : true,
		closableByDimmer : true,
		invokeOnCloseOff : false,
		frameless : false,
		defaultFocusOff : false,
		maintainFocus : true, // <== global default not per instance, applies to all dialogs
		maximizable : true,
		modal : true,
		movable : false,
		moveBounded : false,
		overflow : true,
		padding : true,
		pinnable : true,
		pinned : true,
		preventBodyShift : false, // <== global default not per instance, applies to all dialogs
		resizable : false,
		startMaximized : false,
		transition : 'pulse',
		transitionOff : false,
		tabbable : 'button:not(:disabled):not(.ajs-reset),[href]:not(:disabled):not(.ajs-reset),input:not(:disabled):not(.ajs-reset),select:not(:disabled):not(.ajs-reset),textarea:not(:disabled):not(.ajs-reset),[tabindex]:not([tabindex^="-"]):not(:disabled):not(.ajs-reset)', // <== global default not per instance, applies to all dialogs

		// notifier defaults
		notifier : {
			// auto-dismiss wait time (in seconds)  
			delay : 1,
			// default position
			position : 'bottom-right',
			// adds a close button to notifier messages
			closeButton : true,
			// provides the ability to rename notifier classes
			classes : {
				base : 'alertify-notifier',
				prefix : 'ajs-',
				message : 'ajs-message',
				top : 'ajs-top',
				right : 'ajs-right',
				bottom : 'ajs-bottom',
				left : 'ajs-left',
				center : 'ajs-center',
				visible : 'ajs-visible',
				hidden : 'ajs-hidden',
				close : 'ajs-close'
			}
		},

		// language resources 
		glossary : {
			// dialogs default title
			title : '',
			// ok button text
			ok : '확인',
			// cancel button text
			cancel : '취소'
		},

		// theme settings
		theme : {
			// class name attached to prompt dialog input textbox.
			input : 'ajs-input',
			// class name attached to ok button
			ok : 'ajs-ok',
			// class name attached to cancel button 
			cancel : 'ajs-cancel'
		},
		// global hooks
		hooks : {
			// invoked before initializing any dialog
			preinit : function(instance) {
			},
			// invoked after initializing any dialog
			postinit : function(instance) {
			},
		},
	};
</script>
<!-- alertify css 커스터마이징 끝 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        @import url("https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css");
        #header {
            padding: 10px;
            position: sticky;
        }

        /* 메인 메뉴바 */
        #header_1>ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color: #F4D3D3;
        }

        #header_1 li {
            float: left;
        }

        #header_1 li a {
            display: block;
            color: #492F10;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

        #header_1 li a:hover {
            background-color: #E8A9A9;
        }

        .active {
            background-color: #090580;
        }

        /* 메인 메뉴바 끝 */
        /* 서브 메뉴바 */
        #header_2 {
            display: none;
        }

        #header_2>ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color: #FFEAE3;
        }

        #header_2 li {
            float: left;
        }

        #header_2 li a {
            display: block;
            color: #492F10;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

        #header_2 li a:hover {
            border-bottom: #492F10 2px solid;
        }

        #header_2:after {
            clear: both;
        }
</style>
<style>
	.chatPopup{
		z-index: 50;
		position:fixed;
		bottom:10px;
		left:10px;
		width:300px;
		border:5px solid rgba(107, 117, 255, 0.45);
		padding:2px;
	}
	.chatPopup, .chatTitle{
		background-color: rgb(107, 117, 255);
		color:white;
		font-weight:border;
	}
	.chatList{
		background-color:white;
		border-bottom:1px solid lightgray;
		opacity:100%;
	}
	.chatCont{
		padding-top:10px;
		line-height:150%;
		border-bottom:3px solid rgba(107, 117, 255,0.4);
		border-right:3px solid rgba(107, 117, 255,0.4);
	}
	.chatCont>*{
		display:inline-block;
	}
	.counterName{
		width:100%;
		font-weight:bold;
		font-size: 18px;
		color:black;
		padding-left:10px;
		margin-bottom:10px;
	}
	.chat-prev{
		width:80%;
		padding-left:20px;
		color:gray;
		padding-bottom:5px;
	}
</style>
</head>
<body>
<c:choose>
	<c:when test="${!empty loginUser }">
		<span style="float: right; margin: 10px; ">${loginUser.userId} 님 환영합니다&ensp;|&ensp;<a href="myPage.me" style="text-decoration: none; color: black;">마이페이지</a></span>
	</c:when>
	<c:when test="${!empty sitterUser}">
		<span style="float: right; margin: 10px; ">${sitterUser.petSitterName} 펫시터님 환영합니다&ensp;</span>
	</c:when>
</c:choose>
<br clear="all">
    <nav id="header">
        <nav id="header_1">
            <ul>
                <li class="menu"><a href="map.do">Kindergarten</a></li>
                <li class="menu"><a href="#news">Petcare</a></li>
                <li class="menu"><a href="wedList.wd">Wedding</a></li>
                <li class="menu"><a href="/pjtMungHub/list.bo">Board</a></li>
                <li class="menu"><a href="/pjtMungHub/list.sp">Shop</a></li>
				<li style="float: right">
					<c:choose>
						<c:when test="${empty sitterUser&&empty loginUser}">
							<a class="active" href="/pjtMungHub/enter.me"
							style="color: white;">Login</a>
						</c:when>
						<c:otherwise>
							<a class="active" href="/pjtMungHub/logout.me"
							style="color: white;">Logout</a>
						</c:otherwise>
					</c:choose>
				</li>
            </ul>
        </nav>
        <nav id="header_2">
            <ul>
				<c:choose>
                <c:when test="${loginUser.userGrade == 2 }">
				<li><a href="regList2.do?userNo=${loginUser.userNo}">상담예약내역</a></li>
                </c:when>
                <c:otherwise>
				<li><a href="regList.do?userNo=${loginUser.userNo}">상담예약내역</a></li>
                </c:otherwise>
                </c:choose>
                <li><a href="sitter.re">단기돌봄예약</a> </li>
                <li><a href="hospital.ho">동물병원정보</a> </li>
                <li><a href="houseList.re">장기돌봄예약</a> </li>
                <li><a href="css.re">CSS</a> </li>
            </ul>
        </nav>
    </nav>
    <script>
        $(function () {
            $(".menu").hover(function () {
                $("#header_2").show();
            });
            $("#header_2").mouseleave(function () {
            	$("#header_2").hide();
			});
        });
    </script>
    
    <!-- 알림창 -->
    <c:if test="${not empty alertMsg}">
	    <script>
	        alertify.alert("${alertMsg}");
	    </script>
    	<c:remove var="alertMsg"/>
	</c:if>
	<c:if test="${not empty loginUser||not empty sitterUser}">
	    <div class="chatPopup">
			<div class="chatName" align="left">
				<button class="chatBTN" type="button">채팅</button>
			</div>
			<div class="chatList" style="display:none;">
				<div class="chatTitle">
					<span>채팅 목록</span>
				</div>
				<c:choose>
				<c:when test="${not empty chatList}">
					<c:forEach items="${chatList}" var="cList">
						<c:choose>
							<c:when test="${not empty loginUser}">
							<div class="chatCont sitter">
								<input type="hidden" value="${cList.sitterNo}">
								<span class="counterName">
									<c:forEach items="${sitterList}" var="sitter">${cList.sitterNo eq sitter.petSitterNo ? sitter.petSitterName:""}</c:forEach> 펫시터님
								</span>
								<br>
								<span class="chat-prev">${cList.chatWriter eq 'SITTER' ? '새로운 메시지가 있습니다.' : '새로운 메시지를 남겨보세요'}</span>
							</div>
							</c:when>
							<c:when test="${empty loginUser&&not empty sitterUser}">
							<div class="chatCont master">
								<input type="hidden" value="${cList.masterNo}">
								<span class="counterName">
									<c:forEach items="${masterList}" var="master">${cList.masterNo eq master.userNo ? master.name:""}</c:forEach> 견주님
								</span>
								<br>
								<span class="chat-prev">${cList.chatWriter eq 'MASTER' ? '새로운 메시지가 있습니다.' : '새로운 메시지를 남겨보세요'}</span>
							</div>
							</c:when>
						</c:choose>
					</c:forEach>
				</c:when>
				<c:otherwise>
					현재 진행된 채팅이 없습니다.
				</c:otherwise>
				</c:choose>
			</div>
		</div>
	</c:if>
	<script>
		$(".chatPopup").on("click",function(){
			if($(".chatList").css("display")=="none"){
				$(".chatName").prop("hidden",true);
				$(".chatList").slideDown(250);
			}else{
				$(".chatList").slideUp();
				$(".chatName").prop("hidden",false);
			}
		})
		$(".sitter").on("click",function(){
			var sitterNo= $(this).children().eq(0).val();
			var sitterUser;
			$.ajax({
				url:"read.chat",
				data:{
					sitterNo:sitterNo,
					masterNo:'${loginUser.userNo}'
				},
				success:function(result){
					if(result>0){
						console.log("채팅확인");
					}else{
						console.log("못바꿈");
					}
				},
				error:function(){
					console.log("통신오류");
				}
			});
			$.ajax({
				url:"searchSitter.me",
				data:{
					petSitterNo:sitterNo
				},
				success:function(result){
					sitterUser=result;
				},
				error:function(){
					console.log("검색못함");
				}
			});
			var code='';
				code=sitterNo+'n'+"${loginUser.userNo}";

			var chatRoom=window.open('http://localhost:8888/pjtMungHub/chat/code'+code,'chatpop','titlebar=1,location=no,status=no, scrollbars=yes, width=600, height=850');
		})
		$(".master").on("click",function(){
			var masterNo= $(this).children().eq(0).val();
			var sitterUser;
			$.ajax({
				url:"read.chat",
				data:{
					sitterNo:'${sitterUser.petSitterNo}',
					masterNo:masterNo
				},
				success:function(result){
					if(result>0){
						console.log("채팅확인");
					}else{
						console.log("못바꿈");
					}
				},
				error:function(){
					console.log("통신오류");
				}
			});
			var code='';
				code=${sitterUser.petSitterNo}+'n'+masterNo;

			var chatRoom=window.open('http://localhost:8888/pjtMungHub/chat/code'+code,'chatpop','titlebar=1,location=no,status=no, scrollbars=yes, width=600, height=850');
		})
	</script>
</body>
</html>