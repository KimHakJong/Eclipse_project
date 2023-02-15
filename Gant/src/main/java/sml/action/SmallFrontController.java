package sml.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("*.sml")
public class SmallFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String command = request.getRequestURI().substring(request.getContextPath().length()); //프로젝트 경로 뒤 주소
		
		Action action = null;
		ActionForward forward = null;
		switch (command) {
		case "/chat.sml":				
			action = new ChatAction(); 
			break;
		case "/memo.sml":
			action = new MemoLoad(); //Id값을 받아 해당 회원의 메모장 내용,배경색,글자색을 불러옴
			break;
		case "/memoupdate.sml":	 	//메모 저장눌렀을 때 내용,배경색,글자색,아이디 값을 받아와 수정 후 성공,실패 값 json으로 넘김
			action = new MemoUpdate();
			break;
		}
		
		forward = action.execute(request, response);
		
		if(forward != null) {
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			}else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doProcess(request,response);
	}

}
