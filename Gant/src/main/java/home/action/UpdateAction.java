package home.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import home.db.MypageDAO;
import net.db.Members;

public class UpdateAction implements Action{
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		// db에 접속해서 해당 회원정보를 가져와서, 화면단 쪽에 뿌려줌
		
		ActionForward forward = new ActionForward();
		MypageDAO dao = new MypageDAO();
		Members m_info = new Members();
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		m_info = dao.Myinfo(id);
		
		if(m_info == null) {
			System.out.println("해당 id에 대한 정보 없음");
			request.setAttribute("message", "정보를 찾을 수 없습니다.");
			forward.setRedirect(true);
			forward.setPath("error/error.jsp");
			return forward;
		}
		
		request.setAttribute("info", m_info);
		forward.setRedirect(false);
		forward.setPath("home/update.jsp");
		return forward;
	}
}
