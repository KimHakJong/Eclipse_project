<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .menu a{cursor:pointer;}
    .menu .hide{display:none;}
.organization {border:1px solid #C4C5C8;
display:inline-block;
 width:100%; height:100%; padding:10px;
 overflow:auto}
 
.organization::-webkit-scrollbar {
           width: 7px; /*스크롤바의 너비*/
}
.organization::-webkit-scrollbar-thumb {
    height: 30%; /* 스크롤바의 길이 */
    background: black; /* 스크롤바의 색상 */
    
    border-radius: 10px;
}

.organization::-webkit-scrollbar-track {
    background-color: transparent;  /*스크롤바 뒷 배경 색상*/
} 
 
.oragnization>ul>li{position:relative; left:0px;}
ul{margin:0; padding:0}
li{list-style-type:none}
.menu{width:120px; font-size:15px}
.organization>ul>li>ul>li>ul>li {position:relative; left:30px;}
.organization>ul>li>ul>li>ul>li>ul>li>ul>li{position:relative; left:30px; font-size:15px}
.menu img{width:20px;height:20px; margin:0px 4px 4px 0px}
.plan>li, .sales>li, .human>li, .it>li, .chong>li, .account>li
{position:relative; left:60px; width:90px}
</style>
<script>
$(document).ready(function(){
    $(".menu>a").click(function(){ //플러스마이너스아이콘, show-hide
   		if($(this).find('img').attr('src')=='member/image/plus.png'){
   			$(this).find('img').attr('src','member/image/minus.png');
   		}else{
   			$(this).find('img').attr('src','member/image/plus.png');
   		}
    	$(this).next("ul").toggle();
    });
    
    ajax();
    function ajax(){
    	$.ajax({
	    	url : '${pageContext.request.contextPath}/orgchart.net',
	    	dataType: "json",
	    	success : function(rdata){
	    		
	    		var dname = ["plan","sales","human","it","chong","account"];
				let name;
	    		for(var i=0; i<dname.length; i++){
	    		output = "";
	    		if(i==0){
	    			name=rdata.plan.split(",");
	    		}else if(i==1){
	    			name = rdata.sales.split(",");
	    		}else if(i==2){
	    			name = rdata.human.split(",");
	    		}else if(i==3){
	    			name = rdata.it.split(",");
	    		}else if(i==4){
	    			name = rdata.chong.split(",");
	    		}else if(i==5){
	    			name = rdata.account.split(",");
	    		}
	    		
				for(var j=0; j<name.length-1; j++){
					output += "<li>" + name[j] + "</li>";
				}
				
				$("."+dname[i]).append(output);
				
				}//for end
	    	},//success
	    	complete : function(){
   				$('.plan, .sales, .human, .it, .chong, .account').find('li').prepend("<img src='member/image/people.png'>");
	    	}
    	}) //ajax
   	}; //function
   	
   	});
</script>
</head>
<body>
<div class="organization">
<ul>
<li class="menu"><a><img src="member/image/plus.png">조직도 열기</a>
  <ul class="hide">
  <li>
	<ul>
		<li class="menu"><a><img src="member/image/plus.png">대표</a>
		<ul class="hide">
		<li>

		<ul>
		<li class="menu"><a><img src="member/image/plus.png">기획부</a>
		    	<ul class="hide plan">
		    		
		    	</ul>
		    </li>	
		    
		    <li class="menu"><a><img src="member/image/plus.png">영업부</a>
				<ul class="hide sales">
		    	</ul>
		    </li>
		    			    
		    <li class="menu"><a><img src="member/image/plus.png">인사부</a>
		    	<ul class="hide human">
		    	</ul>
		    </li>
		    	
		    <li class="menu"><a><img src="member/image/plus.png">전산부</a>
		    	<ul class="hide it">
		    	</ul>
		    </li>
		    	
		    <li class="menu"><a><img src="member/image/plus.png">총무부</a>
		    	<ul class="hide chong">
		    	</ul>
		    </li>
		    	
		    <li class="menu"><a><img src="member/image/plus.png">회계부</a>
		    	<ul class="hide account">
		    	</ul>
		    </li>
		</ul>
			</li>
		</ul>
		</li>
	</ul>	
	  </li>
  </ul>
  </li>
  </ul>
</div>
</body>
</html>