package net.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.db.Members;
import net.db.MembersDAO;

public class JoinCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		Members m = new Members();
		m.setAdmin("false");
		m.setId(request.getParameter("id"));
		m.setPassword(request.getParameter("password"));
		m.setName(request.getParameter("name"));
		m.setJumin(request.getParameter("jumin1")+"-"+request.getParameter("jumin2"));
		m.setPhone_num(request.getParameter("phone1")
						+"-" + request.getParameter("phone2")
						+"-" + request.getParameter("phone3"));
		m.setEmail(request.getParameter("email")+"@"+request.getParameter("domain"));
		m.setPost(Integer.parseInt(request.getParameter("post")));
		m.setAddress(request.getParameter("address"));
		m.setDepartment(request.getParameter("department"));
		m.setPosition(request.getParameter("position"));
		MembersDAO dao = new MembersDAO();
		int result = dao.insert(m);
		
		ActionForward forward = new ActionForward();
		if(result==0) {
			System.out.println("회원 가입 실패입니다.");
			forward.setRedirect(false);
			forward.setPath("error/error.jsp");
			request.setAttribute("message", "회원 가입 실패입니다.");
			return forward;
		}
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		
		if (result==1) {//삽입이 된 경우
			out.println("alert('회원 가입을 축하합니다.');"); 
			out.println("location.href='login.net';");
		}else if (result == -1) {
			out.println("alert('중복된 아이디입니다. 다시 입력하세요');");
			out.println("history.back();");
		}
		out.println("</script>");
		out.close();
		return null;
	}

}
