<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>실시간 채팅</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="js/jquery-3.6.3.js"></script>
<style>
* {font-family:"noto sans", sans-serif;
   box-sizing: border-box; font-size:15px}
   body{background-color:#FAFAFA; border-collapse:collapse;}
.out {
    padding: 10px;
    width: 100%;
    height: 100%;
}
#myinfo{padding:12px;height:70px; background:white; border:1px solid #C4C5C8;  border-radius:2px}
#myinfo>img{width:45px; height:45px; float:left;margin-right:20px; border-radius:50%;border:1px solid #C4C5C8}
#myinfo>div:nth-child(2){width:400px;font-weight:bold; margin-bottom:5px}
#myinfo>div:nth-child(3){width:400px; margin-top:5px}
.main{border:1px solid #C4C5C8; border-radius:2px; background:white; height:84%}
#messageWindow2{padding:12px; height:78%; overflow:auto; margin-top:10px}
#messageWindow2::-webkit-scrollbar {
           width: 7px; /*스크롤바의 너비*/
}
#messageWindow2::-webkit-scrollbar-thumb {
    height: 30%; /* 스크롤바의 길이 */
    background: black; /* 스크롤바의 색상 */
    
    border-radius: 10px;
}

#messageWindow2::-webkit-scrollbar-track {
    background-color: transparent;  /*스크롤바 뒷 배경 색상*/
} 
.receive{margin:7px 0px 7px 0px; position:relative}
.profile{width:35px;height:35px; border-radius:50%;position:absolute; left:1.35%; top:10%;border:1px solid #C4C5C8}
.username{padding:3px; margin-top:2px}

.alertMessage{text-align:center; margin:0px 0px 6px 0px}
.receivemessage{width:auto; word-wrap:break-word; 
		 display:inline-block; background:white; border:1px solid #C4C5C8;
		 border-radius:20px; padding:10px; top:2.5px; left: 9.3%; position: relative;}
		 
.sendmessage{width:auto; word-wrap:break-word; float:right;
			 display:inline-block; background-color:black;
			 color:white; border-radius:20px; padding:10px; margin:5px 5px 5px 0px}

#bottombox{position:relative; height:23%; padding: 12px 12px 4px 12px; margin-top:7px}
#inputMessage {width: 94%;  display:inline-block;
			   border:1px solid #C4C5C8; border-radius:25px; margin:0 auto;
			   height:45px; padding:10px 20px; font-size:14px; position:absolute; left:3%; bottom:33.7%}	
#inputMessage:focus {border:2px solid black; outline:none}		 
button{background:transparent; border:none; outline:none; position:absolute; right:5%; bottom:39.7%}
button>img{width:30px;height:30px;}

</style>
</head>
<body>
<div class="out">
	<div id="myinfo">
	<c:if test="${member.profileimg==null}" > <%--프로필사진 없는 경우: 기본이미지 --%>
	  <img src="member/image/defaultprofile.png"><div>나</div><div>${member.name}</div>
	</c:if>
	<c:if test="${member.profileimg!=null}" > <%--프로필사진 등록한 경우: 그 이미지 --%>
	  <img src="memberupload/${member.profileimg}"><div>나</div><div>${member.name}</div>
	</c:if>
	</div>
<!-- onkeydown을 통해서 엔터키로도 입력되도록 설정. -->

<div class="main">
	<div id="messageWindow2"></div>
	
	<div id="bottombox">
	<input id="inputMessage" type="text" placeholder="메시지를 입력하세요"
			onkeydown="if(event.keyCode==13){send();}"/>
	<button type="button" value="send"><img src="member/image/sendicon.png"></button>
	</div>
	
</div>

</div><%-- end class="out" --%>

