package calendar.db;

public class CalendarBean {

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAdmin() {
		return admin;
	}
	public void setAdmin(String admin) {
		this.admin = admin;
	}
	public String getAllday() {
		return "true";
	}
	public void setAllday(String allday) {
		this.allday = allday;
	}
	String id;
	String admin;
	String allday;


	String start;
	String end;
	String title;
	
}
