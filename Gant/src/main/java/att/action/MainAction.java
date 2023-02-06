package att.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import att.db.Attendance;
import att.db.AttendanceDAO;
import att.db.Vacation;

public class MainAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		Attendance att = new Attendance();
		AttendanceDAO attdao = new AttendanceDAO();
		Vacation vac = new Vacation();
		
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
			request.setAttribute("checkbutton","false");
		}else if(select == 1) {
			att = attdao.getselect(id); // AttendanceDAO의 메서드를 이용하여 DB에 저장되어있는 정보를 가져온다.
			
			// 오늘의 요일을 구한다 -> 주간 총 근무시간은 월요일에 리셋이되어야한다. 월요일이면 work_week 값은 00:00:00이 된다.
			Calendar rightNow = Calendar.getInstance();
			// day_of_week 값이(요일이) int 형태로 나타난다. 1 = 일요일, 2 = 월요일 ,3= 화요일 ...7 = 토요일 
			int day_of_week = rightNow.get(Calendar.DAY_OF_WEEK);
			if(day_of_week == 2) {//2 = 월요일 이면 리셋
				request.setAttribute("work_week","00:00:00");
				request.setAttribute("work_week_hours","00"); // 주간 근무 현황의 % 채우기 용도로 사용한다.
				
			}else {
			request.setAttribute("work_week",att.getWork_week()); // 월요일이 아니라면 기존의 주간 총 근무시간을 가져온다.
			request.setAttribute("work_week_hours",att.getWork_week().split(":")[0]);
			
			}
			request.setAttribute("checkbutton",att.getCheckbutton()); // 출/퇴근 버튼 활성화 비활성화를 위한 값 
		}
		
		
	    //휴가 갯수 데이터 가져오기
		//selectVacation == 0 // DB에 id에 해당하는 데이터가 없음을 뜻한다. ->insert
		// select == 1 // 기존에 데이터를 가져온다. -> 
		int selectVacation =  attdao.Vacationselect(id);
		
		// 현재 날짜/시간 // 연차의 갯수를 정하기 위해 현재 날짜를 가져온다. 또한 1월1일이 되면 연차가 리셋된다.
        Date now = new Date();
        // 포맷팅 정의
		SimpleDateFormat Day = new SimpleDateFormat("yyyyMMdd");
		 // 포맷팅 적용
		String now_Day = Day.format(now); // 현재 년월일이다.
		
		
		 //현재 년도구하기
		String now_year = now_Day.substring(0,4);
				
		String hiredate =  attdao.gethiredate(id); // member테이블에서 입사일을 가져온다.
		
		String hiredate_year = hiredate.substring(0,4); // 년도만 가져오기
		
		
		if(selectVacation == 0 ) { // DB에 id에 해당하는 데이터가 없음을 뜻한다. ->insert
				
			     int vacation_num; // 휴가 갯수
		
				//입사년도와 현재 년도가 같다면 연차는 1달에 1개만 적용이 될것이다. 아니라면 15개 적용
				if(hiredate_year.equals(now_year)) {
					String hiredate_month_day = hiredate.substring(4); // 입사년 월/일 가져오기

					int hiredate_month =Integer.parseInt(hiredate.substring(4,6)); //월가져오기

						  //만약 입사일이 1월1일이면 월차는 그 달을 포함하여 계산하여준다.
						if(hiredate_month_day.equals("0101")) {
							vacation_num = 12-hiredate_month+1; // 1년에12달이기 때문에 12번에서 입사달을 빼주고 그 달은 포함시키기 때문에 +1을 해준다.
						}else {
							vacation_num = 12-hiredate_month; //입사일이 01월01일이 아니라면 입사 달은 연차에서 뺀다.
						}
					
					attdao.Vacationinsert(id,vacation_num);	// 휴가 날짜를 insert한다.
					request.setAttribute("vacation_num",vacation_num); //휴가갯수를 attmain.jsp에 넘겨준다.
				}else {
					attdao.Vacationinsert(id,15);	// 입사년도와 현재 년도가 다르다면 휴가는 15개이다.
					request.setAttribute("vacation_num","15");// 휴가 15개로 넘겨준다.
				}
			
			
		}else if(selectVacation == 1) {  // DB에 id에 해당하는 휴가테이블 데이터가 있을때
			
			//만약 해가 바뀐다면 휴가의 갯수는 15개로 채워져야한다.
			int n_year = Integer.parseInt(now_year); // 현재 년도 int 형변환	 
			att = attdao.getselect(id);
			String work_date = att.getWork_date().substring(0,4); // 지난 출근일 년도를 가져온다.
			int last_year = Integer.parseInt(work_date);
			
			
			//현재 년도 = 직전 근무일 년도 + 1 이 true 라면 해가 바뀌었으니 휴가의 갯수는 15개로 채운다.
			if(n_year == last_year+1) {
				attdao.VacationNumUpdate(id);
			}
			   
			vac = attdao.VacationGetselect(id);	
			request.setAttribute("vacation_num",vac.getVacation_num()); //DB에 저장되어있는 휴가 갯수를 보낸다.
		}
		
		request.setAttribute("id",id);
		forward.setPath("att/attmain.jsp");
		forward.setRedirect(false);
		return forward;
		
	}

}
