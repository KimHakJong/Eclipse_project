package sml.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.LoginAction;

/**
 * Servlet implementation class SmallFrontController
 */
@WebServlet("*.sml")
public class SmallFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String command = request.getRequestURI().substring(request.getContextPath().length()); //프로젝트 경로 뒤 주소
		
		Action action = null;
		ActionForward forward = null;
		switch (command) {
		case "/chat.sml":				//쿠키값 확인, 로그인화면이동
			action = new ChatAction(); //자동로그인 쿠키값이 있는 경우 세션에 id값저장 후 메인화면 이동
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
