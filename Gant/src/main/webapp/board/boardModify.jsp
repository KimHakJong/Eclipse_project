<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link href="css/home.css" rel="stylesheet" type="text/css">
<link href="board/board_css/modify.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>


<script>
$(document).ready(function(){
	
	 // 비밀번호 체크박스 클릭시
	 $("#passwordbox").change(function(){
	        if($("#passwordbox").is(":checked")){ // 체크박스 체크했을때 readonly제거
	        	$("#board_pass").removeAttr('readonly');
	        
	        }else{// 체크박스 헤제했을때 readonly 생성
	        	$("#board_pass").attr('readonly','readonly');
	        	$("#board_pass").val("");
	        }
	    }); 

        
	// 공지사항 체크박스 클릭시
	 $("#noticebox").change(function(){
	        if($("#noticebox").is(":checked")){ // 체크박스 체크했을때 val = true
	        	$("#noticebox").attr('value','true');
	            console.log($("#noticebox").val());
	        }else{// 체크박스 체크했을때 readonly 생성
	        	$("#noticebox").attr('value','false');
	           console.log($("#noticebox").val());
	        }
	    }); 
	
	     //파일 업로드 
		$("#myFileUp").change(function(){
			        readURL(this);		
			    });
		
		
		//readURL 함수
		 function readURL(input) {

		        if (input.files && input.files[0]) {
		        let reader = new FileReader();
		        reader.onload = function (e) {
		                $('#cover').attr('src', e.target.result);        //cover src로 붙여지고
		                $('#fileName').val(input.files[0].name);    //파일선택 form으로 파일명이 들어온다
		            }
	          reader.readAsDataURL(input.files[0]);
		        }
		    }

     //글 내용 기본 css
     $('#board_content').css({"font-size": "15px" , "font-weight": "400"});
		
	//내용 글자색 선택시
	$("#fontColor").change(function(){
		$('#board_content').css('color' , $(this).val() );	      	
	});
	
	//내용 글자 크기 선택시
	$("#fontSize").change(function(){
		$('#board_content').css('font-size',$(this).val());	
    });
	
	//내용 글자 굵기 선택시
	$("#fontWeight").change(function(){
		$('#board_content').css('font-weight', $(this).val());			
    });
	
	// 취소버튼 클릭시
	$("#cancel").click(function(){
		history.back(-1);			
    });
	
	// 등록 클릭시 이벤트
	$("#submit").click(function(){
		
	
		// 비밀글 설정이 체크되어있을때만 실행
    	if($("#passwordbox").is(":checked")){ 
    		//비밀번호 공백 검사
    		if($.trim($("#board_pass").val()) == ""){
        		alert('비밀번호를 입력하세요');
        		$("#board_pass").focus();
    			return false;}
    		
    		// 비밀번호 유효성검사
    		if($.trim($("#board_pass").val()).length <= 1){
        		alert('비밀번호를 2자리 이상 입력하세요');
        		$("#board_pass").val("").focus();
    			return false;}
    		
        } // if($("#passwordbox").is(":checked")) end
		
    	//제목 공백 검사
    	if($.trim($("#board_subject").val()) == ""){
    		alert('제목을 입력하세요');
    		$("#board_subject").focus();
			return false;
    	}
    	//내용 공백 검사
    	if($.trim($("#board_content").val()) == ""){
    		alert('글을 입력하세요.');
    		$("#board_content").focus();
			return false;
    	}
    	
	  });//$("#submit").click end
	  
	  // 가져온 데이터로 글 css 적용
		$('#board_content').css('font-weight', ${boarddata.fontWeight}).css('font-size', "${boarddata.fontSize}").css('color', "${boarddata.fontColor}");
		
	  
	  //저장되어있던 폰트 사이즈와 폰트 두께를 지정하여 준다.
	  $("#${boarddata.fontSize}").attr('selected',"selected");
	  $("#${boarddata.fontWeight}").attr('selected',"selected")
	  
	  //저장되어있던 board_notice값이 true이면 공지 게시글이기 때문에 공지체크 표시에 체크하여준다.
	 if(${boarddata.board_notice}){
		$("#noticebox").attr("checked","checked");
		$("#noticebox").attr('value','true');
	 }
	  
	  
});

