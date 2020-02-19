package com.webproject.essuyo.interceptor;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.webproject.essuyo.domain.UserVO;
import com.webproject.essuyo.service.impl.UserServiceImpl;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);

	@Inject
	private UserServiceImpl service;

	//로그인 화면으로 이동하기 전에 들어가려 했던 페이지 정보를 저장하는 메소드
	private void saveDest(HttpServletRequest req) {
		String uri = req.getRequestURI();
		String query = req.getQueryString();

		if (query == null || query.equals("null")) {
			query = "";
		} else {
			query = "?" + query;
		}

		if (req.getMethod().equals("GET")) {
			logger.info("dest: " + (uri + query));
			req.getSession().setAttribute("dest", uri + query);
		}

	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//여기서 원래 접근하려 했던 페이지의 정보를 세션에 저장
		HttpSession session = request.getSession();

		if (session.getAttribute("login") == null) {
			logger.info("current user is not logined");

			//saveDest 객체로 경로를 저장해 둔다.
			saveDest(request);

			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");

			//쿠키를 확인. null이 아니라면, userVO에 로그인 정보를 넣어준다
			if (loginCookie != null) {
				UserVO userVO = service.checkLoginBefore(loginCookie.getValue());

				logger.info("USERVO: " + userVO);
//userVO가 null이 아니라면, 세션에 로그인 어트리뷰트를 세팅해 준다.
				if (userVO != null) {
					session.setAttribute("login", userVO);
					return true;
				}
			}
//만약 로그인하지 않았고, 쿠키도 없다면, 로그인 화면으로 리다이렉트 시킨다. 
			RequestDispatcher rd = request.getRequestDispatcher("/login");
			request.setAttribute("errorMessageTitle", "INFOMATION !");
			request.setAttribute("errorMessage", "로그인이 필요한 서비스입니다.");
			rd.forward(request, response);

			
			return false;
		}

		return true;
	}

}
