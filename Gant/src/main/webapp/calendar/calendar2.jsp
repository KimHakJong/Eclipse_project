<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%
request.setCharacterEncoding("utf-8");
String sessionId = (String) (session.getAttribute("id"));


System.out.println(sessionId);
if(sessionId == null || sessionId.equals("null")){	
	//out.println("<script>alert('로그인 해주세요');location.href='login.net';</script>");
	response.sendRedirect("login.net");
}


%>

<!DOCTYPE html>
<html>

<head>


<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
var jq1 = jQuery.noConflict();
</script>

<!-- bootstrap 4 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>





<link href="css/home.css" rel="stylesheet" type="text/css">
<!-- fullcalendar -->

<link href=${pageContext.request.contextPath}/calendar/lib/main.css
	rel='stylesheet' />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/calendar/lib/main.js"></script>



<style>
@import
	url('https://fonts.googleapis.com/css2?family=Lato&display=swap');

body {
	font-size: 14px;
	background-color: white;
	
}
.fc-button-primary{
background-color: #009CFF !important;
border-color: #009CFF !important;
}
.fc-toolbar-title {
	font-size: 20px !important;
}

#calendar {
	
	margin: 50px 300px 50px 150px;
	
}

.fc-day-sun a {
	color: red !important;
	text-decoration: none;
}

/* 토요일 날짜 파란색 */
.fc-day-sat a {
	color: blue !important;
	text-decoration: none;
}

</style>


<meta charset='utf-8' />


