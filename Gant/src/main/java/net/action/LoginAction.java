package net.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String id = ""; //ID저장전용
		String id2 = ""; //자동로그인전용
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("id")) {
					id = cookies[i].getValue();
				}else if(cookies[i].getName().equals("id2")) {
					id2 = cookies[i].getValue();
				}
			}
		}
		
		//id변수에 저장 후 실어서 login.jsp로 보냄
		ActionForward forward = new ActionForward();
		
		if(!id2.equals("")) { //자동로그인 쿠키가 있는 경우
			HttpSession session = request.getSession();
			session.setAttribute("id", id2);
			forward.setRedirect(true);
			forward.setPath("main.home"); //ID값 들고 로그인화면 안거치고 바로 메인화면 이동
		}else if(!id.equals("")) { //ID저장 쿠키가 있는 경우
			request.setAttribute("id", id);//id값 들고 login.jsp로 이동
			forward.setRedirect(false);
			forward.setPath("member/login.jsp");
		}else { //그외의 경우
			request.setAttribute("id", id);
			forward.setRedirect(false);
			forward.setPath("member/login.jsp");
		}
		
		return forward;
	}

}
