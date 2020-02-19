package com.webproject.essuyo.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.webproject.essuyo.domain.NoticeCriteria;
import com.webproject.essuyo.domain.NoticePageMaker;
import com.webproject.essuyo.domain.NoticeVO;
import com.webproject.essuyo.service.NoticeService;

@Controller
@RequestMapping("/notice/*")
public class NoticeController {
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Inject
	private NoticeService service;

	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void registerGET(NoticeVO notice, Model model, HttpSession session) throws Exception {

		// 현재 로그인 된 ID 가져오기
		String userID = (String) session.getAttribute("login");
		logger.info("user : " + userID);
		notice.setUserID(userID);

		model.addAttribute("noticeVO", notice);

		logger.info(notice.toString());
		logger.info("register get...");
		
	}
	
	@RequestMapping(value="/register", method = RequestMethod.POST)
	public String registPOST(NoticeVO notice, RedirectAttributes rttr) throws Exception {
		
		logger.info("regist post...");
		logger.info(notice.toString());
		
		service.regist(notice);
		
		rttr.addFlashAttribute("msg", "success");
		return "redirect:/notice/listPage";
	}
	
	@RequestMapping(value="/listPage", method=RequestMethod.GET)
	public void listPage(NoticeCriteria cri, Model model) throws Exception{
		logger.info(cri.toString());
		
		model.addAttribute("list", service.listCriteria(cri));
		NoticePageMaker pageMaker = new NoticePageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listCountCriteria(cri));
		
		model.addAttribute("pageMaker", pageMaker);
	}
	
	@RequestMapping(value="/readPage", method=RequestMethod.GET)
	public void read(@RequestParam("noticeNum") int noticeNum, @ModelAttribute("cri") NoticeCriteria cri, Model model) throws Exception{
		model.addAttribute(service.read(noticeNum));
	}
	
	@RequestMapping(value="/removePage", method=RequestMethod.POST)
	public String remove(@RequestParam("noticeNum") int noticeNum, NoticeCriteria cri, RedirectAttributes rttr) throws Exception{	
		service.remove(noticeNum);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addFlashAttribute("msg","SUCCESS");
		
		return "redirect:/notice/listPage";
	}
		
	@RequestMapping(value="/modifyPage", method=RequestMethod.GET)
	public void modifyPagingGET(@RequestParam("noticeNum") int noticeNum,@ModelAttribute("cri") NoticeCriteria cri, Model model) throws Exception{
		model.addAttribute(service.read(noticeNum));
	}
	
	@RequestMapping(value="/modifyPage", method=RequestMethod.POST)
	public String modifyPagingPOST(NoticeVO notice, NoticeCriteria cri, RedirectAttributes rttr) throws Exception{
		
		service.modify(notice);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/notice/listPage";
	}
}







