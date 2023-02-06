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
			action = new FindIdAction(); //아이디찾기 화면 이동
			break;
		case "/findidok.net":
			action = new FindIdOkAction();  //입력한 이름과 이메일을 조회 후 없으면 알림창 뜨면서 뒤로가기
			break;							//조회결과 일치: 이름, 아이디값을 findidok.jsp로 보냄
		case "/findpass.net":				//비밀번호찾기 화면 이동
			action = new FindPassAction();
			break;
		case "/findpassok.net":				 //입력한 아이디,이름,이메일 조회 후 일치하면 id와 알려줄 비밀번호값 findpassok.jsp로 보낸다.
			action = new FindPassOkAction(); //불일치하면 불일치한 값 알림창으로 알려주고 뒤로가기
			break;
		case "/list.net":				//한페이지당 보여줄 개수, 현재 페이지,검색필드, 검색어확인 후 시작 끝 최대 페이지와 해당회원 목록 보냄
			action = new ListAction();
			break;
		case "/orgchart.net":			//주소록에 include할 조직도 화면
			action = new OrgChart();	//부서별 이름을 조회 후 Json객체에 담음	
			break;
		case "/detail.net":
			action = new DetailAction();
			break;
		case "/delete.net":
			action = new DeleteAction();
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
