package net.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.db.MembersDAO;

public class DeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String name = request.getParameter("name");
		String department = request.getParameter("department");
		String phone_num = request.getParameter("phone_num");
		MembersDAO dao = new MembersDAO();
		int result = dao.delete(name,department,phone_num);

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");

		if(result==1) {
			out.println("alert('삭제를 완료했습니다.');"); 
			out.println("location.href='list.net';");
		}else {
			out.println("alert('삭제를 실패하였습니다.');");
			out.println("history.back();");
		}
		out.println("</script>");
		out.close();
		
		return null;
	}

}
