package home.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import board.db.Board;
import home.db.MypageDAO;

public class MyboardAction implements Action{
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
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
		
		
		MypageDAO dao = new MypageDAO();
		List<Board> boardlist = new ArrayList<Board>();
		
		int page = 1;
		int limit = 5;
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		System.out.println("넘어온 페이지 = " + page);
		
		if(request.getParameter("limit") != null) {
			limit = Integer.parseInt(request.getParameter("limit"));
		}
		System.out.println("넘어온 limit = " + limit);
		
		
		// 게시글 전체 갯수 가져오기
		int listcount = dao.getListCount(id);
		// 게시글 내용물 가져오기
		boardlist = dao.getBoardList(page, limit, id);
		
		int maxpage = (listcount + limit - 1) / limit;
		System.out.println("총 페이지 수 = " + maxpage);
		int startpage = ((page - 1) / 10) * 10 + 1;
		System.out.println("현재 페이지에 보여줄 시작 페이지 수 : " + startpage);
		int endpage = startpage + 10 - 1;
		System.out.println("현재 페이지에 보여줄 마지막 페이지 수 : " + endpage);
		if(endpage > maxpage) 
			endpage = maxpage;
		
		String state = request.getParameter("state");
		if(state == null) {
			System.out.println("state == null");
			request.setAttribute("page", page);
			request.setAttribute("maxpage", maxpage);
			request.setAttribute("startpage", startpage);
			request.setAttribute("endpage", endpage);
			request.setAttribute("listcount", listcount);
			request.setAttribute("boardlist", boardlist);
			request.setAttribute("limit", limit);
			
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			
			forward.setPath("home/myboard.jsp");
			return forward;
			
		} else { // ajax로 요청이 왔을때 처리하는 경우
			System.out.println("state = ajax");
		 
			JsonObject object = new JsonObject();
			object.addProperty("page", page);
			object.addProperty("maxpage", maxpage);
			object.addProperty("startpage", startpage);
			object.addProperty("endpage", endpage);
			object.addProperty("listcount", listcount);
			object.addProperty("limit", limit);
		 
			JsonElement je = new Gson().toJsonTree(boardlist);
			System.out.println("boardlist = " + je.toString());
			
			object.add("boardlist", je);
			
			response.setContentType("application/json; charset=utf-8");
			response.getWriter().print(object);
			System.out.println(object.toString());
			return null;
			
		}
	
		
		
	}
}
