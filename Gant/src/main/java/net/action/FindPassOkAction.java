package net.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.db.MembersDAO;

public class FindPassOkAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		MembersDAO dao = new MembersDAO();
		String pass = dao.findPassCheck(id, name, email);
		
		ActionForward forward = new ActionForward();
		if(pass.equals("")) { //아이디 존재X
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			samecode(out, "아이디가");
			
		}else if (pass.equals("noname")) { //이름 존재X
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			samecode(out, "이름이");
			
		}else if (pass.equals("noemail")){ //이메일 존재X
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			samecode(out, "이메일이");
			
		}else { //정보 잘 찾은 경우
			request.setAttribute("id", id);
			request.setAttribute("password", pass);
			forward.setPath("member/findpassok.jsp");
			forward.setRedirect(false);
			return forward;
		}
		
		return null;
	}
	
	public static void samecode(PrintWriter out, String message) {
		out.println("<script>");
		out.println("alert('입력한 " + message + " 존재하지 않습니다.');");
		out.println("history.back();"); //다시 비밀번호찾기 창으로
		out.println("</script>");
		out.close();
	}
}
