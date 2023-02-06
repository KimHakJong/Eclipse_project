<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%
request.setCharacterEncoding("utf-8");
String sessionId = (String)(session.getAttribute("id"));
String sessionNm = (String)(session.getAttribute("nm"));

sessionId = "ceo";

System.out.println(sessionId);

if(sessionId == null || sessionId.equals("null")){   
   //out.println("<script>alert('로그인 해주세요');location.href='login.jsp';</script>");
   response.sendRedirect("login.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<style>
body {
   margin: 40px 10px;
   padding: 0;
   font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
   font-size: 14px;
}

#calendar {
   max-width: 1100px;
   margin: 0 auto;
}
/* 일요일 날짜 빨간색 */
.fc-day-sun a {
   color: red;
   text-decoration: none;
}

/* 토요일 날짜 파란색 */
.fc-day-sat a {
   color: blue;
   text-decoration: none;
}
</style>
<meta charset='utf-8' />
<!-- 화면 해상도에 따라 글자 크기 대응(모바일 대응) 
     <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">-->

<script src="http://code.jquery.com/jquery-latest.js"></script>


<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>



<!-- jquery CDN -->

<script
   src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.0/index.global.min.js'></script>
   <link href='../lib/main.css' rel='stylesheet' />

<!-- fullcalendar CDN 
     <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
     <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>-->
<!-- fullcalendar 언어 CDN -->





<script>
 var calendar =null;
       $(document).ready(function(){
         // calendar element 취득
         var calendarEl = $('#calendar')[0];
         

         var containerEl = document.getElementById('external-events');
         var calendarEl = document.getElementById('calendar');
         var checkbox = document.getElementById('drop-remove');

         
         
         
         // full-calendar 생성하기
         calendar = new FullCalendar.Calendar(calendarEl, {
            themeSystem: 'bootstrap',
          
            
         //  height: '600px', // calendar 높이 설정
         // expandRows: true, // 화면에 맞게 높이 재설정
//당장 필요 없음 (final)        
           //slotMinTime: '08:00', // Day 캘린더에서 시작 시간
           //slotMaxTime: '20:00', // Day 캘린더에서 종료 시간
           
           headerToolbar: {
               left: 'prevYear,prev,next,nextYear today',
                center: 'title',
                right: 'dayGridMonth,listWeek',
                center: 'addEventButton'

             },
             
             editable: true, //재수정여부 가능
           //drop으로 update 해야함
   
             customButtons: {
                  addEventButton: { // 추가한 버튼 설정
                      text : "일정 추가",  // 버튼 내용
                      click : function(){ // 버튼 클릭 시 이벤트 추가
                          $("#calendarModal").modal("show"); // modal 나타내기

                          $("#addCalendar").on("click",function(){  // modal의 추가 버튼 클릭 시
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
                                      "end" : end_date
                                  }//전송할 객체 생성

                                  console.log(obj); //서버로 해당 객체를 전달해서 DB 연동 가능
                              }
                          });
                      }
                  }
              },


             
             //월간 달력으로 시작합니다.
             initialView: 'dayGridMonth',
             editable: true, // 수정 가능?
             selectable: true, // 달력 일자 드래그 설정가능
             nowIndicator: true, // 현재 시간 마크
             dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
             locale: 'ko', // 한국어 설정
             
             eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
                 console.log(obj);
                console.log('이벤트 추가함');
                
                
               },
               eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
                 console.log(obj);
                console.log('이벤트 수정함');
               
               },
               eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
                 console.log(obj);
                console.log('이벤트 삭제함');
               
               },
               
               select: function(arg) {
                 insertModalOpen(arg);   //일자 클릭 시 모달 호출
                 },
                 eventClick: function(arg) {
                 insertModalOpen(arg);   //이벤트 클릭 시 모달 호출
                 }

                  select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
                       var title = prompt('일정추가:');
                       if (title) {
                         calendar.addEvent({
                           title: title,
                           start: arg.start,
                           end: arg.end,
                           allDay: arg.allDay,
                           
                         })
                       }
                       
                     }



     });
     calendar.render();
   });
       
       

       
       function savedata(jsondata){
            $.ajax({
               type:'POST',
               url:'${pageContext.request.contextPath}/project_calendarallSave.cal',
               data:jsondata,
               dataType:"json",
               async:true,
               success:function(rdata){
                  
                  
               },
               error:function(request,status,error){},
               complete:function(){}
            }) 
          
       }   

       
     
       
 </script>
</head>

<body>





   <div id='calendar'></div>
   
     <!-- modal 추가 -->
    <div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">일정을 입력하세요.</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="taskId" class="col-form-label">일정 내용</label>
                        <input type="text" class="form-control" id="calendar_content" name="calendar_content">
                        <label for="taskId" class="col-form-label">시작 날짜</label>
                        <input type="date" class="form-control" id="calendar_start_date" name="calendar_start_date">
                        <label for="taskId" class="col-form-label">종료 날짜</label>
                        <input type="date" class="form-control" id="calendar_end_date" name="calendar_end_date">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" id="addCalendar">추가</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal"
                        id="sprintSettingModalClose">취소</button>
                </div>
    
            </div>
        </div>
    </div>


   <script>

 </script>
</body>
</html>