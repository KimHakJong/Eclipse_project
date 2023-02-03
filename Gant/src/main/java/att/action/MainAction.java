package att.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import att.db.Attendance;
import att.db.AttendanceDAO;

public class MainAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		Attendance att = new Attendance();
		AttendanceDAO attdao = new AttendanceDAO();
		
		HttpSession session = request.getSession();
		String id  = (String) session.getAttribute("id");
		System.out.println("id=" +id);
		
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
	  
		
		// select == 0 // DB에 id에 해당하는 데이터가 없음을 뜻한다. ->insert
		// select == 1 // 기존에 데이터를 가져온다. -> getselect()	
		int select =  attdao.Attselect(id);
		if(select == 0) {
			attdao.insert(id);	
			request.setAttribute("work_week","00:00:00");
		}else if(select == 1) {
			att = attdao.getselect(id);
			request.setAttribute("work_week",att.getWork_week());
		}
		request.setAttribute("id",id);
		forward.setPath("att/attmain.jsp");
		forward.setRedirect(false);
		return forward;
		
	 	
		
	 	
		
	
	}

}
