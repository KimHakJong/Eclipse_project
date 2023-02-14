package home.action;

import java.io.IOException;
import java.io.PrintWriter;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import board.db.BoardDAO;


public class MyBoardDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	boolean result = false;
	
	//파라미터로 가져온 board_num
	int num = Integer.parseInt(request.getParameter("num"));
	
	
	BoardDAO boarddao = new BoardDAO();
	
	
	//삭제처리합니다.
	result = boarddao.boardDelete(num);
	
	//삭제처리 실패한경우

		if(result == false) {
			System.out.println("게시판 삭제 실패");
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			request.setAttribute("message","데이터를 삭제하지 못했습니다.");
			forward.setPath("error/error.jsp");
			return forward;
		}
		
		//삭제 성공의 경우
		System.out.println("게시판 삭제 성공");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('삭제되었습니다.')");
		out.println("location.href='myboard.home';");
		out.println("</script>");
		out.close();
		return null;

	}
}