<script>
var g_arg;	//이벤트 글로벌 변수(모달창에서 호출하는 함수에서 참조하기 위함)
 var calendar = null;
 var i=0;
 var all_events = null;


 jq1(document).ready(function() {
	    	

	 
            jq1('#xbutton').on('click', function(){
                jq1('#calendarModal').modal('hide');
            })
            jq1('#sprintSettingModalClose').on('click', function(){
                jq1('#calendarModal').modal('hide');
            })
            
  


			
           var calendarEl = document.getElementById('calendar');


		all_events = loadingEvents();
		
	
		
		
		//넘어오는 글제목 title
		//admin


		
		console.log("sessionId");
		console.log("<%=sessionId%>");
		
		var loginid = "<%=sessionId%>";
		
		console.log("loginId");
		console.log(loginid);
		



	    calendar = new FullCalendar.Calendar(calendarEl, {
	    	
	          editable: false,
	          droppable: false,

	    
	    

           headerToolbar: {
               left: 'prev,next,today,addEventButton',

                right: 'dayGridMonth,listWeek',
                center: 'title'

             },




			
	          customButtons: {
	        	  
                  addEventButton: { // 추가한 버튼 설정



      				
                      text : "일정 추가",  // 버튼 내용
                      click : function(){ 
                    	  // 버튼 클릭 시 이벤트 추가
                    	  
						jq1('#calendarModal #addCalendar')
                		.css('display', 'inline');
                    	  
                          jq1("#calendarModal").modal("show"); // modal 나타내기

                  		
                          jq1('#calendarModal #modifyCalendar').css('display', 'none');
            				jq1('#calendarModal #deleteCalendar').css('display', 'none');
            				jq1('#calendar_title').val('');
                          jq1('#calendar_content').val('');
                          jq1('#calendar_start_date').val('');
                          jq1('#calendar_end_date').val('');
                          
                          jq1("#calendarModal #calendar_title").attr("readonly",false); 

                          jq1("#addCalendar").off("click").on("click",function(){  // modal의 추가 버튼 클릭 시
                        	  

                        	  
                        	  var title = jq1("#calendar_title").val();
                              var content = jq1("#calendar_content").val();
                              var start_date = jq1("#calendar_start_date").val();
                              
                              var end_date = jq1("#calendar_end_date").val();
                              var check = 0; // 조건에 걸리는지 확인
                              
                              console.log("start_date");
                              console.log(start_date);
                              

                             console.log(all_events.length);
                				
                          	for(var j=0;j<all_events.length;j++)
                    		{

                    			if(all_events[j].id == title && all_events[j].id != null)
                    			{           
                    				
                    				check = 1;
                    				
                    			}
                    		}

                              //내용 입력 여부 확인
                              if(check == "1"){
                    				alert("제목은 중복될 수 없습니다.");
                    				jq1('#calendar_title').val('');
                              }
                              else if( title == null || title == "" ){

                                  alert("내용을 입력하세요.");
                              }else if(content == null || content == ""){
                            	  alert("제목을 입력하세요.");
                              }else if(start_date == "" || end_date ==""){
                                  alert("날짜를 입력하세요.");
                              }else if(new Date(end_date)- new Date(start_date) < 0){ // date 타입으로 변경 후 확인
                                  alert("종료일이 시작일보다 먼저입니다.");
                              }else{ // 정상적인 입력 시
                                 
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

                           
                           var obj = 
                           {
                        			"id" : title,
                        			"name" : loginid,

																			"title" : content,
																			"start" : start_date,
																			"end" : m_end_dt,
																			"allDay" : true
																		}//전송할 객체 생성

																		console
																				.log(m_end_dt);
																		console
																				.log('obj = '
																						+ obj);
																		adddata(obj);
																		
																		if (obj != null)
																			i++;

																		calendar
																				.addEvent({
																					id : title,
																					title : content,
																					start : start_date,
																					end : m_end_dt,
																					allDay : true
																				})

																		/*
																		var allEvent =	 calendar.getEvents();
																		
																		console.log('allEvent[0] = ');
																		console.log(allEvent[0].title);
																		console.log(allEvent[0].start);
																		console.log(allEvent[0].end);
																		console.log(allEvent[0].allDay);
																		
																		
																		var startevent = moment(allEvent[0]._instance.range.start).format("YYYY-MM-DD");
																		var endevent = moment(allEvent[0]._instance.range.end).format("YYYY-MM-DD");
																		
																		//allday의 start end를 yyyy-mm-dd로 가공
																		
																		console.log('startevent');
																		console.log(startevent);

																		console.log('endevent');
																		console.log(endevent);
																		 */

																	}
																	jq1(
																			'#calendarModal')
																			.modal(
																					'hide');
																});

											}
										}
									},

									initialView : 'dayGridMonth',
									editable : true,
									displayEventTime : false,
									dayMaxEvents : true,
									locale : 'ko',
									events : all_events,
									buttonText : {
										today : '오늘',
										month : '달력',
										list : '일정'

									},

									eventAdd : function(obj) {

										console.log(obj);
										console.log('추가');

									},
									eventChange : function(obj) {
										console.log(obj);
										console.log('수정');

									},
									eventRemove : function(obj) {
										console.log(obj);
										console.log('삭제');

									},
									eventClick : function(arg) {
										jq1('#calendarModal #modifyCalendar')
												.css('display', 'inline');
										jq1('#calendarModal #deleteCalendar')
												.css('display', 'inline');
										
										var arg_admin, arg_name; 
										
										for(var i=0;i<all_events.length;i++)
										{
											
											if(all_events[i].title == arg.event.title)
											{
												
												arg_name = all_events[i].name;
												//admin을 calendar 테이블에 입력하는게 아니라
												//로그인 한 아이디의 admin 여부를 판별해야함
												
												//admin을 calendar 테이블에 입력하는게 아니라
												//로그인 한 아이디의 admin 여부를 판별해야함
		
											}	
										}
										console.log("여기까지왔어요");
										
										var arg_admin = getadmin(loginid);
		
										
										console.log(arg_admin);
										
										console.log("arg_name");
										console.log(arg_name);
										
										//console.log("arg_id");
										//console.log(arg_id);
										
										console.log("loginid");
										console.log(loginid);

										insertModalOpen(arg, arg_admin, arg_name, loginid);//이벤트 클릭 시 모달 호출

									}

								});
						calendar.render();
					});(jQuery);

	function loadingEvents() {
		var resultdata;
		jq1.ajax({
			type : 'POST',
			url : '${pageContext.request.contextPath}/show.calendar',
			dataType : "json",
			async : false,

			success : function(result) {
				resultdata = result;
				console.log('db에서 값 가져오기 완료');

				console.log(result);
				console.log('resultdata = ');
				console.log(resultdata);
			},
			error : function(request, status, error) {
			},
			complete : function() {

			}
		})

		return resultdata;
	}

	function adddata(jsondata) {
		console.log(jsondata);
		jq1.ajax({
			type : 'POST',
			url : '${pageContext.request.contextPath}/add.calendar',
			data : jsondata,
			dataType : "text",
			async : true,
			success : function(rdata) {
				console.log('db 저장 완료.');
				document.location.reload();
			},
			error : function(request, status, error) {
			},
			complete : function() {
			}
		})
	}

	function updatedata(arg) {

		var title = jq1("#calendar_title").val();
		var content = jq1("#calendar_content").val();
		var start_date = jq1("#calendar_start_date").val();
		var end_date = jq1("#calendar_end_date").val();
		var check = 0;
		
		console.log("start_date");
		console.log(start_date);

 
		if( title == null || title == "" ){

			alert("내용을 입력하세요.");

		} else if (start_date == "" || end_date == "") {
			alert("날짜를 입력하세요.");
		} else if (new Date(end_date) - new Date(start_date) < 0) { // date 타입으로 변경 후 확인
			alert("종료일이 시작일보다 먼저입니다.");
		} else { // 정상적인 입력 시

			var m_end = new Date(end_date.substr(0, 4),
					end_date.substr(5, 2) - 1, end_date.substr(8, 2));

			m_end.setDate(m_end.getDate() + 1);

			console.log(end_date);
			console.log(m_end);
			console.log(m_end.getFullYear());
			console.log(m_end.getMonth() + 1);

			if (m_end.getMonth() + 1 < 10 && m_end.getDate() < 10) {
				var m_end_dt = m_end.getFullYear() + '-0'
						+ (m_end.getMonth() + 1) + '-0' + m_end.getDate();
			} else if (m_end.getMonth() + 1 < 10 && m_end.getDate() >= 10) {
				var m_end_dt = m_end.getFullYear() + '-0'
						+ (m_end.getMonth() + 1) + '-' + m_end.getDate();
			} else if (m_end.getMonth() + 1 >= 10 && m_end.getDate() < 10) {
				var m_end_dt = m_end.getFullYear() + '-'
						+ (m_end.getMonth() + 1) + '-0' + m_end.getDate();
			} else if (m_end.getMonth() + 1 >= 10 && m_end.getDate() >= 10) {
				var m_end_dt = m_end.getFullYear() + '-'
						+ (m_end.getMonth() + 1) + '-' + m_end.getDate();
			}
		}

		var data = {

			"title" : content,
			"id" : title,
			"start" : start_date,
			"end" : m_end_dt,
			"allDay" : true
		};

		console.log(data);

		jq1.ajax({
			url : "${pageContext.request.contextPath}/update.calendar",
			type : "POST",
			data : data,
			dataType : "text",

			success : function(data) {

				jq1('#calendarModal').modal('hide');
				document.location.reload();
				console.log("event 수정 완료");
				

				g_arg = null;
				
			},
			error : function(data) {
				//alert(xhr.responseText);
				alert('일정 수정 실패, 새로고침 후 재시도 해주세요');
				document.location.reload();
			}
		});
	
	}

	function insertModalOpen(arg, admin, name, loginid) {

		jq1('#calendarModal #addCalendar').css('display', 'none');
		jq1("#calendarModal #calendar_title").attr("readonly",true); 

		
		console.log("name");
		console.log(name);
		
		console.log("loginid");
		console.log(loginid);
		
		//관리자 admin은 나중에 추가
		
		if(name != loginid && admin !="true")
		{
            jq1('#calendarModal #modifyCalendar').css('display', 'none');
			jq1('#calendarModal #deleteCalendar').css('display', 'none');
		}

		g_arg = arg;

		var m_end = new Date(g_arg.event.endStr.substr(0, 4),
				g_arg.event.endStr.substr(5, 2) - 1, g_arg.event.endStr.substr(8, 2));
		
		m_end.setDate(m_end.getDate()-1);

		console.log(m_end);
		console.log(m_end.getFullYear());
		console.log(m_end.getMonth() + 1);

		if (m_end.getMonth() + 1 < 10 && m_end.getDate() < 10) {
			var m_end_dt = m_end.getFullYear() + '-0'
					+ (m_end.getMonth() + 1) + '-0' + m_end.getDate();
		} else if (m_end.getMonth() + 1 < 10 && m_end.getDate() >= 10) {
			var m_end_dt = m_end.getFullYear() + '-0'
					+ (m_end.getMonth() + 1) + '-' + m_end.getDate();
		} else if (m_end.getMonth() + 1 >= 10 && m_end.getDate() < 10) {
			var m_end_dt = m_end.getFullYear() + '-'
					+ (m_end.getMonth() + 1) + '-0' + m_end.getDate();
		} else if (m_end.getMonth() + 1 >= 10 && m_end.getDate() >= 10) {
			var m_end_dt = m_end.getFullYear() + '-'
					+ (m_end.getMonth() + 1) + '-' + m_end.getDate();
		}
		
		console.log("m_end_dt");
		console.log(m_end_dt);
		
		//console.log(g_arg.event.start.getHours()+':'+g_arg.event.start.getMinutes());
		//값이 있는경우 세팅
		if (g_arg.event != undefined) {

			
			jq1('#calendarModal #calendar_title').val(g_arg.event.id);
			jq1('#calendarModal #calendar_content').val(g_arg.event.title);
			jq1('#calendarModal #calendar_start_date').val(g_arg.event.startStr);
			jq1('#calendarModal #calendar_end_date').val(m_end_dt);

		}
		//모달창 show
		jq1('#calendarModal').modal('show');

	}

	
	function deletecal(arg) {
		if (confirm('일정을 삭제하시겠습니까?')) {
			var data = {
				"title" : arg.event.title,
				"id" : arg.event.id
			};

			console.log(arg.event.id);

			//DB 삭제

			jq1.ajax({
				url : "${pageContext.request.contextPath}/delete.calendar",
				type : "POST",
				data : data,
				dataType : "text",

				success : function(data) {

					arg.event.remove();
					jq1('#calendarModal').modal('hide');
					console.log("event.remove 완료");

					g_arg = null;
				},
				error : function(data) {
					//alert(xhr.responseText);
										
					alert('일정 삭제 실패 새로고침 후 재시도 해주세요');
					jq1('#calendarModal').modal('hide');
					document.location.reload();
				}
			});
			//
		}
	}
	
	function getadmin(loginid) {
			var admin2;
			var data = {
				"id" : loginid
			};
			console.log("admin 정보의 loginid");
			console.log(loginid);

			

			jq1.ajax({
				url : "${pageContext.request.contextPath}/getadmin.calendar",
				type : "POST",
				data : data,
				dataType : "text",
				async: false,

				success : function(data) {

					admin2 = data;
					
					console.log("admin");
					console.log(admin2);
					console.log("admin 가져오기 완료");

					
				},
				error : function(data) {
					//alert(xhr.responseText);
					jq1('#calendarModal').modal('hide');
					document.location.reload();
					alert('admin 생성 실패');
				}
			});
			
			return admin2;

		}
	
