package board.db;

public class BoardLike {
	private String id; // 작성자 id
	private int    board_num; //글번호
	private String board_like_check; // 좋아요 클릭시 true 취소시 false
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getBoard_like_check() {
		return board_like_check;
	}
	public void setBoard_like_check(String board_like_check) {
		this.board_like_check = board_like_check;
	}
	
}
