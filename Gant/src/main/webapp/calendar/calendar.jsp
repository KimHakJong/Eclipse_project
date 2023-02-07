<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
 
  <meta charset='utf-8' />
  <!-- 화면 해상도에 따라 글자 크기 대응(모바일 대응) -->
  <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">

  <!-- jquery CDN -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.0/index.global.min.js'></script>
  <!-- fullcalendar CDN 
  <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>-->
  <!-- fullcalendar 언어 CDN -->
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
  <link href='https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.css' rel='stylesheet'>
<link href='https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.13.1/css/all.css' rel='stylesheet'>
  <link rel="stylesheet" href="css/calendar.css">
 
 <script>
 var calendar =null;
	    $(document).ready(function(){
	      // calendar element 취득
	      var calendarEl = $('#calendar')[0];
	      
	      //드래그앤 드롭가능  -> 추후 삭제 예정
	      var Draggable = FullCalendar.Draggable;
	      
	      var containerEl = document.getElementById('external-events');
	      var calendarEl = document.getElementById('calendar');
	      var checkbox = document.getElementById('drop-remove');
	      
	      //드래그앤 드롭가능  -> 추후 삭제 예정
	      new Draggable(containerEl, {
	          itemSelector: '.fc-event',
	          eventData: function(eventEl) {
	            return {
	              title: eventEl.innerText
	            };
	          }
	        });
	      //드래그앤 드롭가능  -> 추후 삭제 예정
	      
	      
	      
	      
	      // full-calendar 생성하기
	      calendar = new FullCalendar.Calendar(calendarEl, {
	    	  themeSystem: 'bootstrap',
	    	
	    	  
	        height: '600px', // calendar 높이 설정
	        expandRows: true, // 화면에 맞게 높이 재설정
//당장 필요 없음 (final)	     
	        //slotMinTime: '08:00', // Day 캘린더에서 시작 시간
	        //slotMaxTime: '20:00', // Day 캘린더에서 종료 시간
	        
	        headerToolbar: {
	            left: 'prev,next today',
	            center: 'title',
 //(final)     right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
 				right : '',
	          },
	          
	          editable: true, //재수정여부 가능
	        //drop으로 update 해야함
	          droppable: true,
	          
	          drop: function(info) {
	            // is the "remove after drop" checkbox checked?
	            if (checkbox.checked) {
	              // if so, remove the element from the "Draggable Events" list
	              info.draggedEl.parentNode.removeChild(info.draggedEl);
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
	            select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
	              var title = prompt('일정추가:');
	              if (title) {
	                calendar.addEvent({
	                  title: title,
	                  start: arg.start,
	                  end: arg.end,
	                  allDay: arg.allDay,
	                  Boolean//?
	                })
	              }
	              calendar.unselect();//뭔지모르겠다
	            }
     });
     calendar.render();
   });
	    
	    
	    //전체 이벤트 뽑아냄(그달의 전체 이벤트)
	    //뽑을때 각각 데이터로 뽑아냄
	    function allSave(){
	   	 var allEvent =	 calendar.getEvents();
	   	 console.log(allEvent);
	   	 alert("전체 이벤트 저장합니다.");
	   	 console.log("전체 이벤트 저장합니다.");
	   	 
	   	 var events = new Array();
	   	 
	   	 for(var i=0; i<allEvent.length;i++){
	   		 var obj = new Object();
	   		 
	   		 obj.title = allEvent[i]._def.title; //이벤트 명칭
	   		 obj.allday =allEvent[i]._def.allDay; //하루종일 이벤트인지 알려주는boolean값
	   		 obj.start = allEvent[i]._instance.range.start//시작날짜 및 시간
	   		 obj.end = allEvent[i]._instance.range.end//마침 날짜 및 시간
	   		 
	   	 savedata(obj);
	   	 }
	   	 
	    }
	    
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

<%-- 추후 삭제 예정 --%>
 <div id = drag_wrap>
	 <div id='external-events'>
	    <p>
	      <strong>드래그앤드롭</strong>
	    </p>
	
	    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
	      <div class='fc-event-main'>My Event 1</div>
	    </div>
	    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
	      <div class='fc-event-main'>My Event 2</div>
	    </div>
	    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
	      <div class='fc-event-main'>My Event 3</div>
	    </div>
	    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
	      <div class='fc-event-main'>My Event 4</div>
	    </div>
	    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
	      <div class='fc-event-main'>My Event 5</div>
	    </div>
	
	    <p>
	      <input type='checkbox' id='drop-remove' />
	      <label for='drop-remove'>드롭제거</label>
	    </p>
	  </div>
  </div>
  <%-- 추후 삭제 예정 --%>
  
  
  
  <%--전체 저장 버튼 누르면 월간 페이지 전체 저장 가능--%>
 <div id = "cal_save_wrap">
 <button id ="cal_save" onclick="allSave();">전체 저장</button>
 </div>
 
 <div id = cal_wrap>
 	<div id='calendar'></div>
 </div>
 <script>

 </script>
</body>
</html>