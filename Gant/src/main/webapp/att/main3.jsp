<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>    
<head>
 <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="att_css/main.css">
<title>근태관리</title>
<script>
	let work_today = "#work_today";
	let work_week = "#work_week";
	$(document).ready(function(){
		 buttonEvt(work_week);
		 buttonEvt(work_today);
	});
	
	function init(){
		$("#time").text("00:00:00");
	}
	
	function buttonEvt(id){
		let time = 0; 
		let starFlag = true; // start클릭시 false
		let hour = 0; //시
		let min = 0;  //분
		let sec = 0;  //초
		let timer; // setInterval()
	
	  // 출근버튼 
	  $(".btn.btn-outline-primary").click(function(){
		  
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
	  $(".btn.btn-outline-primary").click(function(){
		  if(time != 0){
		  if(id == "#work_today"){ // 하루근무시간 퇴근하기 
			  clearInterval(timer);
			  $('input[name=work_today]').val($('#work_today]').text()); // hiddend에 값저장
			  starFlag = true;
			  time = 0;
		      init();
		  }
		  
		  }
		  
	  });
		
		
		//멈출때
	  $("#pausebtn").click(function(){
	    if(time != 0){
	      clearInterval(timer);
	      starFlag = true;
	    }
	  });
	
	  // 리셋할때
	  $("#stopbtn").click(function(){
	    if(time != 0){
	      clearInterval(timer);
	      starFlag = true;
	      time = 0;
	      init();
	    }
	  });	
		

	}
</script>
</head>
<body>
<div class="container mt-3">
          <form action="main.att"  method="post">
                <div id="swa_header">
                    <div class="row">                    
                            <h2>근태관리</h2>               
                    </div>
                </div>
                
                <div class="watch">            
  
                            <span class="swa_dial">
                                <span class="watch_name">주간<br>총 근무시간</span><br>
                                <span id="work_week">00:00:00</span>
                                <input type="hidden" name="work_week">
                            </span> 

                            <span class="swa_dial">
                                 <span class="watch_name">오늘<br>총 근무시간</span><br>
                                 <span id="work_today"> 00:00:00</span>
                                 <input type="hidden" name="work_today">
                            </span>

                            <span class="swa_dial">
                              <span class="watch_name">초과<br>총 근무시간</span><br>
                              <span id="overtime"> 00:00:00</span>
                              <input type="hidden" name="watch_name">
                            </span>
                </div> 
                
          
                               
               <div id="workbutton">
                      <div id="gotowork">                 
                     <button  type="button" class="btn btn-outline-primary">출근</button>
                     </div>
                     <div id="leavework">
                     <button type="submit" class="btn btn-outline-primary">퇴근</button>
                     </div>
               </div>       
           </form> 
          
          
           <div id="work">  
           <button  type="button" class="btn btn-success" id="overtime">근태신청</button>
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