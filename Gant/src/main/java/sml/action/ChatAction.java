package sml.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.db.Members;
import net.db.MembersDAO;

public class ChatAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id= (String) session.getAttribute("id");
		MembersDAO dao = new MembersDAO();
		Members member = dao.selectForChat(id); //채팅에 필요한 name,프로필사진값 가져옴
		
		ActionForward forward = new ActionForward();
		request.setAttribute("member", member);
		forward.setPath("chat/chat.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
