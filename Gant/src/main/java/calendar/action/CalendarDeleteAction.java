package calendar.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.db.BoardDAO;
import calendar.db.CalendarDAO;

public class CalendarDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		boolean result = false;
		//boolean usercheck = false;

		String name = request.getParameter("id");
	//    HttpSession session = request.getSession();
	  //  String id  = (String) session.getAttribute("id");

		CalendarDAO caldao = new CalendarDAO();

		// usercheck = caldao.isWriter(name); 작성자체크
		System.out.println(name);
		result = caldao.caldelete(name);

		// 삭제처리 실패한경우
		System.out.println(result);

		if (result == false) {
			System.out.println("캘린더 db 삭제 실패");
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			request.setAttribute("message", "데이터를 삭제하지 못했습니다.");
			forward.setPath("error/error.jsp");
			return forward;
		}

	
		// 삭제 성공의 경우
		System.out.println("캘린더 db 삭제");

		return null;

	}
}