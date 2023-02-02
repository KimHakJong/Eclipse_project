package net.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MembersDAO {
	private DataSource ds;
	
	public MembersDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		}catch (Exception ex) {
			System.out.println("DB 연결 실패: " + ex);
			return;
		}
	}
	
	public int idCheck(String id) { //아이디 중복체크
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		try {
			conn = ds.getConnection();
			
			String sql = "select id from members where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next())
				result = 1; //아이디중복
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)
					rs.close();
			}catch(SQLException se) {
				se.printStackTrace();
			}try {
				if(pstmt!=null)
					pstmt.close();
			}catch(SQLException se) {
				se.printStackTrace();
			}try {
				if(conn!=null)
					conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	public int idPassCheck(String id,String pass) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0; //아이디 존재X
		try {
			conn = ds.getConnection();
			String sql = "select id,password from members where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString("password").equals(pass)) {
					result = 1; //아이디 비밀번호 일치
				}else {
					result = -1; //아이디만 일치
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)
					rs.close();
			}catch(SQLException se) {
				se.printStackTrace();
			}try {
				if(pstmt!=null)
					pstmt.close();
			}catch(SQLException se) {
				se.printStackTrace();
			}try {
				if(conn!=null)
					conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public int insert(Members m) { //회원가입
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			conn = ds.getConnection();
			String insert_sql = "insert into members "
							+ "(admin,id,password,name,jumin,phone_num,email,post,address,department,position) "
							+ "values(?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(insert_sql);
			pstmt.setString(1, m.getAdmin());
			pstmt.setString(2, m.getId());
			pstmt.setString(3, m.getPassword());
			pstmt.setString(4, m.getName());
			pstmt.setString(5, m.getJumin());
			pstmt.setString(6, m.getPhone_num());
			pstmt.setString(7, m.getEmail());
			pstmt.setInt(8, m.getPost());
			pstmt.setString(9, m.getAddress());
			pstmt.setString(10, m.getDepartment());
			pstmt.setString(11, m.getPosition());
			
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)
					pstmt.close();
			}catch(SQLException se) {
				se.printStackTrace();
			}try {
				if(conn!=null)
					conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	public String findIdCheck(String name, String email) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String id = ""; //해당 이름이 존재X
		try {
			conn = ds.getConnection();
			String sql = "select id,name,email from members where name = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				if(rs.getString("email").equals(email)) {
					id = rs.getString("id");
					break;
				}else {
					id = "noemail"; //이름에 해당하는 이메일이 존재X
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)
					rs.close();
			}catch(SQLException se) {
				se.printStackTrace();
			}try {
				if(pstmt!=null)
					pstmt.close();
			}catch(SQLException se) {
				se.printStackTrace();
			}try {
				if(conn!=null)
					conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return id;
	}

	public String findPassCheck(String id, String name, String email) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String pass = ""; //해당아이디X
		try {
			conn = ds.getConnection();
			String sql = "select id,password,name,email from members "
					   + "where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString("name").equals(name) 
						&& rs.getString("email").equals(email)) {
					pass = rs.getString("password");
				}else if (rs.getString("name").equals(name)
						&& !rs.getString("email").equals(email)) {
					pass = "noemail";
				}else {
					pass = "noname";
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)
					rs.close();
			}catch(SQLException se) {
				se.printStackTrace();
			}try {
				if(pstmt!=null)
					pstmt.close();
			}catch(SQLException se) {
				se.printStackTrace();
			}try {
				if(conn!=null)
					conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return pass;
	}
	
}
