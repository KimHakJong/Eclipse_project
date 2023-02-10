package net.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.db.MembersDAO;

public class LoginCheckAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		String id = request.getParameter("id");
		String pass = request.getParameter("password");
		MembersDAO dao = new MembersDAO();
		int result = dao.idPassCheck(id, pass);
		String profileimg = dao.getProfileimg(id);
		//아이디없음:0 아이디만일치:-1 아이디,비밀번호일치:1

		//로그인 성공
		if(result == 1) {
			HttpSession session = request.getSession();
			session.setAttribute("id", id);
			session.setAttribute("profileimg", profileimg);
			
			String IDStore = request.getParameter("remember");
			String auto = request.getParameter("autologin");
			Cookie cookie = new Cookie("id",id); //ID저장 쿠키
			Cookie cookie2 = new Cookie("id2",id); //자동로그인 쿠키
			
			//자동 로그인 체크한 경우
			if(auto != null && auto.equals("yes")) {
				cookie2.setMaxAge(60*6); //1분(테스트용)
				response.addCookie(cookie2);
				System.out.println("자동로그인 쿠키확인");
			}else {
				cookie2.setMaxAge(0);
				response.addCookie(cookie2);
			}
			//ID 저장을 체크한 경우
			if(IDStore != null && IDStore.equals("store")) {
				cookie.setMaxAge(60*60*24); //쿠키 유효시간 24시간
				response.addCookie(cookie);//클라이언트로 쿠키값 전송
				System.out.println("ID저장 쿠키확인");
			}else{
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
			forward.setRedirect(true);
			forward.setPath("main.home");
			return forward;
			
		}else { //로그인 실패한 경우
			String message ="비밀번호가 일치하지 않습니다.";
			if(result == 0)
				message = "아이디가 존재하지 않습니다.";
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('"+message+"');");
			out.println("location.href='login.net';"); //로그인 실패시 로그인창으로
			out.println("</script>");
			out.close();
			return null;
		}
	}

}
