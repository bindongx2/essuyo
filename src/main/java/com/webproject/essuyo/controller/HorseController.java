package com.webproject.essuyo.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.webproject.essuyo.service.HorseService;

@Controller
@RequestMapping("/horse")
public class HorseController {

	@Autowired
	private HorseService horseService;


    //배당페이지로 이동
	@RequestMapping(value = "/" ,method = RequestMethod.GET)
    public  String main(Model model) {
//		model.addAttribute("total_money", total_money);
//		System.out.println("total_money : " + total_money);
		
		model.addAttribute("list", horseService.horseList());
		System.out.println("list : " + horseService.horseList().toString());
    	return "/rate/main";
    }
	
	//구매페이지 이동w
	@RequestMapping(value = "/buying" ,method = RequestMethod.GET )
	public  String goBuy(Model model) {
		model.addAttribute("list", horseService.horseList());
		return "/rate/buying";
	}
	
	
//	//배당률 계산하는 api
//	@RequestMapping(value = "/odds" ,method = RequestMethod.GET)
//	public  String rate(Model model, int total_money, int part_money) {
//		double rate = horseService.rate(total_money, part_money);
//		model.addAttribute("rate", rate);
//		return "/rate/rate_main";
//	}

}
