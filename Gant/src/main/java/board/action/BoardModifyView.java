package board.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.db.Board;
import board.db.BoardDAO;

public class BoardModifyView implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {


		ActionForward forward = new ActionForward();
		BoardDAO boarddao = new BoardDAO();
		Board boarddata = new Board();
		
		
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
		
		
		//  파라미터로 전달받은 수정할 글 번호를 num변수에 저장
		int num = Integer.parseInt(request.getParameter("num"));
		
		
		//글의 내용을 불러와서 boarddata 객체에 저장
		boarddata = boarddao.getDetail(num);
		// 현재 id에 admin 권한을 가져온다. -> 공지 게시물은 admin권한을 가진 ,id만 올릴수있다.
		String admin = boarddao.getadmindate(id);
		request.setAttribute("admin",admin); // id 값 넘겨주기
		
		// 글불러오기 실패한 경우
		if(boarddata == null) {
		forward = new ActionForward();
		forward.setRedirect(false);
	    request.setAttribute("message","게시판 수정 상세 보기 실패입니다.");
	    forward.setPath("error/error.jsp");
	    return forward;
		}
		
		
		
		//수정 폼 페이지로 이동할때 원문 글 내용을 보여주기 때문에 boarddata 객체를
		// request객체에 저장
		request.setAttribute("boarddata",boarddata);
		forward.setRedirect(false);
		// 글 수정 폼 페이지로 이동하기 위해경로 설정
		forward.setPath("board/boardModify.jsp"); //글 내용보기 페이지로 이동하기 위해 경로 설정
	    return forward;

		}

	}