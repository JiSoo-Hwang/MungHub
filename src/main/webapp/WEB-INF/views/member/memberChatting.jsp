<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅창</title>
</head>
<style>
	.chatTotal{
		width:100%;
		height:99vh;
		top:0;
		left:0;
		display:flex;
 		flex-direction: column;
	}
	.chatTotal>div{
		width:100%;
	}
	.chatHeader>div{
		float:left;
		height:inherit;
	}
	.sitter-left{
		padding-top:25px;
		padding-left:25px;
		padding-right:25px;
		padding-bottom:25px;
	}
	.sitter-photo{
		overflow:hidden;
		border-radius:50%;
		width:150px;
		height:150px;
	}
	.sitter-photo>img{
		height:150px;
		top:50%;
		left:50%;
	}
	.chatHeader{
		height:200px;
		border-bottom:1px solid gray;
		background-color: rgb(218, 253, 255);
	}

	.chat-main{
		display:inline-block;
		flex-grow:1;
		background-color: rgb(255,219,244);
		height:auto;
		overflow:auto;
	}
	.chat-main>div{
		width:100%;
		display:inline-block;
	}
	#chatArea{
		overflow: auto;
	}
	.MASTER{
		float:right;
	}
	.SITTER{
		float:left;
	}
	.chatSender{
		border-top:1px solid gray;
		height:200px;
		background-color:white;

	}
	.chatSender>*{
		width:80%;
		height:200px;
		float:left;
		overflow:auto;
	}
	.userChat{
		margin-bottom:5px;
		overflow:auto;
	}
	.user-chat{
		height:auto;
	}
	.sitter-name{
		padding-top:10px;
		font-size: 25px;
		font-weight: bolder;
		position:absoulte;
	}
	.sitter-introduce{
		margin-top:20px;
		color: gray;
		font-size:15px;
	}
	.exitButton{
		float:right;
		position:relative;
		border:1px solid lightgray;
		height:40px;
		width:150px;
		right:30px;
		font-size: 18px;
		
	}
	.chat-content{
		padding:3px;
		padding-left:8px;
		padding-right:8px;
		margin:5px;
		font-size:18px;
		display:inline;
		border-radius:10px;
		background-color:white;
	}
	.sendButton{
		width:20%;
		height:200px;
		border:none;
		background-color: lightGray;
		float:right;
	}

