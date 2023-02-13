package sml.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import sml.db.SmlDAO;

public class MemoLoad implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id"); //memo.jsp에서 넘김
		
		if(!(id.equals(""))) { //홈페이지에 아이디세션값 살아있는 경우
			SmlDAO dao = new SmlDAO();
			boolean have = dao.isHave(id);//id에 해당하는 row 갖고 있는지
			response.setContentType("application/json;charset=utf-8");
			JsonObject json = new JsonObject();
			if(have==true) { //id에 대한 memo 테이블의 row존재 O
				json = dao.getMemo(id);
				System.out.println(json.toString());
				
			}else { //id에 대한 memo 테이블의 row존재 X
				int addrow = dao.addRow(id);
				if(addrow==0) {
					ActionForward forward = new ActionForward();
					request.setAttribute("message", "메모장 여는 과정에서 오류가 발생했습니다.");
					forward.setPath("error/error.jsp");
					forward.setRedirect(false);
					return forward;
				}
				json.addProperty("addrow", addrow);
			}
			response.getWriter().print(json);
			
		}else { //홈페이지에 아이디세션값이 죽은 경우
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용해주세요');");
			out.println("location.href='login.net';");
			out.println("</script>");
			out.close();
		}
		return null;
	}
}
