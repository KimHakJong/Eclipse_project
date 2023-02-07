package board.action;

// ActionForward 클래스는 Action 인터페이스에서 명령을 수행하고 결과 값을 가지고 이동할 때 사용하는 클래스
public class ActionForward {
	private boolean redirect = false;
	private String path = null;
	
	public ActionForward() {
		
	}
    
	// redirect 의 is 메소드 // 프로퍼티 타입이 boolean일 경우 get 대신 is을 붙일 수 있다
	public boolean isRedirect() {
		return redirect;
	}

	public void setRedirect(boolean redirect) {
		this.redirect = redirect;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}
	
	
}

