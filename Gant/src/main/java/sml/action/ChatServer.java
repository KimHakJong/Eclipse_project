package sml.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServlet;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/ChatServer")
public class ChatServer extends HttpServlet {
	
	private static final List<Session> sessionList=new ArrayList<Session>();
	private static final long serialVersionUID = 1L;
       
	@OnMessage
	public void onMessage(String message, Session session){
		System.out.println("receive:"+message);
		try {
			synchronized (sessionList) {
				for(Session s : sessionList) {
					if(!s.equals(session)) {
						s.getBasicRemote().sendText(message);
					}
				}
			}
	    }catch (Exception e) {
	        System.out.println(e.getMessage());
	    }
	}

	//@OnOpen은 클라이언트 ㅡ> 서버로 접속할 때의 처리입니다.
	@OnOpen
	public void onOpen(Session session) { // Add session to the connected
		// 콘솔에 접속 로그를 출력한다.
		System.out.println("새로운 클라이언트:"+session.getId());
		try {
	    	//자신과 연결된 session을 통해 문자열을 보냅니다.(즉, 자기 자신에게만 메시지 전달됩니다.)
	        session.getBasicRemote().sendText("연결되었습니다");
	    }catch (Exception e) {
	        System.out.println(e.getMessage());
	    }
	    sessionList.add(session);
	}

	//@OnClose는 접속이 끊겼을때 처리입니다.
	@OnClose
	public void onClose(Session session) {
		System.out.println("클라이언트 연결이 끊김"+session.getId());
	}
	
	 @OnError
	public void handleError(Throwable t) {
		 // 콘솔에 에러를 표시한다.
		 t.printStackTrace();
	}
}
