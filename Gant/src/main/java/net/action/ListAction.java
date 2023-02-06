package net.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import net.db.Members;
import net.db.MembersDAO;

public class ListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		
		
		MembersDAO dao = new MembersDAO();
		
		//출퇴근 표시아이콘을 위한 코드 (ajax로 처리)
		if(request.getParameter("name") != null) { //ajax로 키 name이 넘어오면
			String name = request.getParameter("name");
			String department = request.getParameter("department");
			String phone_num = request.getParameter("phone_num");
			JsonObject json = dao.checkCommute(name,department,phone_num);
			response.setContentType("application/json;charset=utf-8");
			System.out.println(json.toString());
			response.getWriter().print(json);
			return null;
		}
		
		int page = 1; //현재 페이지 기본값
		
		if(request.getParameter("page")!=null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		request.setAttribute("page", page); //기본값1,넘어온값 있으면 보낸다.
		
		
		int limit = 6; //최대 보이는 수
		
		List<Members> memberlist = null;
		int membercount = 0; //회원 수
		String searchword="";
		String searchfield="";
		//검색클릭안한 경우
		if(request.getParameter("searchword")==null || request.getParameter("searchword").equals("")) {
			membercount = dao.getMemberCount();
			memberlist = dao.getMemberList(page, limit);
		}else { //검색 클릭한 경우
			searchfield = request.getParameter("searchfield");
			searchword = request.getParameter("searchword");//list.jsp에서 받음
			membercount = dao.getMemberCount(searchfield,searchword);
			memberlist = dao.getMemberList(searchfield, searchword, page, limit);
		}
		
		
		int maxpage = (membercount + limit - 1) / limit; //총 페이지수
		int startpage = ((page-1)/10) * 10 + 1;
		int endpage = startpage + 10 - 1;
		
		if (endpage > maxpage) endpage=maxpage;
		
		//관리자와 인사부는 삭제버튼 보이기 위한 코드
		String id = (String) request.getSession().getAttribute("id");
		String isadminhuman = dao.isadminhuman(id);
		request.setAttribute("isadminhuman", isadminhuman);
		
		//테이블조회를 위한 코드
		request.setAttribute("maxpage", maxpage);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		
		request.setAttribute("membercount", membercount);
		request.setAttribute("memberlist", memberlist);
		request.setAttribute("searchfield", searchfield);
		request.setAttribute("searchword", searchword);
		
		forward.setPath("member/list.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
