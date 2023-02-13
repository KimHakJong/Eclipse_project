package comment.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import comment.db.CommentDAO;

public class CommentList implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
        
		CommentDAO dao = new CommentDAO();
		
		//json 형식으로 받아온 파라미터값 {"comment_board_num" : $("comment_board_num").val() , state:state},
		int comment_board_num = Integer.parseInt(request.getParameter("comment_board_num"));
		System.out.println(comment_board_num);
		int state = Integer.parseInt(request.getParameter("state")); // state == 1 -> 댓글 등록순  ,state == 2 -> 댓글 최신순
		
		// comment_board_num에 해당하는 댓글 갯수
		int listcount = dao.getListCount(comment_board_num);
		
		//JsonObject 객체 생성
		JsonObject object = new JsonObject();
		JsonArray jarray = dao.getCommentList(comment_board_num,state);
		// Json key, value 추가
		object.addProperty("listcount",listcount);
		
		// JsonObject에 배열을 넣어주려는 경우 add메서드에서 toJsonTree(배열)메서드를 사용하여주면된다.
		JsonElement arr = new Gson().toJsonTree(jarray);
		object.add("boardlist",arr);
		
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(object.toString());
		System.out.println(object.toString());
		return null;
	}

}
