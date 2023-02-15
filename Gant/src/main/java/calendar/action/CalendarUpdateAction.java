package calendar.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import calendar.db.CalendarBean;
import calendar.db.CalendarDAO;


public class CalendarUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		CalendarDAO caldao = new CalendarDAO();		
		CalendarBean cal = new CalendarBean();
		ActionForward forward = new ActionForward();
		
		
		int check = 0;
		
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		String title = request.getParameter("title");

		System.out.println("id : " + id);//id = title
		System.out.println("name : " + name);//name = sessionid
		System.out.println("start : " + start);//start
		System.out.println("end : " + end);//end
		System.out.println("title : " + title);//title = content
	
		


		cal.setTitle(title);
		cal.setStart(start);
		cal.setEnd(end);

		
		check = caldao.update(cal, id);
		
		if(check!=0) {
			
			System.out.println("업데이트 성공");
			forward.setRedirect(true);
		    forward.setPath("calendar/calendar2.jsp"); 

		}
		else {
			System.out.println("캘린더 db 삭제 실패");

			forward.setRedirect(false);
			request.setAttribute("message", "데이터를 삭제하지 못했습니다.");
			forward.setPath("error/error.jsp");

		}
		return forward;
	}

}
