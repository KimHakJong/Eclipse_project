package home.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import home.db.MypageDAO;
import net.db.Members;

public class MyboardAction implements Action{
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		// 아직 안건드림
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("home/myboard.jsp");
		return forward;
		
		
	}
}
