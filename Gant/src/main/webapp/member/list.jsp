<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link href="css/home.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>GANT</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Lato&display=swap');
*{box-sizing:border-box; font-family:"noto sans", sans-serif;}

aside{width:30%; height: 60%; display:inline-block;position:absolute; left:5%; top:20%;}

#searchdiv{ margin-bottom:70px; height:44px; position:relative; top:30px; float:right;
			vertical-align:middle;  }
#searchfield{height:40px; padding:0px 30px 0px 15px;
			 position:relative; left:7px; width:120px;
			 border:1px solid lightgray; background-color:white;
		-webkit-appearance:none; /* for chrome */
   		 -moz-appearance:none; /*for firefox*/
   		 appearance:none;
    		background:url('member/image/arrow.png') no-repeat 85% 50%/15px auto;
			}
option{background:white;}
#searchfield::-ms-expand{
   display:none;/*for IE10,11*/
}			
#searchword{height:40px; padding:0px 10px; width:300px;
			 position:relative; left:7px;
			 border:1px solid lightgray;
			 }
#searchfield:focus, #searchword:focus {border:2px solid black; outline:none }
#searchbtn{width:40px;height:40px; background:black; border:none; outline:none; margin:0; padding:0; position:relative; bottom:1px}
#searchicon{margin:0px 0px 3px 0px}
.list{width: 54.5%; position:absolute; right: 5%; top: 6%; display:inline-block}
.addbook{
    width: 100%; border-collapse: collapse; 
    border:1px solid lightgray; text-align:left; 
    margin-bottom:20px;
}
.addbook>thead>tr{border-bottom:2px solid lightgray}
.addbook>tbody>tr>td{border:1px solid lightgray; padding:10px 10px 10px 20px}
.addbook>thead>tr>th{border-right:1px solid lightgray; padding:10px 10px 10px 20px}
.addbook>thead>tr>th:nth-child(1){width:30%}
.addbook>thead>tr>th:nth-child(2){width:28%}
.addbook>thead>tr>th:nth-child(3){width:42%; border-right:none}

.addbook>thead>tr>th:nth-child(4){padding:0px; text-align:center;border-left:none}
.delete{outline:none; border:none; background:#dc3545; 
		color:white; font-weight:bold; 
		border-radius:4px}
.delete:hover{background:#BD2130}
.addbook>tbody>tr>td:nth-child(4){text-align:center;padding:5px 10px 5px 5px; border-left:none}
.addbook>tbody>tr>td:nth-child(3){border-right:none}

.addbook tr {height:50px}
.addbook>tbody>tr>td:first-child>img{width:17px; height:17px; margin-right:3px; position:relative; bottom:2px;}
.godetail{text-decoration:none;color:black}
.godetail:hover{color:black}
.godetail:focus{outline:none}
#detailForm{padding:20px 15px 0px 15px; height:400px}
.modal-body{height:425px}
#profileimg {width:100px; height:100px; float:left; border-radius:50%;
		 border:none;margin:0px 20px 20px 5px}
.infodiv {padding: 0px 5px 0px 5px; text-align:left; line-height:25px; height:25px}
#profileimg + div {width:400px; margin-top:13px}
b{margin:0px 10px 0px 5px;}
#profileimg + div + div{margin-top:5px}
hr{margin:10px;}
#line1,#line2 {width:300px; position:relative; left:120px}
#line1 + div > b:last-child{position:relative; left:190px}
#line2 + div {clear:both}
#name {margin-left:30px}
#department {margin-left:14px; margin-right:28px}
#position{margin-left:25px}
#birth{margin-left:30px}
#phone{margin-left:46px}
#email{margin-left:46px}
#address{margin-left:60px}
#close{height:50px; width:100px;display:block; 
	  font-weight:bold; margin:0 auto; opacity:0.8;
      border-radius:4px;height:50px; font-size:16px;
      background-color:#006CFF; color:white; border:none;
      outline:none; margin-top:23px}
