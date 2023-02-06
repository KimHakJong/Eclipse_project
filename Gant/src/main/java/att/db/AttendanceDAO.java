package att.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class AttendanceDAO {
private DataSource ds;
	
	//생성자에서 JNDI 리소스를 참조하여 Connection 객체를 얻어옵니다.
	public AttendanceDAO() {
		try {
			 // conttext.xml에서 설정한 리소스 jdbc/Oracle을 참조하여 Connection 객체를 얻어온다.
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		}catch (Exception ex) {
			System.out.println("DB 연결 실패 :" + ex);
		}
		
	}
	//DB 데이터가 있는지 없는지 확인하는  select
	public int Attselect(String id) {
		 Connection conn = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		 int result =0; // DB에 해당 id가 없습니다.
		 try {
			conn = ds.getConnection();
		    
			String sql = "select * from attendance where id = ? ";
			// PreparedStatement 객체얻기
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,id);
				rs = pstmt.executeQuery();
			
				if(rs.next()){ //더이상 읽을 데이터가 없을 때 까지 반복
					result = 1; //DB에 해당 id가 있습니다.
				}
				}catch(Exception se) {
					se.printStackTrace();
				}finally {
					try {
						if(rs != null)
							rs.close();
					}catch(SQLException e) {
						System.out.println(e.getMessage());
					}try {
						if(pstmt != null)
							pstmt.close();
					}catch(SQLException e) {
						System.out.println(e.getMessage());
					}
					try {
						if(conn != null)
							conn.close();}
					catch(Exception e) {					
						System.out.println(e.getMessage());
					}
		}
		return result;
		}
    
	//데이터를 가져오는 메서드
	public Attendance getselect(String id) {
		 Connection conn = null;
		 PreparedStatement pstmt = null;
		 ResultSet rs = null;
		 Attendance att = null;
		 try {
			conn = ds.getConnection();
		    
			String sql = "select * from attendance where id = ? ";
			
			// PreparedStatement 객체얻기
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,id);
				rs = pstmt.executeQuery();
			
				if(rs.next()){ //더이상 읽을 데이터가 없을 때 까지 반복
					att = new Attendance();
					String startTime = rs.getString("starTtime");
					String endTime = rs.getString("endTime");
					String overTime = rs.getString("overTime");
					String work_today = rs.getString("work_today");
					String work_week = rs.getString("work_week");
					String checkbutton = rs.getString("checkbutton");
					String work_date = rs.getString("work_date");
					int check_work_week = rs.getInt("check_work_week");
					

					System.out.println(work_week);
					System.out.println("checkbutton =" +checkbutton);
					att.setStarTtime(startTime); // 주간 총 근무시간에서 더해주기 위해 
					att.setEndTime(endTime);
					att.setOverTime(overTime);
					att.setWork_today(work_today);
					att.setWork_week(work_week);	
					att.setCheckbutton(checkbutton);
					att.setWork_date(work_date);
					att.setCheck_work_week(check_work_week);
				
				}
				}catch(Exception se) {
					se.printStackTrace();
				}finally {
					try {
						if(rs != null)
							rs.close();
					}catch(SQLException e) {
						System.out.println(e.getMessage());
					}try {
						if(pstmt != null)
							pstmt.close();
					}catch(SQLException e) {
						System.out.println(e.getMessage());
					}
					try {
						if(conn != null)
							conn.close();}
					catch(Exception e) {					
						System.out.println(e.getMessage());
					}
		}
		return att;
		}
	
	
   //insert 처음 메뉴화면에서 근태관리로 들어갈때 데이터가 없을때 사용
	public int insert(String id) {
		 Connection conn = null;
		  PreparedStatement pstmt = null;
		  int result = 0;
		 try {
			conn = ds.getConnection();
			
			String sql = "INSERT INTO attendance (id,work_week,checkbutton,work_date) "
					+ " VALUES (?,?,'false',to_char(SYSDATE, 'YYYYMMDD'))"; // checkbutton == 'false' 퇴근 버튼 비활성화
	
			// INSERT문 확인하기
			//System.out.println(sql);
		
			// PreparedStatement 객체 얻기
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1,id);
					pstmt.setString(2,"00:00:00");
					
					result = pstmt.executeUpdate(); // 삽입성공시 result는 1
					
					// 결과 확인하기
					System.out.println(result  + "행이 추가되었습니다.(Att)");
							
		 }catch(Exception ex) {
				ex.printStackTrace();
			}finally {
				try {
					if(pstmt != null)
						pstmt.close();
				}catch(SQLException e) {
					e.printStackTrace();
					System.out.println(e.getMessage());
				}
				try {
					if (conn != null)
						conn.close();
				}catch(Exception e1) {
					e1.printStackTrace();
					System.out.println(e1.getMessage());
				}
			}

		return result;
		}// insert end  
	
	
	public int startTimeUpdate(Attendance att) { // 출근버튼 비활성화 checkbutton='true'
			 Connection conn = null;
			 PreparedStatement pstmt = null;
			 int result = 0;
			 String sql = " update attendance "
			 		    + " set starTtime=? , checkbutton='true' , work_date=to_char(SYSDATE, 'YYYYMMDD') "
			 		    + " where id=? ";
			 
			 try {
			    conn = ds.getConnection();
			    
			    pstmt =conn.prepareStatement(sql);
				
		
			   
				pstmt.setString(1,att.getStarTtime());
				pstmt.setString(2,att.getId());
				
				result = pstmt.executeUpdate();
				
				if(result == 1) {
                System.out.println("출근 업데이트 성공");
				}
			}catch(Exception ex) {
				ex.printStackTrace();
				System.out.println(" startTimeUpdate() 에러 :" +ex );
			}finally {
				try {
					if(pstmt != null)
						pstmt.close();
				}catch(SQLException e1) {
					e1.printStackTrace();
				}
				try {
					if (conn != null)
						conn.close();
				}catch(SQLException e1) {
					e1.printStackTrace();
					}
		}
			return result;
		}//startTimeUpdate end
	
	
	//퇴근버튼 클릭시 
	public int endTimeUpdate(Attendance att) {
		 Connection conn = null;
		 PreparedStatement pstmt = null;
		 int result = 0;
		 String sql = " update attendance "
		 		    + " set endTime=? , work_today=?, work_week=? , overTime=? , checkbutton='false' "
		 		    + " where id=? ";
		 
	
		 try {
		    conn = ds.getConnection();
		    
		    pstmt =conn.prepareStatement(sql);
			
	
		   
			pstmt.setString(1,att.getEndTime());
			pstmt.setString(2,att.getWork_today());
			pstmt.setString(3,att.getWork_week());
			pstmt.setString(4,att.getOverTime());
			pstmt.setString(5,att.getId());
			
			result = pstmt.executeUpdate();
			
			if(result == 1) {
            System.out.println("퇴근 업데이트 성공");
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println(" endTimeUpdate() 에러 :" +ex );
		}finally {
			try {
				if(pstmt != null)
					pstmt.close();
			}catch(SQLException e1) {
				e1.printStackTrace();
			}
			try {
				if (conn != null)
					conn.close();
			}catch(SQLException e1) {
				e1.printStackTrace();
				}
	}
		return result;
		
	}//endTimeUpdate end
	
	
	//id에 해당하는 휴가테이블 유무 확인 
	public int Vacationselect(String id) {
		 Connection conn = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		 int result =0; // DB에 해당 id가 없습니다.
		 try {
			conn = ds.getConnection();
		    
			String sql = "select * from vacation where id = ? ";
			// PreparedStatement 객체얻기
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,id);
				rs = pstmt.executeQuery();
			
				if(rs.next()){ //더이상 읽을 데이터가 없을 때 까지 반복
					result = 1; //DB에 해당 id가 있습니다.
				}
				}catch(Exception se) {
					se.printStackTrace();
				}finally {
					try {
						if(rs != null)
							rs.close();
					}catch(SQLException e) {
						System.out.println(e.getMessage());
					}try {
						if(pstmt != null)
							pstmt.close();
					}catch(SQLException e) {
						System.out.println(e.getMessage());
					}
					try {
						if(conn != null)
							conn.close();}
					catch(Exception e) {					
						System.out.println(e.getMessage());
					}
		}
		return result;
		}
	
	// 휴가 테이블 insert
	public int Vacationinsert(String id, int num) {
		 Connection conn = null;
		  PreparedStatement pstmt = null;
		  int result = 0;
		 try {
			conn = ds.getConnection();
			
			String sql = "INSERT INTO vacation (id , vacation_num) "
					+ " VALUES (? , ?)"; // checkbutton == 'false' 퇴근 버튼 비활성화
	
			// INSERT문 확인하기
			//System.out.println(sql);
		
			// PreparedStatement 객체 얻기
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1,id);
					pstmt.setInt(2,num);
					result = pstmt.executeUpdate(); // 삽입성공시 result는 1
					
					// 결과 확인하기
					System.out.println(result  + "행이 추가되었습니다.(Vacation)");
							
		 }catch(Exception ex) {
				ex.printStackTrace();
			}finally {
				try {
					if(pstmt != null)
						pstmt.close();
				}catch(SQLException e) {
					e.printStackTrace();
					System.out.println(e.getMessage());
				}
				try {
					if (conn != null)
						conn.close();
				}catch(Exception e1) {
					e1.printStackTrace();
					System.out.println(e1.getMessage());
				}
			}

		return result;
		}// insert end  
	
	
	//vacation 테이블의 정보를 가져온다.
	public Vacation VacationGetselect(String id) {
		 Connection conn = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  Vacation vac = null;
		 try {
			conn = ds.getConnection();
		    
			String sql = "select * from vacation where id = ? ";
			
			// PreparedStatement 객체얻기
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,id);
				rs = pstmt.executeQuery();
			
				
				
				if(rs.next()){ //더이상 읽을 데이터가 없을 때 까지 반복
					vac = new Vacation();
					String startDate = rs.getString("startDate");
					String endDate = rs.getString("endDate");
					int vacation_num = rs.getInt("vacation_num");
					String emergency = rs.getString("emergency");
					String details = rs.getString("details");
			
					vac.setStartDate(startDate);
					vac.setEndDate(endDate);
					vac.setVacation_num(vacation_num);
					vac.setEmergency(emergency);
					vac.setDetails(details);
				}
				}catch(Exception se) {
					se.printStackTrace();
				}finally {
					try {
						if(rs != null)
							rs.close();
					}catch(SQLException e) {
						System.out.println(e.getMessage());
					}try {
						if(pstmt != null)
							pstmt.close();
					}catch(SQLException e) {
						System.out.println(e.getMessage());
					}
					try {
						if(conn != null)
							conn.close();}
					catch(Exception e) {					
						System.out.println(e.getMessage());
					}
		}
		return vac;
		}
	
	
	//members 테이블에서 id에 해당하는 입사일을 가져온다.
	public String gethiredate(String id) {
		Connection conn = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  String hiredate = "";
		 try {
			conn = ds.getConnection();
		    
			String sql = "select HIREDATE from members where id = ? ";
			
			// PreparedStatement 객체얻기
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,id);
				rs = pstmt.executeQuery();
			
				
				
				if(rs.next()){ 
					hiredate = rs.getString("HIREDATE");
				}
				}catch(Exception se) {
					se.printStackTrace();
				}finally {
					try {
						if(rs != null)
							rs.close();
					}catch(SQLException e) {
						System.out.println(e.getMessage());
					}try {
						if(pstmt != null)
							pstmt.close();
					}catch(SQLException e) {
						System.out.println(e.getMessage());
					}
					try {
						if(conn != null)
							conn.close();}
					catch(Exception e) {					
						System.out.println(e.getMessage());
					}
		}
		return hiredate;
		}
	
	
	//휴가 갯수 update 문 // 새로운 해가 되면 휴가는 15개로 채워진다.
	public int VacationNumUpdate(String id) {
		 Connection conn = null;
		 PreparedStatement pstmt = null;
		 int result = 0;
		 String sql = " update vacation "
		 		    + " set vacation_num=15 "
		 		    + " where id=? ";
		 
		 try {
		    conn = ds.getConnection();
		    
		    pstmt =conn.prepareStatement(sql);
			pstmt.setString(1,id);
			
			
			result = pstmt.executeUpdate();
			
			if(result == 1) {
            System.out.println("휴가 업데이트 성공");
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println(" VacationNumUpdate() 에러 :" +ex );
		}finally {
			try {
				if(pstmt != null)
					pstmt.close();
			}catch(SQLException e1) {
				e1.printStackTrace();
			}
			try {
				if (conn != null)
					conn.close();
			}catch(SQLException e1) {
				e1.printStackTrace();
				}
	}
		return result;
		
	}//VacationNumUpdate() end
	
	
	//초가근무 신청 
	public int overtimeUpdate(Attendance att) {
		 Connection conn = null;
		 PreparedStatement pstmt = null;
		 int result = 0;
		 String sql = " update attendance "
		 		    + " set overtime_date=? , overtime_content=? , overtime_reason=? , overTime=? "
		 		    + " where id=? ";
		
		 try {
		    conn = ds.getConnection();
		    
		    pstmt =conn.prepareStatement(sql);
			pstmt.setString(1,att.getOvertime_date());
			pstmt.setString(2,att.getOvertime_content());
			pstmt.setString(3,att.getOvertime_reason());
			pstmt.setString(4,att.getOverTime());
			pstmt.setString(5,att.getId());
			
			result = pstmt.executeUpdate();
			
			if(result == 1) {
            System.out.println("초가근무신청 업데이트 성공");
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println(" overtimeUpdate() 에러 :" +ex );
		}finally {
			try {
				if(pstmt != null)
					pstmt.close();
			}catch(SQLException e1) {
				e1.printStackTrace();
			}
			try {
				if (conn != null)
					conn.close();
			}catch(SQLException e1) {
				e1.printStackTrace();
				}
	}
		return result;
		
	}//overtimeUpdate end
	
	
	// check_work_week 값을 2로 만들어준다.
	public void check_Plus(String id) {
		 Connection conn = null;
		 PreparedStatement pstmt = null;
		 int result = 0;
		 String sql = " update attendance "
		 		    + " set check_work_week = 2 "
		 		    + " where id=? ";
		
		 try {
		    conn = ds.getConnection();
		    
		    pstmt =conn.prepareStatement(sql);
			pstmt.setString(1,id);		
			result = pstmt.executeUpdate();
			
			if(result == 1) {
            System.out.println("월요일 체크 업데이트 성공");
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println(" check_Plus 에러 :" +ex );
		}finally {
			try {
				if(pstmt != null)
					pstmt.close();
			}catch(SQLException e1) {
				e1.printStackTrace();
			}
			try {
				if (conn != null)
					conn.close();
			}catch(SQLException e1) {
				e1.printStackTrace();
				}
	}
			
	}//check_Plus
	
	
	// check_work_week 값을 1로 만들어준다.
	public void check_Minus(String id) {
		 Connection conn = null;
		 PreparedStatement pstmt = null;
		 int result = 0;
		 String sql = " update attendance "
		 		    + " set check_work_week = 1 "
		 		    + " where id=? ";
		
		 try {
		    conn = ds.getConnection();
		    
		    pstmt =conn.prepareStatement(sql);
			pstmt.setString(1,id);		
			result = pstmt.executeUpdate();
			
			if(result == 1) {
            System.out.println("월요일 체크 업데이트 성공");
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println(" check_Plus 에러 :" +ex );
		}finally {
			try {
				if(pstmt != null)
					pstmt.close();
			}catch(SQLException e1) {
				e1.printStackTrace();
			}
			try {
				if (conn != null)
					conn.close();
			}catch(SQLException e1) {
				e1.printStackTrace();
				}
	}
			
	}//check_Minus
	

	
	//휴가 신청 UPdate
	public int VacationUpdate(Vacation vc, long vacationDate) {
		 Connection conn = null;
		 PreparedStatement pstmt = null;
		 int result = 0;
		 String sql = " update vacation "
		 		    + " set startDate = ? , endDate=? , vacation_num = vacation_num -"+vacationDate+" , "
		 		    		+ " emergency = ? , details=? "
		 		    + " where id=? ";
		
		 try {
		    conn = ds.getConnection();
		    
		    pstmt =conn.prepareStatement(sql);
			pstmt.setString(1,vc.getStartDate());	
			pstmt.setString(2,vc.getEndDate());
			pstmt.setString(3,vc.getEmergency());
			pstmt.setString(4,vc.getDetails());
			pstmt.setString(5,vc.getId());
			result = pstmt.executeUpdate();
			
			if(result == 1) {
            System.out.println(" 휴가신청 성공");
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println(" 휴가신청 성공 :" +ex );
		}finally {
			try {
				if(pstmt != null)
					pstmt.close();
			}catch(SQLException e1) {
				e1.printStackTrace();
			}
			try {
				if (conn != null)
					conn.close();
			}catch(SQLException e1) {
				e1.printStackTrace();
				}
	}
		return result;
	}//check_Minus
	
	
	
	



	
	





}
	
	



