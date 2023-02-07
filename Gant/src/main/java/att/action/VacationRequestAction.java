package att.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import att.db.AttendanceDAO;
import att.db.Vacation;

public class VacationRequestAction implements Action {

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
		
		String startDate = request.getParameter("startDate"); // 휴가시작일
		String endDate = request.getParameter("endDate"); // 휴가 종료일
		String emergency_one = request.getParameter("emergency_one"); // 010
		String emergency_two = request.getParameter("emergency_two"); // 0000
		String emergency_three = request.getParameter("emergency_three"); // 0000
		String details = request.getParameter("details"); // 휴가 세부사항
		String emergency =emergency_one+"-"+emergency_two+"-"+emergency_three;//비상연락망 
		long vacationDate = 0; //휴가 일수 : BD에 저장되어있는 휴가갯수에서 빼준다.
		
		// 휴가 종료일 - 휴가 시작일 -> 휴가 일수
		try {
		 DateFormat format = new SimpleDateFormat("yyyyMMdd");

		 /* Date타입으로 변경 */

		 Date end = format.parse( endDate );
		 Date start = format.parse( startDate );
		 long Sec = (end.getTime() - start.getTime()) / 1000; // 초
		 //long Min = (end.getTime() - start.getTime()) / 60000; // 분
		 //long Hour = (end.getTime() - start.getTime()) / 3600000; // 시
		 long Days = Sec / (24*60*60); // 일자수
	        
		 System.out.println(Sec + "초 차이");
		 //System.out.println(Min + "분 차이");
		 //System.out.println(Hour + "시 차이");
		 System.out.println(Days + "일 차이");
		 // 일차이 + 1일 해줘야한다. 시작일은 포함하여야하기 때문이다.
		 
		// 휴가 일수이다. 최종 휴가 일수   // DB에서 휴가 갯수에서 휴가 일수를 빼준다.
		 vacationDate = Days+1; 
		 
		 //만약 휴가 일수가 음수라면 history.back(-1)
		 if(0 > vacationDate) {
				response.setContentType("text/html;charset=utf-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('휴가 날짜를 다시한번 확인하여 주세요');"); 
				out.println("history.back(-1);");
				out.println("</script>");
				out.close();
				return null;
			}
		 
		 
		}catch (ParseException ex) {
			 System.out.println("휴가 신청 실패입니다.");
			 ActionForward forward = new ActionForward();
			 forward.setRedirect(false);
			 request.setAttribute("message","휴가 신청 실패입니다.");
			 forward.setPath("error/error.jsp");
			 return forward;
		}catch (Exception e) {
			e.getMessage();
		} // catch end

		AttendanceDAO attdao = new AttendanceDAO(); 
		Vacation vc = new Vacation(); 
		
		// DB에 저장되어있는 휴가 잔여일을 가져온다.
		vc = attdao.VacationGetselect(id);
		
				//휴가 잔여일보다 휴가 신청일이 많다면 history.back(-1)
				if(0 > (vc.getVacation_num()-vacationDate)) {
					response.setContentType("text/html;charset=utf-8");
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('휴가 신청일이 잔여일보다 많습니다. 다시 확인해주세요');"); 
					out.println("history.back(-1);");
					out.println("</script>");
					out.close();
					return null;
				}
		
		vc = new Vacation();
		
		vc.setId(id);
		vc.setEndDate(endDate);
		vc.setStartDate(startDate);
		vc.setEmergency(emergency);
		vc.setDetails(details);
		
		
		int result = attdao.VacationUpdate(vc,vacationDate);
		
		if(result == 0){
			 System.out.println("휴가 신청 실패입니다.");
			 ActionForward forward = new ActionForward();
			 forward.setRedirect(false);
			 request.setAttribute("message","초과근무 신청 실패입니다.");
			 forward.setPath("error/error.jsp");
			 return forward;
		 }

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('휴가 신청되었습니다.');");
		out.println("window.close();"); 
		out.println("</script>");
		out.close();
        
		return null;
	}

}