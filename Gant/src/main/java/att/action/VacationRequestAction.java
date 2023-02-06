package att.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class VacationRequestAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		HttpSession session = request.getSession();
		String id  = (String) session.getAttribute("id");
		System.out.println("id ="+id);
		
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
		
		String startDate = request.getParameter("startDate"); // 휴가시작일
		String endDate = request.getParameter("endDate"); // 휴가 종료일
		String emergency_one = request.getParameter("emergency_one"); // 010
		String emergency_two = request.getParameter("emergency_two"); // 0000
		String emergency_three = request.getParameter("emergency_three"); // 0000
		String details = request.getParameter("details"); // 휴가 세부사항
		String emergency =emergency_one+"-"+emergency_two+"-"+emergency_three;//비상연락망 
		// 휴가 종료일 - 휴가 시작일
		

		
		
		// TODO Auto-generated method stub
		return null;
	}

}
