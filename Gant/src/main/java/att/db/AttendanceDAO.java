package att.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
    
	//기존의 주간 시간 데이터를 가져오기
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
					String work_week = rs.getString("work_week");
					System.out.println(work_week);
					att.setWork_week(work_week);	
					
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
			
			String sql = "INSERT INTO attendance (id,work_week) "
					+ " VALUES (?,?)";
	
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
	
	
	public int Update(Attendance att) {
			 Connection conn = null;
			 PreparedStatement pstmt = null;
			 int result = 0;
			 String sql = " update attendance "
			 		    + " set work_today=? , work_week=? , overtime=? "
			 		    + " where id=? ";
			 
			 
			 try {
			    conn = ds.getConnection();
			    
			    pstmt =conn.prepareStatement(sql);
				
		
			   
				pstmt.setString(1,att.getWork_today());
				pstmt.setString(2,att.getWork_week());
				pstmt.setString(3,att.getOvertime());
				pstmt.setString(4,att.getId());
				
				result = pstmt.executeUpdate();

			}catch(Exception ex) {
				ex.printStackTrace();
				System.out.println(" update() 에러 :" +ex );
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
		}//update end

	





}
	
	



