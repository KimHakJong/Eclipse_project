<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%
request.setCharacterEncoding("utf-8");
String sessionId = (String) (session.getAttribute("id"));



//sessionId = "id";//임시로 id설정

System.out.println(sessionId);


%>

<!DOCTYPE html>
<html>
<head>






<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- bootstrap 4 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
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


<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment-with-locales.min.js"
	integrity="sha512-42PE0rd+wZ2hNXftlM78BSehIGzezNeQuzihiBCvUEB3CVxHvsShF86wBWwQORNxNINlBPuq7rG4WWhNiTVHFg=="
	crossorigin="anonymous" referrerpolicy="no-referrer">

</script>

<style>
@import
	url('https://fonts.googleapis.com/css2?family=Lato&display=swap');

body {
	padding: 0;
	font-size: 14px;
}

#calendar {
	max-width: 3000px;
	margin: 0 auto;
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

 var calendar = null;
 $(document).ready(function() {
	    	
	 var i=0;
	 
            $('#xbutton').on('click', function(){
                $('#calendarModal').modal('hide');
            })
            $('#sprintSettingModalClose').on('click', function(){
                $('#calendarModal').modal('hide');
            })
            
            $('#deleteCalendar').on('click', function(){
                alert("정말 삭제하시겠습니까?");
                deletedata()
         
            })
 


			var all_events = null;
           var calendarEl = document.getElementById('calendar');

		all_events = loadingEvents();
		

		console.log("<%=sessionId%>");



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

                          $('#calendarModal #modifyCalendar').css('display', 'none');
            				$('#calendarModal #deleteCalendar').css('display', 'none');
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
                        "name" : "<%=sessionId%>",
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

																		calendar
																				.addEvent({

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
																	$(
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

									eventAdd : function(obj) {

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
										$('#calendarModal #modifyCalendar')
												.css('display', 'inline');
										$('#calendarModal #deleteCalendar')
												.css('display', 'inline');
										$("#calendarModal").modal("show");

										//insertModalOpen(arg); //이벤트 클릭 시 모달 호출
									}

								});
						calendar.render();
					});

	function loadingEvents() {
		var resultdata;
		$.ajax({
			type : 'POST',
			url : '${pageContext.request.contextPath}/show.calendar',
			dataType : "json",
			async : false,

			success : function(result) {
				resultdata = result;
				console.log('이벤트 가져왔습니다.');

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
		$.ajax({
			type : 'POST',
			url : '${pageContext.request.contextPath}/add.calendar',
			data : jsondata,
			dataType : "json",
			async : true,
			success : function(rdata) {
				console.log('db 저장 완료.');
			},
			error : function(request, status, error) {
			},
			complete : function() {
			}
		})
	}
	/*
	function deletedata(jsondata) {
		console.log(jsondata);
		$.ajax({
			type : 'POST',
			url : '${pageContext.request.contextPath}/add.calendar',
			data : jsondata,
			dataType : "json",
			async : true,
			success : function(rdata) {
				console.log('db 저장 완료.');
			},
			error : function(request, status, error) {
			},
			complete : function() {
			}
		})
	}
	 */
	function deletecal(modal, arg) {
		if (confirm('일정을 삭제하시겠습니까?')) {
			var data = {
				"gubun" : "delete",
				"id" : arg.event.id,
				"allowyn" : "0"
			};
			//DB 삭제
			$.ajax({
				url : "${pageContext.request.contextPath}/delete.calendar",
				type : "POST",
				data : JSON.stringify(data),
				dataType : "JSON",
				traditional : true,
				success : function(data, status, xhr) {
					//alert(xhr.status);
					arg.event.remove();
					initModal(modal, arg);
				},
				error : function(xhr, status, error) {
					//alert(xhr.responseText);
					alert('일정 삭제 실패<br>새로고침 후 재시도 해주세요');
				}
			});
			//
		}
	}
</script>
</head>
<style>
.row {
	border: 1px solid black !important;
}

#logo {
	margin-top: 5% !important;
}
</style>
<body>

	<header>
		<jsp:include page="../home/header.jsp" />

	</header>



	<div class="row">
		<div class="side">
			<jsp:include page="../home/left.jsp" />

		</div>
		<br>
		<div id='calendar'></div>

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

					<button type="button" class="btn btn-success" id="modifyCalendar">수정</button>
					<button type="button" class="btn btn-danger" id="deleteCalendar"
						onclick="deletecal('insertModal', g_arg)">삭제</button>

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



</body>
</html>