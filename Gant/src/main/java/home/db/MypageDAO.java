package home.db;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.db.Board;
import comment.db.Comment;
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


	// 글 갯수 구하기
	public int getListCount(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0; //글의 갯수
		try {
			conn = ds.getConnection();
			String sql = "select count(*) from boards "
					+ "	where BOARD_NAME = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if(rs.next()){
				x = rs.getInt(1);
			}
		}catch(Exception se) {
			se.printStackTrace();
			System.out.println("getListCount()에러 :" + se);
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
		return x;
	}//getListCount()



	//일반 게시글 리스트
	public List<Board> getBoardList(int page, int limit, String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select * "
				+ " from  (select rownum rnum, j.* "
				+ "        from (select boards.* , nvl(cnt,0) as cnt "
				+ "              from boards left outer join (select comment_board_num ,count(*) as CNT"
				+ "                                         from com"
				+ "                                         group by comment_board_num)"
				+ "              on BOARD_NUM = comment_board_num "
				+ "				 where BOARD_NAME = ? "
				+ "              order by BOARD_RE_REF desc,"
				+ "              BOARD_RE_SEQ asc) j "                                      
				+ "       where rownum<=? "
				+ "        ) "
				+ " where rnum>=? and rnum<=? ";  

		List<Board> list = new ArrayList<Board> ();
		int startrow = (page -1) * limit + 1 ; 
		int endrow = startrow  + limit -1 ;  

		try {

			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);
			pstmt.setInt(2, endrow);
			pstmt.setInt(3, startrow);
			pstmt.setInt(4, endrow);

			rs = pstmt.executeQuery();

			// DB에서 가져온 데이터를 VO 객체에 담습니다.
			while(rs.next()){

				Board board = new Board();
				board.setBoard_num(rs.getInt("BOARD_NUM"));
				board.setBoard_name(rs.getString("BOARD_NAME"));
				board.setBoard_pass(rs.getString("BOARD_PASS"));
				board.setBoard_subject(rs.getString("BOARD_SUBJECT"));
				board.setBoard_content(rs.getString("BOARD_CONTENT"));
				board.setBoard_file(rs.getString("BOARD_FILE"));
				board.setBoard_re_ref(rs.getInt("BOARD_RE_REF"));
				board.setBoard_re_lev(rs.getInt("BOARD_RE_LEV"));
				board.setBoard_re_seq(rs.getInt("BOARD_RE_SEQ"));
				board.setBoard_readcount(rs.getInt("BOARD_READCOUNT"));
				board.setBoard_date(rs.getString("BOARD_DATE").substring(2,10));
				board.setCnt(rs.getInt("cnt"));
				board.setBoard_like(rs.getInt("BOARD_LIKE"));
				board.setBoard_notice(rs.getString("BOARD_NOTICE"));

				list.add(board); // 값을 담은 객체를 리스트에 저장
			}

		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getBoardList() 에러 :" + ex);
		}finally {
			try {
				if(rs != null)
					rs.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}try {
				if(pstmt != null)
					pstmt.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}try {
				if(conn != null)
					conn.close();}
			catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return list;

	}


	// 댓글 갯수 구하기
	public int getCommentCount(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0; //글의 갯수
		try {
			conn = ds.getConnection();
			String sql = "select count(*) from com "
					+ "	where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if(rs.next()){
				x = rs.getInt(1);
			}
		}catch(Exception se) {
			se.printStackTrace();
			System.out.println("getCommentCount()에러 :" + se);
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
		return x;
	}//getListCount()


	/////////여기부터 수정해야됨
	// 댓글 리스트
	public List<Comment> getCommentList(int page, int limit, String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select * "
				+ " from  (select rownum rnum, j.* "
				+ "  		from (select com.*, BOARD_SUBJECT "
				+ "					from com inner join BOARDS "
				+ "					on comment_board_num = BOARD_NUM "
				+ "					where id = ? "
				+ "					order by comment_re_ref desc, "
				+ "							comment_re_seq asc) j "
				+ "				where rownum<= ? "
				+ "			) "
				+ " where rnum>= ? and rnum<= ? ";
		

		List<Comment> list = new ArrayList<Comment> ();
		int startrow = (page -1) * limit + 1 ; 
		int endrow = startrow  + limit -1 ;  

		try {

			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);
			pstmt.setInt(2, endrow);
			pstmt.setInt(3, startrow);
			pstmt.setInt(4, endrow);

			rs = pstmt.executeQuery();

			while(rs.next()){

				Comment comm = new Comment();
				comm.setNum(rs.getInt("num"));
				comm.setId(rs.getString("id"));
				comm.setContent(rs.getString("content"));
				
				
////				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
////	            Date date = format.parse(rs.getDate("date");
////				comm.setReg_date(rs.getDate("date"));
//				
////				Date date = new Date();
//		        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		        String str = format.format(rs.getDate("date"));
//		        comm.setReg_date(str);
				
				comm.setComment_board_num(rs.getInt("comment_board_num"));
				comm.setComment_re_lev (rs.getInt("comment_re_lev"));
				comm.setComment_re_seq(rs.getInt("comment_re_seq"));
				comm.setComment_re_ref(rs.getInt("comment_re_ref"));
				comm.setSubject(rs.getString("BOARD_SUBJECT"));

				list.add(comm); // 값을 담은 객체를 리스트에 저장
			}

		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getCommentList() 에러 :" + ex);
		}finally {
			try {
				if(rs != null)
					rs.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}try {
				if(pstmt != null)
					pstmt.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}try {
				if(conn != null)
					conn.close();}
			catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return list;

	}





}
