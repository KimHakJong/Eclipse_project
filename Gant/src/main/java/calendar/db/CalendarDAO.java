package calendar.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.catalina.filters.ExpiresFilter.XServletOutputStream;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public class CalendarDAO {

	private DataSource ds;

	public CalendarDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB연결 실패 :" + ex);
		}

	}

	public int add(CalendarBean cal) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			conn = ds.getConnection();

			String sql = "insert into calendar (id, name, startday, endday, title, admin) values (?, ?, ?, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, cal.getName());
			pstmt.setString(2, cal.getId());
			pstmt.setString(3, cal.getStart());
			pstmt.setString(4, cal.getEnd());
			pstmt.setString(5, cal.getTitle());
			pstmt.setString(6, cal.getAdmin());

			result = pstmt.executeUpdate();

		} catch (Exception se) {
			System.out.println("add() 삽입 에러: " + se);

			se.printStackTrace();

		} finally {
			
				try {
					if (pstmt != null)
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}

			
				try {
					if (conn != null)
					conn.close();

				} catch (Exception e) {
					e.printStackTrace();
				}

		}

		return result;

	}

	public JsonArray getCalList() {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select id, name, allday, startday, endday, title, admin from calendar";

		JsonArray list = new JsonArray();

		try {
			con = ds.getConnection();

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				JsonObject j = new JsonObject();
				
				System.out.println(rs.getString("id"));
				System.out.println(rs.getString("name"));

				j.addProperty("id", rs.getString("name"));
				j.addProperty("name", rs.getString("id"));
				j.addProperty("allDay", "true");
				j.addProperty("start", rs.getString("startday"));
				j.addProperty("end", rs.getString("endday"));
				j.addProperty("title", rs.getString("title"));
				j.addProperty("admin", rs.getString("admin"));

				list.add(j);
			}

		} catch (Exception ex) {
			System.out.println("getCalList() 에러: " + ex);

			ex.printStackTrace();

		} finally {
			
				try {
					if (rs != null)
					rs.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}

			
				try {
					if (pstmt != null)
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}

			
				try {
					if (con != null)
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

		return list;

	}

	public boolean caldelete(String id) {

		Connection conn = null;
		PreparedStatement pstmt = null;

		boolean result = false;

		try {

			String sql = "delete from Calendar where name = ?";

			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);

			int rs = pstmt.executeUpdate();

			System.out.println(rs);

			if (rs > 0)
				result = true;

		} catch (Exception ex) {
			System.out.println("delete()에러:" + ex);

		} finally {


				try {
					if (pstmt != null)
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}


				try {
					if (conn != null)
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return result;
	}

	public String getadmindate(String name) 
	{
		System.out.println("여기는 getadmindate\nname = " + name);

		Connection conn2 = null;

		PreparedStatement pstmt2 = null;

		ResultSet rs2 = null;

		String admin = "";
		
		try {

			conn2 = ds.getConnection();
			
			String sql2 = "select admin from members where id = ?";
			


				System.out.println("여기까지왔습니다 id = " + name);
				
				pstmt2 = conn2.prepareStatement(sql2);
				pstmt2.setString(1, name);
				rs2 = pstmt2.executeQuery();
	
				
				
				if (rs2.next()) {

					admin = rs2.getString("admin");
					System.out.println(admin);
					
				}


			

			


		} catch (Exception se) {
			se.printStackTrace();
		} finally {

			try {
				if (rs2 != null)
					rs2.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}

			try {
				if (pstmt2 != null)
					pstmt2.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
			try {
				if (conn2 != null)
					conn2.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return admin;
	}

	public int update(CalendarBean cal, String id) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			conn = ds.getConnection();

			String sql = "update calendar set startday = ?, endday = ?, title = ? where name = ?";

			pstmt = conn.prepareStatement(sql);


			pstmt.setString(1, cal.getStart());
			pstmt.setString(2, cal.getEnd());
			pstmt.setString(3, cal.getTitle());
			pstmt.setString(4, id);
			
			
			

			result = pstmt.executeUpdate();
			if(result > 0) {
				System.out.println("수정 완료");				
			}

		} catch (Exception se) {
			System.out.println("add() 삽입 에러: " + se);

			se.printStackTrace();

		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}

			if (conn != null)
				try {
					conn.close();

				} catch (Exception e) {
					e.printStackTrace();
				}

		}

		return result;

	}

}
