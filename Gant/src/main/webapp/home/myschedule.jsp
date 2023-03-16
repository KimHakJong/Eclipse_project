<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>GANT</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" 
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<link href="css/home.css" rel="stylesheet" type="text/css">

<!-- <script src="js/join.js"></script> -->
<script>

</script>
<style>
*{box-sizing:border-box; font-family:"noto sans", sans-serif;}

	 


/* button:disabled{background:#AEAEAE; border:none} */
/* button:enabled {opacity:0.8} */
/* button:enabled:hover{opacity:1} */


/*
button{background-color:black; color:white}

#menuOutline {
 	border: 1px solid gray;
    width: 70%;
    height: 95%;
    margin: 0 auto;
    margin-top: 20px;
    padding-top: 20px;
    padding-bottom: 20px;
 	
}

.mymenu > a {
	border: 1px solid black;
    border-radius: 0px 0px 12px 12px;
    background-color: black;
    color: white;
    padding: 7px;
    padding-bottom: 0px;
    margin-right: -3px;
    font-size: x-large;
    position: relative;
    left: -19px;
    top: -15px;
}

table {
	border: 1px solid black;
    width: 100%;
    height: 70px;
    text-align: center;
    font-size: x-large;
    border-collapse: collapse;
    margin-top: -21px;
}
td {
    border: 1px solid #444444;
    ad
    width : 14%;
  }
sup {
	color : #35e240;
    font-size: small;
}

*/
</style>
</head>
<body>

<script>
// 	$(function() {
// 		$(".mymenu > a").click(function() {
			
// 			$(this).attr("class", "change");
		
// 		})
		
		
// 		$(".good").click(function() {
			
// 		$(this).toggleClass("change");
		
// 		})
		
		
// 	})

</script>

<header>
	<jsp:include page="header.jsp"/>
</header>

<!-- 	현재 형태만 대략 잡아놓음 -->

	<div class="row">
	
		<div class="side" style="width:15%">
			<jsp:include page="left.jsp" />
		</div>
		
		<div class="main" style="width:85%; height:640px;">
			<div class="mymenu">
				<a href="update.home">개인정보 수정</a>
				<a href="schedule.home">개인 일정</a>
				<a href="myboard.home">게시판 활동</a>
			</div>
			
		  <div id="menuOutline">
		  	<div class="myweek">
		  		<div class="table">
		  			<table>
		  				<tr>
<!-- 		  					일정 있으면 초록색으로 점등 -->
<!-- 		  					<td>월<sup>●</sup></td> -->
		  					<td>월<sup>●</sup></td>
		  					<td>화<sup></sup></td>
		  					<td>수<sup></sup></td>
		  					<td>목<sup></sup></td>
		  					<td>금<sup></sup></td>
		  					<td>토<sup></sup></td>
		  					<td>일<sup></sup></td>
		  				</tr>
		  			</table>	
		  		</div>
		  		
		  		<div>
		  			<span>할일 표시</span>
		  		
		  		</div>
		  		
		  	
		  	</div>
		  	
		  
		  
		  </div> <!-- end menuOutline  -->
		</div> <!-- end main -->
	</div> <!-- end row -->

<footer>
	<jsp:include page="bottom.jsp"/>
</footer>

</body>
</html>