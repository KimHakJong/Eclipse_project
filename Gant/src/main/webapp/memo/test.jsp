<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.memolist{
	background-size: 100% 100%;
		width: 500px;
		height: 480px;
		position:fixed;
		z-index:2000;
		left: 320px;
  		top: 140px;
  		background:#F9E5A7
}
.memolist .btnClose {
    width: 10px;
    cursor: pointer;
    float: right;
    margin-right: 40px;
    font-size: 40px;
    color: black;
}
.btnClose + img {
    width: 40px;
    float: right;
    margin-right: 35px;
    margin-top: 12px;
    outline: none;
    height: 40px;
}
#memotitle{
	margin-top:22px; margin-left:35px;
	display:inline-block;
	font-size:19px;
	font-weight:bold
}
</style>
</head>
<body>
<div class="memolist">
	<span id="memotitle">메모장</span>
	<div class="btnClose">&times;</div>
	<img src="${pageContext.request.contextPath}/memo/image/deleteicon.png">
	
	<div class="postitlist">
		<img src="${pageContext.request.contextPath}/memo/image/postit.PNG" class="postits">
	</div>
</div>
</body>
</html>