package sml.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.google.gson.JsonObject;

public class SmlDAO {
	private DataSource ds;
	
	public SmlDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		}catch (Exception ex) {
			System.out.println("DB 연결 실패: " + ex);
			return;
		}
	}
	
	public JsonObject getMemo(String id) { //메모장 열었을 때 전에 저장된 것들을 불러옴
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		JsonObject json = new JsonObject();
		try {
			conn = ds.getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("select * from memo ");
			sql.append("where id = ?");
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				json.addProperty("id", rs.getString("id"));
				json.addProperty("content", rs.getString("content"));
				json.addProperty("background", rs.getString("background"));
				json.addProperty("color", rs.getString("color"));
			}else {
				
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("getMemo메서드 에러");
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
		return json;
	}
	
	public boolean isHave(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean have = false;
		try {
			conn = ds.getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("select id from memo ");
			sql.append("where id = ?");
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				have = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("getMemo메서드 에러");
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
		return have;
	}

	public int addRow(String id) { // id에 해당하는 row가 존재X : row 추가
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			conn = ds.getConnection();
			String sql = "insert into memo "
					   + "(id, content, background, color) "
					   + "values (?,?,'memo-yellow.png','rgb(0, 0, 0)')"; //기본 배경노랑, 글자검정
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, "");
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("addRow메서드 에러");
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

	public int UpdateMemo(Memo memo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			conn = ds.getConnection();
			String sql = "update memo set "
					   + "content=?, background=?, color=? "
					   + "where id = ?"; //기본 배경노랑, 글자검정
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memo.getContent());
			pstmt.setString(2, memo.getBackground());
			pstmt.setString(3, memo.getColor());
			pstmt.setString(4, memo.getId());
			
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("UpdateMemo메서드 에러");
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
	
}
