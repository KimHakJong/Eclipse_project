package net.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import net.db.MembersDAO;

public class OrgChart implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MembersDAO dao = new MembersDAO();
		//각 부서별 이름을 ','로 구분하여 String형으로 담음
		String plan = dao.selectByDname("기획부");
		String sales = dao.selectByDname("영업부");
		String human = dao.selectByDname("인사부");
		String it = dao.selectByDname("전산부");
		String chong = dao.selectByDname("총무부");
		String account = dao.selectByDname("회계부");
		
		JsonObject json = new JsonObject();
		json.addProperty("plan", plan);
		json.addProperty("sales", sales);
		json.addProperty("human", human);
		json.addProperty("it", it);
		json.addProperty("chong", chong);
		json.addProperty("account", account);
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().print(json);
		
		return null;
		}
	}