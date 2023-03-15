<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<meta charset="UTF-8">
<script>
$(document).ready(function(){
	   
	   $( ".memo" ).draggable();
	   
		$('.chat').click(function(){
			var win;
			if(win){
				win.close();
				win = window.open('chat.sml', 'chat', 'width=500, height=450, top=170px, left=230px, resizable=no,menubar=no,status=no,titlebar=no,toolbar=no, scrollbars=no,directories=no,location=no');
			}
		});
	   })
</script>
<style>
.chat:hover {
color:#009CFF;
background:transparent;
}
 .openmemo:hover{
 color:#009CFF;
background:transparent;
 }
</style>
</head>
<body>
            <!-- Navbar Start -->
            <nav class="up navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
                <a href="index.html" class="navbar-brand d-flex d-lg-none me-4">
                    <h2 class="text-primary mb-0"><i class="fa fa-hashtag"></i></h2>
                </a>
                <a href="#" class="sidebar-toggler flex-shrink-0">
                    <i class="fa fa-bars"></i>
                </a>
                
                <div class="navbar-nav align-items-center ms-auto">
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                            <i class="fa fa-bell me-lg-2"></i>
                            <span class="d-none d-lg-inline-flex">알림</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                            <a href="#" class="dropdown-item">
                                <div class="d-flex align-items-center">
                                       <c:if test="${empty profileimg}">
	    									<img class="rounded-circle" src="member/image/defaultprofile.png"  alt="" style="width: 40px; height: 40px;">
	    								</c:if>
	    								<c:if test="${!empty profileimg}">
	    									<img class="rounded-circle" src="memberupload/${profileimg}"  alt="" style="width: 40px; height: 40px;">
	    								</c:if>                          
                                    <div class="ms-2">
                                        <h6 class="fw-normal mb-0">Jhon send you a message</h6>
                                        <small>15 minutes ago</small>
                                    </div>
                                </div>
                            </a>
                            <hr class="dropdown-divider">
                            <a href="#" class="dropdown-item">
                                <div class="d-flex align-items-center">
                                        <c:if test="${empty profileimg}">
	    									<img class="rounded-circle" src="member/image/defaultprofile.png"  alt="" style="width: 40px; height: 40px;">
	    								</c:if>
	    								<c:if test="${!empty profileimg}">
	    									<img class="rounded-circle" src="memberupload/${profileimg}"  alt="" style="width: 40px; height: 40px;">
	    								</c:if>                                      
                                    <div class="ms-2">
                                        <h6 class="fw-normal mb-0">Jhon send you a message</h6>
                                        <small>15 minutes ago</small>
                                    </div>
                                </div>
                            </a>
                            <hr class="dropdown-divider">
                            <a href="#" class="dropdown-item">
                                <div class="d-flex align-items-center">
                                       <c:if test="${empty profileimg}">
	    									<img class="rounded-circle" src="member/image/defaultprofile.png"  alt="" style="width: 40px; height: 40px;">
	    								</c:if>
	    								<c:if test="${!empty profileimg}">
	    									<img class="rounded-circle" src="memberupload/${profileimg}"  alt="" style="width: 40px; height: 40px;">
	    								</c:if>       
                                    <div class="ms-2">
                                        <h6 class="fw-normal mb-0">Jhon send you a message</h6>
                                        <small>15 minutes ago</small>
                                    </div>
                                </div>
                            </a>
                            <hr class="dropdown-divider">
                            <a href="#" class="dropdown-item text-center">알림</a>
                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                            <i class="fa fa-envelope me-lg-2"></i>
                            <span class="d-none d-lg-inline-flex">바로가기</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                       		
                            <a href="chat.sml" onClick="window.open('chat.sml', 'chat', 'width=500, height=450, top=170px, left=230px, resizable=no,menubar=no,status=no,titlebar=no,toolbar=no, scrollbars=no,directories=no,location=no'); return false;"
                               class="dropdown-item text-center chat">채팅</a>
                            <a href="avascript:void(0)" class="dropdown-item text-center openmemo">메모장</a>
                            
                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                        <c:if test="${empty profileimg}">
	    					<img class="rounded-circle me-lg-2" src="member/image/defaultprofile.png"  alt="" style="width: 40px; height: 40px;">
	    				</c:if>
	    				<c:if test="${!empty profileimg}">
	    					<img class="rounded-circle me-lg-2" src="memberupload/${profileimg}"  alt="" style="width: 40px; height: 40px;">
	    				</c:if>         
                            <span class="d-none d-lg-inline-flex">${name}</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                            <a href="update.home" class="dropdown-item">마이페이지</a>
                            <a href="logout.net" class="dropdown-item">로그아웃</a>
                        </div>
                    </div>
                </div>
            </nav>
            <!-- Navbar End -->
</body>
</html>