#close:hover{opacity:1}
a.page-link{font-family: 'Lato', sans-serif}
.pagination{ margin-top:40px}
.page-link {border:none; color:#777777; margin:0px 12px 0px 12px; padding:0px; 
height:25px; font-size:16px}
.page-link:focus{box-shadow: none;}
.page-link:hover{background-color:white;color:#777777;}
.page-item.active .page-link {
    color: #000;
    background-color: white;
  	border-bottom:2px solid #000;
}
.first {margin:0px 12px 0px 0px;}
.back {margin:0px 22px 0px 0px;}
.next {margin:0px 0px 0px 22px;}
.last {margin:0px 0px 0px 12px;}
h1 {
  font-size: 2rem;
  text-align:center;
  margin-top:150px;
}
.noresult{width:600px; height:350px; margin-top:113px; border:1px solid lightgray}
</style>
<script>
$(document).ready(function(){
	let selval = '${searchfield}';
	if(selval != ""){
		$("#searchfield").val(selval);
	}else{
		selval=0; //선택된 필드X
	}
	
	$('.addbook>tbody>tr').each(function(index,item){
		let name = $(this).find('td:eq(0)').text(); //출퇴근 체크할 이름
		let department = $(this).find('td:eq(1)').text(); //출퇴근 체크할 부서명
		let phone_num = $(this).find('td:eq(2)').text(); //출퇴근 체크할 휴대폰
		ajax(name,department,phone_num, $(this).find('a'));
		
		function ajax(name, department, phone_num, where){
			
		  $.ajax({
			url : "list.net",
			data : { "name" : name, "department" : department,
				    "phone_num" : phone_num },
			dataType : "json",
			success : function(rdata){
				let check = rdata.check;
				if(check=="true"){
					where.before("<img src='member/image/greencircle.png' title='출근상태'>"); //where은 이미지삽입되는 뒤 형제요소
				}else{
					where.before("<img src='member/image/redcircle.png' title='퇴근상태'>");
				}
			}
		  });
		}
	});
	//모달
	$('.godetail').click(function(){
		let clickname = $(this).text();
		$.ajax({
			url : "detail.net",
			data : {"clickname" : clickname } ,
			dataType : "json",
			success : function(data){
				if(data.profileimg==null){
					$("#profileimg").attr('src','member/image/defaultprofile.png');
				}else{
					$("#profileimg").attr('src','memberupload/'+data.profileimg);
				}
				$("#name").text(data.name);
				$("#department").text(data.department);
				
				$("#position").text(data.position);
				$("#birth").text(data.birth);
				$("#phone").text(data.phone_num);
				$('#email').text(data.email);
				$("#address").text(data.address);
			}
			
		});
	});
	
	$('.delete').click(function(){
		let del = prompt("정말로 해당 회원을 삭제하려면\n'삭제' 를 입력하세요.");
		if(del=='삭제'){
			let name = $(this).parent().parent().find('.godetail').text();
			let department = $(this).parent().parent().find('td:eq(1)').text();
			let phone_num = $(this).parent().parent().find('td:eq(2)').text();
			location.href="delete.net?name="+ name+"&department="+department+"&phone_num="+phone_num;
		}
	});
});


</script>
</head>
<body>
	<header>
		<jsp:include page="../home/header.jsp" />
	</header>

	<div class="row">
		<div class="side" style="width:15%">
			<jsp:include page="../home/left.jsp" />
		</div>
		
		<div class="main" style="width:85%">
		
<aside>
<jsp:include page="orgchart.jsp"/>
</aside>

<div class="list">
<form action="list.net" method="post">

<div id="searchdiv">
<select id="searchfield" name="searchfield">
	<option value="name" selected>이름</option>
	<option value="department">부서명</option>
	<option value="phone_num">휴대폰</option>
</select>
<input type="text" name="searchword" id="searchword" value="${searchword}">
<button type="submit" id="searchbtn"><img id="searchicon" src="member/image/searchicon2.png"></button>
</div>
</form>

<c:if test="${membercount > 0}">
<table class="addbook">
	<thead>
		<tr>
			<th>이름</th>
			<th>부서명</th>
			<th>휴대폰</th>
			<c:if test="${isadminhuman=='true'}">
			  <th></th>
			</c:if>
		</tr>
	</thead>
	<tbody>
	   <c:forEach var="m" items="${memberlist}">
		<tr>
			<td><a class="godetail" data-toggle="modal" href="#detailmodal" data-backdrop="static">${m.name}</a></td>
			<td>${m.department}</td>
			<td>${m.phone_num}</td>
			<c:if test="${isadminhuman==true}">
			  <td><button class="delete" type="button">X</button></td>
			</c:if>
		</tr>
		</c:forEach>
	</tbody>
</table>

<%--모달 창 --%>
<div class="modal" id="detailmodal">
		<div class="modal-dialog">
		  <div class="modal-content">
		  	<%--Modal Body --%>
		  	<div class="modal-body">
		  		<form name="detailForm" id="detailForm">
		  		<img src="" id="profileimg">
		  		<div class="infodiv">
		  		<b>이름</b><span id="name"></span>
		  		</div><hr id="line1">
		  		
		  		<div class="infodiv">
		  		<b>부서명</b><span id="department"></span>
		  		<b>직급</b><span id="position"></span>
		  		</div><hr id="line2">
		  		
		  		<div class="infodiv">
		  		<b>생년월일</b><span id="birth"></span>
		  		</div><hr>
		  		
		  		<div class="infodiv">
		  		<b>휴대폰</b><span id="phone"></span>
		  		</div><hr>
		  		
		  		<div class="infodiv">
		  		<b>이메일</b><span id="email"></span>
		  		</div><hr>
		  		
		  		<div class="infodiv">
		  		<b>주소</b><span id="address"></span>
		  		</div><hr>
		  		
		  		<button type="button" id="close" data-dismiss="modal">창 닫기</button>
		  		</form>
		  	</div>
		  </div>
		</div>
	</div>
	<%--모달 끝 --%>
<div>
	<ul class="pagination justify-content-center">
	  <%-- 1페이지이전: 작동X, 안보임 --%>
	  <c:if test="${page<=1}">
	    <li class="paga-item" style="display:none">
	      <a class="page-link">&lt;&lt;&nbsp;</a>
	    </li>
	    <li class="paga-item" style="display:none">
	      <a class="page-link">&lt;&nbsp;</a>
	    </li>
	  </c:if>
	  
	  <%-- 1페이지이상: 이전버튼 누르면 page-1값, 검색필드, 검색어 list.net으로 보냈다 다시옴 --%>
	  <c:if test="${page>1}">
	    <c:url var="first" value="list.net">
	    	<c:param name="searchfield" value="${searchfield}"/>
	    	<c:param name="searchword" value="${searchword}"/>
	    	<c:param name="first" value="${1}"/>
	    </c:url>
	    
	   	<c:url var="back" value="list.net">
	        <c:param name="searchfield" value="${searchfield}"/>
	        <c:param name="searchword" value="${searchword}"/>
	        <c:param name="page" value="${page-1}"/>
	    </c:url>
	    <li class="paga-item">
	    	 <a href="${first}" class="page-link first">&lt;&lt;</a>&nbsp;
	    </li>
	    
	    <li class="paga-item">
	         <a href="${back}" class="page-link back">&lt;</a>&nbsp;
	    </li>
	  </c:if>
	  
	  <%-- 1번부터 끝번호까지 페이지번호 매김--%>
	  <c:forEach var="i" begin="${startpage}" end="${endpage}" step="1">
	    <%--현재 페이지는 색깔다르고, 이동없음 --%>
	    <c:if test="${i == page}">
	      <li class="page-item active">
	        <a class="page-link">${i}</a>
	      </li>
	    </c:if>
	    <%--다른 페이지는 누르면 검색필드,검색어,페이지들고 list.net갔다온다 --%>
	    <c:if test="${i != page}">
	      <c:url var="move" value="list.net">
	        <c:param name="searchfield" value="${searchfield}"/>
	        <c:param name="searchword" value="${searchword}"/>
	        <c:param name="page" value="${i}"/>
	      </c:url>
	      <li class="paga-item">
	        <a href="${move}" class="page-link">${i}</a>
	      </li> 
	      </c:if>
	  </c:forEach>
	    
	    <%--현재 페이지가 최대페이지거나 이상 : 작동X, 안보임 --%>  
	    <c:if test="${page >= maxpage}">
	      <li class="page-item" style="display:none">
	      	<a class="page-link">&nbsp;&gt;</a>
	      </li>
	      <li class="page-item" style="display:none">
	      	<a class="page-link">&nbsp;&gt;</a>
	      </li>
	    </c:if>
	    
	    <%--최대페이지미만: 다음 버튼누르면 page+1값, 검색필드, 검색어 들고 list.net 갔다옴 --%>
	    <c:if test="${page < maxpage}">
	      <c:url var="last" value="list.net">
	      	<c:param name="searchfield" value="${searchfield}"/>
	      	<c:param name="searchword" value="${searchword}"/>
	      	<c:param name="page" value="${maxpage}"/>
	      </c:url>
	      
	      <c:url var="next" value="list.net">
	        <c:param name="searchfield" value="${searchfield}"/>
	        <c:param name="searchword" value="${searchword}"/>
	        <c:param name="page" value="${page+1}"/>
	      </c:url>
	      <li class="page-item">
	        <a href="${next}" class="page-link next">&nbsp;&gt;</a>
	      </li>
	      <li class="page-item">
	        <a href="${last}" class="page-link last">&nbsp;&gt;&gt;</a>
	      </li>
	    </c:if> <%--회원있는경우 끝 --%>
	   </ul>
    </div>
    </c:if>
    
    <c:if test="${membercount==0 && empty searchword}">
    <div class="noresult">
      <h1>회원이 존재하지 않습니다.</h1>
    </div>
    </c:if>
    
    <c:if test="${membercount==0 && !empty searchword}">
	<div class="noresult">
      <h1>검색된 회원은 존재하지 않습니다.</h1>
	</div>
    </c:if>  
	</div><%--list end --%>
  </div><%--main --%>
  </div><%--row --%>

	<footer>
		<jsp:include page="../home/bottom.jsp" />
	</footer>
</body>
</html>