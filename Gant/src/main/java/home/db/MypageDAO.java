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
					+ " email, post, address, department, position, jumin, "
					+ " profileimg "
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
				m.setJumin(rs.getString("jumin"));
				m.setProfileimg(rs.getString("profileimg"));
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


	// 개인정보 수정
	public int update(Members m) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			conn = ds.getConnection();
			String sql = "update members "
					  + " set password = ?, phone_num = ?, email = ?, "
					  + " post = ?, "
					  + " address = ?, department = ?, "
					  + " position = ?, profileimg = ? "
					  + " where id = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m.getPassword());
			pstmt.setString(2, m.getPhone_num());
			pstmt.setString(3, m.getEmail());
			pstmt.setInt(4, m.getPost());
			pstmt.setString(5, m.getAddress());
			pstmt.setString(6, m.getDepartment());
			pstmt.setString(7, m.getPosition());
			pstmt.setString(8, m.getProfileimg());
			pstmt.setString(9, m.getId());
			
			result = pstmt.executeUpdate();
			if(result == 0) {
				System.out.println("개인정보 변경하지 못했습니다");
			}
			

		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("update()에러 : 개인정보 수정 부분 에러");
		} finally {
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
		return result;
	}
}
