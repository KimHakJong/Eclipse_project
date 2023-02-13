package comment.action;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//특정 비즈니스 요처으로 수행하고 결과값을 ActionForward 타입으로 변환하는
//메서드가 정의되어있다.
    public interface Action{
     public ActionForward execute(HttpServletRequest request,
    		                      HttpServletResponse response) throws ServletException, IOException ;
    
    }

