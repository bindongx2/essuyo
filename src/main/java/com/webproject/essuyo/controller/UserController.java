package com.webproject.essuyo.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.webproject.essuyo.domain.BusinessVO;
import com.webproject.essuyo.domain.CompanyVO;
import com.webproject.essuyo.domain.UserVO;
import com.webproject.essuyo.service.BusinessService;
import com.webproject.essuyo.service.CompanyService;
import com.webproject.essuyo.service.FacilityAdminService;
import com.webproject.essuyo.service.ImageAdminService;
import com.webproject.essuyo.service.ReservationService;
import com.webproject.essuyo.service.impl.UserServiceImpl;
import com.webproject.essuyo.utility.CommonUtil;
import com.webproject.essuyo.utility.Encryption;
import com.webproject.essuyo.utility.Upload;

@Controller
@RequestMapping("/user/*")
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Inject
	private UserServiceImpl service;

	@Autowired
	private BusinessService businessService;

	@Autowired
	private ReservationService reservationService;

	@Autowired
	private CompanyService companyService;

	@Autowired
	private ImageAdminService imageAdminService;

	@Autowired
	private FacilityAdminService FAService;

	
	//2019-06-29(게시판 연습중) sidebar에 있는 게시판 연습중
	@RequestMapping(value = "/boardPratice", method = RequestMethod.GET)
	public String abc() throws Exception{
		return "user/boardPratice";
	}
	
	
	// 엑셀파일에 데이터 파인딩하여 가져오기(2019-06-13)
	@RequestMapping(value = "/print", method = RequestMethod.POST)
	public View print(UserVO vo, Model model) throws Exception {
		logger.info("print.......");
		UserVO userVO = service.print(vo);
		
		List<Object> listData = new ArrayList<Object>();
		Map<String, Object> oneData = new HashMap<String, Object>();
		Date date = new Date();

		
		oneData.put("name", userVO.getName());
		oneData.put("email", userVO.getEmail());
		oneData.put("age", userVO.getAge());
		oneData.put("gender", userVO.getGender());
		oneData.put("juso", userVO.getJuso());
		oneData.put("phoneNo", CommonUtil.phoneFormat(userVO.getPhoneNo()));  		
		oneData.put("creDate", CommonUtil.dateFormat(userVO.getCreDate(), "-"));				
		oneData.put("sysDate", CommonUtil.dateFormat(date, "-"));
//		listData.add(1);		
//		listData.add(2);		
//		listData.add(3);		
		model.addAttribute(listData);		
		model.addAttribute(oneData);		
		
		System.out.println("oneData : " + oneData.toString());
		System.out.println("listData : " + listData.toString());
		System.out.println("model : " + model.toString());
		
		return new Upload();
	}
	
		
	// GET 방식으로 회원가입 페이지에 접근. 그냥 회원가입 페이지로 보내준다
	@RequestMapping(value = "/regist", method = RequestMethod.GET)
	public void registGet(UserVO vo, Model modex) throws Exception {
		logger.info("registGet.......");
	}

	@GetMapping("/businessStart")
	public String startBusiness(RedirectAttributes redirectAttr, HttpSession httpSession, Model model)
			throws Exception {

		String email = (String) httpSession.getAttribute("login");

		int businessId = service.addBusiness(email);
		if (businessId != 0) {
			httpSession.setAttribute("companyLogin", businessId);
			redirectAttr.addFlashAttribute("errorMessageTitle", "SUCCESS !");
			redirectAttr.addFlashAttribute("errorMessage", "회사를 등록해 사업을 시작하세요!");
			return "redirect:/user/companyUpdate";
		}

		redirectAttr.addFlashAttribute("errorMessageTitle", "ERROR !");
		redirectAttr.addFlashAttribute("errorMessage", "사업을 시작 할 수 없습니다.");
		return "redirect:/user/companyUpdate";

	}

	// POST 방식으로 회원가입 페이지 접근
	@RequestMapping(value = "/regist", method = RequestMethod.POST)
	public String registPost(UserVO vo, HttpSession session, Model model, RedirectAttributes rttr) throws Exception {
		// RedirectAttributes는 Model기능을 그대로 확장한 상태에서 몇개의 메소드 추가 형태(데이터를 숨겨서 보내고 싶을때 사용)
		// RedirectAttributes는 redirect가 발생하기 전에 모든 플래시 속성을 세션에 저장한다.
		logger.info("registPost.......");
		try {
			service.regist(vo);
			// addFlashAttribute()는 redirect직전 플래시에 저장하는 메소드(redirect 이후에는 사라짐)
			// 별도의 작업을 하지 않고 EL표기법(${data})을 사용하여  표현 가능 
			rttr.addFlashAttribute("errorMessageTitle", "가입 성공");
			rttr.addFlashAttribute("errorMessage", "회원가입에 성공했습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("errorMessageTitle", "가입 실패");
			rttr.addFlashAttribute("errorMessage", "회원가입에 실패했습니다. 관리자에게 문의해 주세요.");
			return "redirect:/user/regist";
		}
		return "redirect:/login";
	}	

	// 컴퍼니 테이블을 수정하는 서비스의 컨트롤러(미완성)
	// 테스트 중. 컴퍼니 테이블 작성 페이지로 가는 컨트롤러
	@RequestMapping(value = "/companyUpdate", method = RequestMethod.GET)
	public void companyUpdateGET(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		logger.info("companyUpdateGET.....");
		String email = (String) request.getSession().getAttribute("login");
		UserVO vo = service.selectByEmail(email);
		if (vo.getBusinessId() != 0) {
			BusinessVO bvo = businessService.selectById(vo.getBusinessId());
			CompanyVO cvo = companyService.getCompanyVO(bvo.getCompanyId());
			// 모델 대신 세션에 세트
			// model.addAttribute("cvo", cvo);
			session.setAttribute("cvo", cvo);
			List<String> faList = FAService.selectById(cvo.getId());
			if (!faList.isEmpty()) {
				String facStr = "※ 현재 선택된 시설은";
				for (String fac : faList) {
					facStr += ", " + fac;
				}
				facStr += " 입니다.";
				model.addAttribute("facStr", facStr);
			} else {
				String facStr = "※ 현재 아무런 시설도 선택되지 않은 상태입니다.";
				model.addAttribute("facStr", facStr);
			}

		}
	}

	// form을 다 작성하고 보냈을 때.
	// 이미지 업로드
	@Transactional
	@RequestMapping(value = "/companyUpdate", method = RequestMethod.POST)
	public String companyUpdatePOST(@RequestParam("imgs") List<MultipartFile> files, CompanyVO cvo,
			HttpServletRequest request, RedirectAttributes rttr, HttpSession session,
			@RequestParam("facIds") ArrayList<String> facIds) throws Exception {
		logger.info("companyUpdatePOST......");
		String email = (String) request.getSession().getAttribute("login");
		UserVO vo = service.selectByEmail(email);
		// 반드시 아래 순서로 실행되어야 값이 제대로 들어간다
		try {
			service.companyUpdate(cvo);
			int cId = companyService.selectId();
			businessService.insertWithCId();
			service.bIdtoUser(vo);

			for (MultipartFile file : files) {
				String fileType = file.getContentType().toString();
				// 이미지 파일만 받도록 ,if문을 걸었음
				if (!fileType.equals("application/octet-stream")) {
					System.out.println(fileType);
					imageAdminService.uploadFile(file);
					companyService.companyImgInsert(cId);
				}

			}

			if (facIds.size() >= 2) {
				for (String facId : facIds) {
					if (!facId.equals("no")) {
						Map<String, Object> map = new HashMap<>();
						map.put("company_id", cId);
						map.put("facility_id", facId);
						FAService.insertToAdmin(map);
					}
				}
			}
			session.removeAttribute("cvo");
			rttr.addFlashAttribute("errorMessageTitle", "정보 입력 성공");
			rttr.addFlashAttribute("errorMessage", "성공적으로 정보가 입력됐습니다.");
			session.setAttribute("companyLogin", vo.getBusinessId());
			return "redirect:/user/companyUpdate";
		} catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("errorMessageTitle", "정보 입력 실패");
			rttr.addFlashAttribute("errorMessage", "정보 입력에 실패했습니다. 관리자에게 문의해 주세요.");
			return "redirect:/user/companyUpdate";
		}

	}

	// 컴퍼니 테이블을 수정(update)하는 컨트롤러
	@Transactional
	@RequestMapping(value = "/companyModify", method = RequestMethod.POST)
	public String companyModify(@RequestParam("imgs") List<MultipartFile> files, CompanyVO cvo,
			HttpServletRequest request, RedirectAttributes rttr, HttpSession session,
			@RequestParam("facIds") ArrayList<String> facIds) throws Exception {
		logger.info("companyModify......");
		// 처음 companyUpdate에 GET으로 접근할 때 세션으로 세팅한 cvo 객체
		CompanyVO cvo2 = (CompanyVO) request.getSession().getAttribute("cvo");
		cvo.setId(cvo2.getId());

		// 반드시 아래 순서로 실행되어야 값이 제대로 들어간다
		try {
			service.companyModify(cvo);
			int cId = cvo.getId();
			List<Integer> imgIds = service.getImgIds(cvo);
			if (!files.get(1).getContentType().toString().equals("application/octet-stream")) {
				for (Integer imgId : imgIds) {
					String SavePath = imageAdminService.getImagePath(imgId);
					imageAdminService.deleteFile(SavePath, imgId);
				}
			}
			for (MultipartFile file : files) {
				String fileType = file.getContentType().toString();
				// 이미지 파일만 받도록 ,if문을 걸었음
				if (!fileType.equals("application/octet-stream")) {
					System.out.println("파일 타입 : " + fileType);
					imageAdminService.uploadFile(file);
					companyService.companyImgInsert(cId);
				}

			}

			if (facIds.size() == 1) {
				FAService.deleteFacAdmin(cId);
			} else {
				FAService.deleteFacAdmin(cId);

				for (String facId : facIds) {
					if (!facId.equals("no")) {
						Map<String, Object> map = new HashMap<>();
						map.put("company_id", cId);
						map.put("facility_id", facId);
						FAService.insertToAdmin(map);
					}
				}
			}

			session.removeAttribute("cvo");
			rttr.addFlashAttribute("errorMessageTitle", "정보 수정 성공");
			rttr.addFlashAttribute("errorMessage", "성공적으로 정보가 수정됐습니다.");
			return "redirect:/user/companyUpdate";
		} catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("errorMessageTitle", "정보 수정 실패");
			rttr.addFlashAttribute("errorMessage", "정보 수정에 실패했습니다. 관리자에게 문의해 주세요.");
			return "redirect:/user/companyUpdate";
		}

	}

	@GetMapping("/profile")
	public String showProfilePage(HttpSession httpSession, Model model) {

		String email = (String) httpSession.getAttribute("login");

		Map<String, Object> userInfo = service.getUserInfo(email);
		model.addAttribute("user", userInfo);

		if (userInfo.get("business") != null) {
			BusinessVO business = (BusinessVO) userInfo.get("business");
			model.addAttribute("company", companyService.getSimpleCompanyInfo(business.getCompanyId()));
		}

		return "/user/profile";
	}

	@PostMapping("/profileUpdate")
	public String showProfilePage(UserVO newUserInfo, RedirectAttributes redirectAttr, HttpSession httpSession,
			MultipartFile file, Model model) {

		UserVO user = service.getUserVO((String) httpSession.getAttribute("login"));

		newUserInfo.setId(user.getId());

		if (newUserInfo.getPassword().equals("") == false) {
			newUserInfo.setPassword(Encryption.SHA512(newUserInfo.getPassword()));
		}

		newUserInfo.setImageInfoId(user.getImageInfoId());

		int update = service.setUserInfo(newUserInfo, file);

		if (update > 0) {
			redirectAttr.addFlashAttribute("errorMessageTitle", "SUCCESS !");
			redirectAttr.addFlashAttribute("errorMessage", "회원 정보가 성공적으로 수정되었습니다.");

		} else {
			redirectAttr.addFlashAttribute("errorMessageTitle", "ERROR !");
			redirectAttr.addFlashAttribute("errorMessage", "회원 정보 수정에 실패하였습니다.");
		}

		return "redirect:/user/profile";
	}

	@GetMapping("/dashboard")
	public String showDashboardPage(HttpSession httpSession, Model model) {

		String email = (String) httpSession.getAttribute("login");
		UserVO user = service.getUserVO(email);

		model.addAttribute("userType", "user");
		model.addAttribute("id", user.getId());
		setUserDashboard(email, "user", user.getId(), model);

		return "/user/dashboard";

	}
	//임시(하상재)
	@GetMapping("/dashboard2")
	public String showDashboardPage1(HttpSession httpSession, Model model) {
		
		String email = (String) httpSession.getAttribute("login");
		UserVO user = service.getUserVO(email);
		
		model.addAttribute("userType", "user");
		model.addAttribute("id", user.getId());
		setUserDashboard(email, "user", user.getId(), model);
		
		return "/user/dashboard2";
		
	}

	@GetMapping("/dashboardCompany")
	public String showCompanyDashboardPage(HttpSession httpSession, RedirectAttributes redirectAttr, Model model) {

		String email = (String) httpSession.getAttribute("login");
		int businessId = service.getBusinessInfo(email).getId();
		int companyId = service.getBusinessInfo(email).getCompanyId();

		if (companyId != 0 && businessId != 0) {
			model.addAttribute("userType", "company");
			model.addAttribute("id", companyId);
			setCompanyDashboard(email, "company", companyId, model);
			return "/user/dashboard";
		} else if (companyId == 0 && businessId == 0) {
			redirectAttr.addFlashAttribute("errorMessageTitle", "ERROR !");
			redirectAttr.addFlashAttribute("errorMessage", "정상적인 방법으로 시도해 주세요.");
			return "redirect:/";
		} else {
			redirectAttr.addFlashAttribute("errorMessageTitle", "IMFOMATION !");
			redirectAttr.addFlashAttribute("errorMessage", "회사를 등록 후 이용해주시길 바랍니다.");
			return "redirect:/user/companyRegist";
		}

	}
	
	//DashBoard에 사용되는 매개변수들(COMPANY)
	public void setCompanyDashboard(String email, String type, int id, Model model) {

		/*****************************************************************************/
		/********************************** 종합 그래프 *********************************/
		/*****************************************************************************/

		// < 1. 예약 관련 종합적인 데이터
		List<List<Integer>> comprehensiveGraph = reservationService.getMonthlyReservationCount(type, id);
		model.addAttribute("lineGraph", comprehensiveGraph);

		// < 3. 화면단 표시 문자열
		model.addAttribute("lineGraphName", "월별 상품 판매");

		/*****************************************************************************/
		/******************************* 사용자별 예약 횟수 ********************************/
		/*****************************************************************************/

		// < 1. 년 단위 사용자별 예약 횟수
		model.addAttribute("totalReservtionCount", reservationService.getReservationListNotState(type, id).size());

		// < 2. 남여 예약 분포도
		List<Integer> categoryReservationList = reservationService.getGenderReservationCount(id); // < 카테고리별 예약 횟수 리스트
		model.addAttribute("dounutChart", categoryReservationList);

		// < 3. 화면단 표시 문자열
		model.addAttribute("dounutChartName", "예약 성별 비율");

		/*****************************************************************************/
		/******************************* 사용자별 지출/수입 *******************************/
		/*****************************************************************************/

		// < 1. 년 단위 총 지출/수입 내용
		model.addAttribute("totalPayment", reservationService.getReservationTotalPrice(type, id));

		// < 2. 월 단위 총 지출/수입 내용
		List<Integer> MonthsPaymentList = reservationService.getMonthlyPrice(type, id); // < 월별 지불/수입 리스트
		model.addAttribute("MonthsPaymentList", MonthsPaymentList);

		// < 3. 화면단 표시 문자열
		model.addAttribute("sparkLineName", "수입");

	}
	
	
	//DashBoard에 사용되는 매개변수들(USER)
	public void setUserDashboard(String email, String type, int id, Model model) {

		/*****************************************************************************/
		/******************************* 사용자별 종합 그래프 ******************************/
		/*****************************************************************************/

		// < 1. 예약 관련 종합적인 데이터
		List<List<Integer>> comprehensiveGraph = reservationService.getComprehensiveReservation(type, id);
		model.addAttribute("lineGraph", comprehensiveGraph);

		// < 3. 화면단 표시 문자열
		model.addAttribute("lineGraphName", "카테고리별 예약 종합");

		/*****************************************************************************/
		/******************************* 사용자별 예약 횟수 ********************************/
		/*****************************************************************************/

		// < 1. 년 단위 사용자별 예약 횟수
		model.addAttribute("totalReservtionCount", reservationService.getReservationListNotState(type, id).size());

		// < 2. 카테고리별 예약 분포도
		List<Integer> categoryReservationList = reservationService.getCategoryReservationCount(type, id); // < 카테고리별 예약
																											// 횟수 리스트
		model.addAttribute("dounutChart", categoryReservationList);

		// < 3. 화면단 표시 문자열
		model.addAttribute("dounutChartName", "카테고리 별 예약횟수");

		/*****************************************************************************/
		/******************************* 사용자별 지출/수입 *******************************/
		/*****************************************************************************/

		// < 1. 년 단위 총 지출/수입 내용
		model.addAttribute("totalPayment", reservationService.getReservationTotalPrice(type, id));

		// < 2. 월 단위 총 지출/수입 내용
		List<Integer> MonthsPaymentList = reservationService.getMonthlyPrice(type, id); // < 월별 지불/수입 리스트
		model.addAttribute("MonthsPaymentList", MonthsPaymentList);

		// < 3. 화면단 표시 문자열
		model.addAttribute("sparkLineName", "지출");

	}

}