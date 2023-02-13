<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
 <meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
* {font-family:"noto sans", sans-serif;
   box-sizing: border-box}
    body > div > div{margin-top:30px; text-align:center}
    img{width:150px}
	h1{font-family:"Lora"; text-align:center; margin-bottom:20px; font-weight:bold; font-size:40px; color:#006CFF}
	
	form{width:500px; margin:0 auto; border:1px solid #C4C5C8; padding:20px 40px; border-radius: 4px;
		margin-bottom:50px;}
		
	#log{margin: 20px 0px 10px 0px; font-size:32px; font-weight:bold}	
	#id, #password {width:100%; height:50px; margin:15px 0px; border:1px solid #C4C5C8; padding:15px 12px; border-radius: 4px;
	}
	#password + img {
    width: 28px;
    height: 28px;
    position: relative;
    top: -55px;
    left: 372px;
	}
	
	#log + div + div {height:80px}
	#id:focus, #password:focus{border:3px solid black; outline:none}
	label{cursor:pointer}
	#check1, #check2 {margin:5px 0px; accent-color:black}
	span {position:relative; margin-left:6px}
	#remember + span {
    position: relative;
    top: -1.6px;
	}
	input[type=checkbox], input[type=radio] {
    box-sizing: border-box;
    padding: 0;
    width: 14px;
    height: 14px;
	}
	a{float:right;  text-decoration: none; color:black; }
	a:hover{color:black}
	button{width:100%; height:50px; margin:10px 0px; 
	border-radius: 4px; color:white;
	padding: 10px;
	border:none;
	}
	 
	#joinbtn{background-color:black}
	#submitbtn {background-color: white; color: black; border: 1px solid black;}
	#submitbtn:hover, #joinbtn:hover {cursor:pointer}
	#submitbtn:hover {background-color:black; color:white}
</style>
<script>
$(document).ready(function(){
	
  var id = '${id}';
  if(id){
	  $('#remember').attr('checked',true);
	  $('#id').val(id);
  }
  
  $('#joinbtn').click(function(){
	location.href="join.net";
  });
  
  $('#password + img').click(function(){
	  if($('#password').attr('type')=='password'){
		  $('#password').attr('type','text');
		  $(this).attr('src','member/image/hidepass.png');
	  }else if($('#password').attr('type')=='text'){
		  $('#password').attr('type','password');
		  $(this).attr('src','member/image/showpass.png');
	  }
  })
});
</script>
</head>
<body>
<div>
	<div><img src="member/image/logoblack.png"></div>
	<form action="logincheck.net" method="post">
		<div id="log">LOGIN</div>
		<div>
			<input type="text" id="id" name="id" placeholder="아이디를 입력하세요">
		</div>
		<div>
			<input type="password" id="password" name="password" autocomplete="off" placeholder="비밀번호를 입력하세요"><img src="member/image/showpass.png">
		</div>	
		<div id="check1">
			<label for="remember">
				<input type="checkbox" name="remember" id="remember" value="store"><span>ID</span> 저장</label>
			<a href="findid.net">아이디/비밀번호 찾기</a>
		</div>
		<div id="check2">
			<label for="autologin">
				<input type="checkbox" name="autologin" id="autologin" value="yes"><span>자동 로그인</span></label>
		</div>
		<button type="submit" id="submitbtn">로그인</button>
		<button type="button" id="joinbtn">회원가입</button>
	</form>
</div>
</body>
</html>