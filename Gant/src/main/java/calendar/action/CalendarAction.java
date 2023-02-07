package calendar.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;

import calendar.db.CalendarDAO;

public class CalendarAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)

			throws ServletException, IOException {

	      ActionForward forward = new ActionForward();
	      forward.setRedirect(false);
	      forward.setPath("calendar/calendar2.jsp");
	      return forward;
	      
	      

	}

}
