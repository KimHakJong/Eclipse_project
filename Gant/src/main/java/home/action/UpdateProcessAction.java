package home.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import home.db.MypageDAO;
import net.db.Members;
import net.db.MembersDAO;

public class UpdateProcessAction implements Action{
	public ActionForward execute(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {

		String realFolder =	"";
		String saveFolder = "memberupload";
		int fileSize = 5*1024*1024;

		ServletContext sc = request.getServletContext();
		realFolder = sc.getRealPath(saveFolder);

		try {
			MultipartRequest multi = new MultipartRequest(
					request, realFolder, fileSize, "utf-8", new DefaultFileRenamePolicy());
			String id = multi.getParameter("id");
			String password = multi.getParameter("password");
			String phone1 = multi.getParameter("phone1");
			String phone2 = multi.getParameter("phone2");
			String phone3 = multi.getParameter("phone3");
			String phone_num = phone1+ "-" +phone2+ "-" +phone3;
			String email = multi.getParameter("email")+"@"+multi.getParameter("domain");
			int post = Integer.parseInt(multi.getParameter("post"));
			String address = multi.getParameter("address");
			String department = multi.getParameter("department");
			String position = multi.getParameter("position");

			String profileimg = multi.getFilesystemName("profileimg");

			MypageDAO dao = new MypageDAO();
			Members m = new Members();

			m.setId(id);
			m.setPassword(password);
			m.setPhone_num(phone_num);
			m.setEmail(email);
			m.setPost(post);
			m.setAddress(address);
			m.setDepartment(department);
			m.setPosition(position);
			m.setProfileimg(profileimg);

			if(profileimg != null) {
				m.setProfileimg(profileimg);
			}else if(multi.getParameter("check") != "") {
				m.setProfileimg(multi.getParameter("check"));
			}

			int result = dao.update(m);

			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			if(result == 1) {
				
				MembersDAO mdao = new MembersDAO();
				mdao.getProfileimg(id);
				HttpSession session = request.getSession();
				session.setAttribute("profileimg", mdao.getProfileimg(id));
				
				out.println("<script>");
				out.println("alert('개인정보 수정 성공하였습니다.');");
				out.println("location.href='main.home';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('개인정보 수정 실패하였습니다.');");
				out.println("location.href='update.home';");
				out.println("</script>");
			}
			out.close();
			return null;


		} catch(IOException e) {
			e.printStackTrace();
			ActionForward forward = new ActionForward();
			forward.setPath("error/error.jsp");
			request.setAttribute("message", "프로필 사진 업로드 사진 실패.");
			forward.setRedirect(false);
			return forward;
		}











	}

}
