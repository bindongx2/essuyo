package com.webproject.essuyo.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.webproject.essuyo.domain.BusinessVO;
import com.webproject.essuyo.domain.ProductVO;
import com.webproject.essuyo.domain.ReservationVO;
import com.webproject.essuyo.service.CompanyService;
import com.webproject.essuyo.service.ProductService;
import com.webproject.essuyo.service.ReservationService;
import com.webproject.essuyo.service.UserService;

@Controller
@RequestMapping("/product")
public class ProductController {

	@Autowired
	private ProductService productService;

	@Autowired
	private ReservationService reservationService;

	@Autowired
	private CompanyService companyService;
	
	@Autowired
	private UserService userService;

	
	private BusinessVO getCheckBusinessVO(HttpSession httpSession) {
		int BusinessId = (Integer) httpSession.getAttribute("companyLogin");
		if( BusinessId != 0 ) {
			return userService.getBusinessInfo(BusinessId);
			
		}else {
			String email = (String) httpSession.getAttribute("login");
			return userService.getBusinessInfo(email);
		}
	}
	@GetMapping("/reservation")
	public String showReservationPage(@RequestParam("company") int companyId, @RequestParam("product") int productId,
			Model model) throws Exception {

		Map<String, Object> result = productService.getProduct(productId);

		if (result != null) {
			model.addAttribute("product", result);
			model.addAttribute("company", companyService.getCompanyVO(companyId));

			return "/product/productReservation";
		}

		// < list page 완성되면 수정
		return "redirect:/list";

	}

	@PostMapping("/reserve")
	public String setReserve(@ModelAttribute ReservationVO reservationInfo, 
			HttpSession httpSession, 
			RedirectAttributes redirectAttr,
			Model model) {

		String viewName = "";
		String email = (String) httpSession.getAttribute("login");

		if (email != null && email.equals("") == false) {
			int resultId = reservationService.regReservationInfo(email, reservationInfo);

			if (resultId == 0) {
				redirectAttr.addFlashAttribute("errorMessageTitle", "ERROR !");
				redirectAttr.addFlashAttribute("errorMessage", "예약에 실패 했습니다.\n다시시도해주세요");
				
				viewName = "redirect:/user/product/reservation/page?"
						+ "company="  + reservationInfo.getCompanyId() 
						+ "&product=" + reservationInfo.getProductId();
			}

			redirectAttr.addFlashAttribute("errorMessageTitle", "SUCCESS !");
			redirectAttr.addFlashAttribute("errorMessage", "예약에 성공했습니다.");
			viewName = "redirect:/user/dashboard";
		}

		return viewName;
	}
	
	@GetMapping("/admin")
	public String showProductMangerPage(HttpSession httpSession, Model model) {

		String viewName = "/product/productAdmin";
		BusinessVO business = getCheckBusinessVO(httpSession);
		
		if(business != null && business.getCompanyId() != 0) {
			model.addAttribute("companyId" ,business.getCompanyId());
		}
			
	
		return viewName;
	}
	
	@GetMapping("/register")
	public String showProductRegisterPage(HttpSession httpSession, Model model) {

		String viewName = "/product/productRegister";
		BusinessVO business = getCheckBusinessVO(httpSession);
		
		if( business != null && business.getCompanyId() != 0)
			model.addAttribute("companyId" ,business.getCompanyId());
	
		return viewName;
	}
	
	@PostMapping("/register")
	public String Registerproduct(@ModelAttribute ProductVO product,
			List<MultipartFile> fileList,
			@RequestParam int productCount,
			RedirectAttributes redirectAttr,
			HttpSession httpSession, Model model) {

		BusinessVO business = getCheckBusinessVO(httpSession);
	
		if( business != null ) {
			if( productService.addProduct(product, productCount, business.getCompanyId(), fileList) == 1) {
				redirectAttr.addFlashAttribute("errorMessageTitle", "SUCCESS !");
				redirectAttr.addFlashAttribute("errorMessage", "상품이 등록되었습니다.");
			}else{
				redirectAttr.addFlashAttribute("errorMessageTitle", "ERROR !");
				redirectAttr.addFlashAttribute("errorMessage", "상품 등록에 실패하였습니다.");
			}
		}else {
			redirectAttr.addFlashAttribute("errorMessageTitle", "ERROR !");
			redirectAttr.addFlashAttribute("errorMessage", "다시 로그인하여 시도해 주시길 바랍니다.");
		}
		return "redirect:/product/admin";

	}

}
