<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
 <meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<style>
*{font-family:"noto sans", sans-serif;}
.memo {
		background-size: 100% 100%;
		width: 450px;
		height: 480px;
		position:fixed;
		z-index:2000;
		left: 320px;
  		top: 140px;
}

.btnChange {
    width: 200px;
    height: 30px;
    float: left;
    margin-left:23px;
    margin-top:21px;
    
}
.btnChange > img {
	width: 35px;
	height: 35px;
	cursor: pointer;
}
.back_colors {
	margin-left:10px;
	display:none;
}

.back_colors > img {
	width:18px;
	height:18px;
	border: 1px solid black;
	cursor:pointer;
}

.pen_colors {
    position: relative;
    top: 20px;
    left: 50px;
}

.pen_colors > img {
    width: 30px;
    height: 30px;
    cursor: pointer;
}

.memo_store {
    width: 50px;
    float: right;
    margin-right: 20px;
    margin-top: 19px;
    outline: none;
    background: black;
    height: 33px;
    color: white;
}
.memo .btnClose {
    width: 10px;
    cursor: pointer;
    float: right;
    margin-right: 40px;
    font-size: 40px;
    color: black;
}
	
	.memo .txtMemo {
		margin-left: 35px;
		margin-top: 16px;
		width: 360px;
		height: 350px;
		resize: none;
		border: 0;
		outline: none;
		background-color: transparent;
		font-weight:bold;
		font-size:16px;
	}
	
	.memo .txtMemo::-webkit-scrollbar {
    	width: 5px;
  	}
  	.memo .txtMemo::-webkit-scrollbar-thumb {
    	background-color: black;
    	border-radius: 10px;
	    background-clip: padding-box;
	    border: 2px solid transparent;
 	 }
  	..memo .txtMemo::-webkit-scrollbar-track {
    	background-color: grey;
    	border-radius: 10px;
    	box-shadow: inset 0px 0px 5px white;
  	}
  	
  	.memo{display:none}
</style>
<script>
$(document).ready(function(){
	
	$('.btnChange > img').click(function(){ //배경색 이미지목록을 열고 닫음
		$('.back_colors').toggle();
	});
	
	$('.back_colors>img').click(function(){ //배경색 클릭하면 그색으로 바뀜
		memoBackground = $(this).attr('src');
		$('.memo').css('background-image',"url('"+ memoBackground + "')");
		$('.back_colors').css('display','none');
	});
	
	$('.pen_colors > img').click(function(){  //연필모양클릭하면 그색으로 바뀜
		console.log($('.txtMemo').css('color'));
		if($('.txtMemo').css('color')=='rgb(0, 0, 0)'){ //검은색일때 클릭하면, 흰색으로 바뀌고->겅믄색그림색그림
			$('.txtMemo').css('color','white');
			$(this).attr('src','memo/image/color-black.png');
		}else if($('.txtMemo').css('color')=='rgb(255, 255, 255)'){//흰색일 때 클릭하면, 검은색으로 바뀌고->흰색 그림
			$('.txtMemo').css('color','black');
			$(this).attr('src','memo/image/color-white.png');
		}
	});
	
	$('.openmemo').click(function(e){
	    e.preventDefault();
		
	  	//열려있는 상태에서 또 열면 입력된 데이터가 삭제되고 다시 저장되어 있던 데이터가 불러와짐 방지
		if($('.memo').css('display')=='none'){
			//열려지면서 ajax로 데이터 받아옴
			$('.memo').css('display','block');
			var id = '${id}';
		
			$.ajax({
			 url : "memo.sml",
			 data : {"id" : id},
			 dataType : "json",
			 success : function(Mdata){
		 	   if(!Mdata.addrow==1) {
		  			$('.memo').css('background-image',"url('memo/image/"+ Mdata.background + "')"); //배경색 불러온 대로 설정
		  			
		  			if(Mdata.color == 'rgb(0, 0, 0)'){ //불러온 색과 반대색이 위에 그림에 표시되도록, 글자색 설정
		  				$('.pen_colors>img').attr('src',"memo/image/color-white.png");
		  				$('.memo .txtMemo').css('color','rgb(0, 0, 0)');
		  			}else{
		  				$('.memo .txtMemo').css('color','rgb(255, 255, 255)');
		  				$('.pen_colors>img').attr('src',"memo/image/color-black.png");
		  			}
		  			
		  			$('.txtMemo').val(Mdata.content); //저장되어있던 내용 불러옴
		  			storedText = Mdata.content; //메모장 종료할 때 값변경되었는지 확인하기 위해
		  			storedBack = Mdata.background;
		  			storedColor = Mdata.color;
		  			console.log("기존회원="+storedBack+"<and>"+ storedColor);
		  			
		  		}else{ //막 회원가입하여 방금 메모장테이블 row가 생성된 경우 사용법 알림창
		  			alert("색변경 및 메모장 작성 후엔\n꼭 저장해주시기 바랍니다.");
		  			storedText="";
		  			storedBack = "memo-yellow.png";
		  			storedColor = "rgb(0, 0, 0)";
		  			console.log("첫회원="+storedBack+"<and>"+ storedColor);
		  	    }
	  	  	  }//success
			}); //ajax
	    }//if end
	}); //openmemo end
		
		$('.btnClose').click(function(){ //메모장 종료
			let length = $('.memo').css('background-image').length;
			if(storedText!=$('.txtMemo').val() || storedBack!=$('.memo').css('background-image').substring(43,length-2) || storedColor!=$('.txtMemo').css('color')){
				var close = confirm("데이터 변경 후 저장되지 않았습니다.\n정말 종료하시겠습니까?");
				
				if(close) { //확인
					$('.memo').css('display','none');
				}
			}else{
				$('.memo').css('display','none');
			}
		});
		
		$('.memo_store').click(function(){ //메모장 저장
			let id = "${id}";
			
			let length = $('.memo').css('background-image').length;
			console.log($('.memo').css('background-image').substring(43,length-2));
			let background = $('.memo').css('background-image').substring(43,length-2); //배경색이미지값만 추출
			let	color = $('.txtMemo').css('color');
			let content = $('.txtMemo').val();
			
			$.ajax({
				url : 'memoupdate.sml',
				data : {"id" : id, "background" : background, "color":color, "content":content},
				dataType : "json",
				success : function(rdata){
					if(rdata == 1){
						alert("저장되었습니다.");
						//메모장 종료할 때 값변경되었는지 확인하기 위해
						storedText = content; 
						storedBack = background;
						storedColor = color;
						console.log("저장할때="+storedBack+storedColor)
					}else{
						alert("저장 실패입니다.");
					}
				}
			})
		}); //저장 클릭
		
});
</script>
</head>
<body>
<div class="memo" style="background-image: url('memo/image/memo-yellow.png')">
	<div class="btnChange"><img src='memo/image/change.png'>
		<span class='back_colors'>
		<img src="memo/image/memo-red.png">
		<img src="memo/image/memo-pink.png">
		<img src="memo/image/memo-orange.png">
		<img src="memo/image/memo-yellow.png">
		<img src="memo/image/memo-green.png">
		<img src="memo/image/memo-blue.png">
		</span>
	</div>
	<span class="pen_colors">
		<img src="memo/image/color-white.png">
	</span>
	<div class="btnClose">&times;</div>
	<button class="memo_store" type="button">저장</button>
	<textarea class="txtMemo" ></textarea>
</div>
</body>
</html>