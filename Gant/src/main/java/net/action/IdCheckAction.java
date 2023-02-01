package net.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import net.db.MembersDAO;

public class IdCheckAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String id = request.getParameter("id");
		MembersDAO dao = new MembersDAO();
		int result = dao.idCheck(id);
		
		response.setContentType("application/json;charset=utf-8");
		JsonObject json = new JsonObject();
		json.addProperty("result", result);
		response.getWriter().print(json);
		
		return null;
	}

}