</body>
<script>
	if("${member.name}"==""){
		alert('로그인 후 이용해주세요');
		window.close();
	}
	
	//웹소켓 설정
	var webSocket = new WebSocket("ws://localhost:8088/Gant/ChatServer");
	
	//같은 이가 여러번 보낼때 이름 판별할 변수

	//let list = new Array(); //접속자 수
	// OnOpen은 서버 측에서 클라이언트와 웹 소켓 연결이 되었을 때 호출되는 함수
	webSocket.onopen = function(event) {
		onOpen(event)
	};
	
	function onOpen(event) {
		//접속했을 때 접속자들에게 알릴 내용
		webSocket.send("${member.name} 님이 채팅방에 들어왔습니다.");
		//list.add()
	}
	
	// OnError는 웹 소켓이 에러가 나면 발생을 하는 함수.
	webSocket.onerror = function(event) {
		onError(event)
	};
	
	function onError(event) {
		alert("채팅 연결에 실패하였습니다. " + event.data);
	}
	
	// OnClose는 웹 소켓이 끊겼을 때 동작하는 함수.
	function onClose(event){
		//for(var i=0;i<list.length;i++){
			//if(list[i]=='')
		//}		
		webSocket.close();
	}
	
	// OnMessage는 클라이언트에서 서버 측으로 메시지를 보내면 호출되는 함수
	webSocket.onmessage = function(event) {
		onMessage(event)
	};
	//보낸 session의 경우 자기메시지 안오도록 설정해놓음
	function onMessage(event) {
		
		if(event.data.split("|\|").length==1){
			//list.add("${member.name}"); //접속자가 들어와서 추가
			//console.log(list);
			
			//입력한 내용을 받는 것이 아닌 onOpen, onClose때 보낸 내용
			let alertMessage = "<div class='alertMessage'>"+ event.data + "</div>";
			$("#messageWindow2").append(alertMessage);
		}else{ //입력한 메시지가 온 경우
			
			//클라이언트에서 날아온 메시지를 (구분) 단위로 분리한다
			var rmessage = event.data.split("|\|");
			//[0]은 프로필사진, [1]은 이름, [2]는 내용
		
		let receiveDiv ="";
		receiveDiv += "<div class='receive'>"
					+		"<img src=";
					if(rmessage[0]==''){
						receiveDiv += "'member/image/defaultprofile.png'";
					}else{
						receiveDiv += "'memberupload/"+rmessage[0]+"''";
					}
		receiveDiv += 			" class='profile'>" //프로필 사진(없으면 기본사진,있으면 그사진)
					+ 		"<div class='receivemessage'>"+rmessage[2]+"</div>" //메시지 내용
					+ 		"<div class='username'>"+ rmessage[1] + "</div>" //이름
					+ "</div>"; //receive end
					
		//receive div는 받는 메시지 출력할 공간
		$('#messageWindow2').append(receiveDiv);
		
		//clear div 추가. 줄바꿈용.		
		let clear = "<div style='clear:both'></div>";
			$('#messageWindow2').append(clear);
		
		}
		//div 스크롤 아래로
		$("#messageWindow2").scrollTop($("#messageWindow2")[0].scrollHeight);
		//messageWindow2.scrollTop = messageWindow2.scrollHeight;
	}


	function send() {
		
		//inputMessage가 있을때만 전송가능
		if($('#inputMessage').val()!=""){
			
			//	서버에 보낼때 날아가는 값.
			webSocket.send("${member.profileimg}|\|${member.name}|\|" + $('#inputMessage').val());
			console.log("send:${member.profileimg}|\|${member.name}|\|" + $('#inputMessage').val());
			// 채팅화면 div에 붙일 내용
			let sendmessage = "<div class='sendmessage'>"+$("#inputMessage").val()+"</div>";
			
			$('#messageWindow2').append(sendmessage);

			let clear = "<div style='clear:both'></div>";
			$('#messageWindow2').append(clear);
			
			//	?
			//inputMessage.value = "";

			//	inputMessage의 value값을 지운다.
			$("#inputMessage").val('');

			//	textarea의 스크롤을 맨 밑으로 내린다.
			//messageWindow2.scrollTop = messageWindow2.scrollHeight;
			$('#messageWindow2').scrollTop($('#messageWindow2')[0].scrollHeight);
			//	보낸 사람(나)를 임시 저장한다.
			sender = "${member.name}";
		}//inputMessage가 있을때만 전송가능 끝.

		// send 함수를 통해 웹소켓으로 메시지를 보낸다.
		$('button').click(function(){
			send();
		});
		

	}
</script>
</html>