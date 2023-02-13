package calendar.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;

import calendar.db.CalendarBean;
import calendar.db.CalendarDAO;


public class CalendarShowAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		CalendarDAO caldao = new CalendarDAO();		
		CalendarBean cal = new CalendarBean();
		
		
		JsonArray list = caldao.getCalList();
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().print(list);
		
		System.out.println(list.toString());
		
		return null;
	}

}
