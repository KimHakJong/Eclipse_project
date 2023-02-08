<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
<link href="css/home.css" rel="stylesheet" type="text/css">
<link href="board/board_css/main_bo.css" rel="stylesheet" type="text/css">
<script>

</script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Lato&display=swap');
.pagination{font-family: 'Lato', sans-serif; margin-top:40px}
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

select.form-control{
width: auto;
margin-bottom: 2em;
display: inline-block;
}

.rows{
text-align: right;
}

.gray {
 color: gray;
}

body > div > table > thead > tr:nth-child(2) > th:nth-child(1){width:8%}
body > div > table > thead > tr:nth-child(2) > th:nth-child(2){width:47%}
body > div > table > thead > tr:nth-child(2) > th:nth-child(3){width:13%}
body > div > table > thead > tr:nth-child(2) > th:nth-child(4){width:14%}
body > div > table > thead > tr:nth-child(2) > th:nth-child(5){width:9%}
body > div > table > thead > tr:nth-child(2) > th:nth-child(6){width:9%}



</style>

<%--<script src="js/list.js"></script> --%>
<title>자유/공지 게시판</title>
</head>
<body>

	<header>
		<jsp:include page="../home/header.jsp" />
	</header>

	<div class="row">
		<div class="side" >
			<jsp:include page="../home/left.jsp" />
		</div>
		
		<div class="main">
			<div class="container">
 
<%-- 게시글이 있는경우 --%>
<c:if test="${listcount > 0 }">
 <table class="table">
  <thead class="thead-dark">
    <tr>
     <th colspan="4">공지/자유 게시판</th>
     <th colspan="2">
       <span>글 개수 : ${listcount}</span>
     </th>
   </tr>
   <tr>
     <th><div>번호</div></th>
     <th><div>제목</div></th>    
     <th><div>작성자</div></th>  
     <th><div>작성일</div></th>  
     <th><div>조회수</div></th>
     <th><div>추천</div></th>  
   </tr>
   </thead>
   <tbody>
    <%-- num은 번호를 나타낸다. 총갯수부터 글이 내려갈수록 1씩 내려간다. --%>
    <c:set var="num" value="${listcount-(page-1)*limit}" />
    
    <%-- 1페이지일때 공지사항인 게시글 이 먼저 올라간다. --%>  
    <c:if test="${page==1}">  
    <c:forEach var="b" items="${boardNoticelist}">
			   <tr>
		       <td><%-- 번호 --%>
		         <c:out value="${'[공지]'}" /> <%-- num 출력 --%>
		         <c:set var="num" value="${num-1}" /> <%-- num = num-1 의미 --%>
		       </td>
		       <td><%--제목 --%>
		        <div>
		          <%-- 답변글 제목 앞에 여백처리부분 --%>
		         <c:if test="${b.board_re_lev != 0}"> <%-- 답글인경우 --%>
			           <c:forEach var="a" begin="0" end="${b.board_re_lev*2}" step="1">
			           &nbsp;
			           </c:forEach>
		           <img src="board/board_image/arrow.png"> 
		         </c:if>
		         
		         <c:if test="${b.board_re_lev == 0}"><%-- 원문인경우 --%>
		         &nbsp;
		         </c:if>
		         
		         <a href="BoardDetailAction.bo?num=${b.board_num}">
		           <c:if test="${b.board_subject.length()>= 18}">
		            <c:out value="${b.board_subject.substring(0,18)}..." />
		          </c:if>
		          <c:if test="${b.board_subject.length() < 18}">
		            <c:out value="${b.board_subject}" />
		          </c:if>
		         </a>[${b.cnt}]
		        </div>  
		       </td>
		       <td><div>${b.board_name}</div></td>
		       <td><div>${b.board_date}</div></td>
		       <td><div>${b.board_readcount}</div></td>
		       <td><div>${b.board_like}</div></td>
		      </tr>
		    
	  </c:forEach> 
	 </c:if> 
	   <%-- 공지사항인 게시글 끝 --%>
	   
	   <%-- 일반게시물 --%>
	   <c:forEach var="b" items="${boardlist}">    
			      
		      <tr>
		       <td><%-- 번호 --%>
		         <c:out value="${num}" /> <%-- num 출력 --%>
		         <c:set var="num" value="${num-1}" /> <%-- num = num-1 의미 --%>
		       </td>
		       <td><%--제목 --%>
		        <div>
		          <%-- 답변글 제목 앞에 여백처리부분 --%>
		         <c:if test="${b.board_re_lev != 0}"> <%-- 답글인경우 --%>
			           <c:forEach var="a" begin="0" end="${b.board_re_lev*2}" step="1">
			           &nbsp;
			           </c:forEach>
		           <img src="board/board_image/arrow.png"> 
		         </c:if>
		         
		         <c:if test="${b.board_re_lev == 0}"><%-- 원문인경우 --%>
		         &nbsp;
		         </c:if>
		         
		         <a href="BoardDetailAction.bo?num=${b.board_num}">
		           <c:if test="${b.board_subject.length()>= 18}">
		            <c:out value="${b.board_subject.substring(0,18)}..." />
		          </c:if>
		          <c:if test="${b.board_subject.length() < 18}">
		            <c:out value="${b.board_subject}" />
		          </c:if>
		         </a>[${b.cnt}]
		        </div>  
		       </td>
		       <td><div>${b.board_name}</div></td>
		       <td><div>${b.board_date}</div></td>
		       <td><div>${b.board_readcount}</div></td>
		       <td><div>${b.board_like}</div></td>
		      </tr>
    </c:forEach>
    <%-- 일반게시물  끝--%>
   </tbody>  
 </table>
 
 <%--테이블 끝 --%>
 
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
	    <c:url var="first" value="Main.bo">
	    	<c:param name="page" value="${1}"/>
	    </c:url>
	    
	   	<c:url var="back" value="Main.bo">
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
	      <c:url var="move" value="Main.bo">
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
		      <c:url var="last" value="Main.bo">
		      	<c:param name="page" value="${maxpage}"/>
		      </c:url>
		      
		      <c:url var="next" value="Main.bo">
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
</c:if> <%--  <c:if test="${listcount > 0}"> end --%>

<%-- 게시글이 없는경우 --%>
<c:if test="${listcount == 0}">
 <h3 style="text-align: center">등록된 글이 없습니다.</h3>
</c:if> 

<button type="button" class="btn btn-dark float-right">글쓰기</button>
</div>

		</div> <%-- class main end --%>
	</div> <%-- class row end --%>

	<footer>
		<jsp:include page="../home/bottom.jsp" />
	</footer>




</body>
</html>