</script>
</head>
<body>

	<jsp:include page="../home/side.jsp" />

	<div class="content">
	<jsp:include page="../home/header2.jsp" />
	<div class="container-fluid pt-4 px-4"> 
	
         <div class="container" id="container">
		  <form action="BoardModifyAction.bo" method="post" enctype="multipart/form-data" name="boardform">
		   
		   <input type="hidden" name="num" value="${boarddata.board_num}">
		   
		   <div class="form-group">     
		      <label for="board_name">글쓴이</label>
		      <input name="board_name" id="board_name" value="${id}" readonly
		       type="text" class="form-control" placeholder="Enter board_name">
		
		   </div>
		   
		   <div class="form-group">
		      <label for="board_pass">비밀글 설정&nbsp;&nbsp;<input type="checkbox" id="passwordbox" checked="checked" ></label>
		      <c:if test="${boarddata.board_pass == '1'}">
		      <input name="board_pass" id="board_pass"  type="password" maxlength="30" 
		      class="form-control" placeholder="Enter board_pass">
		      </c:if>
		      <c:if test="${boarddata.board_pass != '1'}">
		      <input name="board_pass" id="board_pass"  type="password" maxlength="30" 
		      class="form-control" placeholder="Enter board_pass" value="${boarddata.board_pass}">
		      </c:if>
		   </div>
		   
		  <c:if test="${boarddata.board_re_lev == 0}"><%-- 원문인경우에만  파일첨부가 가능하기 때문에 원문일경우에만 보이게 한다.--%>
		  <div class="form-group">
		    <label id="filelabel">파일첨부</label> 
		         <input id="fileName" class="fileName" value="${boarddata.board_file}" disabled="disabled" placeholder="파일선택">
			   <div class="fileRegiBtn">
				 <label for="myFileUp" id="FileUp">파일등록하기</label>
				 <input type="file" id="myFileUp" name="board_file" >
		       </div>
		  </div>
		  </c:if>

		   <div class="form-group">
		      <label for="board_subject">제목</label>
		      <input name="board_subject" id="board_subject"  type="text" maxlength="100" 
		      class="form-control" placeholder="Enter board_subject" value="${boarddata.board_subject}">
		   </div>
		   
		   <div class="form-group">
		      <label for="board_content">내용</label>
		      
		      <div class="board_style">
		      글자 색 : <input type="color" name="fontColor" id="fontColor" value="${boarddata.fontColor}"> &nbsp;&nbsp;
		      글자 크기 :&nbsp;<select name='fontSize' id="fontSize">
				  <option value='10px' id='10px'>10px</option>
				  <option value='15px' id='15px'>15px</option>
				  <option value='20px' id='20px'>20px</option>
				  <option value='25px' id='25px'>25px</option>
				  <option value='30px' id='30px'>30px</option>
				  <option value='35px' id='35px'>35px</option>
				  <option value='40px' id='40px'>40px</option>
				  <option value='45px' id='45px'>45px</option>
				  <option value='50px' id='50px'>50px</option>
				  <option value='55px' id='55px'>55px</option>
				  <option value='60px' id='60px'>60px</option>
			  </select>
			  &nbsp;&nbsp;글자 굵기 :&nbsp;<select name='fontWeight' id="fontWeight">
				  <option value=200 id='200'>얇은</option>
				  <option value=400 id='400'>보통</option>
				  <option value=700 id='700'>굵은</option>
				  <option value=900 id='900'>더 굵은</option>
			  </select>
		      </div>
		      <textarea name="board_content" id="board_content"   
		                rows="10" class="form-control" >${boarddata.board_content}</textarea>
		   </div>
		   
		   <c:if test="${admin == 'true'}">
		   <div class="form-group">
		   <label for="noticebox" style="color:orange;">공지글 설정&nbsp;&nbsp;
		   <input type="checkbox" id="noticebox" name="noticebox" value="false"></label>   
		   </div>
		   
		  </c:if>
		    <div class="form-group">
		    <button type="button" class="button" id="cancel">취소</button>
		    <button type="submit" class="button" id="submit">수정</button>
		    </div>
		  </form>
		</div> <%-- contain--%>
	</div> 
  </div> 

     
	<footer>
		<jsp:include page="../home/bottom.jsp" />
	</footer> 
		
</body>
</html>