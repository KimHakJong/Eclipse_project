package board.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.db.Board;
import board.db.BoardDAO;

public class BoardReplyView implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		BoardDAO boarddao = new BoardDAO();
		Board boarddata = new Board();
		
		
		//  파라미터로 전달받은 수정할 글 번호를 num변수에 저장
		int num = Integer.parseInt(request.getParameter("num"));
		
		
		//글의 내용을 불러와서 boarddata 객체에 저장
		boarddata = boarddao.getDetail(num);
		
		
		// 글내용이 없는 경우
		if(boarddata == null) {
		System.out.println("글이 존재하지 않습니다.");	
		forward.setRedirect(false);
	    request.setAttribute("message","글이 존재하지 않습니다.");
	    forward.setPath("error/error.jsp");
	    return forward;
		}
		
		System.out.println("답변 페이지 이동 완료");
		
		//답변 폼 페이지로 이동할때 원문 글 내용을 보여주기 위해 boarddata 객체를
		// request객체에 저장
		request.setAttribute("boarddata",boarddata);
		forward.setRedirect(false);
		// 글 답변 폼 페이지로 이동하기 위해경로 설정
		forward.setPath("board/boardReply.jsp"); //글 내용보기 페이지로 이동하기 위해 경로 설정
	    return forward;

		}

	}

