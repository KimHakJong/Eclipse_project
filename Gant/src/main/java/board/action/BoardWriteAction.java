package board.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.db.BoardDAO;

public class BoardWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		HttpSession session = request.getSession();
		String id  = (String) session.getAttribute("id");
	
		if(id == null) {//session에 id값이 존재하지 않는다면 로그인 화면으로 이동
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('로그인을 해주세요');"); 
		out.println("location.href='login.net';");
		out.println("</script>");
		out.close();
		return null;
		}
		
		
		BoardDAO dao = new BoardDAO();
		// 현재 id에 admin 권한을 가져온다. -> 공지 게시물은 admin권한을 가진 ,id만 올릴수있다.
		String admin = dao.getadmindate(id);
		request.setAttribute("admin",admin); // id 값 넘겨주기
		request.setAttribute("id",id); // id 값 넘겨주기
		 
		 ActionForward forward = new ActionForward();
		   forward.setRedirect(false);
		   
		   // 글쓰기 페이지로 이동하기 위해 경로를 설정합니다.
		   forward.setPath("board/boardWrite.jsp");
		   return forward; // BoardFrontController.java로 리턴
		
		
	}

}
