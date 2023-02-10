<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GANT</title>
<script src="js/jquery-3.6.3.js"></script>
<style>
* {font-family:"noto sans", sans-serif;
   box-sizing: border-box}
   
#frame{width:520px; margin:0 auto; margin-top:90px;
	  border-radius:4px; border:1px solid #C4C5C8; padding:20px 40px 40px 40px;
	  height:310px}
#text{text-align:center}
span{font-weight:bold;}
span:nth-child(2){color:red}

button{height:50px; width:200px; 
       border-radius:4px; border:none; 
	   outline:none; font-size:16px; cursor:pointer;
	   color:white;}
	   
#logbtn{float:left; background:black;}
#logbtn:hover, #findpassbtn:hover{color:black; background:white; border:2px solid black}

#findpassbtn{float:right; background:black}
</style>
<script>
$(document).ready(function(){
	$('button').click(function(){
		if($(this).attr('id')=="logbtn"){
			location.href="login.net";
		}else{
			location.href="findpass.net";
		}
	});
});
</script>
</head>
<body>
  <div id="frame">
  	<h3>아이디 조회 결과</h3>
  	<hr>
  	<br>
  	<br>
  	
  	<div id="text">
  	<span>${name}</span> 님의 아이디는 
  	<span>${id}</span> 입니다.
  	</div>
  	<br>
  	<br>
  	<br>
  	<button type="button" id="logbtn">로그인</button>
  	<button type="button" id="findpassbtn">비밀번호 찾기</button>
  </div>
</body>
</html>