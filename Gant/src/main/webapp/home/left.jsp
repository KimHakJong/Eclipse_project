<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ include file="../memo/memo.jsp" %>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous"> -->
<!-- 	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>  -->
<!-- 	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>  -->
	   <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<!-- <script src="http://code.jquery.com/jquery-latest.js"></script> -->
<style>
* { 
 box-sizing: border-box;
 }

body {
  font-family: "Lato", sans-serif;
}

.my {text-align:center}

#profile {
	position: relative;
	width:80px; height:80px; border-radius:50%;
	margin:0px 35px;
}

/* 여기부터 회원정보(이름, 직책)관련 css */
.dropbtn {
  background-color: white;
  color: black;
  padding: 16px;
  font-size: 18px;
  border: none;
}

.dropup {
  position: relative;
  display: inline-block;
}

.dropup-content {
  display: none;
  position: absolute;
  background-color: black;
  min-width: 160px;
  bottom: 50px;
  z-index: 1;
  border-radius: 12px;
  
}

.dropup-content a {
  color: white;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropup-content a:hover {
	background-color: white;
	color : black;
	border : 1px solid black;
	border-radius: 12px;
	}

.dropup:hover .dropup-content {display: block;}

.dropup:hover .dropbtn { background-color: white;}



/* 여기부터 바로가기 버튼 관련 css*/
.sidepanel  {
  width: 0;
    position: relative;
    z-index: 1;
    /* height: 150px; */
    left: 0;
    background-color: white;
    color: black;
    overflow-x: hidden;
    transition: 0.5s;
    padding-top: 60px;
    border-radius: 40px;
    /* border : 1px solid green; */
    bottom: 0;
    opacity: 0.8;
    top: -20%;
    left: 53%;
}

/* 바로가기 표시되는 중에 스크롤바 표시X */
#mySidepanel::-webkit-scrollbar {
    display: none;
}

.sidepanel a {
  padding: 8px 8px 8px 32px;
  text-decoration: none;
  font-size: 25px;
  color: black;
  display: block;
  transition: 0.3s;
}

.sidepanel a:hover {
  color: black;
  font-weight:bold
}

.sidepanel .closebtn {
    position: absolute;
    top: -10px;
    color: black;
    left: 65px;
    font-size: 30px;
}
.closebtn:focus {
	outline:none
}

.sidepanel {right:-30px}
.openbtn {
  font-size: 20px;
  cursor: pointer;
  background-color: white;
  color: white;
  padding: 7px 15px;
  border-radius:12px;
  border:1px solid lightgray;
  position: relative;
  bottom: 4.5%;
  left: 10px;
  box-shadow: 3px 3px 4px grey
}

.openbtn:hover {
  background-color:white;
  border: solid 2px black;
  border-radius:12px;
}
.openbtn:focus {
  outline:none;
}
/* 메뉴 전체 테두리 */
.left {
	width : 100%;
  
  padding: 10px 0;
}


/* 검색 박스*/
#mySearch {
  	position: relative;
    top: -10px;
    left: 14px;
    width: 95%;
    font-size: 17px;
    padding: 11px;
    border: 3px solid black;
    background: white;
    border-radius: 12px;
}
#mySearch:focus {
	outline:none
}
/* 메뉴 검색 아이콘 : #searchicon은 주소록에 있음*/
#menusearchicon {
  width: 25px;
  height: 25px;
  position: relative;
  top: -50px;
  left: 85%;
}
/*메뉴안의 글자크기*/
#myMenu {
  list-style-type: none;
  padding: 10px;
  margin: 0;
}
/*메뉴안의 글자*/
#myMenu li a {
  	padding: 12px;
    text-decoration: none;
    color: black;
    font-size: 20px;
    font-weight: 800;
    display: block;
    position: relative;
    top: -10px;
    text-align: center;
    background-color: white;
    border-radius: 12px;
}
#myMenu li a {
	outline:none;
}
#myMenu li {
  border-color: #006CFF;
	color: dodgerblue;
	margin-left: 0px;
}

.left li {
    margin: 13px -15px;
    opacity : 0.8;
}

#myMenu li a:hover {
  background-color: black;
  border: 3px solid black;
  color: white;
  border-radius: 12px;
}

#myMenu li .active{background:black; color:white; border:2px solid black}
#mySidepanel a {
    width: 140px;
    
}
#mySidepanel a:focus{
	outline:none
}

