package board.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.db.Board;
import board.db.BoardDAO;
import board.db.BoardLike;

public class BoardDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		BoardDAO boarddao = new BoardDAO();
		Board boarddata = new Board();
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
		
	
			
		//비밀글일 경우 입력한 input_pass 와 board_pass 가 다르다면 다시 리스트 화면으로 가게한다.
		String board_pass = request.getParameter("board_pass");
		
		if(!board_pass.equals("1")) {
		String input_pass = request.getParameter("input_pass");	
		    
		    // input_pass 와 board_pass 가 다르다면 다시 리스트 화면으로 가게한다
		    if(!board_pass.equals(input_pass)) {	
		    	response.setContentType("text/html;charset=utf-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('비밀번호가 다릅니다.')");
				out.println("history.back(-1);");
				out.println("</script>");
				out.close();
				return null;
		    }
		      
		}
		
		
		//글번호  파라미터 값을 num변수에 저장
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		//boardLike 테이블이있는지 확인 select으로 확인 
		//selectlike 1이면 있고 0이면 없음
		int selectlike = boarddao.selectLike(id,board_num);
		String like_check = ""; 
		if(selectlike == 0) {
			boarddao.insertLike(id,board_num);
			request.setAttribute("like_check","false");
		}else if(selectlike == 1) {
			like_check =  boarddao.selectLikeCheck(id,board_num);
			request.setAttribute("like_check",like_check);
		}
		
		//내용을 확인할 글의 조회수를 증가시킵니다.
		boarddao.setReadCountUpdate(board_num);
		
		
		//글의 내용을 DAO에서 읽은 후 결과를 boarddata 객체에 저장
		boarddata = boarddao.getDetail(board_num);
		
		//boarddata =null; // error테스트를 위한 값 설정
		// DAO에서 글의 내용을 읽지 못할경우 null반환
		if(boarddata == null) {
		System.out.println("상세보기 실패");	
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
	    request.setAttribute("message","데이터를 읽지 못했습니다.");
	    forward.setPath("error/error.jsp");
	    return forward;
		}
		
		System.out.println("상세보기 성공");
		
		// membet테이블에서 id에 해당하는 프로필 사진명을 가져온다.
		
		String profileimg =  boarddao.getMemberProfile(id);
		
		//해당 id에 admin권한이 있는지확인한다.
		String admin = boarddao.getadmindate(id);
		
		//boarddata 객체를 request객체에 저장
		request.setAttribute("boarddata",boarddata);
		
		
		if(profileimg == null) { // 프로필 사진이 없다면 기본이미지로 변경
			request.setAttribute("profileimg","user.png");
		}else{
		    request.setAttribute("profileimg",profileimg);
		}
		
		request.setAttribute("admin",admin);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("board/boardView.jsp"); //글 내용보기 페이지로 이동하기 위해 경로 설정
	    return forward;

		}

	}