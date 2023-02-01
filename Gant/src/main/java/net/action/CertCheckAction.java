package net.action;

import java.io.IOException;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import net.db.MyEmail;

public class CertCheckAction implements Action{

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	
		String sender = "tosil0702@naver.com";
		String receiver = request.getParameter("emdo"); //받는 이메일 주소
		
		int num = (int) (Math.random() * 999999 + 1);
		String certnum = String.format("%06d", num);
		String subject = "인증번호 [" + certnum + "] 이메일 인증 메일입니다.";
		String content = "<h3>인증번호는 " + certnum + "입니다.</h3>";
		
		String server = "smtp.naver.com";
		int port = 587;
		JsonObject json = new JsonObject();
		String result = "";
		response.setContentType("application/json;charset=utf-8");
		try {
			Properties properties = new Properties();
			properties.put("mail.stmp.host", server);
			properties.put("mail.stmp.port", port);
			properties.put("mail.smtp.ssl.protocols", "TLSv1.2");
			
			Session s = Session.getInstance(properties);
			Address sender_address = new InternetAddress(sender);
			Address receiver_address = new InternetAddress(receiver);
			
			//메일 보내기 위한 정보 입력 객체 생성
			Message message = new MimeMessage(s);
			message.setHeader("content-type", "text/html;charset=utf-8");
			message.setFrom(sender_address);
			message.addRecipient(Message.RecipientType.TO, receiver_address);
			message.setSubject(subject);
			message.setContent(content,"text/html;charset=utf-8");
			
			//메일 전송 클래스
			Transport transport = s.getTransport("smtp");
			transport.connect(server, MyEmail.naverid, MyEmail.naverpass);
			transport.sendMessage(message, message.getAllRecipients());
			transport.close();
			
			json.addProperty("certnum", certnum);
			result = "인증번호를 발송했습니다.";
			json.addProperty("result", result);
		} catch (Exception e) {
			result = "인증번호 발송을 실패했습니다.";
			json.addProperty("message", result);
			e.printStackTrace();
		}finally {
			response.getWriter().print(json);
		}
		return null;
	}
}
