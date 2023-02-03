package att.db;

public class Attendance{
	private String id;
	private String overtime;
	private String work_today;
	private String work_week;
	private String overtime_content;
	private String overtime_reason;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOvertime() {
		return overtime;
	}
	public void setOvertime(String overtime) {
		this.overtime = overtime;
	}
	public String getWork_today() {
		return work_today;
	}
	public void setWork_today(String work_today) {
		this.work_today = work_today;
	}
	public String getWork_week() {
		return work_week;
	}
	public void setWork_week(String work_week) {
		this.work_week = work_week;
	}
	public String getOvertime_content() {
		return overtime_content;
	}
	public void setOvertime_content(String overtime_content) {
		this.overtime_content = overtime_content;
	}
	public String getOvertime_reason() {
		return overtime_reason;
	}
	public void setOvertime_reason(String overtime_reason) {
		this.overtime_reason = overtime_reason;
	}
	

}