package sml.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.db.Members;
import net.db.MembersDAO;

public class ChatAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MembersDAO dao = new MembersDAO();
		Members member = dao.selectForChat(request.getParameter("id"));
		
		ActionForward forward = new ActionForward();
		request.setAttribute("member", member);
		forward.setPath("chat/chat.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
