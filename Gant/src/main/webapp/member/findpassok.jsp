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
	 border-radius:4px; border:1px solid #C4C5C8; padding:20px 40px 40px 40px}
hr{color:#ced4da}
#text{text-align:center}
span{font-weight:bold;}
span:nth-child(2){color:red}

button{height:50px; width:180px; 
       border-radius:4px; border:1px solid #009CFF; 
	   outline:none; font-size:16px; cursor:pointer;
	   color:white;display:block; margin:0 auto; background:#009CFF}
	   
#logbtn:hover{background:#26abff; border:1px solid #26abff; }

</style>
<script>
$(document).ready(function(){
	$('button').click(function(){
		location.href="login.net";
	});
});
</script>
</head>
<body>
   <div id="frame">
  	<h3>비밀번호 조회 결과</h3>
  	<hr>
  	<br>
  	<br>
  	<div id="text">
  	<span>${id}</span> 님의 비밀번호는 
  	<span>${password}</span>입니다.
  	</div>
  	<br>
  	<br>
  	<br>
  	<button type="button" id="logbtn">로그인</button>
  </div>
</body>
</html>