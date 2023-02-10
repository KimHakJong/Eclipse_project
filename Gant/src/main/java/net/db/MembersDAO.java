package net.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.google.gson.JsonObject;

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
	public int idPassCheck(String id,String pass) { //로그인 아이디비밀번호확인
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
	
	public String getProfileimg(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String profile = "";
		try {
			conn = ds.getConnection();
			String sql = "select profileimg from members "
					   + "where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				profile = rs.getString("profileimg");
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("getProfileimg 에러");
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
		return profile;
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

	public String findIdCheck(String name, String email) { //아이디 찾기
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

	public String findPassCheck(String id, String name, String email) { //비밀번호찾기
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

	public int getMemberCount() {
		Connection conn = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		int cnt = 0; //조회된 회원X
		try {
			conn = ds.getConnection();
			String sql = "select count(*) from members "
					   + "where admin != 'true'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				cnt = rs.getInt(1);
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("getMemberCount에러");
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
		return cnt;
	}

	public List<Members> getMemberList(int page, int limit) {
		Connection conn = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		List<Members> list = new ArrayList<Members>();
		try {
			conn = ds.getConnection();
			String sql = "select * "
					+ " from (select a.*, rownum rnum"
					+ "       from ( select * from members "
					+ "              where admin != 'true'"
					+ "              order by name)a"
					+ "       where rownum <= ? "
					+ "       )"
					+ " where rnum >= ? and rnum <= ?";
			
			pstmt = conn.prepareStatement(sql);
			
			int startrow = (page - 1) * limit + 1; //1페이지는 10부터가 아닌 번호1부터라 -1
			int endrow = startrow + limit - 1;
			
			pstmt.setInt(1, endrow);
			pstmt.setInt(2, startrow);
			pstmt.setInt(3, endrow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Members m = new Members();
				m.setName(rs.getString("name"));
				m.setDepartment(rs.getString("department"));
				m.setPhone_num(rs.getString("phone_num"));
				list.add(m);
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("getMemberList에러");
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
		return list;
	}

	public int getMemberCount(String searchfield, String searchword) {
		Connection conn = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		int cnt = 0; //조회된 회원X
		try {
			conn = ds.getConnection();
			String sql = "select count(*) from members "
					   + "where admin != 'true' "
					   + "and " + searchfield + " like ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+searchword+"%");
			
			rs = pstmt.executeQuery();
			if(rs.next())
				cnt = rs.getInt(1);
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("오버로딩 getMemberCount메소드 에러");
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
		return cnt;
	}

	public List<Members> getMemberList(String field, String word, int page, int limit) {
		Connection conn = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		List<Members> list = new ArrayList<Members>();
		try {
			conn = ds.getConnection();
			String sql = "select * "
					+ " from (select a.*, rownum rnum"
					+ "       from ( select * from members "
					+ "              where admin != 'true' "
					+ "              and " + field + " like ? "
					+ "              order by name) a"
					+ "       where rownum <= ?"
					+ "       )"
					+ " where rnum >= ? and rnum <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+word+"%");
			
			int startrow = (page - 1) * limit + 1; //1페이지는 10부터가 아닌 번호1부터라 -1 , 1부터시작:+1
			int endrow = startrow + limit - 1;
			
			pstmt.setInt(2, endrow);
			pstmt.setInt(3, startrow);
			pstmt.setInt(4, endrow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Members m = new Members();
				m.setName(rs.getString("name"));
				m.setDepartment(rs.getString("department"));
				m.setPhone_num(rs.getString("phone_num"));
				list.add(m);
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("오버로딩 getMemberList 에러");
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
		return list;
	}

	public String selectByDname(String dname) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String names = "";
		try {
			conn = ds.getConnection();
			String sql = "select name from members "
					   + "where department = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dname);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				names += rs.getString("name") + ",";
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("selectByDname에러");
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
		return names;
	}

	public JsonObject memberDetail(String name) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		JsonObject json = new JsonObject();
		try {
			conn = ds.getConnection();
			String sql = "select profileimg, name, department, position, jumin, "
					+ "phone_num, email, address from members "
					+ "where name = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				Members m = new Members();
				json.addProperty("profileimg", rs.getString("profileimg"));
				json.addProperty("name",rs.getString("name"));
				json.addProperty("department",rs.getString("department"));
				json.addProperty("position",rs.getString("position"));
			
				m.setJumin(rs.getString("jumin"));
				json.addProperty("birth",m.getBirth()); //주민번호를 생년월일로 변환
				
				json.addProperty("phone_num",rs.getString("phone_num"));
				json.addProperty("email",rs.getString("email"));
				json.addProperty("address",rs.getString("address"));
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("selectByDname에러");
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
	
	public JsonObject checkCommute(String name, String department, String phone_num) { //출퇴근표시아이콘을위한 메소드
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		JsonObject json = new JsonObject();
		try {
			conn = ds.getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("select checkbutton ");
			sql.append("from members natural join attendance ");
			sql.append("where id = ");
			sql.append("           (select id from members ");
			sql.append("            where name=? and department=? and phone_num=?)");
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, name);
			pstmt.setString(2, department);
			pstmt.setString(3, phone_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				json.addProperty("check", rs.getString("checkbutton"));
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("checkCommute()에러");
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
				if(conn!=null) {
					conn.setAutoCommit(true);
					conn.close();
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return json;
	}
	
	public String isadminhuman(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String adminhuman = "";
		try {
			conn = ds.getConnection();
			String sql = "select admin, department from members "
					   + "where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString("admin").equals("true") || rs.getString("department").equals("인사부")) {
					adminhuman = "true";
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
		return adminhuman;
	}

	public int delete(String name, String department, String phone_num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			conn = ds.getConnection();
			String sql = "delete from members "
					   + "where name = ? and department = ? and phone_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, department);
			pstmt.setString(3, phone_num);
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

	public Members selectForChat(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Members m = null;
		try {
			conn = ds.getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("select name,profileimg from members ");
			sql.append("where id = ?");
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				m = new Members();
				m.setName(rs.getString("name"));
				m.setProfileimg(rs.getString("profileimg"));
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("selectName에러");
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
		return m;
	}
}
