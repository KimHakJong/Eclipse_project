package board.action;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.db.Board;
import board.db.BoardDAO;

public class BoardAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		BoardDAO boarddao = new BoardDAO();
		Board boarddata = new Board();
		ActionForward forward = new ActionForward();
		
		
		String realFolder ="";
		
		//webapp 아래에 꼭 폴더를 생성하세요
		String saveFolder="boardsupload";
		
		int fileSize = 5*1024*1024; // 업로드할 파일의 최대 사이즈 입니다. 5MB
		
		//실제저장 결로를 지정
		ServletContext sc = request.getServletContext();
		realFolder = sc.getRealPath(saveFolder);
		System.out.println("realFolder = " + realFolder);
		boolean result = false;
		try {
			MultipartRequest multi = new MultipartRequest(
					request,
					realFolder,
					fileSize,
					"utf-8",
					new DefaultFileRenamePolicy());
		
		//BoardBean 객체에 글 등록 폼에서 입력 받은 정보들을 저장		
		String board_name = multi.getParameter("board_name");
		String board_pass = multi.getParameter("board_pass"); //값이 1이번 비밀글x 
		String board_subject = multi.getParameter("board_subject");
		String fontColor = multi.getParameter("fontColor");
		String fontSize = multi.getParameter("fontSize");
		String fontWeight = multi.getParameter("fontWeight");
		String board_content = multi.getParameter("board_content");
		String Board_notice = ""; //공지게시글 체크 여부
		
		// 공지게시글 체크 여부는 admin 계정만 할 수 있다. 만약 noticebox값이 null이라면 "false"(일반글) 로 값을 넣어준다.
		if(multi.getParameter("noticebox") == null ) {
			Board_notice = "false";
		}else {
			Board_notice = multi.getParameter("noticebox");
		}
		
		
		boarddata.setBoard_name(board_name);
		if(board_pass == null) { // 비밀글 설정을 안했다면 1을 넣어준다.
			boarddata.setBoard_pass("1");
		}else {
		    boarddata.setBoard_pass(board_pass); // 아니라면 입력받은 데이터를 넣는다.
		}
		
		boarddata.setBoard_subject(board_subject);
		boarddata.setFontColor(fontColor);
		boarddata.setFontSize(fontSize);
		boarddata.setFontWeight(Integer.parseInt(fontWeight));
		boarddata.setBoard_content(board_content);
		boarddata.setBoard_notice(Board_notice);
		
		// 시스템상에 업로드된 실제 파일명을 얻어온다.	
		String filename = multi.getFilesystemName("board_file");
		boarddata.setBoard_file(filename);
		
		//글 등록 처리를 위해 DAO의 boardInsert() 메서드를 호출합니다.
		//글 등록 폼에서 입력한 정보가 저장되어있는 boarddata객체를 전달합니다.
		result = boarddao.boardInsert(boarddata);
		
		//글 등록에실패할 경우 false를 반환
		if(result == false) {
			System.out.println("게시판 등록 실패");
			forward.setPath("error/error.jsp");
			request.setAttribute("message","게시판 등록 실패입니다.");
			forward.setRedirect(false);
			return forward;
		}
		System.out.println("게시판 등록 완료");
		
		//글 등록이 완료되면 글 목록을 보여주기 위해 "Main.bo"로 이동
		//Redirect여부를 true로 설정
		forward.setRedirect(true);
		forward.setPath("Main.bo"); //이동경로지정
		return forward;
		} catch (IOException ex) {
			ex.printStackTrace();
			forward.setPath("error/error.jsp");
			request.setAttribute("message","게시판 등록 실패입니다.");
			forward.setRedirect(false);
			return forward;
		}// catch end	
	}//execute end

	// 크로스 사이트 스크립팅 방지하기 위한 메서드
	
	
	
}
		
