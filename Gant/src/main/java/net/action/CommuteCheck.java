package net.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import net.db.MembersDAO;

public class CommuteCheck implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//출퇴근 표시아이콘을 위한 코드 (ajax로 처리)
		MembersDAO dao = new MembersDAO();
		String name = request.getParameter("name");
		String department = request.getParameter("department");
		String phone_num = request.getParameter("phone_num");
		System.out.println(name+department+phone_num);
		JsonObject json = dao.checkCommute(name,department,phone_num);
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().print(json);
		return null;
	}
}
