<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%
request.setCharacterEncoding("utf-8");
String sessionId = (String) (session.getAttribute("id"));
String paramId = (String) (request.getParameter("id"));
String isAdmin = (String) (request.getParameter("admin"));

//sessionId = "id";//임시로 id설정

System.out.println(sessionId);
System.out.println(paramId);
System.out.println(isAdmin);

if (sessionId == null || sessionId.equals("null")) {
	//out.println("<script>alert('로그인 해주세요');location.href='login.jsp';</script>");
	response.sendRedirect("login.net");
}
%>

<!DOCTYPE html>
<html>
<head>



<style>
@import
	url('https://fonts.googleapis.com/css2?family=Lato&display=swap');

* {
	font-family: "noto sans", sans-serif;
}

body {
	margin: 40px 10px;
	padding: 0;
	font-size: 14px;
}

#calendar {
	max-width: 1100px;
	margin: 0 auto;
}
</style>
<meta charset='utf-8' />

<meta name='viewport' content='width=device-width, initial-scale=1'>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- bootstrap 4 -->

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">


<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<link href="css/home.css" rel="stylesheet" type="text/css">
<!-- fullcalendar -->

<link href=${pageContext.request.contextPath}/calendar/lib/main.css
	rel='stylesheet' />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/calendar/lib/main.js"></script>



