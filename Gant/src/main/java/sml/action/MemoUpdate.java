package sml.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sml.db.Memo;
import sml.db.SmlDAO;

public class MemoUpdate implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		SmlDAO dao = new SmlDAO();
		Memo memo = new Memo();
		memo.setId(request.getParameter("id"));
		memo.setBackground(request.getParameter("background"));
		memo.setColor(request.getParameter("color"));
		memo.setContent(request.getParameter("content"));
		int result = dao.UpdateMemo(memo);
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().print(result);
		return null;
	}

}
