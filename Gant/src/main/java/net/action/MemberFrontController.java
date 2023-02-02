package net.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.net")
public class MemberFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String command = request.getRequestURI().substring(request.getContextPath().length()); //프로젝트 경로 뒤 주소
		
		Action action = null;
		ActionForward forward = null;
		switch (command) {
		case "/login.net":				//쿠키값 확인, 로그인화면이동
			action = new LoginAction(); //자동로그인 쿠키값이 있는 경우 세션에 id값저장 후 메인화면 이동
			break;
		case "/join.net":
			action = new JoinAction(); //회원가입화면 이동
			break;
		case "/idcheck.net":
			action = new IdCheckAction(); //회원가입 시 ajax 이용하여 id중복확인
			break;
		case "/certcheck.net":
			action = new CertCheckAction(); //이메일인증 시 ajax 이용하여 인증번호 발송, 인증번호 넘김 
			break;
		case "/joincheck.net":
			action = new JoinCheckAction(); //회원가입정보 입력 후 가입하기눌렀을 때 성공,실패여부 확인 
			break;
		case "/logincheck.net":				 //ID저장 또는 자동로그인 체크한 경우 id값을 쿠키에 저장
			action = new LoginCheckAction(); //로그인 성공 및 실패 여부 확인
			break;
		case "/logout.net":
			action = new LogoutAction(); //유효한 세션 제거 후 로그아웃 알림창 후 로그인화면 이동
			break;						 //만약 자동로그인 쿠키 살아있는 경우 쿠키 유효시간 설정 0
		case "/findid.net":
			action = new FindIdAction();
			break;
		case "/findidok.net":
			action = new FindIdOkAction();
			break;
		case "/findpass.net":
			action = new FindPassAction();
			break;
		case "/findpassok.net":
			action = new FindPassOkAction();
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
