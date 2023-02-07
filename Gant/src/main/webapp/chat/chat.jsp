<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
#myinfo{padding:12px;height:70px; background:white; border:1px solid #DBDBDB;  border-radius:2px}
#myinfo>img{width:45px; height:45px; float:left;margin-right:20px; border-radius:50%}
#myinfo>div:nth-child(2){width:400px;font-weight:bold; margin-bottom:5px}
#myinfo>div:nth-child(3){width:400px; margin-top:5px}
.main{border:1px solid #DBDBDB; border-radius:2px; background:white; height:345px}
#messageWindow2{padding:12px; height:18em; overflow:auto;}

.username{padding:3px; margin-left:3px}

.receive{width:auto; word-wrap:break-word; 
		 display:inline-block; background:white; border:1px solid #DBDBDB;
		 border-radius:20px; margin:5px 0px 5px 5px; padding:10px}
		 
.sendmessage{width:auto; word-wrap:break-word; float:right;
			 display:inline-block; background-color:#006CFF;
			 color:white; border-radius:20px; padding:10px; margin:5px 5px 5px 0px}

#bottombox{position:relative; height:74px; padding:12px;margin-top:7px}
#inputMessage {width: 94%;  display:inline-block;
			   border:1px solid #DBDBDB; border-radius:25px; margin:0 auto;
			   height:40px; padding:10px 20px; font-size:14px; position:absolute; left:15px}			 
button{background:transparent; border:none; outline:none; position:absolute; right:18px;top:16px}
button>img{width:30px;height:30px;}

</style>
</head>
<body>
<div class="out">
	<div id="myinfo">
	  <img src="member/image/defaultprofile.png"><div>나</div><div>${member.name}</div>
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
	//웹소켓 설정
	var webSocket = new WebSocket("ws://localhost:8088/Gant/ChatServer");
	
	//같은 이가 여러번 보낼때 이름 판별할 변수
	var re_send = "";

	// OnOpen은 서버 측에서 클라이언트와 웹 소켓 연결이 되었을 때 호출되는 함수
	webSocket.onopen = function(event) {
		onOpen(event)
	};
	
	function onOpen(event) {
		//접속했을 때 접속자들에게 알릴 내용
		webSocket.send("{member.name} 님이 채팅방에 들어왔습니다.");
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
		webSocket.send("${member.name} 님이 채팅방을 나가셨습니다.\n");
	}
	
	// OnMessage는 클라이언트에서 서버 측으로 메시지를 보내면 호출되는 함수
	webSocket.onmessage = function(event) {
		onMessage(event)
	};
	
	function onMessage(event) {

		//클라이언트에서 날아온 메시지를 |\| 단위로 분리한다
		var message = event.data.split("|\|");
		
			//금방 보낸 이를 re_send에 저장하고,
			//금방 보낸 이가 다시 보낼경우 보낸이 출력 없도록 함.
			if(message[0] != re_send){
				let username = "<div class='username'>"+ message[0] + "</div>";
				
				$('#messageWindow2').append(username);

				re_send = message[0];
			}
		
			//div는 받은 메시지 출력할 공간.
			var div=document.createElement('div');
			let receive = "<div class='receive'>"+message[1]+"</div>";
			
			$("#messageWindow2").append(receive);
		
		//clear div 추가. 줄바꿈용.		
		let clear = "<div style='clear:both'></div>";
			$('#messageWindow2').append(clear);
		
		//div 스크롤 아래로.
		//messageWindow2.scrollTop = messageWindow2.scrollHeight;
	}


	function send() {
		
		//inputMessage가 있을때만 전송가능
		if($('#inputMessage').val()!=""){
			
			//	서버에 보낼때 날아가는 값.
			webSocket.send("${member.name}|\|" + $('#inputMessage').val());
			console.log("${member.name}|\|" + $('#inputMessage').val());
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
			
			//	금방 보낸 사람을 임시 저장한다.
			re_send = "{member.name}";
		}//inputMessage가 있을때만 전송가능 끝.

		// send 함수를 통해 웹소켓으로 메시지를 보낸다.
		$('button').click(function(){
			send();
		});
		

	}
</script>
</html>