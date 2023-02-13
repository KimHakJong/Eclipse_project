package board.action;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import board.db.Board;
import board.db.BoardDAO;

public class BoardReplyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		BoardDAO boarddao = new BoardDAO();
		Board boarddata = new Board();
		ActionForward forward = new ActionForward();

		
		//BoardBean 객체에 글 등록 폼에서 입력 받은 정보들을 저장		
		String board_name = request.getParameter("board_name");
		String board_pass = request.getParameter("board_pass"); //값이 1이번 비밀글x 
		String board_subject = request.getParameter("board_subject");
		String fontColor = request.getParameter("fontColor");
		String fontSize = request.getParameter("fontSize");
		String fontWeight = request.getParameter("fontWeight");
		String board_content = request.getParameter("board_content");
		boarddata.setBoard_re_ref(Integer.parseInt(request.getParameter("board_re_ref")));
		boarddata.setBoard_re_lev(Integer.parseInt(request.getParameter("board_re_lev")));
		boarddata.setBoard_re_seq(Integer.parseInt(request.getParameter("board_re_seq")));
		int result = 0;//입력될 답글의 board_num
        
		
		//boarddata 객체에 저장
		boarddata.setBoard_name(board_name);
		
		if(board_pass == null || board_pass.equals("")) { // 비밀글 설정을 안했다면 1을 넣어준다.   
			boarddata.setBoard_pass("1");
		}else {
		    boarddata.setBoard_pass(board_pass); // 아니라면 입력받은 데이터를 넣는다.
		}
		
		boarddata.setBoard_subject(board_subject);
		boarddata.setFontColor(fontColor);
		boarddata.setFontSize(fontSize);
		boarddata.setFontWeight(Integer.parseInt(fontWeight));
		boarddata.setBoard_content(board_content);
		
		
		
		//글 등록 처리를 위해 DAO의 boardInsert() 메서드를 호출합니다.
		//글 등록 폼에서 입력한 정보가 저장되어있는 boarddata객체를 전달합니다.
		//result는 답글의 board_num
		result = boarddao.boardReply(boarddata);
		
		//글 등록에실패할 경우 false를 반환
		if(result == 0) {
			System.out.println("게시판 등록 실패");
			forward.setPath("error/error.jsp");
			request.setAttribute("message","게시판 등록 실패입니다.");
			forward.setRedirect(false);
			return forward;
		}
		System.out.println("답글 등록 완료");
		
		
		//글 등록이 완료되면 글 목록을 보여주기 위해 "Main.bo"로 이동
		//Redirect여부를 true로 설정
		forward.setRedirect(true);
		forward.setPath("Main.bo"); //이동경로지정
		return forward;
		
		
	}//execute end

}	// 크로스 사이트 스크립팅 방지하기 위한 메서드
	
	
