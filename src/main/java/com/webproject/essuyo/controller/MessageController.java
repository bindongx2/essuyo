package com.webproject.essuyo.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.webproject.essuyo.domain.MessageCriteriaVO;
import com.webproject.essuyo.domain.MessageListCriVO;
import com.webproject.essuyo.domain.MessagePageMakerVO;
import com.webproject.essuyo.domain.MessageVO;
import com.webproject.essuyo.domain.UserVO;
import com.webproject.essuyo.service.MessageService;
import com.webproject.essuyo.service.UserService;

@Controller
@RequestMapping("/message/*")
public class MessageController {
	private static final Logger logger = LoggerFactory.getLogger(MessageController.class);

	@Inject
	private MessageService service;

	@Autowired
	private UserService userService;


	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void registerGET(MessageVO message, RedirectAttributes rttr, Model model, HttpSession session) throws Exception {
		logger.info("register get...");
		
		// 현재 로그인 된 ID 가져오기
		String userID = (String) session.getAttribute("login");
		message.setUserID(userID);

		// receiverID 받아오기
		String id = message.getReceiverID();

		// UserVO 의 id 값으로 들어온 값을 email로 변환
		UserVO user = userService.selectMessageEmail(id);
		String receiverID = user.getEmail();
		
		// receiverID 초기화
		message.setReceiverID(receiverID);

		model.addAttribute("messageVO", message);

	}

	@RequestMapping(value = "/registerSend", method = RequestMethod.POST)
	public String registerPOST(MessageVO message, RedirectAttributes rttr, Model model) throws Exception {

		logger.info("register POST...");

		model.addAttribute("messageVO", message);

		service.regist(message);

		rttr.addFlashAttribute("msg", "success");

		return "redirect:/message/listPage";
	}
	
	@RequestMapping(value = "/replyPage", method = RequestMethod.GET)
	public void replyPage(MessageVO message, RedirectAttributes rttr, Model model,
			@RequestParam("userID") String userID, @RequestParam("receiverID") String receiverID)
			throws Exception {
		logger.info("----- 답장 replyPage() -----");
		
		// 답장하기 위해 전달 받은 ID값을 반대로 저장
		message.setUserID(userID);
		message.setReceiverID(receiverID);
			
		model.addAttribute("messageVO", message);

		rttr.addFlashAttribute("msg", "success");
	}
	
	@RequestMapping(value = "/removePage", method = RequestMethod.GET)
	public String remove(@RequestParam("megNum") int megNum, MessageCriteriaVO cri,
			RedirectAttributes rttr) throws Exception {
		logger.info("----- 삭제 remove() -----");
		service.remove(megNum);

		logger.info("----- 삭제 완료 -----");
		rttr.addAttribute("perPageNum", cri.getPerPageNum());

		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/message/listPage";
	}

	@RequestMapping(value = "/listPage", method = RequestMethod.GET)
	public void listPage(@ModelAttribute("cri") MessageListCriVO cri, Model model, HttpSession session) 
			throws Exception {
		logger.info("----- 전체 쪽지함 listPage() -----");
	
		// 현재 로그인 된 ID 가져오기
		String userID = (String) session.getAttribute("login");
		cri.setUserID(userID);
				
		MessagePageMakerVO pageMaker = new MessagePageMakerVO();
		pageMaker.setListCri(cri);
		pageMaker.setListTotalCount(service.listCountCriteria(cri));
		model.addAttribute("pageMaker", pageMaker);
		
		model.addAttribute("list", service.listCriteria(cri));
	}

	@RequestMapping(value = "/readPage", method = RequestMethod.GET)
	public void read(@RequestParam("megNum") int megNum, 
			@ModelAttribute("cri") MessageCriteriaVO cri,
			Model model, HttpSession session) throws Exception {
		logger.info("----- 읽기 readPage() -----");
		// 현재 로그인 된 ID 가져오기
		String userID = (String) session.getAttribute("login");
		
		model.addAttribute(service.read(megNum, userID));
		

	}

	// 보낸 쪽지함
	@RequestMapping(value = "/sendMeg", method = RequestMethod.GET)
	public void sendMeg(@ModelAttribute("listCri") MessageListCriVO listCri, Model model, HttpSession session) 
			throws Exception {
		logger.info("----- 보낸 쪽지함 sendMeg() -----");

		// 현재 로그인 된 ID 가져오기
		String userID = (String) session.getAttribute("login");
	
		// 페이징 처리를 위한 설정
		MessagePageMakerVO pageMaker = new MessagePageMakerVO();
		listCri.setUserID(userID);
		pageMaker.setListCri(listCri);
		pageMaker.setListTotalCount(service.sendCountPaging(userID));

		model.addAttribute("pageMaker", pageMaker);

		model.addAttribute("sendList", service.sendCri(listCri));

	}

	// 받은 편지함
	@RequestMapping(value = "/recevieMeg", method = RequestMethod.GET)
	public void recevieMeg(@ModelAttribute("listCri") MessageListCriVO listCri, Model model, HttpSession session) 
			throws Exception {
		logger.info("----- 받은 쪽지함 recevieMeg() -----");

		// 현재 로그인 된 ID 가져오기
		String userID = (String) session.getAttribute("login");
	
		// 페이징 처리를 위한 설정
		MessagePageMakerVO pageMaker = new MessagePageMakerVO();
		listCri.setUserID(userID);
		pageMaker.setListCri(listCri);
		pageMaker.setListTotalCount(service.recevieCountPaging(userID));

		model.addAttribute("pageMaker", pageMaker);

		model.addAttribute("recevieList", service.recevieCri(listCri));
	}
}
