<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>달력</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script type="text/javascript">
    $(document).ready(function () {
            $.datepicker.setDefaults($.datepicker.regional['ko']); 
            $( "#startDate" ).datepicker({
                 changeMonth: true, 
                 changeYear: true,
                 nextText: '다음 달',
                 prevText: '이전 달', 
                 dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
                 dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
                 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 dateFormat: "yymmdd",
                 maxDate: 500,                       // 선택할수있는 최대날짜, ( 500일 이후 날짜 선택 불가)
                 minDate:0, //선택할수있는 최소 날짜 ( 오늘 이후 날짜 선택 불가))
                 onClose: function( selectedDate ) {    
                      //시작일(startDate) datepicker가 닫힐때
                      //종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                     $("#endDate").datepicker( "option", "minDate", selectedDate );
                 }    
 
            });
            $( "#endDate" ).datepicker({
                 changeMonth: true, 
                 changeYear: true,
                 nextText: '다음 달',
                 prevText: '이전 달', 
                 dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
                 dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
                 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 dateFormat: "yymmdd",
                 maxDate: 500,           // 선택할수있는 최대날짜, ( 500일 이후 날짜 선택 불가)
                 minDate:0, //선택할수있는 최소 날짜 ( 오늘 이후 날짜 선택 불가))
                 onClose: function( selectedDate ) {    
                     // 종료일(endDate) datepicker가 닫힐때
                     // 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
                     $("#startDate").datepicker( "option", "maxDate", selectedDate );
                 }    
 
            });  
            
            
            //submit click 이벤트 
            $(".btn.btn-dark.btn-block").click(function(){
		    	//공백 검사
            	if($("#startDate").val() == ""){
		    		alert('휴가 시작일을 선택하세요.');
		    		$("#startDate").focus();
					return false;
		    	}
		    	
            	if($("#endDate").val() == ""){
		    		alert('휴가 종료일을 선택하세요.');
		    		$("#endDate").focus();
					return false;
		    	}
            	
            	if($("#emergency_one").val() == ""){
		    		alert('비상연락망을 입력하세요');
		    		$("#emergency_one").focus();
					return false;
		    	}
            	
            	
            	if($("#emergency_two").val() == ""){
		    		alert('비상연락망을 입력하세요');
		    		$("#emergency_two").focus();
					return false;
		    	}
            	
            	if($("#emergency_three").val() == ""){
		    		alert('비상연락망을 입력하세요');
		    		$("#emergency_three").focus();
					return false;
		    	}
            	
            	if($("#details").val() == ""){
		    		alert('세부사항을 입력하세요');
		    		$("#details").focus();
					return false;
		    	}
         	
  		  });
            
            // 휴가 시작날짜 입력시 유효성 검사
            $('#startDate').keyup(function(){
            	if($.trim($(this).val()).length == 8){ // 입력값이 8자리가 되었을때 실행
            	// 년도4자리 월2자리 일 자리	
        		const pattern = /^[0-9]{4}(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|[3][01])$/;
        		const domain = $(this).val();
        		if(!pattern.test(domain)){
        			alert('날짜 형식에 맞게 입력하여 주세요');
        			$(this).val("").focus();
        		}
            	}
        	}); 
            
            // 휴가 종료날짜 입력시 유효성 검사
            $('#endDate').keyup(function(){
            	if($.trim($(this).val()).length == 8){ // 입력값이 8자리가 되었을때 실행
            	// 년도4자리 월2자리 일 자리	
        		const pattern = /^[0-9]{4}(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|[3][01])$/;
        		const domain = $(this).val();
        		if(!pattern.test(domain)){
        			alert('날짜 형식에 맞게 입력하여 주세요');
        			$(this).val("").focus();
        		}
            	}
        	});
            
            //전화번호 입력시 유효성 검사
            $('#emergency_one').keyup(function(){
            	if($.trim($(this).val()).length == 3){ // 입력값이 8자리가 되었을때 실행
            	// 년도4자리 월2자리 일 자리	
        		const pattern = /^[0-9]{3}$/;
        		const domain = $(this).val();
        		if(!pattern.test(domain)){
        			alert('형식에 맞게 숫자로 입력하여 주세요');
        			$(this).val("").focus();
        		}else{
        			$('#emergency_two').focus();
        		}
            	}
        	});
            
            $('#emergency_two').keyup(function(){
            	if($.trim($(this).val()).length == 4){ // 입력값이 8자리가 되었을때 실행
            	// 년도4자리 월2자리 일 자리	
        		const pattern = /^[0-9]{4}$/;
        		const domain = $(this).val();
        		if(!pattern.test(domain)){
        			alert('형식에 맞게 숫자로 입력하여 주세요');
        			$(this).val("").focus();
        		}else{
        			$('#emergency_three').focus();
        		}
            	}
        	});
            
            $('#emergency_three').keyup(function(){
            	if($.trim($(this).val()).length == 4){ // 입력값이 8자리가 되었을때 실행
            	// 년도4자리 월2자리 일 자리	
        		const pattern = /^[0-9]{4}$/;
        		const domain = $(this).val();
        		if(!pattern.test(domain)){
        			alert('형식에 맞게 숫자로 입력하여 주세요');
        			$(this).val("").focus();
        		}else{
        			$('#details').focus();
        		}
            	}
        	});
            
            
            
            
    });
</script>

<style>
*{
font-family:"noto sans", sans-serif;
}
#startDate,#endDate{
border-radius: 4px;
}
h1{
font-size: 1.5rem ;
text-align: center;
margin-bottom: 15px;
margin-top: 15px;
}
.container{
width: 60%
}
label{
font-weight: bold;
display: block;
 }
img{
width: 20px
}
</style>
</head>
<body>
<div class="container">
  <form action="VacationRequest.att" method="post" name="boardform">
    
     <h1>휴가 신청서</h1> 
        
    <div class="form-group">
    <label for="vacation">휴가기간</label>
    <div class="input-group mb-3">
    <input type="text" class="form-control" name="startDate" id="startDate" placeholder="휴가 시작일">&nbsp;~&nbsp;
    <input type="text" class="form-control" name="endDate" id="endDate" placeholder="휴가 종료일">
   </div>
   </div>
  
    <div class="form-group">
    <label for="emergency">비상연락망</label>
    <div class="input-group mb-3">
    <input type="text" class="form-control emergency" name="emergency_one" id="emergency_one" placeholder="010" maxlength="3"> &nbsp;- &nbsp;
    <input type="text" class="form-control emergency" name="emergency_two" id="emergency_two" placeholder="0000" maxlength="4">&nbsp;- &nbsp;
    <input type="text" class="form-control emergency" name="emergency_three" id="emergency_three" placeholder="0000" maxlength="4">
   </div>
   </div>
   
   <div class="form-group">
      <label for="details">세부사항</label>
      <textarea name="details" id="details"   
                rows="10" class="form-control" ></textarea>
   </div>
     
    <div class="form-group">
    <button type="submit" class="btn btn-dark btn-block">신청</button>
    </div>
  </form>
</div>

</body>
</html>