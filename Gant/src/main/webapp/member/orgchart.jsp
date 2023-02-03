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
li{list-style-type:none}
div>ul>li>ul>li>ul>li {position:relative; left:-50px}
</style>
<script>
$(document).ready(function(){
    $(".menu>a").click(function(){
    	$(this).next("ul").toggle();
    });
    
    function ajax(){
    	$.ajax({
	    	url : 'orgchart.net',
	    	dataType : 'json',
	    	success : function(rdata){
	    		
	    	}
    });
    }
});
</script>
</head>
<body>
<div>
<ul>
<li class="menu"><a>조직도 열기</a>
  <ul class="hide">
  <li>
	<ul>
		<li class="menu"><a>대표이사</a>
		<ul class="hide">
		<li>

		<ul>
		<li class="menu"><a>기획부</a>
		    	<ul class="hide">
		    		<li>김</li>
		    		<li>김</li>
		    		<li>김</li>
		    	</ul>
		    </li>	
		    
		    <li class="menu"><a>영업부</a>
				<ul class="hide">
		    		<li>이</li>
		    		<li>이</li>
		    		<li>이</li>
		    	</ul>
		    </li>
		    			    
		    <li class="menu"><a>인사부</a>
		    	<ul class="hide">
		    		<li>신</li>
		    		<li>신</li>
		    		<li>신</li>
		    	</ul>
		    </li>
		    	
		    <li class="menu"><a>전산부</a>
		    	<ul class="hide">
		    		<li>신</li>
		    		<li>신</li>
		    		<li>신</li>
		    	</ul>
		    </li>
		    	
		    <li class="menu"><a>총무부</a>
		    	<ul class="hide">
		    		<li>신</li>
		    		<li>신</li>
		    		<li>신</li>
		    	</ul>
		    </li>
		    	
		    <li class="menu"><a>회계부</a>
		    	<ul class="hide">
		    		<li>신</li>
		    		<li>신</li>
		    		<li>신</li>
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