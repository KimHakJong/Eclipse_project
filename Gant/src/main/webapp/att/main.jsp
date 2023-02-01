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
</head>
<body>
<div class="container mt-3">
          
                <div id="swa_header">
                    <div class="row">                    
                            <h2>근태관리</h2>               
                    </div>
                </div>
                
                <div class="watch">            
  
                            <span class="swa_dial">
                                <span class="watch_name">주간<br>총 근무시간</span><br>
                                <span id="work_week"> 00:00:00</span>
                            </span> 

                            <span class="swa_dial">
                                 <span class="watch_name">오늘<br>총 근무시간</span><br>
                                 <span id="work_today"> 00:00:00</span>
                            </span>

                            <span class="swa_dial">
                              <span class="watch_name">초과<br>총 근무시간</span><br>
                              <span id="overtime"> 00:00:00</span>
                            </span>
                </div>  
                               
               <div id="workbutton">
                      <div id="gotowork">                 
                     <button  type="button" class="btn btn-outline-primary">출근</button>
                     </div>
                     <div id="leavework">
                     <button type="button" class="btn btn-outline-primary">퇴근</button>
                     </div>
               </div>       
          
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