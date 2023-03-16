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

<script>

</script>
<style>
*{box-sizing:border-box; font-family:"noto sans", sans-serif;}
button{background-color:black; color:white}
#del{
	background-color:orange; color:black;
	border : 1px solid orange;
	border-radius : 12px;
	cursor: pointer;
}

#menuOutline {
 	
    width: 70%;
    height: 95%;
    margin: 0 auto;
    margin-top: 20px;
    padding-top: 20px;
    padding-bottom: 20px;
 	
}

.mymenu > a {
	
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


.col-sm-3, .col-sm-8 {
	
	height: 640px;
    margin-top: -21px;
}
.col-sm-3 {
    border-left: none;
    border-top: none;
    margin-top: -21px;
}
.col-sm-8 {
    border : none;
}

aside > ul {
	margin-top: 25px;
}
aside > ul > li {
	margin-top: 10px;
    font-size: 18px;
    cursor: pointer;
}
#lcount {
color : red;
}

table {
/* 	border: 1px solid black; */
    width: 100%;
    height: 70px;
    font-size: x-large;
    border-collapse: collapse;
    margin-top: 21px;
    margin-left: 40px;    
}
thead > tr:nth-child(1) > th {
	text-align: left;
	font-size: 17px;
    font-weight: 540;
}
thead > tr:nth-child(2) > th:nth-child(3),th:nth-child(4),th:nth-child(5) {
	text-align: center;
}
tbody > tr > td:nth-child(1),td:nth-child(3),td:nth-child(4),td:nth-child(5),td:nth-child(6) {
	text-align: center;
}

.pagination{
	font-family: 'Lato', sans-serif; 
	top: 520px;
    left: 500px;
    position: absolute;
  }

.page-link {border:none; color:#777777; margin:0px 12px 0px 12px; padding:0px; 
height:25px; font-size:16px}
.page-link:focus{box-shadow: none;}
.page-link:hover{background-color:white;color:#777777;}
.page-item.active .page-link {
    color: #000;
    background-color: white;
     
}
.main{
		border-color: white !important;
}

</style>
<script>
	
	// 자기 글이니깐 비밀번호가 설정되어 있더라도 바로 삭제?? 
			//=> 비번 입력시에는 비번도 가지고 와서 글번호와 비번 넘기기
			
	// 아니면 비밀번호 입력?? 
			//=> 바로 삭제시에는 글번호만 넘기기

	// 아니면 비밀번호 존재 유무를 확인해서 
		// 있으면 비밀번호 입력 요구
		// 없으면 바로 삭제
			
			
	$(function() {
		$('#del').click(function() {
			alert('정말 삭제하시겠습니까?');
	
		})		

	})

</script>


</head>
<body>

<jsp:include page="../home/side.jsp" />

<div class="content">
<jsp:include page="../home/header2.jsp" />
<div class="container-fluid pt-4 px-4">


	<div class="row">

		
		<div class="main" style="width:85%; height:640px;">
			<div class="mymenu">
				<a href="update.home">개인정보 수정</a>
				<a href="myboard.home">게시판 활동</a>
			</div>
			
		  <div id="menuOutline">
			  <div class="row">
					<div class="col-sm-3">
						<aside>
							<ul>
								<li><a href="myboard.home">내가 쓴 게시글 보기</a></li>
								<li><a href="myreply.home">내가 쓴 댓글 보기</a></li>
							</ul>
						</aside>
					</div>		
					
					<div class="col-sm-8">
	<c:if test="${commentcount > 0}">
			<table>
				<thead>
				  <tr>
				    <th colspan="2"><div>총 작성한 댓글 : <span id="lcount">${commentcount}</span> 개</div></th>
				  </tr>
				  <tr>
				  	<th><div></div></th>
				  	<th><div style="margin: 8px;">내용</div></th>
				  	<th><div>관련 글</div></th>
				  </tr>
				</thead>
				<tbody>
				  <c:set var="num" value="${commentcount-(page-1) * limit }"/>
					<c:forEach var="b" items="${commentlist }">
						<tr>
						  <td>
						    <c:out value="${num }."/>
						    <c:set var="num" value="${num-1 }"/>
						  </td>
						  
						  <td><div>${b.content} </div></td>  
						  
						  <td>
						    <div>
<!-- 						    	원문글을 제외한 -->
<!-- 									답글경우 들여쓰기 하여 표시하기 위한 설정 -->
						      <c:if test="${b.comment_re_lev != 0 }">
						      
						        <c:if test="${b.comment_re_lev == 1 }">
<!-- 						        	재댓글*&nbsp; -->
						        </c:if>
						        <c:if test="${b.comment_re_lev == 2 }">
<!-- 						        	재재댓글*&nbsp; -->
						        </c:if>
						        
						      </c:if>
						      
						      <c:if test="${b.comment_re_lev == 0 }">
<!-- 						        댓글*&nbsp; -->
						      </c:if>
						      
						      <a href="BoardDetailAction.bo?num=${b.num }">
						        <c:if test="${b.subject.length() >= 25 }">
						        	<c:out value="${b.subject.substring(0,25)}..."/>
						        </c:if>
						        <c:if test="${b.subject.length() < 25}">
						        	<c:out value="${b.subject}"/>
						        </c:if>
<!-- 						         해당 게시글에 달른 댓글 갯수 -->
						      </a> 
						     </div>
						   </td>
						   
						   
						   <td><div>${b.reg_date}</div></td>
						     
						   <td><%-- <div id="del">삭제</div> --%></td>  
						</tr>
					</c:forEach>
				</tbody>  
			</table>
			
			
			
			
			
<!-- 			페이징 처리 하는 부분 -->
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
			  
			  <%-- 1페이지보다 크면: 이전버튼 누르면 page값 ,Main.bo으로 보냄 --%>
			  <c:if test="${page>1}">
			    <c:url var="first" value="myboard.home">
			    	<c:param name="page" value="${1}"/>
			    </c:url>
			    
			   	<c:url var="back" value="myboard.home">
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
			    
			    <%--다른 페이지는 누르면 검색필드,검색어,페이지들고 Main.bo갔다온다 --%>
			    <c:if test="${i != page}">
			      <c:url var="move" value="myboard.home">
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
			    
				    <%--최대페이지미만: 다음 버튼누르면 page+1값, 검색필드, 검색어 들고 Main.bo 갔다옴 --%>
				    <c:if test="${page < maxpage}">
				      <c:url var="last" value="myboard.home">
				      	<c:param name="page" value="${maxpage}"/>
				      </c:url>
				      
				      <c:url var="next" value="myboard.home">
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
				
		<c:if test="${listcount ==0}">
			<h3 style="text-align:center">등록된 글이 없습니다.</h3>			
		</c:if>
							
				</div>
			</div>
	  
	  </div> <!-- end menuOutline  -->
	</div> <!-- end main -->
</div> <!-- end row -->
</div>
</div>

<footer>
	<jsp:include page="bottom.jsp"/>
</footer>

</body>
</html>