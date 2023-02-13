package board.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardFileDownAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		 String fileName = request.getParameter("filename");
		 System.out.println("filename =" + fileName );

		 String savePath = "boardsupload" ;
		 
		  //서블릿의 실행 환경 정보를 담고 있는객체를 리턴
		  ServletContext context = request.getServletContext();
		  // 실제 파일이 업로드 되어있는 경로 지정
		  String sDownloadPath = context.getRealPath(savePath);
		 
		 
		 // "\" 추가하기 위해 "\\" 사용
		  String sFilePath = sDownloadPath + "\\" + fileName;
		  System.out.println(sFilePath);
		  
		  byte b[] =new byte[4096];
		  
		  //sFilePath에있는 파일의 MimeType을 구해옵니다.
		  String sMimeType = context.getMimeType(sFilePath);
		  System.out.println("sMimeType>>" + sMimeType);
		  
		  
		  if(sMimeType == null)
			  sMimeType = "application/octet-stream";
		  
		  response.setContentType(sMimeType);
		  
		  
		  // 한글파일명이 깨지는것을 방지
		  //getBytes() - 지정된 캐릭터 셋의바이트 배열로 변환하는 메서드
		  //String(바이트배열,캐릭터셋) 생성자 : 해당 바이트 배열을 주어지 캐릭터 셋으로 간주하여 스트링을 만드는 생성자
		  String sEncoding = new String(fileName.getBytes("utf-8"),"ISO-8859-1");
		  System.out.println(sEncoding);
		  
		  //Content-Disposition : attachment : 브라우저는해당 Content를 처리하지 않고 다운로드 하게 됨
		  
		  response.setHeader("Content-Disposition","attachment; filename=" + sEncoding);
		  
		  // try - with = resource 문으로 try()괄호안에 선언되 자원은 try문이 
		  // 끝날때 자동으로 close()메서드를 호출 
		  //BufferedOutputStream -> 속도향상으로 씀
		  try(
		  // 웹브라우저로의 출력 스트릠 생성
			BufferedOutputStream out2 = new BufferedOutputStream(response.getOutputStream());
		    // sFilePath로 지정한 파일에 대한 입력스트림을 생성
		    BufferedInputStream in = new BufferedInputStream(new FileInputStream(sFilePath)); 
				  )
		  {
			  int numRead;
			  //read(b,0,b.length):바이트 배열 b의 0번부터 b.length크기만큼 읽어온다. 
			  while((numRead = in.read(b,0,b.length)) != -1) { //읽을 데이터가 존재하는 경우
				  out2.write(b,0,numRead); //바이트 배열 b의 0번부터 numRead크기 만큼 브라우저로 출력
			  }
		  } catch(Exception e) {
			  e.printStackTrace();//6212727866922627  16055250
		  }
		  return null;
		}
			}
