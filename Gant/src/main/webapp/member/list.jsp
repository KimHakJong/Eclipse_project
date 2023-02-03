<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<meta charset="UTF-8">
<title>GANT</title>
<style>
body>div{width:600px}
</style>
<script>
$(document).ready(function(){
	let selval = '${searchfield}';
	if(selval != ""){
		$("#searchfield").val(selval);
	}else{
		selval=0; //선택된 필드X
	}
});
</script>
</head>
<body>
<div>
<form action="list.net" method="post">

<select id="searchfield" name="searchfield">
	<option value="name" selected>이름</option>
	<option value="department">부서명</option>
	<option value="phone_num">휴대폰 번호</option>
</select>
<input type="text" name="searchword" id="searchword" value="${searchword}">
<button type="submit">검색</button>

</form>

<c:if test="${membercount > 0}">
<table class="table table-bordered">
	<thead>
		<tr>
			<th>이름</th>
			<th>부서명</th>
			<th>휴대폰 번호</th>
		</tr>
	</thead>
	<tbody>
	   <c:forEach var="m" items="${memberlist}">
		<tr>
			<td><a href="memberInfo.net?id=${m.name}">${m.name}</a></td>
			<td>${m.department}</td>
			<td>${m.phone_num}</td>
		</tr>
		</c:forEach>
	</tbody>
</table>

<div>
	<ul class="pagination justify-content-center">
	  <%-- 1페이지이전: 이전버튼 눌러도 작동X --%>
	  <c:if test="${page<=1}">
	    <li class="paga-item">
	      <a class="page-link gray">이전&nbsp;</a>
	    </li>
	  </c:if>
	  
	  <%-- 1페이지이상: 이전버튼 누르면 page-1값, 검색필드, 검색어 list.net으로 보냈다 다시옴 --%>
	  <c:if test="${page>1}">
	   	<c:url var="back" value="list.net">
	        <c:param name="searchfield" value="${searchfield}"/>
	        <c:param name="searchword" value="${searchword}"/>
	        <c:param name="page" value="${page-1}"/>
	    </c:url>
	    <li class="paga-item">
	         <a href="${back}" class="page-link">이전</a>&nbsp;
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
	    
	    <%--현재 페이지가 최대페이지거나 이상 : 작동X --%>  
	    <c:if test="${page >= maxpage}">
	      <li class="page-item">
	      	<a class="page-link gray">&nbsp;다음</a>
	      </li>
	    </c:if>
	    
	    <%--최대페이지미만: 다음 버튼누르면 page+1값, 검색필드, 검색어 들고 list.net 갔다옴 --%>
	    <c:if test="${page < maxpage}">
	      <c:url var="next" value="list.net">
	        <c:param name="searchfield" value="${searchfield}"/>
	        <c:param name="searchword" value="${searchword}"/>
	        <c:param name="page" value="${page+1}"/>
	      </c:url>
	      <li class="page-item">
	        <a href="${next}" class="page-link">&nbsp;다음</a>
	      </li>
	    </c:if> <%--회원있는경우 끝 --%>
	   </ul>
    </div>
    </c:if>
    
    <c:if test="${membercount==0 && empty searchword}">
      <h1>회원이 존재하지 않습니다.</h1>
    </c:if>
    
    <c:if test="${membercount==0 && !empty searchword}">
      <h1>검색된 회원은 존재하지 않습니다.</h1>
    </c:if>  
 </div>   
</body>
</html>