</style>	
<body>
	<div hidden="true">
		<%@include file="/WEB-INF/views/common/header.jsp" %>
	</div>
	<div class="chatTotal">
	<div class="chatHeader">
		<div class="sitter-left">
			<div class="sitter-photo">
				<img src='/pjtMungHub/${sitterUser.filePath}${sitterUser.originName}'>			
			</div>
		</div>
		<div class="sitter-right">
			<div class="sitter-name">
				${sitterUser.petSitterName} 시터님
			<c:if test="${not empty loginUser}">
			<button class="exitButton" onclick="disconnect(); return false;">채팅방 나가기</button>
			</c:if>
			</div>
			<div class="sitter-introduce">
				${sitterUser.introduce}
			</div>
		</div>
	</div>
	<div class="chat-main">
		<div id="chatArea">
			<c:if test="${not empty chatList}">
				<c:forEach items="${chatList}" var="chat">
					${chat.chatContent}
				</c:forEach>
			</c:if>
		</div>
	</div>
	<div class="chatSender">
		<textarea id="summernote"></textarea>
		<button class="sendButton" onclick="send(); return false;">보내기</button>
	</div>
	</div>
	<script>
		// 웹소켓 접속 함수
		var socket; // 웹소켓을 담아 놓을 변수
		var code='${code}';
		var lastWriter;
		var [ sitterNo , masterNo ] = code.split("n");
		$(function(){
			// 접속 경로를 담아 socket 생성
			var url = "ws://localhost:8888/pjtMungHub/chat";
			socket = new WebSocket(url);
			// 연결이 되었을 때 동작
			socket.onopen = function(){
				console.log("연결 성공");
			}
			// 연결이 끊겼을 때 동작
			socket.onclose = function(){
				var data=$("#chat").innerHTML;
				$.ajax({
					url:"update.chat",
					data:data,
					success:function(){
						console.log("저장완료");
					},
					error:function(){
						console.log("통신오류");
					}
					
				})
				console.log("연결 종료");
			}
			// 에러가 발생했을 때 동작
			socket.onerror = function(e){
				console.log("에러 발생");
				console.log(e);
			}
			// 메시지를 수신했을 때
			socket.onmessage = function(message){
				console.log("메시지를 받았습니다.")
				console.log(message.data);
				var data = message.data.slice(6);
				console.log(data);
				var div = document.getElementById("chatArea");
				var newDiv = document.createElement("div");
				var innerDiv = document.createElement("div");
				var sender="chat-content "+message.data.substring(0,6);
				lastWriter=message.data.substring(0,6);
				var newSpan= document.createElement("div");
				innerDiv.appendChild(newSpan).setAttribute("class",sender);
				newSpan.innerHTML = data;
				innerDiv.setAttribute("class","user-chat");
				newDiv.appendChild(innerDiv);
				div.appendChild(newDiv).setAttribute("class","userChat");
				$(".user-Chat").prop("style","height:auto;");
				$(".chat-content").prop("style","padding:3px;padding-left:8px;padding-right:8px;margin:5px;font-size:18px;display:inline;border-radius:10px;background-color:white;");
				$(".MASTER").prop("style","float:right;");
				$(".MASTER *").prop("style","float:right;");
				$(".SITTER").prop("style","float:left;");
				$(".SITTER *").prop("style","float:left;");
				$("p").prop("style","margin:0;")
				var newMsg=window.opener.document.querySelectorAll(".chatCont");
				var counterNo=0;
				if(${not empty loginUser}){
					counterNo=sitterNo;
				}else{
					counterNo=masterNo;
				}
				console.log(counterNo);
				for(var i=0;i<newMsg.length;i++){
					console.log(newMsg[i].querySelector("input[type=hidden]"));
					if(newMsg[i].querySelector("input[type=hidden]").value==counterNo){
						newMsg[i].querySelector(".chat-prev").innerHTML=data;
						break;
					}
				};
				saveData();
			}
		});
		function disconnect(){
			var chat=$("#chatArea");
			console.log(chat.innerHTML);
			
			var out=window.confirm("채팅방을 나갈 시 해당 시터와 나눈 대화가 삭제됩니다. 정말 나가시겠습니까?");
			if(out){
				$.ajax({
					url:"delete.chat",
					data:{
						sitterNo:sitterNo,
						masterNo:masterNo
					},
					success:function(){
						console.log("삭제");
					},
					error:function(){
						console.log("통신오류");
					}
				})
				socket.close();
				window.close();				
			}
		}

		$('#summernote').summernote({
			height:140,
			disableResizeEditor:true,
			toolbar:[
				['insert',['picture','link','video']]
			],
			callbacks:{
				onImageUpload:function(files,editor,welEditable){
					for(var i=0;i<files.length;i++){
						uploadFile(files[i],this);
					}
				}
			}
		});
		$(".note-toolbar").on("click",function(){
			$(".note-modal-backdrop").prop("style","z-index:1;");
		})
		function uploadFile(file,el){
			var form_data = new FormData();
			form_data.append('file',file);
			$.ajax({
				url : "uploadFile.chat",
				type:"post",
				data:form_data,
				encType: 'multipart/form-data',
				cache:false,
				contentType:false,
				processData:false, 
				success: function(url){
					console.log(url);
					$(el).summernote('insertImage',url,function($image){
						$image.css('width',"25%");
					});
				},
				error:function(){
					console.log("통신오류");
				}
			});
		}
		// 메시지 전송 함수
		function send(){
			// 사용자가 입력한 텍스트를 추출하여 웹소켓에 전달하기
			var summernote=document.querySelector(".note-editable p");
			var message;
			if(message!="<br>"){
				var loginUser=${empty loginUser};
				if(loginUser){
					message='SITTER';
				}else{
					message='MASTER';
				}
				message+= summernote.innerHTML;
				console.log(message);
				socket.send(message);
				summernote.value="";
				document.querySelector(".note-editable p").innerHTML="<br>";
			}else{
				return false;
			}
		}
		window.addEventListener("beforeunload",function(event){
		})
		function saveData(){
			var data=document.querySelector("#chatArea").innerHTML;
			var chatWriter=lastWriter;
			console.log("lastWriter : "+lastWriter);
			var status;
			if(${not empty loginUser&&chatWriter=='MASTER'||empty loginUser&&chatWriter=='SITTER'}){
				status='N';
			}else{
				status='Y'
			}
			$.ajax({
				url:"save.chat",
				data:{
					sitterNo:sitterNo,
					masterNo:masterNo,
					chatContent:data.trim(),
					chatWriter:chatWriter,
					status:status
				},
				success:function(){
					console.log("저장완료");
				},
				error:function(){
					console.log("저장 간 통신문제");
				}
			})
		}
	</script>
</body>
</html>