<script>

 var calendar = null;
 document.addEventListener('DOMContentLoaded', function () {
	    	
	 
            $('#xbutton').on('click', function(){
                $('#calendarModal').modal('hide');
            })
            $('#sprintSettingModalClose').on('click', function(){
                $('#calendarModal').modal('hide');
            })
 


	      var calendarEl = document.getElementById('calendar');

		


	    calendar = new FullCalendar.Calendar(calendarEl, {
	    	
	    	
	    
	    

           headerToolbar: {
               left: 'prevYear,prev,next,nextYear today',
                center: 'title',
                right: 'dayGridMonth,listWeek',
                center: 'addEventButton'

             },

	          editable: true,
	          
			
			
	          customButtons: {
	        	  
                  addEventButton: { // 추가한 버튼 설정

                	  
                      text : "일정 추가",  // 버튼 내용
                      click : function(){ 
                    	  // 버튼 클릭 시 이벤트 추가
                    	  
                          $("#calendarModal").modal("show"); // modal 나타내기


                          $('#calendar_content').val('');
                          $('#calendar_start_date').val('');
                          $('#calendar_end_date').val('');

                          $("#addCalendar").off("click").on("click",function(){  // modal의 추가 버튼 클릭 시
                        	  

                        	  
                              var content = $("#calendar_content").val();
                              var start_date = $("#calendar_start_date").val();
                              var end_date = $("#calendar_end_date").val();
                              
                              
                              
                              //내용 입력 여부 확인
                              if(content == null || content == ""){
                                  alert("내용을 입력하세요.");
                              }else if(start_date == "" || end_date ==""){
                                  alert("날짜를 입력하세요.");
                              }else if(new Date(end_date)- new Date(start_date) < 0){ // date 타입으로 변경 후 확인
                                  alert("종료일이 시작일보다 먼저입니다.");
                              }else{ // 정상적인 입력 시
                            	  
                                  var obj = {
                                      "title" : content,
                                      "start" : start_date,
                                      "end" : end_date,
                                      "allDay" : true
                                  }//전송할 객체 생성

                              
                         adddata(obj);
                              
   
 

                          
                           var m_end = new Date(end_date.substr(0, 4), end_date.substr(5, 2)-1, end_date.substr(8, 2));
                              
 
                                  
                           m_end.setDate(m_end.getDate()+1);
                                  
                           console.log(end_date);
                           console.log(m_end);
                           console.log(m_end.getFullYear());
                           console.log(m_end.getMonth()+1);
                                 
                                 
                           if(m_end.getMonth()+1 < 10 && m_end.getDate() < 10){
                              	 var m_end_dt = m_end.getFullYear() + '-0' + (m_end.getMonth()+1) + '-0' + m_end.getDate();	 
                           }
                           else if (m_end.getMonth()+1 < 10 && m_end.getDate() >= 10  )
                           {
                            	var m_end_dt = m_end.getFullYear() + '-0' + (m_end.getMonth()+1) + '-' + m_end.getDate();	  	 
                           }
                           else if(m_end.getMonth()+1 >= 10 && m_end.getDate() < 10)
                           {
                            	var m_end_dt = m_end.getFullYear() + '-' + (m_end.getMonth()+1) + '-0' + m_end.getDate();
                           }
                           else if(m_end.getMonth()+1 >= 10 && m_end.getDate() >= 10)
                           {
                            	var m_end_dt = m_end.getFullYear() + '-' + (m_end.getMonth()+1) + '-' + m_end.getDate();
                           }

                               console.log(m_end_dt);
                             
                             calendar.addEvent({
                            	 
              			            title: content,
              			            start: start_date,
              			            end: m_end_dt,
              			            allDay: true
       						 })
       						 
                             console.log('obj = ' + obj);
                             
                             var allEvent =	 calendar.getEvents();
                             
                             console.log('allEvent[0] = ');
                             console.log(allEvent[0].title);
                             console.log(allEvent[0].start);
                             console.log(allEvent[0].end);
                             
                             console.log('allEvent = ');
                             console.log(allEvent);
                             
       						 
                         }
                              $('#calendarModal').modal('hide');
                          });

                      }
                  }
              },

	          initialView: 'dayGridMonth',
	          editable: true,
	          displayEventTime: false,
	          dayMaxEvents: true,
	          locale: 'ko',
	          
	          eventAdd: function(obj) { 
	        	
	        	
	          	console.log('추가');

	          	
	  
	
	          },

     });
     calendar.render();
   });
	    
 
	function loadingEvents(){
	 	   
	 	   var return_value = null;
	    		$.ajax({
	    			type:'POST',
	    			url:'${pageContext.request.contextPath}/show.calendar',
	    			dataType:"json",
	    			async:false,
	    			success:function(result){
	    				return_value = result;
	    				console.log('이벤트 가져왔습니다.');
	    				
	    				console.log(result);
	    				console.log('다음');
	    				console.log(return_value);
	    			},
	    			error:function(request,status,error){},
	    			complete:function(){}
	    		}) 
	 	return return_value;   
	    }
	    

	    
	function adddata(jsondata){
    	console.log(jsondata);
	   	$.ajax({
	   		type:'POST',
	   		url:'${pageContext.request.contextPath}/add.calendar',
		  	data: jsondata,
	  		dataType:"json",
	   		async:true,
	   		success:function(rdata){
	   			console.log('db 저장 완료.');
	   		},
	 	  	error:function(request,status,error){},
	   		complete:function(){}
	   	}) 
	}

	    //일정등록창 모달
	    function insertModalOpen(arg){
	  	
	    	  if('<%=sessionId%>' == null) {
			alert();
			location.href = 'login.net';
		}
	}


</script>
</head>

<body>

	<header>
		<jsp:include page="../home/header.jsp" />
	</header>


	<div class="row">
		<div class="side">
			<jsp:include page="../home/left.jsp" />

		</div>
		<div id='calendar'></div>
	</div>



	<!-- modal 추가 -->

	<div class="modal fade" id="calendarModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">일정을 입력하세요.</h5>

					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close" id="xbutton">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="taskId" class="col-form-label">일정 내용</label> <input
							type="text" class="form-control" id="calendar_content"
							name="calendar_content"> <label for="taskId"
							class="col-form-label">시작 날짜</label> <input type="date"
							class="form-control" id="calendar_start_date"
							name="calendar_start_date"> <label for="taskId"
							class="col-form-label">종료 날짜</label> <input type="date"
							class="form-control" id="calendar_end_date"
							name="calendar_end_date">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-warning" id="addCalendar">추가</button>
					
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal" id="sprintSettingModalClose"
						data-backdrop="static" data-keybord="false">닫기</button>
				</div>

			</div>
		</div>
	</div>

	<footer>
		<jsp:include page="../home/bottom.jsp" />
	</footer>



</body>
</html>