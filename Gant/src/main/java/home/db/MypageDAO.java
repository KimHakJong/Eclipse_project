package home.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import net.db.Members;

public class MypageDAO {
	
	private DataSource ds;
	
	public MypageDAO() {
		
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception e) {
			System.out.println("DB연결 실패 : "+e);
			return;
		}
	}
	
	
	// 자기에 대한 정보 가져오기
	public Members Myinfo (String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Members m = null;
		try {
			conn = ds.getConnection();
			
			String sql = "select name, id, password, phone_num, "
						+ " email, post, address, department, position "
						+ " from members "
						+ " where id = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				m = new Members();
				m.setName(rs.getString("name"));
				m.setId(rs.getString("id"));
				m.setPassword(rs.getString("password"));
				m.setPhone_num(rs.getString("phone_num"));
				m.setEmail(rs.getString("email"));
				m.setPost(rs.getInt("post"));
				m.setAddress(rs.getString("address"));
				m.setDepartment(rs.getString("department"));
				m.setPosition(rs.getString("position"));
			}
			
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("Myinfo()에러 발생");
		} finally {
			try {
				if(rs!=null)
					rs.close();
			} catch(SQLException e) {
				System.out.println(e.getMessage());
				e.printStackTrace();
			}
			try {
				if(pstmt!=null)
					pstmt.close();
			} catch(SQLException e) {
				System.out.println(e.getMessage());
				e.printStackTrace();
			}
			try {
				if(conn!=null)
					conn.close();
			} catch(SQLException e) {
				System.out.println(e.getMessage());
				e.printStackTrace();
			}
		}
		return m;
	}
	
}
