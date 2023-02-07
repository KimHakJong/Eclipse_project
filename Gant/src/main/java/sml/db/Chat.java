package sml.db;

public class Chat {
	private String id;
	private String name;
	private String contents;
	private String regdate;
	private String chatimg;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getRegdate() {
		return regdate.substring(11,16); //15:00 시간만 나오게
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getChatimg() {
		return chatimg;
	}
	public void setChatimg(String chatimg) {
		this.chatimg = chatimg;
	}
	
}
