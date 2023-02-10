<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link href="css/home.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<style>

.container{width: 60%}
label{font-weight: bold;}

img{width: 20px}



.fileRegiBtn label {
	display: inline-block; 
	padding: .5em .75em; 
	color: #ffffff; 
	font-size: inherit; 
	line-height: normal; 
	vertical-align: middle; 
	background-color: #0d0d0d; 
	cursor: pointer; 
	border: 1px solid #ebebeb; 
	border-bottom-color: #e2e2e2; 
	border-radius: .25em;
}

/*파일선택시 선택된 파일명이 붙는것을 가려준다*/
.fileRegiBtn input[type="file"]{
	position: absolute; 
	width: 1px; 
	height: 1px; 
	padding: 0; 
	margin: -1px; 
	overflow: hidden; 
	clip:rect(0,0,0,0); 
	border: 0;
}

#filelabel{
    display:block
}

.fileRegiBtn{
width:130px; 
display:inline;
margin-left:-3px;	
}

.fileName:disabled, .fileName[readonly] {
    background-color: #e9ecef;
    opacity: 1;
}
.fileName {
	margin-right:-4px;
    width: 40%;
    height: calc(1.5em + 0.75rem + 2px);
    padding: 0.375rem 0.75rem;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #495057;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    border-radius: 0.25rem;
    transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}

.board_style{
    padding-left : 10px ;
    font-size : 13px;
    color: #495057;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    border-radius: 0.25rem;
    transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}

#fontColor{
    margin-top : 5px;
    margin-bottom:5px
}

#board_content{
 resize: none;

}

.button {
    display: inline;
    font-weight: 400;
    text-align: center;
    vertical-align: middle;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-color: transparent;
    border: 1px solid transparent;
    padding: 0.375rem 0.75rem;
    font-size: 1rem;
    line-height: 1.5;
    border-radius: 0.25rem;
    transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
        color: #fff;
    background-color: #343a40;
    border-color: #343a40;
    float : right;
    margin : 3px;
}

#container{
margin-top: 20px
}
</style>

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
         <div class="container" id="container">
		  <form action="BoardAddAction.bo" method="post" enctype="multipart/form-data" name="boardform">
		   
		   <div class="form-group">     
		      <label for="board_name">글쓴이</label>
		      <input name="board_name" id="board_name" value="${id}" readonly
		       type="text" class="form-control" placeholder="Enter board_name">
		
		   </div>
		   
		   <div class="form-group">
		      <label for="board_pass">비밀글 설정&nbsp;&nbsp;<input type="checkbox" id="passwordbox" checked="checked" ></label>
		      <input name="board_pass" id="board_pass"  type="password" maxlength="30" 
		      class="form-control" placeholder="Enter board_pass">
		   </div>
		   
		 
		  <div class="form-group">
		    <label id="filelabel">파일첨부</label> 
		         <input id="fileName" class="fileName" value="파일선택" disabled="disabled">
			   <div class="fileRegiBtn">
				 <label for="myFileUp" id="FileUp">파일등록하기</label>
				 <input type="file" id="myFileUp" name="board_file">
		       </div>
		  </div>
		  
		   
		   
		   <div class="form-group">
		      <label for="board_subject">제목</label>
		      <input name="board_subject" id="board_subject"  type="text" maxlength="100" 
		      class="form-control" placeholder="Enter board_subject">
		   </div>
		   
		   <div class="form-group">
		      <label for="board_content">내용</label>
		      
		      <div class="board_style">
		      글자 색 : <input type="color" name="fontColor" id="fontColor"> &nbsp;&nbsp;
		      글자 크기 :&nbsp;<select name='fontSize' id="fontSize">
				  <option value='10px'>10px</option>
				  <option value='15px' selected>15px</option>
				  <option value='20px'>20px</option>
				  <option value='25px'>25px</option>
				  <option value='30px'>30px</option>
				  <option value='35px'>35px</option>
				  <option value='40px'>40px</option>
				  <option value='45px'>45px</option>
				  <option value='50px'>50px</option>
				  <option value='55px'>55px</option>
				  <option value='60px'>60px</option>
			  </select>
			  &nbsp;&nbsp;글자 굵기 :&nbsp;<select name='fontWeight' id="fontWeight">
				  <option value=200 >얇은</option>
				  <option value=400 selected>보통</option>
				  <option value=700 >굵은</option>
				  <option value=900>더 굵은</option>
			  </select>
		      </div>
		      <textarea name="board_content" id="board_content"   
		                rows="10" class="form-control" ></textarea>
		   </div>
		   
		   <c:if test="${admin == 'true'}">
		   <div class="form-group">
		   <label for="noticebox" style="color:orange;">공지글 설정&nbsp;&nbsp;
		   <input type="checkbox" id="noticebox" name="noticebox" value="false"></label>   
		   </div>
		   
		  </c:if>
		    <div class="form-group">
		    <button type="button" class="button" id="cancel">취소</button>
		    <button type="submit" class="button" id="submit">등록</button>
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