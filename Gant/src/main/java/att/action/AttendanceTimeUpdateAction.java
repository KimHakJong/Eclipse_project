package att.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;

import att.db.Attendance;
import att.db.AttendanceDAO;


public class AttendanceTimeUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String id  = (String) session.getAttribute("id");
		System.out.println("id ="+id);
		String checkbutton  = request.getParameter("checkbutton");
		
		if(id == null) {//session에 id값이 존재하지 않는다면 로그인 화면으로 이동
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('로그인을 해주세요');"); 
		out.println("location.href='login.net';");
		out.println("</script>");
		out.close();
		return null;
		}
		
		Attendance att = null;
		
		if(checkbutton.equals("startbutton")) { // start버튼 클릭시 수행 
			 String startTime  = request.getParameter("startTime");
				
		 	 att = new Attendance();
			 att.setId(id);
			 att.setStarTtime(startTime);
			 
			 AttendanceDAO attdao = new AttendanceDAO(); 
			 int result = attdao.startTimeUpdate(att); // 데이터를 넣는다. // checkbutton 을 false로 변경 // 출근버튼 비활성화
			 
			 if(result == 0){
				 System.out.println("출근처리 실패입니다.");
				 ActionForward forward = new ActionForward();
				 forward.setRedirect(false);
				 request.setAttribute("message","출근처리 실패입니다.");
				 forward.setPath("error/error.jsp");
				 return forward;
			 }

			 JsonObject object = new JsonObject();
			 object.addProperty("success","출근등록되었습니다.");
			 
			 response.setContentType("application/json;charset=utf-8");
			 PrintWriter out =response.getWriter();
			 out.print(object.toString());
			 System.out.println(object.toString());
			 return null;
			
		}else if(checkbutton.equals("endbutton")) { // 퇴근버튼
			String endTime  = request.getParameter("endTime"); // 퇴근시간 
			System.out.println("퇴근시간:"+endTime);
			String work_week  = request.getParameter("work_week"); // 주간 총 근무시간 -> 하루 총근무시간을 더해준다.
			System.out.println("업데이트 전 주간 총 근무시간:"+work_week);
			AttendanceDAO attdao = new AttendanceDAO(); 
			att = new Attendance(); // DAO에서 가져온 데이터 저장 
			att = attdao.getselect(id);  // select을 이용하여 출근시간을 가져온다.->= 하루 총 근무시간 = 퇴근시간 - 출근시간 
			String startTime = att.getStarTtime(); // 출근시간 
			System.out.println("출근시간:"+startTime);
			
			try {
				
		    // ---------하루근무시간 구하기------------------	
			SimpleDateFormat f = new SimpleDateFormat("HH:mm:ss", Locale.KOREA); // Locale.KOREA ->지역설정을 한국어로 해야 mon요일, tue요일 등 방지할 수 있음!
			//SimpleDateFormat class의parse() 메서드를 이용하여   String 에서 날짜 객체로 변경
			Date end = f.parse(endTime);
			Date start = f.parse(startTime);
			// 밀리초로 변경하여 계산 // GMT 기준 한국 시간이 문제가 있어 -32400000ms가더해진 값이 나온다. 그래서 각 ms 값에 32400000을 더해준다. 
			long todaywork = (end.getTime()+32400000) - (start.getTime()+32400000);
			
			//만약 당일에 퇴근버튼을 클릭하지 않고 다음날 퇴근버튼을 클릭했다면 출근시간보다 퇴근시간이 빨라 ms가 음수 (-) 형태로 나올 가능성이 있다.
			//또한 오늘날짜와 출근 날짜가 다르다면 그것또한 퇴근버튼을 클릭하지 않은것이다. 이럴때는 퇴근날짜를 클릭하지 않은 날은 0시간으로 누적되게 한다.
			
			//출근을 클릭했을때 년 월일
			String last_Work_date = att.getWork_date();
			
		    //오늘 날짜 구하기
			Date now = new Date();
	        // 포맷팅 정의
			SimpleDateFormat Day = new SimpleDateFormat("yyyyMMdd");
			 // 포맷팅 적용
			// 현재 년월일.
			String now_Day = Day.format(now); 
			
			// 하루근무시간(ms)가 음수로 나오거나 출근을 클릭했을때와 퇴근을 클릭했을때 날짜가 다르다면 하루 근무시간은 0으로 한다.
			if( 0 > todaywork || !last_Work_date.equals(now_Day)) {
				todaywork = 0;
			}
			
			long hours = (todaywork / 1000) / 60 / 60 % 24; //밀리초를 시간으로 계산
			long minutes = (todaywork / 1000) / 60 % 60; //밀리초를 분으로 계산
			long seconds = (todaywork / 1000) % 60; //밀리초를 초로 계산			
			
			
			// 시간,분,초 가 10미만이면 앞에 0이붙어야한다.(01:01:01)
	   	    
			String th; // 문자열로 형변환 
	   	    String tm;
	   	    String ts;
	   	  
	   	    if(hours<10){ 
	   	     th = "0" + hours;
	   	     }else { // 10의 자리라면 ""을 이용하여 형 변환만 해준다.
	   	    	th = ""+ hours;	 
	   	     }
	   	    if(minutes < 10){
	   	     tm = "0" + minutes;
	   	    }else {
	   	    	tm = "" + minutes;	 
	   	     }
	   	    if(seconds < 10){
	   	     ts = "0" + seconds;
	   	    }else {
	   	    ts = "" + seconds;	 
		   	   }
	   	      
	   	    
	        String work_today = th + ":" + tm + ":" + ts; // 시:분:초
			System.out.println("하루근무시간 :" + work_today);
			
			// ---------하루근무시간 구하기 끝------------------
			
			
	       // --------- 주간 총 근무시간시간 = 기존의 주간 총 근무시간시간 + 하루근무시간 구하기------------------
			
			SimpleDateFormat t = new SimpleDateFormat("HH:mm:ss", Locale.KOREA); // Locale.KOREA ->지역설정을 한국어로 해야 mon요일, tue요일 등 방지할 수 있음!
			//SimpleDateFormat class의parse() 메서드를 이용하여   String 에서 날짜 객체로 변경
			Date week = t.parse(work_week); // 누적된 주간 총 근무시간
			// 밀리초로 변경하여 계산 // GMT 기준 한국 시간이 문제가 있어 -32400000ms가더해진 값이 나온다. 그래서 각 ms 값에 32400000을 더해준다. 
			long weekwork = (week.getTime()+32400000) + todaywork;
			
			
			//밀리초를 시간 형태로 변경 00:00:00
			hours = (weekwork / 1000) / 60 / 60 % 24; //밀리초를 시간으로 계산
			minutes = (weekwork / 1000) / 60 % 60; //밀리초를 분으로 계산
			seconds = (weekwork / 1000) % 60; //밀리초를 초로 계산
			
			// 시간,분,초 가 10미만이면 앞에 0이붙어야한다.(01:01:01) 
	   	    if(hours<10){ 
	   	     th = "0" + hours;
	   	     }else { // 10의 자리라면 ""을 이용하여 형 변환만 해준다.
	   	    	th = ""+ hours;	 
	   	     }
	   	    if(minutes < 10){
	   	     tm = "0" + minutes;
	   	    }else {
	   	    	tm = "" + minutes;	 
	   	     }
	   	    if(seconds < 10){
	   	     ts = "0" + seconds;
	   	    }else {
	   	    ts = "" + seconds;	 
		   	   }
	   	      
	        String new_work_week = th + ":" + tm + ":" + ts; // 시:분:초
			System.out.println("주간 총 근무시간+하루근무시간 :" + new_work_week);
			
			// ---------주간 총 근무시간시간 + 하루근무시간 구하기 끝------------------
			
			
			// ---------초과근무시간 구하기 ------------------
			
			//todaywork = 하루 총 근무시간을 밀리초로 나타낸 값이다. 9시간 = 32400000 ms 이다 점심시간을 포함하여 9이상 근무시 초가근무 시간이 들어간다.
			String overTime; // 초가 근무시간
			if(todaywork >= 32400000) {
				long over = todaywork - 32400000;
				
				//밀리초를 시간 형태로 변경 00:00:00				                                       
				hours = (over / 1000) / 60 / 60 % 24; //밀리초를 시간으로 계산
				minutes = (over / 1000) / 60 % 60; //밀리초를 분으로 계산
				seconds = (over / 1000) % 60; //밀리초를 초로 계산;

				// 시간,분,초 가 10미만이면 앞에 0이붙어야한다.(01:01:01)
		   	    if(hours<10){ 
		   	     th = "0" + hours;
		   	     }else { // 10의 자리라면 ""을 이용하여 형 변환만 해준다.
		   	    	th = ""+ hours;	 
		   	     }
		   	    if(minutes < 10){
		   	     tm = "0" + minutes;
		   	    }else {
		   	    	tm = "" + minutes;	 
		   	     }
		   	    if(seconds < 10){
		   	     ts = "0" + seconds;
		   	    }else {
		   	    ts = "" + seconds;	 
			   	   }
		   	      
		        overTime = th + ":" + tm + ":" + ts; // 시:분:초
				System.out.println("초가 근무시간 :" + overTime);	
			}else {
				overTime = "00:00:00";
				System.out.println("초가 근무시간 :" + overTime);
			}
			
			// ---------초과근무시간 구하기 끝 ------------------
			
			
		 	 att = new Attendance();
		 	 att.setId(id);
			 att.setEndTime(endTime);
			 att.setWork_today(work_today);//work_week
			 att.setWork_week(new_work_week);
			 att.setOverTime(overTime);
			 
			 int result = attdao.endTimeUpdate(att); // 데이터를 넣는다.
			 
			 if(result == 0){
				 System.out.println("퇴근처리 실패입니다.");
				 ActionForward forward = new ActionForward();
				 forward.setRedirect(false);
				 request.setAttribute("message","퇴근 실패입니다.");
				 forward.setPath("error/error.jsp");
				 return forward;
			 }

			 att = attdao.getselect(id);  // select을 이용하여 주간 총 근무시간 , 초과근무시간, 하루 총 근무시간을 가져온다.
			 JsonObject object = new JsonObject(); //json 형식으로 ajax으로 값 보내기
			 object.addProperty("overTime",att.getOverTime());
			 object.addProperty("work_today",att.getWork_today());
			 object.addProperty("work_week",att.getWork_week());
			 object.addProperty("work_week_hours",att.getWork_week().split(":")[0]);
			 
			 
			 response.setContentType("application/json;charset=utf-8");
			 PrintWriter out =response.getWriter();
			 out.print(object.toString());
			 System.out.println(object.toString());
			 return null;
			
		   // try end
			}catch (ParseException ex) {
				ex.getMessage();
				System.out.println("근무시간 구하기 실패입니다." );
			}catch (Exception e) {
				e.getMessage();
			} // catch end
	
		}//else if(checkbutton.equals("endbutton"))
		
		return null;
	}
}
