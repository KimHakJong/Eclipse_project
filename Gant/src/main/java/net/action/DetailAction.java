package net.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import net.db.Members;
import net.db.MembersDAO;

public class DetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String name = request.getParameter("clickname");
		MembersDAO dao = new MembersDAO();
		JsonObject json = dao.memberDetail(name);
		
		response.setContentType("application/json;charset=utf-8");
		System.out.println(json.toString());
		response.getWriter().print(json);
		
		return null;
		
	}

}
