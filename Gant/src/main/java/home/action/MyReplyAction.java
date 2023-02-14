package home.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import comment.db.Comment;
import home.db.MypageDAO;

public class MyReplyAction implements Action{
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		MypageDAO dao = new MypageDAO();
		List<Comment> commentlist = new ArrayList<Comment>();
		
		int page = 1;
		int limit = 10;
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		System.out.println("넘어온 페이지 = " + page);
		
		if(request.getParameter("limit") != null) {
			limit = Integer.parseInt(request.getParameter("limit"));
		}
		System.out.println("넘어온 limit = " + limit);
		
		
		// 댓글 전체 갯수 가져오기
		int commentcount = dao.getCommentCount(id);
		// 게시글 내용물 가져오기
		commentlist = dao.getCommentList(page, limit, id);
		
		int maxpage = (commentcount + limit - 1) / limit;
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
			request.setAttribute("commentcount", commentcount);
			request.setAttribute("commentlist", commentlist);
			request.setAttribute("limit", limit);
			
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			
			forward.setPath("home/myreply.jsp");
			return forward;
			
		} else { // ajax로 요청이 왔을때 처리하는 경우
			System.out.println("state = ajax");
		 
			JsonObject object = new JsonObject();
			object.addProperty("page", page);
			object.addProperty("maxpage", maxpage);
			object.addProperty("startpage", startpage);
			object.addProperty("endpage", endpage);
			object.addProperty("commentcount", commentcount);
			object.addProperty("limit", limit);
		 
			JsonElement je = new Gson().toJsonTree(commentlist);
			System.out.println("commentlist = " + je.toString());
			
			object.add("commentlist", je);
			
			response.setContentType("application/json; charset=utf-8");
			response.getWriter().print(object);
			System.out.println(object.toString());
			return null;
			
		}
	
		
		
	}
}
