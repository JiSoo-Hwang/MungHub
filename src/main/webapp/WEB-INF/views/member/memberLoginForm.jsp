<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.2/kakao.min.js"
	  integrity="sha384-TiCUE00h649CAMonG018J2ujOgDKW/kVWlChEuu4jK2vxfAAD0eZxzCKakxg55G4" crossorigin="anonymous"></script>
	<script src="https://accounts.google.com/gsi/client" async></script>
	<meta name="google-signin-client_id" content="214727713756-rr8ifm1lva6musaa03n7iasqdssae36q.apps.googleusercontent.com">
	<script src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
	
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.total-area{
		width:100%;
		margin:auto;
	}
	#loginArea{
		height:	500px;
		margin-left:25%;
		margin-right:25%;
		margin-top:10%;
		margin-bottom:30px;
		border:1px solid lightgray;
	}
	#loginMain{
		background-color:
	}
	.loginTitle{
		padding-bottom:20px;
		margin-top:20px;
		width:100%;
	}
	form{
		border-top:1px solid gray;
	}
	.loginInput{
		margin:auto;
		margin-top: 20px;
		margin-bottom: 10px;
	}
	.loginInput>tr{
		height:25px;
	}
	.loginButton{
		float:right;
		margin-left:10px;
		height:62px;
		border:none;
		color: white;
		width: 80px;
	}
	#loginServiceArea{		
		overflow:auto;
	}
	.loginService{
		margin:auto;
		margin-top:15px;	
		margin-bottom:10px;
	}
	.loginService td{
		overflow: auto;
	}
	.loginService button{
		border:none;
	}
	#loginAPIArea{
		border-top:1px solid gray;
		height: 20%;
	}
	#loginAPIArea>div{
		width: inherit;
	}
	.apiArea{
		height:180px;
		left:50%;
		position:absolute;
	}
	.apiArea>div{
		position:relative;
		margin-bottom:10px;
		transform:translate(-50%,50%);
	}
	#kakao_login{
		display: inline-block;
		width:209px;
		height:45px;
		background-color:#FEE500;
		border-radius:4px;
		border:1px solid lightgray;
	}
	.kakaoButton:hover {
		cursor: pointer;
	}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp" %>
	<div class="total-area">
	<div id="loginArea">
		<div class="loginMain">
		<div class="loginTitle">
			<h2 align="center">로그인</h2>
		</div>
		<form action="login.me" method="post">
			<table class="loginInput">
				<tr>
					<td style="width:80px;">아이디 </td> 
					<td><input type="text" id="userId" name="userId" required placeholder="아이디"></td>
					<td rowspan=2>
						<button class="active loginButton" type="submit">로그인</button>
					</td>
				</tr>
				<tr>
					<td style="width:80px;">비밀번호 </td>
					<td><input type="password" id="password" name="password" required placeholder="비밀번호"></td>
				</tr>
				<tr>
					<td colspan=3>
					</td>
				</tr>
			</table>
		</form>
		
		<div id="loginServiceArea">
			<table class="loginService">
				<tr>
					<td>
						<button onclick="loginUpdate();" >아이디 / 비밀번호 조회</button>
					</td>
					<td>
						<button onclick="memberEnroll();">회원가입</button>
					</td>
				</tr>
			</table>
		</div>
		</div>
		<div id="loginAPIArea">
			<div class="loginTitle">
				<h5 align="center">다른 방식으로 로그인하기</h5>
			</div>
			<div class="apiArea">
					<div id="kakao-login">
						<div id="kakao_login">
							<img src="./resources/uploadFiles/login/kakao2.png" class="kakaoButton" onclick="kakao();">
						</div>
					</div>
					<div id="naver-login">
						<div id="naver_id_login"></div>
					</div>
					<div id="g_id_onload"
					     data-client_id="214727713756-rr8ifm1lva6musaa03n7iasqdssae36q.apps.googleusercontent.com"
					     data-context="signin"
					     data-ux_mode="popup"
					     data-callback="handleCredentialResponse"
					     data-auto_prompt="false" hidden="true">
					</div>
					<div id="google-login">
						<div class="g_id_signin"
						     data-type="standard"
						     data-shape="rectangular"
						     data-theme="outline"
						     data-text="signin_with"
						     data-size="large"
						     data-logo_alignment="left">
						</div>	
					</div>
			</div>
		</div>
	</div>
	</div>
	<script>
		var naver_id_login = new naver_id_login("fx5vZaNv0sDLANZnS_vt", "http://localhost:8887/pjtMungHub/naver.me");
	  	var state = naver_id_login.getUniqState();
	  	naver_id_login.setButton("green", 3, 45);
	  	naver_id_login.setDomain();
	  	naver_id_login.setState(state);
	  	naver_id_login.setPopup();
	  	naver_id_login.init_naver_id_login();
		// 네이버 사용자 프로필 조회
		naver_id_login.get_naver_userprofile("naverSignInCallback()");
		// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
		function naverSignInCallback() {
			alert(naver_id_login.getProfileData('email'));
			alert(naver_id_login.getProfileData('nickname'));
		}
	  	function kakao(){
	  		var kakapPopup=window.open('http://localhost:8887/pjtMungHub/kakao.me', 'kakaologinpop', 'titlebar=1, resizable=1, scrollbars=yes, width=600, height=550'); 
	  	}
		function loginUpdate(){
			location.href="loginInfo.me";
		}
		function memberEnroll(){
			location.href="enroll.me";
		}
		function handleCredentialResponse(response) {
	        console.log("Encoded JWT ID token: " + response.credential);
	        const responsePayload = decodeJwtResponse(response.credential);
	 		var email="";
	 		var name="";
	        console.log("ID: " + responsePayload.sub);
	        console.log('Full Name: ' + responsePayload.name);
	        console.log("Email: " + responsePayload.email);
	        console.log("id: " + responsePayload.id);
	        name=responsePayload.name;
	        email=responsePayload.email;
	        location.href="google.me?name="+name+"&&email="+email;
		}

		function decodeJwtResponse (token) {
			var base64Url = token.split('.')[1];
			var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
			var jsonPayload = decodeURIComponent(window.atob(base64).split('').map(function(c) {
				return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
				}).join(''));
		
			return JSON.parse(jsonPayload);
		}
	
	</script>
</body>
</html>