</script>
</head>
<style>


</style>
<body>

<jsp:include page="../home/side.jsp" />



<div class="content">
<jsp:include page="../home/header2.jsp" />
<div id='calendar'></div>
<div class="container-fluid pt-4 px-4">

		

	</div>
	</div>





	<!-- modal 추가 -->

	<div class="modal fade insertModal" id="calendarModal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
						<label for="taskId" class="col-form-label">일정 제목</label> <input
							type="text" class="form-control" id="calendar_title"
							name="calendar_title"> <label for="taskId"
							class="col-form-label">일정 내용</label> <input type="text"
							class="form-control" id="calendar_content"
							name="calendar_content"> 
							<label for="taskId"
							class="col-form-label">시작 날짜</label> <input type="date"
							class="form-control" id="calendar_start_date"
							name="calendar_start_date" value="2023-02-14">
							<label for="taskId"
							class="col-form-label">종료 날짜</label> <input type="date"
							class="form-control" id="calendar_end_date"
							name="calendar_end_date">
					</div>
				</div>
				<div class="modal-footer">

					<button type="button" class="btn btn-success" id="modifyCalendar"
						onclick="updatedata(g_arg)">수정</button>
					<button type="button" class="btn btn-danger" id="deleteCalendar"
						onclick="deletecal(g_arg)">삭제</button>

					<button type="button" class="btn btn-secondary" id="addCalendar">추가</button>

					<button type="button" class="btn btn-dark" data-dismiss="modal"
						id="sprintSettingModalClose" data-backdrop="static"
						data-keybord="false">닫기</button>
				</div>

			</div>
		</div>
	</div>

<footer>
<jsp:include page="../home/bottom.jsp" />
</footer>

<script>


</script>

</body>
</html>
