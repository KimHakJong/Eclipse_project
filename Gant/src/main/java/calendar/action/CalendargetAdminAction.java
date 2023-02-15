package calendar.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;

import calendar.db.CalendarBean;
import calendar.db.CalendarDAO;


public class CalendargetAdminAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		CalendarDAO caldao = new CalendarDAO();		
		CalendarBean cal = new CalendarBean();

		String ad;
		String ad2;
		
		String id = request.getParameter("id");
		String name = request.getParameter("name");

		System.out.println("id : " + id);//id = title
		System.out.println("name : " + name);//name = id

		//ad = caldao.getadmindate(name); // admin
		ad2 = caldao.getadmindate(id); // admin
		
		//System.out.println("admin : " + ad);
		System.out.println("admin2 : " + ad2);
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().print(ad2);
		
		return null;
	}

}
