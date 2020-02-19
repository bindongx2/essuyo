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

import com.webproject.essuyo.domain.MessageCriteriaVO;
import com.webproject.essuyo.domain.QnACriteriaVO;
import com.webproject.essuyo.domain.QnAPageMakerVO;
import com.webproject.essuyo.domain.QnAVO;
import com.webproject.essuyo.service.QnAService;

@Controller
@RequestMapping("/qna/*")
public class QnAController {
	private static final Logger logger = LoggerFactory.getLogger(QnAController.class);

	@Inject
	private QnAService service;


	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void registerGET(QnAVO vo, RedirectAttributes rttr, Model model, HttpSession session) throws Exception {
		logger.info("register get..........");

		String userId = (String) session.getAttribute("login");
		vo.setUserId(userId);

		model.addAttribute("qnaVO", vo);
	}

	@RequestMapping(value = "/registerSend", method = RequestMethod.POST)
	public String registerPOST(QnAVO vo, RedirectAttributes rttr, Model model) throws Exception {

		logger.info("register POST...");

		model.addAttribute("qnaVO", vo);

		service.regist(vo);

		rttr.addFlashAttribute("msg", "REGISTERSUCCESS");

		return "redirect:/qna/listPage";
	}

	@RequestMapping(value = "/readPage", method = RequestMethod.GET)
	public void read(@RequestParam("id") int id, @ModelAttribute("cri") MessageCriteriaVO cri, Model model, HttpSession session)
			throws Exception {

		String userId = (String) session.getAttribute("login");

		model.addAttribute("qna", service.read(id, userId));
	}

	@RequestMapping(value = "/remove", method = RequestMethod.GET)
	public String remove(@RequestParam("id") int id, MessageCriteriaVO cri, RedirectAttributes rttr) throws Exception {
		logger.info("----- 삭제 remove() -----");
		service.remove(id);

		logger.info("----- 삭제 완료 -----");
		rttr.addAttribute("perPageNum", cri.getPerPageNum());

		rttr.addFlashAttribute("msg", "REMOVESUCCESS");

		return "redirect:/qna/listPage";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public void updateGET(QnAVO vo, RedirectAttributes rttr, Model model, HttpSession session) throws Exception {
		
		String userId = (String) session.getAttribute("login");
		vo.setUserId(userId);

		model.addAttribute("qnaVO", vo);
	}
	
	@RequestMapping(value="/updateQ", method=RequestMethod.POST)
	public String updatePOST(QnAVO vo, RedirectAttributes rttr, Model model) throws Exception{
				
		service.update(vo);
		
		rttr.addFlashAttribute("msg", "UPDATESUCCESS");
		return "redirect:/qna/listPage";
	}

	@RequestMapping(value = "/listPage", method = RequestMethod.GET)
	public void listPage(@ModelAttribute("cri") QnACriteriaVO cri, Model model) throws Exception {

		logger.info(cri.toString());		

		model.addAttribute("list", service.listAll());
		model.addAttribute("criList", service.listCriteria(cri));
		QnAPageMakerVO pageMaker = new QnAPageMakerVO();
		pageMaker.setCri(cri);

		pageMaker.setTotalCount(service.listCountCriteria(cri));

		model.addAttribute("pageMaker", pageMaker);
	}
}
