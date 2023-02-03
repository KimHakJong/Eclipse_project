package net.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import net.db.MembersDAO;

public class OrgChart implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MembersDAO dao = new MembersDAO();
		//각 부서별 이름을 ','로 구분하여 String형으로 담음
		JsonObject json1 = dao.selectByDname("기획부"); 
		JsonObject json2 = dao.selectByDname("영업부");
		JsonObject json3 = dao.selectByDname("인사부");
		JsonObject json4 = dao.selectByDname("전산부");
		JsonObject json5 = dao.selectByDname("총무부");
		JsonObject json6 = dao.selectByDname("회계부");
		json1.addProperty("", "");
		JsonArray array = new JsonArray();
		array.add(json1);
		array.add(json2);
		array.add(json3);
		array.add(json4);
		array.add(json5);
		array.add(json6);
		return null;
		}
	}