#mySidepanel > a:nth-child(2){
height: 50px;
    position: absolute;
    top: 30px;
    color: black;
}


#mySidepanel > a:nth-child(3){
height: 50px;
    position: absolute;
    top: 70px;
    color: black;

}
</style>


<script>
   
	//바로가기 버튼 부분
	function openNav() {
	  document.getElementById("mySidepanel").style.width = "140px";
	  document.getElementById("mySidepanel").style.height = "150px";
	  document.getElementById("mySidepanel").style["border"]="1px solid black";
	}
	
	function closeNav() {
	  document.getElementById("mySidepanel").style.width = "0";
	  document.getElementById("mySidepanel").style["border"]="none";
	}
	
	//메뉴 검색창 부분
	function myFunction() {
	  var input, filter, ul, li, a, i;
	  input = document.getElementById("mySearch");
	  filter = input.value.toUpperCase();
	  ul = document.getElementById("myMenu");
	  li = ul.getElementsByTagName("li");
	  for (i = 0; i < li.length; i++) {
	    a = li[i].getElementsByTagName("a")[0];
	    if (a.innerHTML.toUpperCase().indexOf(filter) > -1) {
	      li[i].style.display = "";
	    } else {
	      li[i].style.display = "none";
	    }
	  }
	}
	
$(document).ready(function(){
	console.log($(".memo"));
	$( ".memo" ).draggable();
	//현재 프로젝트명 뒤 경로
	let page = window.location.pathname.substring(6);
	//메뉴 클릭하면 해당 메뉴에 active 클래스를 생성하여 다른 색으로 칠해지기 위한 코드입니다.
	const pagename = ["Main.att", "Main.bo", "main.calendar","list.net"];
	for(var i=0; i<pagename.length; i++){
		if(page==pagename[i]){
			$("#myMenu > li:eq("+i+")").find('a').addClass('active');
		}else{
			$("#myMenu > li:eq("+i+")").find('a').removeClass('active');
		}
	}
	
		$('.mySidepanel>a:eq(1)').click(function(){
			var win;
			if(win){
				win.close();
				win = window.open('chat.sml', 'chat', 'width=500, height=450, top=170px, left=230px, resizable=no,menubar=no,status=no,titlebar=no,toolbar=no, scrollbars=no,directories=no,location=no');
			}
		});
		 
});
</script>

</head>    
    
<!-- 	전체적으로 링크 아직 안걸어놓음 -->
	
	<div class="my">
		<a href="#">
			<c:if test="${empty profileimg}">
	    		<img src="member/image/defaultprofile.png" alt="profile" id="profile">
	    	</c:if>
	    	<c:if test="${!empty profileimg}">
	    		<img src="memberupload/${profileimg}" alt="profile" id="profile">
	    	</c:if>
	   	</a>
	   	
		<div class="dropup">
		  <button class="dropbtn">${id} 님 ▲</button>
			  <div class="dropup-content">
			    <a href="update.home">마이페이지</a>
			    <a href="logout.net">로그아웃</a>
			  </div>
		</div>
	   	
	</div>
	<br>
    
    <div class="left">
	    <input type="text" id="mySearch" onkeyup="myFunction()" placeholder="메뉴를 검색하세요"><img id="menusearchicon" src="image/searchmain.png">
	    <ul id="myMenu">
	      <li><a href="Main.att ">근태관리</a></li>
	      <li><a href="Main.bo">공지/자유게시판</a></li>
	      <li><a href="main.calendar">캘린더</a></li>
	      <li><a href="list.net">주소록</a></li>
	    </ul>
	  </div>
   
    <button class="openbtn" onclick="openNav()"><img style="width:50px;height:40px" src="image/tap.png"></button>
    <div id="mySidepanel" class="sidepanel">
	  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>
	  <a href="chat.sml" 
	  onClick="window.open('chat.sml', 'chat', 'width=500, height=450, top=170px, left=230px, resizable=no,menubar=no,status=no,titlebar=no,toolbar=no, scrollbars=no,directories=no,location=no'); return false;">
	  채팅</a>
	  <a id="openmemo" href="javascript:void(0)">메모장</a>
	</div>
	
	<div></div>
	<div></div>

    
    
    
    
    
    
    
    
    
    
    