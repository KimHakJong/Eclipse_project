package att.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import att.db.Attendance;
import att.db.AttendanceDAO;


public class AttendanceTimeUpdateAction implements Action {

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
		
		
		String work_week= request.getParameter("week");
		System.out.println("work_week ="+work_week);
		String work_today= request.getParameter("today");
		System.out.println("work_today ="+work_today);
	 	String overtime= request.getParameter("over");
		System.out.println("overtime ="+overtime);
		
		
		
		
	 	Attendance att = new Attendance();
		 att.setId(id);
		 att.setWork_week(work_week);
		 att.setWork_today(work_today);
		 att.setOvertime(overtime);
	 	
		 AttendanceDAO attdao = new AttendanceDAO();
		 
		int result = attdao.Update(att); // 데이터를 넣는다.
		 
		 if(result == 0) {
			 System.out.println("퇴근처리 실패입니다.");
			 ActionForward forward = new ActionForward();
			 forward.setRedirect(false);
			 request.setAttribute("message","퇴근 실패입니다.");
			 forward.setPath("error/error.jsp");
			 return forward;
		 }
		 
		 
		 response.setContentType("text/html;charset=utf-8");
		 PrintWriter out = response.getWriter();
		 out.println("<script>");
		 if(result == 1) { // 삽입이 된 경우
			 out.println("alert('퇴근처리 되었습니다.')");
			 out.println("location.href='Main.att';");
		 }
		 out.println("</script>");
		 out.close();
		 return null;
	}
}
