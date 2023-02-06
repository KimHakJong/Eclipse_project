package net.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.db.MembersDAO;

public class FindIdOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		MembersDAO dao = new MembersDAO();
		String id = dao.findIdCheck(name,email);
		
		ActionForward forward = new ActionForward();
		if(id.equals("")) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('등록된 이름이 없습니다.');");
			out.println("history.back();"); //다시 아이디찾기 창으로
			out.println("</script>");
			out.close();
		}else if(id.equals("noemail")) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('등록된 이메일이 존재하지 않습니다.');");
			out.println("history.back();"); //다시 아이디찾기 창으로
			out.println("</script>");
			out.close();
		}else { //정보 잘 찾은 경우
			request.setAttribute("name", name);
			request.setAttribute("id", id);
			forward.setPath("member/findidok.jsp");
			forward.setRedirect(false);
			return forward;
		}
		return null; 
	}

}
