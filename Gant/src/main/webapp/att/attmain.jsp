<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>    
<head>
 <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="att/att_css/main.css">
<title>근태관리</title>
<script>
	let work_today = "#work_today";
	let work_week = "#work_week";
	let overtime = "#overtime";
	$(document).ready(function(){
		work_today_Fun(work_today);//출근버튼 클릭시 주간총근무시간 타이머가 돌아간다.
		work_week_Fun(work_week);// 출근버튼 클릭시 오늘 총 근무시간 타이머가 돌아간다.
        
		setTimeout(function() {
		overtime_Fun(overtime);
		}, 32400000); //밀리세컨드로 9시간은 32400000 이다. 9시간이 지나도 퇴근을찍지 않는다면 실행된다. 
		
	});


	
	function init(){
		$("#time").text("00:00:00");
	}
	
	/* function end(name,id){ // 퇴근버튼 이벤트 함수 
		$("#end").click(function(){
			 $("input[name="+name+"]").val("00:00:00"); //input으로 시간 넘기기
			  if(time != 0){
				  clearInterval(timer); // setInterval stop
				  starFlag = true;
				  time = 0; 
			  }
		  });
	} */
	
	
	// 하루 총 근무 타이머 함수
	function work_today_Fun(id){
		let time = 0; 
		let starFlag = true; // start클릭시 false
		let hour = 0; //시
		let min = 0;  //분
		let sec = 0;  //초
		let timer; // setInterval()
	
	  // 출근버튼 
	  $("#start").click(function(){
	    if(starFlag){
	      starFlag = false;
	      if(time == 0){ //time이 0이면 시간 초기화
	        init(); 
	      }
	
	      timer = setInterval(function(){
	        time++;
	        
	      //Math.floor()항상 내림하고 주어진 숫자보다 작거나 같은 가장 큰 정수를 반환합니다.
	                                   //time = 1(1초)  60(1분)   3600(1시간)
	        min = Math.floor(time/60); //       0         1       60
	        hour = Math.floor(min/60);//        0         0        1
	        sec = time%60;            //        1         0        0
	        min = min%60;             //        0         1        0
	
	        
	        // 시 분 초 가 1의 자리일때 두번째자리는 0 이 붙는다. 01 : 02 : 13
	        let th = hour;
	        let tm = min;
	        let ts = sec;
	        if(th<10){
	        th = "0" + hour;
	        }
	        if(tm < 10){
	        tm = "0" + min;
	        }
	        if(ts < 10){
	        ts = "0" + sec;
	        }
	       
	        $(id).text(th + ":" + tm + ":" + ts);
	      }, 1000);
	    }
	  });
	
		
		//퇴근버튼 
	  $("#end").click(function(){
			  if(time != 0){
				  $("#today").val($("#work_today").text()); //input으로 시간 넘기기
				  clearInterval(timer); // setInterval stop
				  starFlag = true;
				  time = 0; 
			  }
		  });
		
	}//work_today_Fun

	
	
	
	// 주간 총 근무타이머 함수
	function work_week_Fun(id){
	   let time = 0; //시간을 숫자로 나타낸 변수 
	   let now = new Date(); // 현재 날짜 및 시간
       const week_array = ['일', '월', '화', '수', '목', '금', '토'];
	   let datOfweek = week_array[now.getDay()]; //오늘 요일을 숫자로 반환 일요일 = 0 ,월요일 = 1 ...
	   console.log("오늘의 요일은 :"+datOfweek); //오늘 요일을 표시 	
	   
		if(datOfweek == '월'){// 요일이 월요일이면 time을 0으로지정 : 주간 총 근무시간이기때문에 월요일이면 00:00:00으로 다시시작
		 time = 0; 
		}else{ // 월요일이 아니면 기존에 근무타임을 이어나간다. time 변수는 초를 나타낸다
		let worktimes = $("#work_week").text().split(":"); //기존에 근무 타임을 초로 바꾸는 과정이다.
		//문자열을 숫자로 
		let h = parseInt(worktimes[0]); 
		let m = parseInt(worktimes[1]); 
		let s = parseInt(worktimes[2]);
		console.log("시간:"+h+",분:"+m+",초:"+s);
		//시 분 초 를 초로 변환하는 과정 //시간*60*60 , 분*60 , 초 
		 time = (h*60*60)+(m*60)+s ;
		console.log("누적 근무시간 :"+time); //누적 근무시간
		}
		let starFlag = true; // start클릭시 false 
		let hour = 0; //시
		let min = 0;  //분
		let sec = 0;  //초
		let timer; // setInterval()
	
	  // 출근버튼 
	  $("#start").click(function(){
	    if(starFlag){
	      starFlag = false;
	      timer = setInterval(function(){
	      time++;
	        
	      //Math.floor()항상 내림하고 주어진 숫자보다 작거나 같은 가장 큰 정수를 반환합니다.
	                                   //time = 1(1초)  60(1분)   3600(1시간)
	        min = Math.floor(time/60); //       0         1       60
	        hour = Math.floor(min/60);//        0         0        1
	        sec = time%60;            //        1         0        0
	        min = min%60;             //        0         1        0
	
	        
	        // 시 분 초 가 1의 자리일때 두번째자리는 0 이 붙는다. 01 : 02 : 13
	        let th = hour;
	        let tm = min;
	        let ts = sec;
	        if(th<10){
	        th = "0" + hour;
	        }
	        if(tm < 10){
	        tm = "0" + min;
	        }
	        if(ts < 10){
	        ts = "0" + sec;
	        }
	       
	        $(id).text(th + ":" + tm + ":" + ts);
	      }, 1000);
	    }
	  });
	
		
		//퇴근버튼함수
	  //end("week",id);
	  $("#end").click(function(){
		  if(time != 0){
			  $("#week").val($("#work_week").text()); //input으로 시간 넘기기
			  clearInterval(timer); // setInterval stop
			  starFlag = true;
			  time = 0; 
		  }
	  });	
		
	}//work_week_Fun
	
	
	
	// 초가근무 근무타이머
	function overtime_Fun(id){
		let time = 0; 
		let starFlag = true; // start클릭시 false
		let hour = 0; //시
		let min = 0;  //분
		let sec = 0;  //초
		let timer; // setInterval()
	
	  // 초가 근무타이머는 click이벤트를 사용하지 않는다.
	  // setTimeout을 이용하여 9시간(점심시간을 포함한 시간)이 지나면 실행되게 할것이다.
	    if(starFlag){
	      starFlag = false;
	      if(time == 0){ //time이 0이면 시간 초기화
	        init(); 
	      }
	
	      timer = setInterval(function(){
	        time++;
	        
	      //Math.floor()항상 내림하고 주어진 숫자보다 작거나 같은 가장 큰 정수를 반환합니다.
	                                   //time = 1(1초)  60(1분)   3600(1시간)
	        min = Math.floor(time/60); //       0         1       60
	        hour = Math.floor(min/60);//        0         0        1
	        sec = time%60;            //        1         0        0
	        min = min%60;             //        0         1        0
	
	        
	        // 시 분 초 가 1의 자리일때 두번째자리는 0 이 붙는다. 01 : 02 : 13
	        let th = hour;
	        let tm = min;
	        let ts = sec;
	        if(th<10){
	        th = "0" + hour;
	        }
	        if(tm < 10){
	        tm = "0" + min;
	        }
	        if(ts < 10){
	        ts = "0" + sec;
	        }
	       
	        $(id).text(th + ":" + tm + ":" + ts);
	      }, 1000);
	    }
	

	  //퇴근버튼함수
	    $("#end").click(function(){
			  if(time != 0){
				  $("#over").val($("#overtime").text()); //input으로 시간 넘기기
				  clearInterval(timer); // setInterval stop
				  starFlag = true;
				  time = 0; 
			  }
		  });	
		
	}//overtime_Fun
	
	
	
	
