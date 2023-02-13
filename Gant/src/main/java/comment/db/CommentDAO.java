package comment.db;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;



public class CommentDAO {
private DataSource ds;
	
	//생성자에서 JNDI 리소스를 참조하여 Connection 객체를 얻어옵니다.
	public CommentDAO() {
		try {
			 // conttext.xml에서 설정한 리소스 jdbc/Oracle을 참조하여 Connection 객체를 얻어온다.
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		}catch (Exception ex) {
			System.out.println("DB 연결 실패 :" + ex);
			return;
		}
		
	}

	//comment_board_num에 해당하는  댓글 갯수 구하기
	public int getListCount(int comment_board_num) {
		  Connection conn = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  int x = 0; //글의 갯수
		  String sql = "select count(*) "
				   + " from com "
				   + " where comment_board_num = ?  ";
			 try {
				conn = ds.getConnection();
				// PreparedStatement 객체얻기
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1,comment_board_num);
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

	
	public JsonArray getCommentList(int comment_board_num, int state) {
		  Connection conn = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  String sort ="asc"; //등록순
		  if(state == 2) {
			  sort="desc"; // 최신순
		  }
		 			 	  
		  String sql = "select num , com.id , content , reg_date , comment_re_lev, "
		  		+"              comment_re_seq , "
		  		+"              comment_re_ref , members.profileimg "
		  		+ "      from com join members "
		  		+ "      on com.id=members.id "
		  		+ "      where comment_board_num = ? "
		  		+ "      order by comment_re_ref "+ sort +", "
		  	    + "           comment_re_seq asc";
			      
		
		  JsonArray arry = new JsonArray();
		  try {

			    conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1,comment_board_num);		
				rs = pstmt.executeQuery();
					
				// DB에서 가져온 데이터를 VO 객체에 담습니다.
				while(rs.next()){
                 JsonObject object = new JsonObject();
                 object.addProperty("num",rs.getInt(1));
                 object.addProperty("id",rs.getString(2));
                 object.addProperty("content",rs.getString(3));
                 object.addProperty("reg_date",rs.getString(4));
                 object.addProperty("comment_re_lev",rs.getInt(5));
                 object.addProperty("comment_re_seq",rs.getInt(6));
                 object.addProperty("comment_re_ref",rs.getInt(7));
                 object.addProperty("profileimg",rs.getString(8));
                 arry.add(object);
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
		return arry;

	} //getBoardList
       
	
	
	//댓글 삭제
	public int commentsDelete(int num) {
		 Connection conn = null;
		 PreparedStatement pstmt = null;
		 int result = 0;
		 String sql = "delete com where num=? ";			 
				
		 try {
			    conn = ds.getConnection();
			    pstmt = conn.prepareStatement(sql);			   
			    pstmt.setInt(1,num);
			    result = pstmt.executeUpdate();
			    
			    if(result == 1) {
			    	System.out.println("데이터가 삭제 되었습니다.");
			    }
			    
				}catch(Exception ex) {
					ex.printStackTrace();
					System.out.println("commentsDelete() 에러 :" + ex);;
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
		 return result;
			}   //commentsDelete end
    
	
	
	// 댓글 내용 insert
	public int commentInsert(Comment co) {
		 Connection conn = null;
		  PreparedStatement pstmt = null;
		  int result = 0;
		 try {
			conn = ds.getConnection();

			
			String sql = "INSERT INTO com  "
					+ " VALUES (comm_seq.nextval,?,?,sysdate,?,?,?,comm_seq.nextval)";
	
			// INSERT문 확인하기
			//System.out.println(sql);
		
			// PreparedStatement 객체 얻기
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1,co.getId());
					pstmt.setString(2,co.getContent());
					pstmt.setInt(3,co.getComment_board_num());
					pstmt.setInt(4,co.getComment_re_lev());
					pstmt.setInt(5,co.getComment_re_seq());
					result = pstmt.executeUpdate(); // 삽입성공시 result는 1
					if(result == 1) {
						System.out.println("데이터 삽입이완료되었습니다.");
					}
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

		return result;
		}// insert end
     
	
	
	//댓글 수정
	public int commentsUpdate(Comment co) {
		 Connection conn = null;
		 PreparedStatement pstmt = null;
		 int result = 0;
		 String sql = "update com set content=? where num=? ";			 
				
		 try {
			    conn = ds.getConnection();
			    pstmt = conn.prepareStatement(sql);
			    pstmt.setString(1, co.getContent());
			    pstmt.setInt(2,co.getNum());
			    result = pstmt.executeUpdate();
			    
			    if(result == 1) {
			    	System.out.println("데이터가 수정되었습니다.");
			    }
			    
				}catch(Exception ex) {
					ex.printStackTrace();
					System.out.println("commentsUpdate() 에러 :" + ex);;
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
		 return result;
			}   //commentsUpdate end

	
	
	//답글입력 내용을 가져와 insert
		public int commentsReply(Comment co) {
			 Connection conn = null;
			 PreparedStatement pstmt = null;
			 int result = 0;
			 
			 try {
		            conn = ds.getConnection();
		            conn.setAutoCommit(false);
		            String update_sql = "update com "
		            +"                   set   comment_re_seq=comment_re_seq +1 " 
		            +"                   where comment_re_ref= ? "
		            +"                   and   comment_re_seq> ? ";
				    pstmt = conn.prepareStatement(update_sql.toString());			   
				    pstmt.setInt(1,co.getComment_re_ref());
				    pstmt.setInt(2,co.getComment_re_seq());
				    pstmt.executeUpdate();
				    pstmt.close();
				    
				    String sql = "insert into com "
				    		   + " values(comm_seq.nextval, ?, ?, sysdate, ?,?,?,?)";
				    
				    pstmt = conn.prepareStatement(sql);
				    pstmt.setString(1,co.getId());
				    pstmt.setString(2,co.getContent());
				    pstmt.setInt(3,co.getComment_board_num());
				    pstmt.setInt(4,co.getComment_re_lev()+1);
				    pstmt.setInt(5,co.getComment_re_seq()+1);
				    pstmt.setInt(6,co.getComment_re_ref());
				    result = pstmt.executeUpdate();
				    if(result == 1) {
				    	System.out.println("댓글의 댓글이 삽입 되었습니다.");
				    	conn.commit();
				    }
				    
					}catch(Exception ex) {
						ex.printStackTrace();
						System.out.println("commentsReply() 에러 :" + ex);;
						try {
							conn.rollback();
						}catch(SQLException e) {
							e.printStackTrace();
						}	
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
			 return result;
				}   //commentsReply
		

	
	
	

	

} // class end
