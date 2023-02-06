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

import att.db.Attendance;
import att.db.AttendanceDAO;



public class OvertimeRequestAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	 
	
		HttpSession session = request.getSession();
		String id  = (String) session.getAttribute("id");
		System.out.println("id ="+id);
		
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
		
		String overtime_date = request.getParameter("overtime_date"); // 초가근무날짜
		String startTime = request.getParameter("startTime"); //초과근무 시작 시간
		String endTime = request.getParameter("endTime"); // 초과근무 끝난 시간
		String overtime_content = request.getParameter("overtime_content"); //작업내용
		String overtime_reason = request.getParameter("overtime_reason"); // 사유
		String overTime ="";//초과근무시간 
	
	    System.out.println("초과근무시작시간 : " + startTime);
	    System.out.println("초과근무끝난시간 : " + endTime);
		try {
			
	    // ---------초가근무시간 = 초가근무 근무 끝난시간 - 초가근무 시작 시간 ------------------	
		SimpleDateFormat f = new SimpleDateFormat("HH:mm", Locale.KOREA); // Locale.KOREA ->지역설정을 한국어로 해야 mon요일, tue요일 등 방지할 수 있음!
		//SimpleDateFormat class의parse() 메서드를 이용하여   String 에서 날짜 객체로 변경
		Date end = f.parse(endTime);
		Date start = f.parse(startTime);
		// 밀리초로 변경하여 계산 // GMT 기준 한국 시간이 문제가 있어 -32400000ms가더해진 값이 나온다. 그래서 각 ms 값에 32400000을 더해준다. 
		//만약 종료시간의 ms가 시작시간 ms 보다 작다면 시간을 다시 입력하도록 한다. -> 종료시간보다 시작이간이 더 늦은경우
		if((start.getTime()+32400000)>(end.getTime()+32400000)) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('초가근무 시작시간과 종료시간을 다시 확인하여 주세요');"); 
			out.println("history.back(-1);");
			out.println("</script>");
			out.close();
			return null;
		}
		
		long todaywork = (end.getTime()+32400000) - (start.getTime()+32400000);
		//밀리초를 시간 형태로 변경
		
		long hours = (todaywork / 1000) / 60 / 60 % 24; //밀리초를 시간으로 계산
		long minutes = (todaywork / 1000) / 60 % 60; //밀리초를 분으로 계산		
		
		
		// 시간,분,초 가 10미만이면 앞에 0이붙어야한다.(01:01:01)
   	    
		String th; // 문자열로 형변환 
   	    String tm;

   	  
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
   	    
   	      
   	    
        overTime = th + ":" + tm + ":00"; // 시:분:초
		System.out.println("초과근무시간 :" + overTime);
		
		// ---------초과근무시간 구하기 끝------------------

		 // try end
		}catch (ParseException ex) {
			 System.out.println("초과근무 신청 실패입니다.");
			 ActionForward forward = new ActionForward();
			 forward.setRedirect(false);
			 request.setAttribute("message","초과근무 신청 실패입니다.");
			 forward.setPath("error/error.jsp");
			 return forward;
		}catch (Exception e) {
			e.getMessage();
		} // catch end
		
		AttendanceDAO attdao = new AttendanceDAO(); 
		Attendance att = new Attendance(); 
		
		att.setId(id);
		att.setOvertime_date(overtime_date);
		att.setOvertime_content(overtime_content);
		att.setOvertime_reason(overtime_reason);
		att.setOverTime(overTime);
		
		int result = attdao.overtimeUpdate(att);
		
		if(result == 0){
			 System.out.println("초과근무 신청 실패입니다.");
			 ActionForward forward = new ActionForward();
			 forward.setRedirect(false);
			 request.setAttribute("message","초과근무 신청 실패입니다.");
			 forward.setPath("error/error.jsp");
			 return forward;
		 }

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('초과근무 신청되었습니다.');");
		out.println("window.close();"); //다시 아이디찾기 창으로
		out.println("</script>");
		out.close();
        
		return null;
	}

}
