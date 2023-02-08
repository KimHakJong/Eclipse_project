package board.db;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;




		public class BoardDAO {
		private DataSource ds;
			
			//생성자에서 JNDI 리소스를 참조하여 Connection 객체를 얻어옵니다.
			public BoardDAO() {
				try {
					 // conttext.xml에서 설정한 리소스 jdbc/Oracle을 참조하여 Connection 객체를 얻어온다.
					Context init = new InitialContext();
					ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
				}catch (Exception ex) {
					System.out.println("DB 연결 실패 :" + ex);
					return;
				}
				
			}

	     // 글 갯수 구하기
		public int getListCount() {
			  Connection conn = null;
			  PreparedStatement pstmt = null;
			  ResultSet rs = null;
			  int x = 0; //글의 갯수
				 try {
					conn = ds.getConnection();
					String sql = "select count(*) from boards";
					// PreparedStatement 객체얻기
						pstmt = conn.prepareStatement(sql);
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
		public List<Board> getBoardList(int page, int limit) {
			  Connection conn = null;
			  PreparedStatement pstmt = null;
			  ResultSet rs = null;
		 // page : 페이지
	     // limit : 페이지당 목록의 수
		 // 	  
			  String sql = "select * "
				    + " from  (select rownum rnum, j.* "
				    + "        from (select boards.* , nvl(cnt,0) as cnt "
				    + "              from boards left outer join (select comment_board_num ,count(*) as CNT"
				    + "                                         from com"
				    + "                                         group by comment_board_num)"
				    + "              on BOARD_NUM = comment_board_num "
				    + "              order by BOARD_RE_REF desc,"
				    + "              BOARD_RE_SEQ asc) j "                                      
				    + "       where rownum<=? "
				    + "        ) "
				    + " where rnum>=? and rnum<=? and BOARD_NOTICE='false' ";  
			
			  List<Board> list = new ArrayList<Board> ();
			  //한 페이지당 10개씩 목록인 경우 1페이지 2페이지 3페이지 4페이지 ....
			  int startrow = (page -1) * limit + 1 ; //읽기 시작할 row 번호 ( 1 11 21 31..
			  int endrow = startrow  + limit -1 ; //읽을 마지막 row 번호    ( 10 20 30 40..
			  
			  try {

				    conn = ds.getConnection();
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setInt(1, endrow);
					pstmt.setInt(2, startrow);
					pstmt.setInt(3, endrow);
					
					rs = pstmt.executeQuery();
					
					// DB에서 가져온 데이터를 VO 객체에 담습니다.
					while(rs.next()){

					Board board = new Board();
					board.setBoard_num(rs.getInt("BOARD_NUM"));
					board.setBoard_name(rs.getString("BOARD_NAME"));
					board.setBoard_subject(rs.getString("BOARD_SUBJECT"));
					board.setBoard_content(rs.getString("BOARD_CONTENT"));
					board.setBoard_file(rs.getString("BOARD_FILE"));
					board.setBoard_re_ref(rs.getInt("BOARD_RE_REF"));
					board.setBoard_re_lev(rs.getInt("BOARD_RE_LEV"));
					board.setBoard_re_seq(rs.getInt("BOARD_RE_SEQ"));
					board.setBoard_readcount(rs.getInt("BOARD_READCOUNT"));
					board.setBoard_date(rs.getString("BOARD_DATE"));
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

		} //getBoardList
		
		
		//공지사항 게시글 리스트
		public List<Board> getBoardNoticeList() {
			  Connection conn = null;
			  PreparedStatement pstmt = null;
			  ResultSet rs = null;
		 // page : 페이지
	     // limit : 페이지당 목록의 수
		 // 	  
			  String sql = "select * "
				    + " from  (select rownum rnum, j.* "
				    + "        from (select boards.* , nvl(cnt,0) as cnt "
				    + "              from boards left outer join (select comment_board_num ,count(*) as CNT"
				    + "                                         from com"
				    + "                                         group by comment_board_num)"
				    + "              on BOARD_NUM = comment_board_num "
				    + "              order by BOARD_RE_REF desc,"
				    + "              BOARD_RE_SEQ asc) j ) "                                      
				    + " where BOARD_NOTICE='true' ";  
			
			  List<Board> list = new ArrayList<Board> ();
			 
			  
			  try {

				    conn = ds.getConnection();
					pstmt = conn.prepareStatement(sql);
					
					
					
					rs = pstmt.executeQuery();
					
					// DB에서 가져온 데이터를 VO 객체에 담습니다.
					while(rs.next()){

					Board board = new Board();
					board.setBoard_num(rs.getInt("BOARD_NUM"));
					board.setBoard_name(rs.getString("BOARD_NAME"));
					board.setBoard_subject(rs.getString("BOARD_SUBJECT"));
					board.setBoard_content(rs.getString("BOARD_CONTENT"));
					board.setBoard_file(rs.getString("BOARD_FILE"));
					board.setBoard_re_ref(rs.getInt("BOARD_RE_REF"));
					board.setBoard_re_lev(rs.getInt("BOARD_RE_LEV"));
					board.setBoard_re_seq(rs.getInt("BOARD_RE_SEQ"));
					board.setBoard_readcount(rs.getInt("BOARD_READCOUNT"));
					board.setBoard_date(rs.getString("BOARD_DATE"));
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

		} //getBoardNoticeList



}
