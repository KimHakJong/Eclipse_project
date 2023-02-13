package home.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.home")
public class HomeFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doProcess(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {

		String requestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = requestURI.substring(contextPath.length());
		
		System.out.println("command : " + command);
		
		ActionForward forward = null;
		Action action = null;

		switch (command) {
		case "/main.home":  // 메인페이지로 이동
			action = new MainAction(); 
			break;
		case "/update.home": // 개인정보 수정
			action = new UpdateAction();
			break;
		case "/updateProcess.home": // 개인정보 수정 데이터 처리
			action = new UpdateProcessAction();
			break;
		case "/schedule.home": // 개인 일정
			action = new ScheduleAction();
			break;
		case "/myboard.home": // 게시판 활동
			action = new MyboardAction();
			break;
		case "/myreply.home": // 게시판 활동
			action = new MyReplyAction();
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
	
	protected void doGet(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doProcess(request,response);
	}

}
