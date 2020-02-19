package com.webproject.essuyo.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.webproject.essuyo.domain.UserVO;

import com.webproject.essuyo.service.impl.UserServiceImpl;
import com.webproject.essuyo.utility.CommonUtil;

@Controller
public class LoginController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Inject
	private UserServiceImpl service;

	// 로그인 컨트롤. 로그인 페이지에 들어갈 때
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void loginGET(@ModelAttribute UserVO vo) {

	}
	
	// 로그인 페이지에서, form을 전송할 때.
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginPOST(@ModelAttribute UserVO userVO, HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		session = request.getSession();
		// 세션이 이미 login 값이 들어있다면 이 값을 지워준다.
		if (session.getAttribute("login") != null) {
			logger.info("clear login data before");
			session.removeAttribute("login");
		}

		// 서비스의 로그인 메소드를 실행해서 UserVO 객체에 넣는다.
		UserVO vo = service.login(userVO);

		// 그 vo 객체가 null 이라면 해당되는 이메일, 비밀번호가 없다는 뜻이니까 다시 로그인 페이지로.
		if (vo == null) {
			logger.info("login failed......");
			if (!model.containsAttribute("msg")) {
				model.addAttribute("msg", "이메일이나 비밀번호가 잘못됐습니다.");
			}
			return "/login";
		} else if (vo.getBusinessId() != 0) {
			// 만약 비즈니스 아이디가 -1(기본값)이 아닐 경우,
			// 세션에 companyLogin과 login, 두가지 어트리뷰트를 세트해 주고, 메인 페이지로 보낸다.
			logger.info("new company login success");
			session.setAttribute("companyLogin", vo.getBusinessId());
			session.setAttribute("login", vo.getEmail());
			session.setAttribute("name", vo.getName());
			session.setAttribute("juso", vo.getJuso());
			session.setAttribute("zeroPlusId", CommonUtil.plusZero(vo.getId()));
			String phone = CommonUtil.phoneFormat(vo.getPhoneNo());  //핸드폰 번호 포멧팅(000-0000-0000)
			session.setAttribute("phoneNo", phone);
			service.updateLastDate(vo);
			return "redirect:/";
		} else {
			// 비즈니스 아이디가 0일 경우 그냥 login 어트리뷰트만 세트해 준다.
			logger.info("new login success");
			session.setAttribute("login", vo.getEmail());
			session.setAttribute("name", vo.getName());
			session.setAttribute("juso", vo.getJuso());
			session.setAttribute("zeroPlusId", CommonUtil.plusZero(vo.getId()));
			String phone = CommonUtil.phoneFormat(vo.getPhoneNo());  //핸드폰 번호 포멧팅(000-0000-0000)
			session.setAttribute("phoneNo", phone);
			service.updateLastDate(vo);
			return "redirect:/";
		}
	}

	// 로그 아웃 기능
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			RedirectAttributes rttr) throws Exception {

		Object obj1 = session.getAttribute("login");
		Object obj2 = session.getAttribute("companyLogin");
		

			if (obj1 != null && obj2 != null) {
				session.removeAttribute("login");
				session.removeAttribute("companyLogin");
				session.invalidate();
				
				rttr.addFlashAttribute("errorMessageTitle", "로그아웃");
				rttr.addFlashAttribute("errorMessage", "로그아웃하셨습니다");
			} else if (obj1 != null) {

				session.removeAttribute("login");
				session.invalidate();

			rttr.addFlashAttribute("errorMessageTitle", "로그아웃");
			rttr.addFlashAttribute("errorMessage", "로그아웃하셨습니다");

		}

		return "redirect:/login";
	}

}