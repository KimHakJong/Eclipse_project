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
            $( "#overtime_date" ).datepicker({
                 changeMonth: true, 
                 changeYear: true,
                 nextText: '다음 달',
                 prevText: '이전 달', 
                 dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
                 dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
                 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 dateFormat: "yymmdd",
                 maxDate: 0
            });
            
           
            
            
            //submit click 이벤트 
            $(".btn.btn-dark.btn-block").click(function(){
		    	//공백 검사
            	if($("#overtime_date").val() == ""){
		    		alert('근무일자를 선택하세요.');
		    		$("#overtime_date").focus();
					return false;
		    	}
		    	
            	if($("#startTime").val() == ""){
		    		alert('초과근무 시작시간을 선택하세요.');
		    		$("#startTime").focus();
					return false;
		    	}
            	
            	if($("#endTime").val() == ""){
		    		alert('초과근무 끝난시간을 선택하세요.');
		    		$("#endTime").focus();
					return false;
		    	}
		    	
            	if($("#overtime_content").val() == ""){
		    		alert('작업내용을 입력하세요.');
		    		$("#overtime_content").focus();
					return false;
		    	}
            	
            	if($("#overtime_reason").val() == ""){
		    		alert('사유를 입력하세요.');
		    		$("#overtime_reason").focus();
					return false;
		    	}
            	
  		  });
            
            // 근무일자 입력시 유효성 검사
            $('#overtime_date').keyup(function(){
            	if($.trim($(this).val()).length == 8){ // 입력값이 8자리가 되었을때 실행
            	// 년도4자리 월2자리 일 자리	
        		const pattern = /^[0-9]{4}(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|[3][01])$/;
        		const domain = $(this).val();
        		if(!pattern.test(domain)){
        			alert('형식에 맞게 입력하여 주세요');
        			$(this).val("").focus();
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
  <form action="OvertimeRequest.att" method="get" name="boardform">
     <h1>초과근무 신청서</h1>
    <div class="form-group">
    <label for="vacation">근무일자</label>
    <input type="text" class="form-control" name="overtime_date" id="overtime_date" maxlength="8" placeholder="근무 날짜를 선택하세요">
   </div>
  
    <div class="form-group">
    <label for="emergency">근무시간</label>
    <div class="input-group mb-3">
    <input type="time" class="form-control emergency" name="startTime" id="startTime"> &nbsp;~ &nbsp;
    <input type="time" class="form-control emergency" name="endTime" id="endTime">
   </div>
   </div>

   <div class="form-group">
      <label for="vertime_content">작업내용</label>
      <textarea name="overtime_content" id="overtime_content"   
                rows="10" class="form-control" maxlength="1000" ></textarea>
   </div>
   
   <div class="form-group">
      <label for="overtime_reason">사유</label>
      <textarea name="overtime_reason" id="overtime_reason"   
                rows="10" class="form-control" maxlength="1000"></textarea>
   </div> 
    
    <div class="form-group">
    <button type="submit" class="btn btn-dark btn-block">신청</button>
    </div>
  </form>
</div>

</body>
</html>