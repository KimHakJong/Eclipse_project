<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<title>Insert title here</title>
<script>
	let time = 0; 
	let starFlag = true; // start클릭시 false
	$(document).ready(function(){
	  buttonEvt();
	});
	
	function init(){
		$("#time").text("00:00:00");
	}
	
	function buttonEvt(){
		let hour = 0; //시
		let min = 0;  //분
		let sec = 0;  //초
		let timer; // setInterval()
	
	  // start btn
	  $("#startbtn").click(function(){
	
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
	       
	        $("#time").text(th + ":" + tm + ":" + ts);
	        
	      }, 1000);
	    }
	  });
	
	  // 멈출때
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
	<div id="time" class="time">00:00:00</div>
	<button type="button" id="startbtn" class="fa fa-play" aria-hidden="true"></button> 
	<button type="button" id="pausebtn" class="fa fa-pause" aria-hidden="true"></button>
	<button type="button" id="stopbtn" class="fa fa-stop" aria-hidden="true"></button>
</body>
</html>