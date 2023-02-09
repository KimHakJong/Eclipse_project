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

		try 
		{
			conn = ds.getConnection();

			
			String sql = "insert into calendar (id, startday, endday, title) values (?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1,cal.getId() );
			pstmt.setString(2,cal.getStart());
			pstmt.setString(3,cal.getEnd());
			pstmt.setString(4,cal.getTitle());

			result = pstmt.executeUpdate();

			
		} catch (Exception se)
		{
			System.out.println("add() 삽입 에러: " + se);
			
			se.printStackTrace();

		} 
		finally 
		{
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

	public List<CalendarBean> getCalList() {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from calendar";

		List<CalendarBean> list = new ArrayList<CalendarBean>();
		
		try {
			con = ds.getConnection();

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				CalendarBean b = new CalendarBean();
						
				b.setStart(rs.getString("startday"));
				b.setEnd(rs.getString("endday"));
				b.setTitle(rs.getString("title"));

				list.add(b);
			}


		} catch (Exception ex) {
			System.out.println("getCalList() 에러: " + ex);
			
			ex.printStackTrace();

		} finally {
			if (rs != null)
			try {
					rs.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
			if (pstmt != null) {
			try {
					pstmt.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
			if (con != null)
			try {
					con.close();

			} catch (Exception e) {
				e.printStackTrace();
			}

			}
		}

		return list;

	}


}
