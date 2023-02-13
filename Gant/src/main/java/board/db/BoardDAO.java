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
					board.setBoard_pass(rs.getString("BOARD_PASS"));
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
					board.setBoard_pass(rs.getString("BOARD_PASS"));
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

		
		
		//제목  검색어가 포함된 게시글 수 
		public int getSearchListCount(String search_name) {
			 Connection conn = null;
			  PreparedStatement pstmt = null;
			  ResultSet rs = null;
			  int x = 0; //글의 갯수
				 try {
					conn = ds.getConnection();
					String sql = "select count(*) from boards where BOARD_SUBJECT LIKE ? ";
					// PreparedStatement 객체얻기
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1,"%"+search_name+"%");
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
				}//getSearchListCount()

		
		
		//검색어가 포함되어있는 리스트 갯수
		public List<Board> getSearchBoardList(int page, int limit, String search_name) {
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
				    + "              where BOARD_SUBJECT LIKE ? "
				    + "              order by BOARD_RE_REF desc,"
				    + "              BOARD_RE_SEQ asc) j "                                      
				    + "       where rownum<=? "
				    + "        ) "
				    + " where rnum>=? and rnum<=?";  
			
			  List<Board> list = new ArrayList<Board> ();
			  //한 페이지당 10개씩 목록인 경우 1페이지 2페이지 3페이지 4페이지 ....
			  int startrow = (page -1) * limit + 1 ; //읽기 시작할 row 번호 ( 1 11 21 31..
			  int endrow = startrow  + limit -1 ; //읽을 마지막 row 번호    ( 10 20 30 40..
			  
			  try {

				    conn = ds.getConnection();
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1,"%"+search_name+"%");
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

		} //getSearchBoardList
		
		
		//members 테이블에서 admin 권한을 가져온다.
		public String getadmindate(String id) {
			Connection conn = null;
			  PreparedStatement pstmt = null;
			  ResultSet rs = null;
			  String admin = "";
			 try {
				conn = ds.getConnection();
			    
				String sql = "select admin from members where id = ? ";
				
				// PreparedStatement 객체얻기
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1,id);
					rs = pstmt.executeQuery();
				
					
					
					if(rs.next()){ 
						admin = rs.getString("admin");
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
			return admin;
			}
		

		
		
		public boolean boardInsert(Board board) {
			 Connection conn = null;
			  PreparedStatement pstmt = null;
			 int result = 0;
			 try {
				    conn = ds.getConnection();
				    
			String max_sql = "(select nvl(max(board_num),0)+1 from boards)";
			
			//원문글의 BOARD_RE_REF필드는 자신을 글번호 입니다.
		    String sql = "insert into boards " 
				       + "(BOARD_NUM,     BOARD_NAME,   BOARD_PASS,  BOARD_SUBJECT,"
					   + " BOARD_CONTENT, BOARD_FILE,   BOARD_RE_REF," 
				       + " BOARD_RE_LEV,  BOARD_RE_SEQ, BOARD_READCOUNT ,"
				       + " BOARD_LIKE , BOARD_NOTICE ,fontColor ,fontSize, fontWeight ) " 
				       + "values("+max_sql+",?,?,?,"
				       + "       ?,?,"+max_sql+","
				       + "       ?,?,?,"
				       + "       ?,?,?,?,? )";
		    
		    
		    //새로운 글을 등록하는 부분
		    pstmt =conn.prepareStatement(sql);
			
			pstmt.setString(1,board.getBoard_name());
			pstmt.setString(2,board.getBoard_pass());
			pstmt.setString(3,board.getBoard_subject());
			pstmt.setString(4,board.getBoard_content());
			pstmt.setString(5,board.getBoard_file());
			
			// 원문글의 경우 BOARD_RE_LEV,  BOARD_RE_SEQ 필드 값은 0 이다.
			pstmt.setInt(6,0); // BOARD_RE_LEV
			pstmt.setInt(7,0); // BOARD_RE_SEQ
			pstmt.setInt(8,0);
			pstmt.setInt(9,0); // 좋아요 갯수는 0
			pstmt.setString(10,board.getBoard_notice()); // 공지글 체크
			pstmt.setString(11,board.getFontColor()); // 게시글색
			pstmt.setString(12,board.getFontSize()); // 게시글 사이즈
			pstmt.setInt(13,board.getFontWeight()); // 게시글 굵기
			result = pstmt.executeUpdate();
		
			if(result == 1) {
				System.out.println("데이터 삽입이 모두 완료되었습니다.");
				return true;
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println(" boardInsert() 에러 :" +ex );
			try {
				if (conn != null)
					conn.rollback();
			}catch(SQLException e1) {
				e1.printStackTrace();
			}
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
		return false;
	}

		
		// 조회수 증가
		public void setReadCountUpdate(int num) {
			 Connection conn = null;
			 PreparedStatement pstmt = null;
			 String sql = "update boards "
						 +   " set BOARD_READCOUNT = BOARD_READCOUNT+1 "
						 +   " where BOARD_NUM = ? ";
						  
			 try {
				    conn = ds.getConnection();
				    pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1,num);
				    pstmt.executeUpdate();
					}catch(Exception ex) {
						ex.printStackTrace();
						System.out.println("setReadCountUpdate() 에러 :" + ex);;
					}finally {
						try {
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
				}   // setReadCountUpdate end
        
		
		//글 내용 담기
		public Board getDetail(int num) {
			Board board = null; 
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
		    String sql = "select * "
				         + " from boards "
				         + " where BOARD_NUM = ? ";  

		   try {
				    conn = ds.getConnection();
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1,num);
					rs = pstmt.executeQuery();
					
					// DB에서 가져온 데이터를 VO 객체에 담습니다.
					if(rs.next()){
					board = new Board();
					board.setBoard_num(rs.getInt("BOARD_NUM"));
					board.setBoard_pass(rs.getString("BOARD_PASS"));
					board.setBoard_name(rs.getString("BOARD_NAME"));
					board.setBoard_subject(rs.getString("BOARD_SUBJECT"));
					board.setBoard_content(rs.getString("BOARD_CONTENT"));
					board.setBoard_file(rs.getString("BOARD_FILE"));
					board.setBoard_re_ref(rs.getInt("BOARD_RE_REF"));
					board.setBoard_re_lev(rs.getInt("BOARD_RE_LEV"));
					board.setBoard_re_seq(rs.getInt("BOARD_RE_SEQ"));
					board.setBoard_readcount(rs.getInt("BOARD_READCOUNT"));
					board.setBoard_date(rs.getString("BOARD_DATE"));
					board.setBoard_like(rs.getInt("BOARD_LIKE"));
					board.setBoard_notice(rs.getString("BOARD_NOTICE"));
					board.setFontColor(rs.getString("fontColor"));
					board.setFontSize(rs.getString("fontSize"));
					board.setFontWeight(rs.getInt("fontWeight"));
	
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
			return board;
		} //getDetail
       
		
		
		//member 테이블에서 프로필 사진을 가져온다.
		public String getMemberProfile(String id) {
			Connection conn = null;
			  PreparedStatement pstmt = null;
			  ResultSet rs = null;
			  String profileimg = "";
			 try {
				conn = ds.getConnection();
			    
				String sql = "select profileimg from members where id = ? ";
				
				// PreparedStatement 객체얻기
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1,id);
					rs = pstmt.executeQuery();
				
					
					
					if(rs.next()){ 
						profileimg = rs.getString("profileimg");
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
			return profileimg;
			}


			//게시글 삭제
			public boolean boardDelete(int num) {
				Connection conn = null;
				PreparedStatement pstmt = null,pstmt2 = null ;
				ResultSet rs = null;
				
				String select_sql = "select BOARD_RE_REF , BOARD_RE_LEV , BOARD_RE_SEQ "
						          + "  from boards "
						          + "  where BOARD_NUM=? ";
						         
				// 원문글의 경우 답변글포함 삭제 , 답변글의 경우 답변의 답변도 삭제한다.
				String board_delete_sql =  "delete from BOARDS "
						    +" where BOARD_RE_REF = ? " 
						    +" and BOARD_RE_LEV >= ? "
						    +" and BOARD_RE_SEQ >= ? "
						    +" and BOARD_RE_SEQ <=( nvl((select min(BOARD_RE_SEQ)-1 "
						    +"                     from BOARDS "
						    +"                    where BOARD_RE_REF = ? "
						    +"                     and BOARD_RE_LEV = ? "
						    +"                     and BOARD_RE_SEQ > ?) , "
						    +"                     (select max(BOARD_RE_SEQ) "
						    +"                      from BOARDS "
						    +"                     where BOARD_RE_REF = ?)) "
						    +"                    )";

				
				  boolean result_check = false;
				  
			  try {
					
				    conn = ds.getConnection();
					pstmt = conn.prepareStatement(select_sql);
					pstmt.setInt(1, num);
					rs = pstmt.executeQuery();
					if(rs.next()) {
				 pstmt2 = conn.prepareStatement(board_delete_sql);
				 pstmt2.setInt(1,rs.getInt("BOARD_RE_REF"));
				 pstmt2.setInt(2,rs.getInt("BOARD_RE_LEV"));
				 pstmt2.setInt(3,rs.getInt("BOARD_RE_SEQ"));
				 pstmt2.setInt(4,rs.getInt("BOARD_RE_REF"));
				 pstmt2.setInt(5,rs.getInt("BOARD_RE_LEV"));
				 pstmt2.setInt(6,rs.getInt("BOARD_RE_SEQ"));
				 pstmt2.setInt(7,rs.getInt("BOARD_RE_REF"));
					}
					
					int count = pstmt2.executeUpdate();
					
					if(count >= 1) {
						result_check = true; // 삭제가 안된경우 false를 반환
					}

					}catch(Exception ex) {
						ex.printStackTrace();
						System.out.println("boardDelete() 에러 :" + ex);;
					}finally {
						try {
							if(rs != null)
								rs.close();
						}catch(SQLException e1) {
							e1.printStackTrace();
						}try {
							if(pstmt != null)
								pstmt.close();
						}catch(SQLException e) {
							e.printStackTrace();
						}try {
							if(pstmt2 != null)
								pstmt2.close();
						}catch(SQLException e) {
							e.printStackTrace();
						}
						try {
							if(conn != null)
								conn.close();}
						catch(SQLException e) {
							e.printStackTrace();
						}
			}
				return result_check;
			}// boardDelete 
            
			
			
			//boardLike테이블이 있는지 확인 
			public int selectLike(String id , int board_num) {
				Connection conn = null;
				  PreparedStatement pstmt = null;
				  ResultSet rs = null;
				 int result =0; // id와 테이블번호에 해당 테이블이 없습니다.
				 try {
					conn = ds.getConnection();
				    
					String sql = "select * from boardLike where id = ? and board_num = "+board_num ;
					// PreparedStatement 객체얻기
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1,id);
						rs = pstmt.executeQuery();
					
						if(rs.next()){ //더이상 읽을 데이터가 없을 때 까지 반복
							result = 1; // id와 테이블번호에 해당 테이블이 있습니다.
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

			public void insertLike(String id, int board_num) {
				 Connection conn = null;
				  PreparedStatement pstmt = null;
				  int result = 0;
				 try {
					conn = ds.getConnection();
					
					String sql = "INSERT INTO boardLike (id,board_num,like_check) "
							+ " VALUES (?,"+board_num+",'false')"; // like_check == 'false' 추천버튼 비활성화
					// INSERT문 확인하기
					//System.out.println(sql);
				
					// PreparedStatement 객체 얻기
							pstmt = conn.prepareStatement(sql);
							
							pstmt.setString(1,id);							
							result = pstmt.executeUpdate(); // 삽입성공시 result는 1
							
							// 결과 확인하기
							System.out.println(result  + "행이 추가되었습니다.(boardLike)");
									
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

				}// insert end  
            
			
			
			//id와 테이블번호에 해당하는 like_check 값을 가져온다.
			public String selectLikeCheck(String id, int board_num) {
				Connection conn = null;
				  PreparedStatement pstmt = null;
				  ResultSet rs = null;
				 String like_check = ""; 
				 try {
					conn = ds.getConnection();
				    
					String sql = "select like_check from boardLike where id = ? and board_num = "+board_num ;
					// PreparedStatement 객체얻기
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1,id);
						rs = pstmt.executeQuery();
					
						if(rs.next()){ //더이상 읽을 데이터가 없을 때 까지 반복
							like_check = rs.getString(1);
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
				return like_check;
				}//selectLikeCheck end

			
			
			//like체크 update
			public int updateLike(String id, int board_num, String like_check) {
				 Connection conn = null;
				 PreparedStatement pstmt = null;
				 int result = 0;
				 String sql = " update boardLike "
				 		    + " set  like_check = ? "
				 		    + " where id = ? and board_num = "+board_num;
				 
				   
				 
				 try {
				    conn = ds.getConnection();
				    
				    pstmt =conn.prepareStatement(sql);
					
			
				   
					pstmt.setString(1,like_check);
					pstmt.setString(2,id);
					
					result = pstmt.executeUpdate();
					
					if(result == 1) {
	                System.out.println("like체크 update");
					}
				}catch(Exception ex) {
					ex.printStackTrace();
					System.out.println(" updateLike() 에러 :" +ex );
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
			}//updateLike

			
			//boards의 좋아요 갯수 증가 혹은 감소
			public void BoardupdateLike(int board_num, int add) {
				 Connection conn = null;
				 PreparedStatement pstmt = null;
				 int result = 0;
				 String sql = " update boards "
				 		    + " set  BOARD_LIKE = BOARD_LIKE +"+add
				 		    + " where board_num = "+board_num;
				 

				 try {
				    conn = ds.getConnection();
				    
				    pstmt =conn.prepareStatement(sql);
					
					result = pstmt.executeUpdate();
					
					if(result == 1) {
	                System.out.println("BoardupdateLike update");
					}
				}catch(Exception ex) {
					ex.printStackTrace();
					System.out.println(" updateLike() 에러 :" +ex );
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
				
			}//BoardupdateLike

			
			
			
			
			public int boardReply(Board board) {
				Connection conn = null;
				PreparedStatement pstmt = null;
			    ResultSet rs = null;
			    int num = 0; // 답글의 board_num
			    
			    //board 테이블의 글번호를 구하기 위해 board_num 컬럼의 최대값+1을 구해온다.
			    String board_max_sql = "select max(board_num)+1 from boards";
			    
			    //답변을 달 원문글 그룹 번호
			    int re_ref = board.getBoard_re_ref();
			    
			    // 답변의 깊이   원문: 0 , 원문답글 : 1 , 답글의 답글 : 2
			    int re_lev = board.getBoard_re_lev();
			    
			    // 같은 관련글 중에서 해당 들이 출력되는 순서
			    int re_seq = board.getBoard_re_seq();
			    
			    
			    try {
				    conn = ds.getConnection();
				    
				    //트랜잭션을 이용하기 위해 setAutoCommit을 false로 설정
				    conn.setAutoCommit(false); // 트렌직션 설정
				    
				  //----------1번작업시작 --------------
				    
				    pstmt =conn.prepareStatement(board_max_sql);
				    rs=pstmt.executeQuery();
				    if(rs.next()) {
				    	num=rs.getInt(1);
				    }
				    pstmt.close();
				    
				  //----------1번작업종료 --------------
				    
				    //BOARD_RE_REF , BOARD_RE_SEQ 값을 확인하여 원문글에 답글이 달려있다면
				    // 달린답글의  BOARD_RE_SEQ값을 1씩 증가시킵니다.
				    // 현재 글을 이미 달린 답글보다 앞에 출력하게 하기 위해서 입니다.

					//----------2번작업시작 --------------
				    
					String sql = " update boards " 
						     + "set    BOARD_RE_SEQ = BOARD_RE_SEQ + 1 " 
							 + "where  BOARD_RE_REF = ? "
						  	 + "and    BOARD_RE_SEQ > ?";
					
					pstmt =conn.prepareStatement(sql);
					pstmt.setInt(1,re_ref);
					pstmt.setInt(2,re_seq);
					pstmt.executeUpdate();
					pstmt.close();
				//----------2번작업종료 --------------
					
					
				//----------3번작업시작 --------------
				// 등록할 답변글의 BOARD_RE_LEV , BOARD_RE_SEQ 값을 원문글보다 1씩 증가시킵니다.
					
					re_seq = re_seq + 1 ; // 원문글보다 1증가
					re_lev = re_lev + 1 ; //답변:1 ,답변의 답변:2 즉 , 1 증가
					
							
					    sql = "insert into boards " 
						       + "(BOARD_NUM,     BOARD_NAME,   BOARD_PASS,  BOARD_SUBJECT,"
							   + " BOARD_CONTENT, BOARD_FILE,   BOARD_RE_REF," 
						       + " BOARD_RE_LEV,  BOARD_RE_SEQ, BOARD_READCOUNT ,"
						       + " BOARD_LIKE , BOARD_NOTICE ,fontColor ,fontSize, fontWeight ) " 
						       + "values("+num+",?,?,?,"
						       + "       ?,?,?,"
						       + "       ?,?,?,"
						       + "       ?,?,?,?,? )";
					
					
					
					pstmt =conn.prepareStatement(sql);
					
					pstmt.setString(1,board.getBoard_name());
					pstmt.setString(2,board.getBoard_pass());
					pstmt.setString(3,board.getBoard_subject());
					pstmt.setString(4,board.getBoard_content());
					pstmt.setString(5,"");//답변에는 파일을 업로드 하지 않습니다.
					pstmt.setInt(6, re_ref); // 원문 글번호
					pstmt.setInt(7,re_lev); 
					pstmt.setInt(8,re_seq); 
					pstmt.setInt(9,0); //BOARD_READCOUNT 조회수는 0
					pstmt.setInt(10,0); // 좋아요 갯수는 0
					pstmt.setString(11,"false"); // 답글은공지글로 할 수 없다.
					pstmt.setString(12,board.getFontColor()); // 게시글색
					pstmt.setString(13,board.getFontSize()); // 게시글 사이즈
					pstmt.setInt(14,board.getFontWeight()); // 게시글 굵기
					
					if(pstmt.executeUpdate() == 1) {
						conn.commit(); // commit합니다.
					}else {
						conn.rollback();
					}
				
					//----------3번작업종료 --------------
					
					
				}catch(Exception ex) {
					ex.printStackTrace();
					System.out.println(" boardReply() 에러 :" +ex );
					try {
						if (conn != null)
							conn.rollback(); //rollback 합니다.
					}catch(SQLException e1) {
						e1.printStackTrace();
					}
				}finally {
					try {
						if(rs != null)
							rs.close();
					}catch(SQLException e1) {
						e1.printStackTrace();
					}
					try {
						if(pstmt != null)
							pstmt.close();
					}catch(SQLException e1) {
						e1.printStackTrace();
					}
					try {
						if (conn != null) {
							conn.setAutoCommit(true);
							conn.close();
						}
					}catch(SQLException e1) {
						e1.printStackTrace();
						}
			}
				return num;
			} //boardReply
           
			
			
			//게시물 수정
			public boolean boardUpdate(Board board) {
				 Connection conn = null;
				  PreparedStatement pstmt = null;
				 int result = 0;
				 try {
					    conn = ds.getConnection();
					    
				String max_sql = "(select nvl(max(board_num),0)+1 from boards)";
				
				//원문글의 BOARD_RE_REF필드는 자신을 글번호 입니다.
			    String sql = " update boards " 
					       + "set BOARD_PASS=? , BOARD_SUBJECT=? , "
						   + " BOARD_CONTENT=?, BOARD_FILE=?, "
					       + " BOARD_NOTICE=? ,fontColor=? , fontSize=? , fontWeight=?  " 
					       + " where board_num=? ";
			    
			    
			    //새로운 글을 등록하는 부분
			    pstmt =conn.prepareStatement(sql);
				pstmt.setString(1,board.getBoard_pass());
				pstmt.setString(2,board.getBoard_subject());
				pstmt.setString(3,board.getBoard_content());
				pstmt.setString(4,board.getBoard_file());
				pstmt.setString(5,board.getBoard_notice()); // 공지글 체크
				pstmt.setString(6,board.getFontColor()); // 게시글색
				pstmt.setString(7,board.getFontSize()); // 게시글 사이즈
				pstmt.setInt(8,board.getFontWeight()); // 게시글 굵기
				pstmt.setInt(9,board.getBoard_num());
				result = pstmt.executeUpdate();
			
				if(result == 1) {
					System.out.println("데이터 수정이 완료되었습니다.");
					return true;
				}
			}catch(Exception ex) {
				ex.printStackTrace();
				System.out.println(" boardUpdate() 에러 :" +ex );
				try {
					if (conn != null)
						conn.rollback();
				}catch(SQLException e1) {
					e1.printStackTrace();
				}
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
			return false;
		}//boardUpdate






}
