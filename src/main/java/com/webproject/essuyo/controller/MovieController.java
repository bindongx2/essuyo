package com.webproject.essuyo.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/movie")
public class MovieController {

	private static final Logger logger = LoggerFactory.getLogger(MovieController.class);
	
//	판매리스트 전체
	@RequestMapping(value = "/movieList", method = RequestMethod.GET)
	public String moiveList(@RequestParam(value="type", defaultValue="'전체'") String type,  Model model) throws Exception {
		logger.info("moiveList@@@@");	
		
		model.addAttribute("type",type);
		return "movie/movieList";
	}

}
