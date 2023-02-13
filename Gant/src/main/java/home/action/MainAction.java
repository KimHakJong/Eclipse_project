package home.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.db.MembersDAO;


public class MainAction implements Action{
	public ActionForward execute(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		MembersDAO mdao = new MembersDAO();
		mdao.getProfileimg(id);
		session.setAttribute("profileimg", mdao.getProfileimg(id));
		
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("home/main.jsp");
		return forward;
		
	}
}
