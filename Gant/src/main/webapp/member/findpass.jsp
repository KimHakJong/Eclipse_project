<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GANT</title>
<script src="js/jquery-3.6.3.js"></script>
<script src="js/findpass.js"></script>
<style>
* {font-family:"noto sans", sans-serif;
   box-sizing: border-box}
body > div {margin:0 auto; width:600px; position:relative; top:90px}
a { font-size:18px;
   display:inline-block; height:50px; width:50%; text-align:center;
   line-height:50px; border:1px solid #C4C5C8;
   text-decoration-line: none; color:black;}
form{padding:100px 60px 20px 60px; border-radius: 4px; border:1px solid #C4C5C8; }
a:nth-child(1) {float:left;  border-bottom:1px solid black; font-size:14px;}
a:nth-child(2) {float:right; border-bottom:none; font-weight:bold; cursor:default}
a:focus{border:none; outline:none}

label{font-size:16px; width:26%; float:left; height:50px; line-height:50px;margin-top:10px; margin-bottom:10px}

input{padding:15px 12px}
button,input{height:50px; margin-top:10px; margin-bottom:10px; border:1px solid #C4C5C8; border-radius: 4px}
input:focus, button:focus {border:2px solid black; outline:none}
#email {width:45%; position:relative; left:5px}
#id, #name, #certnum {width:73%; float:right}
#sendcert{width:28%; float:right; color:white; background:black; opacity:0.9}
#sendcert:disabled {background:#AEAEAE; opacity:1}
#sendcert:hover{opacity:1}

button[type=submit]{margin-top:20px; width:100%; background:black; color:white; font-size:16px; opacity:0.9}
button[type=submit]:hover{opacity:1}
#formargin{margin-bottom:150px;}
</style>
</head>
<body>
<div>
<div>
  	<a href="findid.net">아이디 찾기</a>
  	<a href="findpass.net">비밀번호 찾기</a>
</div>

  <form action="findpassok.net" method="post">
	
	<label for="id">아이디</label>
    <input type="text" name="id" id="id">
	
    <label for="name">이름</label>
    <input type="text" name="name" id="name">
    
    <label for="email">이메일 주소</label>
    <input type="text" name="email" id="email">
    <button type="button" id="sendcert">인증번호 발송</button>
	
    <label for="certnum">인증번호</label>
    <input type="text" maxlength="6" name="certnum" id="certnum">
    
    <button type="submit">인증확인</button>
  </form>
  <div id="formargin"></div>
</div>
</body>
</html>