</script>
</head>
<body>
<div class="container mt-3">
          <form method="post" id="send" action="TimeUpdate.att">
                <div id="swa_header">
                    <div class="row">                    
                            <h2>근태관리</h2>               
                    </div>
                </div>
                
                <div class="watch">            
  
                            <span class="swa_dial">
                                <span class="watch_name">주간<br>총 근무시간</span><br>
                                <span id="work_week">${work_week}</span> 
                                <input type="hidden" name="week" id="week">                    
                            </span> 
                               
                            <span class="swa_dial">
                                 <span class="watch_name">오늘<br>총 근무시간</span><br>
                                 <span id="work_today"> 00:00:00</span>
                                  <input type="hidden" name="today" id="today">                             
                            </span>

                            <span class="swa_dial">
                              <span class="watch_name">초과<br>총 근무시간</span><br>
                              <span id="overtime"> 00:00:00</span>
                               <input type="hidden" name="over" id="over">             
                            </span>
                </div> 
                           
               <div id="workbutton">
                      <div id="gotowork">                 
                     <button  type="button" class="btn btn-outline-primary" id="start">출근</button>
                     </div>
                     <div id="leavework">
                     <button type="submit" class="btn btn-outline-primary" id="end">퇴근</button>
                     </div>
               </div>       
           </form> 
          
          
           <div id="work">  
           <button  type="button" class="btn btn-success" id="overtime_apply">근태신청</button>
            <h5>나의 근무 현황</h5>
		      <div class="progress">
		       <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="50"
		       aria-valuemin="0" aria-valuemax="100" style="width:50%">
		     50%
             </div>
            </div>
          </div>
          
           <div id="work">  
           <button  type="button" class="btn btn-success" id="vacation">휴가신청</button>
            <h5>나의 휴가 현황</h5>
		      <div class="progress">
		       <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="50"
		       aria-valuemin="0" aria-valuemax="100" style="width:50%">
		     50% 
             </div>
            </div>
          </div>
     

     
     </div>

</body>
</html>