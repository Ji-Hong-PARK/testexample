package kr.ac.kopo.foodmall.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.ac.kopo.foodmall.model.Member;

public class AdminInterceptor extends HandlerInterceptorAdapter {
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		
		if(session != null) {
			Member user = (Member) session.getAttribute("member");
			
			if(user != null) {
				if("admin".equals(user.getMemberId())) {
					return true;
				}else {
					response.sendRedirect("/main");
					return false;
				}
			}
		}

		response.sendRedirect("/main");
		return false;
	}
}
