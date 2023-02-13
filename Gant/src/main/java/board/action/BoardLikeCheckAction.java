package board.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.db.BoardDAO;
import board.db.BoardLike;

public class BoardLikeCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		       
		
		        BoardDAO boarddao = new BoardDAO();
				BoardLike like = new BoardLike();
				
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
				
				// 
				int board_num =Integer.parseInt(request.getParameter("num"));
				String like_check = request.getParameter("like_check"); 
				
				if(like_check.equals("true")) {
					// like_check 를 false에서 true으로 변경
					int result = boarddao.updateLike(id,board_num,like_check);
					if(result == 0){
						 ActionForward forward = new ActionForward();
						 forward.setRedirect(false);
						 request.setAttribute("message","like 테이블 업데이트 실패입니다.");
						 forward.setPath("error/error.jsp");
						 return forward;
					 }
					// board BOARD_LIKE(좋아요수) 를 1 증가시킨다.
					boarddao.BoardupdateLike(board_num,1);
				}else if(like_check.equals("false")) {
					// like_check 를 false에서 true으로 변경
					int result = boarddao.updateLike(id,board_num,like_check);
					if(result == 0){
						 ActionForward forward = new ActionForward();
						 forward.setRedirect(false);
						 request.setAttribute("message","like 테이블 업데이트 실패입니다.");
						 forward.setPath("error/error.jsp");
						 return forward;
					 }
					// board BOARD_LIKE(좋아요수) 를 1 감소시킨다.
					boarddao.BoardupdateLike(board_num,-1);
				}

				
				 
				 response.setContentType("text/html;charset=utf-8");
				 PrintWriter out =response.getWriter();
				 out.print("업데이트성공");
				 return null;

	}

}
