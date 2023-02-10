<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>게시판 - 상세</title>
<link rel="stylesheet" href="board/board_css/view.css" type="text/css"> 
<link href="css/home.css" rel="stylesheet" type="text/css">
<%--<script src="js/view.js"></script>--%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
$(function(){
	 // 가져온 데이터로 글 css 적용
	$('#content').css('font-weight', ${boarddata.fontWeight}).css('font-size', "${boarddata.fontSize}").css('color', "${boarddata.fontColor}");
	
	 //모달 닫기 버튼 클릭시 이벤트
	$("#close_modal").click(function() {
        $("#myModal").modal("hide");
    });
	
});
</script>
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
		<input type="hidden" id="loginid" value="${id}" name="loginid"> <%-- view.js 에서 사용하기 위해 추가--%>
		<div class="container">
		  <table class="table">
		  <thead class="thead-dark">
		     <tr>
		        <th>공지/자유게시판</th>
		        <th id="date"><div id="board_date">${boarddata.board_date}</div></th>
		    </tr>
		    </thead>
		    <tr>
		       <td id="member">
		       <img src="memberupload/${profileimg}" id="memberfile" alt="memberfile">        
		       <div id="board_name">${boarddata.board_name}</div>
		       </td>
               <td></td>
	    </tr>
	    <tr>
	        <td><div>제목</div></td>
	        <td><c:out value="${boarddata.board_subject}"/></td>
	    </tr> 
	    <tr>
	        <td><div>내용</div></td>
	        <td style="padding-right: 0px">
	            <textarea class="form-control" 
	                      rows="5" id="content" readOnly>${boarddata.board_content}</textarea>
	        </td>
	    </tr>
	    
	    <c:if test="${boarddata.board_re_lev == 0}">
	    <%-- 원문글인 경우만 첨부파일을  추가 할 수 있습니다. --%>
	    <tr>
	       <td><div id="File">첨부파일</div></td>
	       <%-- 파일을 첨부한 경우 --%>
	        <c:if test="${!empty boarddata.board_file}">
	          <td id="Filename"><img src="board/board_image/download.png" width="20px">
	            <a href="BoardFileDown.bo?filename=${boarddata.board_file}">${boarddata.board_file}</a>
	           </td>
	        </c:if>
	       <%-- 파일을 첨부하지 않은경우 --%>
	        <c:if test="${empty boarddata.board_file}">  
	         <td></td>
	        </c:if>
	      </tr>
	    </c:if>
	    </table>
	     
	     <%-- 댓글 영역 --%>
	    <div class="comment-area">
				<div class="comment-head">
					<h3 class="comment-count">
						댓글 <sup id="count"></sup><%--superscript(윗첨자) --%>
					</h3>
					<div class="comment-order">
						<ul class="comment-order-list">
						</ul>
					</div>
				</div><%-- comment-head end--%>
				<ul class="comment-list">
				</ul>
				<div class="comment-write">
					<div class="comment-write-area">
						<b class="comment-write-area-name" >${id}</b> <span
							class="comment-write-area-count">0/200</span>
						<textarea placeholder="댓글을 남겨보세요" rows="1"
							class="comment-write-area-text" maxLength="200"></textarea>
						
					</div>
					<div class="register-box" >
						<div class="button btn-cancel" >취소</div><%-- 댓글의 취소는 display:none, 등록만 보이도록 합니다.--%>
						<div class="button btn-register" >등록</div>
					</div>
				</div><%--comment-write end--%>
			</div><%-- comment-area end--%>
			
			
			
		        <div id="button">
		           <c:if test="${boarddata.board_name == id || admin == 'true' }">
		             <a href="BoardModifyView.bo?num=${boarddata.board_num}">
		               <button class="btn btn-warning">수정</button>
		             </a>
		            <%-- href의 주소를 #으로 설정합니다. --%> 
		            <a href="BoardDeleteAction.bo?num=${boarddata.board_num}">
		               <button class="btn btn-danger" data-toggle="modal"
		               data-target="#myModal">삭제</button>
		            </a>
		          </c:if>
		         <a href="Main.bo">
		           <button class="btn btn-dark">목록</button>
		         </a>
		         <a href="BoardReplyView.bo?num=${boarddata.board_num}">
		           <button class="btn btn-dark">답변</button>
		         </a>
		      </div>
		</div> <%-- class="container" end --%>
	</div> <%-- class main end --%>
</div> <%-- class row end --%>

	<footer>
		<jsp:include page="../home/bottom.jsp" />
	</footer>
		
		
</body>
</html>