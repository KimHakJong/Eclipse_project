<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<%
request.setCharacterEncoding("utf-8");
String sessionId = (String) (session.getAttribute("id"));
String sessionNm = (String) (session.getAttribute("nm"));

sessionId = "ceo";

System.out.println(sessionId);

if (sessionId == null || sessionId.equals("null")) {
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


<meta name='viewport' content='width=device-width, initial-scale=1'>
<!-- jquery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- bootstrap 4 -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">


<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<!-- fullcalendar -->
<link href='../lib/main.css' rel='stylesheet' />
<script type="text/javascript" src="../lib/main.js"></script>






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
	    	  //themeSystem: 'bootstrap',
	    	
	    	  
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
                                      "end" : end_date,
                                      "allDay" : true
                                  }//전송할 객체 생성

                                  var m_end = new Date(end_date.substr(0, 4), end_date.substr(5, 2)-1, end_date.substr(8, 2));
                              
 
                                  
                                  m_end.setDate(m_end.getDate()+1);
                                  
                                 console.log(end_date);
                                 console.log(m_end);
                                 console.log(m_end.getFullYear());
                                 console.log(m_end.getMonth()+1);
                                 
                                 
                                 if(m_end.getMonth()+1 < 10 && m_end.getDate() < 10)
                               	{
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
                                  

                                 

 

                                
                              }
                              
                              calendar.addEvent({
       			                  title: content,
       			                  start: start_date,
       			                  end: m_end_dt,
       			                  allDay: true
       			                  
       			                })
                              
                              
                              
                          });
                      }
                  }
              },


	          
	          //월간 달력으로 시작합니다.
	          initialView: 'dayGridMonth',
	          editable: true, // 수정 가능?
	          displayEventTime: false, // 시간 표시 x
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
	            



     });
     calendar.render();
   });
	    


	    //모달초기화
	    function initModal(modal, arg){
	  	$('.'+modal+' #title').val('');
	  	$('.'+modal+' #start').val('09:00');
	  	$('.'+modal+' #end').val('09:30');
	  	$('.'+modal+' #allDay').val('0');
	  	$('.'+modal+' input[name="allDay"]').val(['false']);
	  	$('.'+modal).modal('hide');
	  	g_arg = null;
	    }
	    
	    //일정등록창 모달
	    function insertModalOpen(arg){
	  	
	      if('<%=sessionId%>' == null)
	      {
	  		alert();
	  		location.href='login.jsp';
	  		}
	      

	  	
	  	g_arg = arg;
	  	//값이 있는경우 세팅
	  	if(g_arg.event != undefined){
	  		$('.insertModal .deleteBtn').css('display', 'inline');
	  		$('.insertModal .empl_nm').css('display', 'inline');
	  		$('.insertModal #empl_nm').val(g_arg.event.extendedProps.empl_nm);
	  		$('.insertModal #title').val(g_arg.event.title);
	  		$('.insertModal #start').val(stringFormat(g_arg.event.start.getHours())+':'+stringFormat(g_arg.event.start.getMinutes()));
	  		$('.insertModal #end').val(stringFormat(g_arg.event.end.getHours())+':'+stringFormat(g_arg.event.end.getMinutes()));
	  		$('.insertModal input[name="allDay"]').val([g_arg.event.allDay]);
	  		
	  		//본인 이벤트면 삭제 수정버튼 있음
	  		if('<%=sessionId%>' == g_arg.event.extendedProps.regid){
	  			$('.insertModal .deleteBtn').css('display', 'inline');
	  			$('.insertModal .insertBtn').css('display', 'inline');
	  		//남의 이벤트면
	  		}else{
	  			$('.insertModal .deleteBtn').css('display', 'none');
	  			$('.insertModal .insertBtn').css('display', 'none');
	  		}		
	  		//대표 외엔 승인/반려 불가
	  		$('.insertModal .approvalBtn').css('display', 'none');
	  		$('.insertModal .rejectBtn').css('display', 'none');

	  	//신규 이벤트
	  	}else{
	  		//month 외 week, day는 시간 값까지 받아와서 값 바인딩 ex)09:00
	  		if(g_arg.startStr.length > 10){
	  			$('.insertModal #start').val(g_arg.startStr.substr(11, 5));
	  			$('.insertModal #end').val(g_arg.endStr.substr(11, 5));
	  		}
	  		//등록자 숨김(readonly)
	  		$('.insertModal .empl_nm').css('display', 'none');
	  		//등록버튼 외 숨김
	  		$('.insertModal .insertBtn').css('display', 'inline');
	  		$('.insertModal .deleteBtn').css('display', 'none');
	  		$('.insertModal .approvalBtn').css('display', 'none');
	  		$('.insertModal .rejectBtn').css('display', 'none');
	  	}
	  	//모달창 show
	  	$('.insertModal').modal({backdrop: 'static'});
	  	console.log(arg);
	  	$('.insertModal #title').focus();
	    }
	    
	    //일정삭제
	    function deleteSch(modal, arg){
	  	if(confirm('일정을 삭제하시겠습니까?')){
	  		var data = {"gubun": "delete", "id" : arg.event.id, "allowyn": "0"};
	  		//DB 삭제
	  		$.ajax({
	  		  url: "./deleteSch.jsp",
	  		  type: "POST",
	  		  data: JSON.stringify(data),
	  		  dataType: "JSON",
	  		  traditional: true,
	  		  success : function(data, status, xhr){
	  			  //alert(xhr.status);
	  			  arg.event.remove();
	  			  initModal(modal, arg);
	  		  },
	  		  error : function(xhr, status, error){
	  			    //alert(xhr.responseText);
	  			  alert('일정 삭제 실패<br>새로고침 후 재시도 해주세요');
	  		  }
	  		});
	  		//
	  	}
	    }
	    
	    function insertSch(modal, arg){
	    	
	    	if($('.'+modal+' #title').val() == ''){
	    		alert('제목을 입력해주세요');
	    		return;
	    	}
	    	if($('.'+modal+' #title').val().length > 100){
	    		alert('제목은 100자를 넘을 수 없습니다 현재 ' + $('.'+modal+' #title').val().length + '자');
	    		return;
	    	}
	    		
	    	//수정 (승인 함수의 수정로직과 동일)
	    	if(arg.event != undefined){
	    		if($('.insertModal input[name="allDay"]:checked').val()!='true'){
	    			  if(arg.event.startStr.substring(0, 10) == arg.event.endStr.substring(0, 10)){
	    				  if($('.insertModal #end').val() <= $('.insertModal #start').val()){
	    					  alert('종료시간을 시작시간보다 크게 선택해주세요');
	    					  $('.insertModal #end').focus();
	    					  return;
	    				  }
	    		  		}
	    			}
	    		var data;
	    		var m_start = new Date(arg.event.startStr.substr(0, 4), arg.event.startStr.substr(5, 2)-1, arg.event.startStr.substr(8, 2));
	    		var m_end = new Date(arg.event.endStr.substr(0, 4), arg.event.endStr.substr(5, 2)-1, arg.event.endStr.substr(8, 2));
	    		var m_month = m_end.getMonth()+1;
	    		var be_allday = arg.event.allDay;
	    		var m_date;
	    		var m_end_dt;
	    		if($('.insertModal input[name="allDay"]:checked').val()!='true'){
	    			if($('.'+modal+' #start').val() == null){
	    				alert('시작시간을 입력해주세요');
	    				return;
	    			}
	    			if($('.'+modal+' #end').val() == null){
	    				alert('종료시간을 입력해주세요');
	    				return;
	    			}
	    			if(be_allday){
	    				m_end.setDate(m_end.getDate()-1);
	    			}
	    			
	    			var m_end_com = new Date(arg.event.endStr.substr(0, 4), arg.event.endStr.substr(5, 2)-1, arg.event.endStr.substr(8, 2));
	    			var m_first = new Date(m_end.getFullYear(),  m_end.getMonth()+1, 1);
	    			if(m_end_com.getFullYear()+''+stringFormat(m_end_com.getMonth())+''+stringFormat(m_end_com.getDate())
	    					== m_first.getFullYear()+''+stringFormat(m_first.getMonth())+''+stringFormat(m_first.getDate())){
	    				m_month = m_end.getMonth()+1;
	    			}
	    			
	    			m_date = m_end.getDate();
	    			m_end_dt = m_end.getFullYear() + '-' + stringFormat(m_month) + '-' + stringFormat(m_date);
	    			data = { 
	    					id : arg.event.id,
	    			  		title : $('.'+modal+' #title').val(),
	    			  		startdt : arg.event.startStr.substr(0, 10)+'T'+$('.'+modal+' #start').val(),
	    			  		enddt : m_end_dt+'T'+$('.'+modal+' #end').val(),
	    			  		allday : $('.'+modal+' input[name="allDay"]:checked').val(),				  		
	    			  		allowyn : '0',
	    			  		comments : '',
	    			  		regid : '<%=sessionId%>'
	    			  	}
	    		}else{
	    			if(!be_allday){
	    				m_end.setDate(m_end.getDate()+1);
	    			}
	    			
	    			var m_end_com = new Date(arg.event.endStr.substr(0, 4), arg.event.endStr.substr(5, 2)-1, arg.event.endStr.substr(8, 2));
	    			m_end_com.setDate(m_end_com.getDate()+1);
	    			var m_first = new Date(m_end.getFullYear(),  m_end.getMonth(), 1);
	    			if(m_end_com.getFullYear()+''+stringFormat(m_end_com.getMonth())+''+stringFormat(m_end_com.getDate())
	    					== m_first.getFullYear()+''+stringFormat(m_first.getMonth())+''+stringFormat(m_first.getDate())){
	    				m_month = m_end.getMonth()+1;
	    			}
	    			
	    			m_date = m_end.getDate();
	    			m_end_dt = m_end.getFullYear() + '-' + stringFormat(m_month) + '-' + stringFormat(m_date);
	    			
	    			data = {
	    					id : arg.event.id,
	    			  		title : $('.'+modal+' #title').val(),
	    			  		startdt : arg.event.startStr.substr(0, 10)+'T00:00',
	    			  		enddt : m_end_dt+'T00:00',
	    			  		allday : $('.'+modal+' input[name="allDay"]:checked').val(),				  		
	    			  		allowyn : '0',
	    			  		comments : '',
	    			  		regid : '<%=sessionId%>'
	    			  	}
	    		}
	    		if(data.startdt >= data.enddt){
	    			alert('종료시간을 시작시간보다 크게 선택해주세요');
	    			return;
	    		}
	    		//DB 수정
	    		$.ajax({
	    		  url: "./updateSch.jsp",
	    		  type: "POST",
	    		  data: JSON.stringify(data),
	    		  dataType: "JSON",
	    		  traditional: true,
	    		  success : function(data, status, xhr){
	    			  if($('.insertModal input[name="allDay"]:checked').val()=='true'){
	    					arg.event.setProp('title', $('.'+modal+' #title').val());
	    					arg.event.setAllDay(true);
	    					arg.event.setStart(arg.event.startStr+'T00:00');
	    					arg.event.setEnd(m_end_dt+'T00:00');	
	    					arg.event.setExtendedProp('allowyn', '0');
	    			  }else{
	    					arg.event.setProp('title', $('.'+modal+' #title').val());
	    					arg.event.setAllDay(false);
	    					arg.event.setStart(new Date(arg.event.startStr.substr(0, 10)+'T'+$('.'+modal+' #start').val()));
	    					arg.event.setEnd(new Date(m_end_dt+'T'+$('.'+modal+' #end').val()));
	    					arg.event.setExtendedProp('allowyn', '0');
	    			  }
	    			  if(arg.event.extendedProps.regid == ceo){
	    				  arg.event.setProp('backgroundColor', '#ffc107');
	    				  arg.event.setProp('borderColor', '#ffc107');
	    				  arg.event.setProp('textColor', textBlack);  
	    			  }else{
	    				  arg.event.setProp('backgroundColor', '#343a40');
	    				  arg.event.setProp('borderColor', '#343a40');
	    				  arg.event.setProp('textColor', textWhite);  
	    			  }
	    			  initModal(modal, arg);
	    		  },
	    		  error : function(xhr, status, error){
	    			    //alert(xhr.responseText);
	    			  alert('일정 수정 실패<br>새로고침 후 재시도 해주세요');
	    		  }
	    		});
	    		//
	    	//신규	
	    	}else{
	    		if($('.insertModal input[name="allDay"]:checked').val()!='true'){
	    			  if(arg.startStr.substring(0, 10) == arg.endStr.substring(0, 10)){
	    				  if($('.insertModal #end').val() <= $('.insertModal #start').val()){
	    					  alert('종료시간을 시작시간보다 크게 선택해주세요');
	    					  $('.insertModal #end').focus();
	    					  return;
	    				  }
	    		  		}
	    			}
	    		var data;
	    		//구간이벤트면
	    		if($('.insertModal input[name="allDay"]:checked').val()!='true'){
	    			var m_start = new Date(arg.startStr.substr(0, 4), arg.startStr.substr(5, 2)-1, arg.startStr.substr(8, 2));
	    			var m_end = new Date(arg.endStr.substr(0, 4), arg.endStr.substr(5, 2)-1, arg.endStr.substr(8, 2));
	    			var m_month = m_end.getMonth()+1;
	    			//week나 day에서 추가할때(시간 존재)
	    			if(arg.endStr.length > 10){
	    				m_end.setDate(m_end.getDate());
	    				//month에선 2021.09.30 클릭 시 endstr이 2021.10.01로 잡히기 떄문에 일-1
	    			}else{
	    				m_end.setDate(m_end.getDate()-1);	
	    			}
	    			
	    			//말일에 대한 로직
	    			var m_end_com = new Date(arg.endStr.substr(0, 4), arg.endStr.substr(5, 2)-1, arg.endStr.substr(8, 2));
	    			var m_first = new Date(m_end.getFullYear(),  m_end.getMonth()+1, 1);
	    			if(m_end_com.getFullYear()+''+stringFormat(m_end_com.getMonth())+''+stringFormat(m_end_com.getDate())
	    					== m_first.getFullYear()+''+stringFormat(m_first.getMonth())+''+stringFormat(m_first.getDate())){
	    				m_month = m_end.getMonth()+1;
	    			}
	    							
	    			var m_date = m_end.getDate();
	    			arg.endStr = m_end.getFullYear() + '-' + stringFormat(m_month) + '-' + stringFormat(m_date);
	    			
	    			if(arg.startStr.length > 10){
	    				//일자만 추출
	    				arg.startStr = arg.startStr.substr(0, 10);
	    			}
	    			
	    			data = { 
	    			  		title : $('.'+modal+' #title').val(),
	    			  		startdt : arg.startStr+'T'+$('.'+modal+' #start').val(),
	    			  		enddt : arg.endStr+'T'+$('.'+modal+' #end').val(),
	    			  		allday : $('.'+modal+' input[name="allDay"]:checked').val(),				  		
	    			  		allowyn : '0',
	    			  		comments : '',
	    			  		empl_nm: '<%=sessionNm%>',
	    			  		regid : '<%=sessionId%>'
	    			  	}
	    			//종일이벤트면
	    		}else{
	    			if(arg.startStr.length > 10){
	    				//일자만 추출
	    				arg.startStr = arg.startStr.substr(0, 10);
	    			}
	    			if(arg.endStr.length > 10){
	    				var m_end = new Date(arg.endStr.substr(0, 4), arg.endStr.substr(5, 2)-1, arg.endStr.substr(8, 2));
	    				//종일이기에 일+1 (시간은 어차피 00:00)
	    				m_end.setDate(m_end.getDate()+1);
	    				arg.endStr = m_end.getFullYear()+'-'+ stringFormat(m_end.getMonth()+1)+'-'+ stringFormat(m_end.getDate());
	    			}
	    			
	    			data = {
	    			  		title : $('.'+modal+' #title').val(),
	    			  		startdt : arg.startStr+'T00:00',
	    			  		enddt : arg.endStr+'T00:00',
	    			  		allday : $('.'+modal+' input[name="allDay"]:checked').val(),				  		
	    			  		allowyn : '0',
	    			  		comments : '',
	    			  		empl_nm: '<%=sessionNm%>',
	    			  		regid : '<%=sessionId%>'
	    			  	}
	    		}
	    		
	    		if(data.startdt >= data.enddt){
	    			alert('종료시간을 시작시간보다 크게 선택해주세요');
	    			return;
	    		}
	    		//DB 삽입	
	    		$.ajax({
	    		  url: "./insertSch.jsp",
	    		  type: "POST",
	    		  data: JSON.stringify(data),
	    		  dataType: "JSON",
	    		  traditional: true,
	    		  success : function(data, status, xhr){
	    			  var id;
	    			  $.each(data, function(key, value){
	    				  id = value;
	    			  });
	    			  if($('.insertModal input[name="allDay"]:checked').val()=='true'){
	    				  if('<%=sessionId%>' == ceo){
	    					  calendar.addEvent({
	    					    id: id,
	    						title: $('.'+modal+' #title').val(),
	    						start: arg.startStr+'T'+$('.'+modal+' #start').val(),
	    						end: arg.endStr+'T'+$('.'+modal+' #end').val(),
	    						backgroundColor: ceoColor,
	    						borderColor: ceoColor,
	    						textColor: textBlack,
	    						regid: '<%=sessionId%>',
	    						empl_nm: '<%=sessionNm%>',
	    						allDay: true
	    					  });
	    				  }else{
	    					  calendar.addEvent({
	    							id: id,
	    							title: $('.'+modal+' #title').val(),
	    							start: arg.startStr+'T'+$('.'+modal+' #start').val(),
	    							end: arg.endStr+'T'+$('.'+modal+' #end').val(),
	    							backgroundColor: regColor,
	    							borderColor: regColor,
	    							textColor: textWhite,
	    							regid: '<%=sessionId%>',
	    							empl_nm: '<%=sessionNm%>',
	    							allDay: true
	    						});  
	    				  }
	    					
	    			  }else{
	    				  if('<%=sessionId%>' == ceo){
	    					  calendar.addEvent({
	    							id: id,
	    							title: $('.'+modal+' #title').val(),
	    							start: arg.startStr+'T'+$('.'+modal+' #start').val(),
	    							end: arg.endStr+'T'+$('.'+modal+' #end').val(),
	    							backgroundColor: ceoColor,
	    							borderColor: ceoColor,
	    							regid: '<%=sessionId%>',
	    							empl_nm: '<%=sessionNm%>',
	    							textColor: textBlack
	    						});
	    				  }else{
	    					  calendar.addEvent({
	    							id: id,
	    							title: $('.'+modal+' #title').val(),
	    							start: arg.startStr+'T'+$('.'+modal+' #start').val(),
	    							end: arg.endStr+'T'+$('.'+modal+' #end').val(),
	    							backgroundColor: regColor,
	    							regid: '<%=sessionId%>',
	    							empl_nm: '<%=sessionNm%>',
	    							
										borderColor : regColor
									});
								}

							}
							calendar.unselect();
							initModal(modal, arg);
						},
						error : function(xhr, status, error) {
							//alert(xhr.responseText);
							alert('일정 등록 실패<br>새로고침 후 재시도 해주세요');
						}
					});
			//
		}
	}
</script>
</head>

<body>





	<div id='calendar'></div>

	<!-- modal 추가 -->
	<div class="modal fade" id="calendarModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">일정을 입력하세요.</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
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
						data-dismiss="modal" id="sprintSettingModalClose">취소</button>
				</div>

			</div>
		</div>
	</div>


	<script>
		
	</script>
</body>
</html>