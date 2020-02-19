package com.webproject.essuyo.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.webproject.essuyo.domain.SeatVO;
import com.webproject.essuyo.utility.Excel;

@Controller
@RequestMapping("/seat")
public class SeatController {

	private static final Logger logger = LoggerFactory.getLogger(SeatController.class);
	
	
	@RequestMapping(value = "/saveSeat", method = RequestMethod.GET)
	public String  saveSeat(SeatVO seatVO, HttpServletRequest request, Model model) throws Exception{
		logger.info("saveSeat@@@@");	
		
		return "seat/seat";
	}
	
	@RequestMapping(value ="/saveExcelSeat", method= RequestMethod.POST)
	public String saveExcelSeat(SeatVO seatVO, HttpServletRequest request, Model model, @RequestParam("file") MultipartFile file) throws Exception{
		logger.info("saveExcelSeat@@@@");	
		
		String fileName = file.getOriginalFilename();		//파일 이름
		String savePath = "C:\\Users\\HSJ\\git\\essuyo\\src\\main\\webapp\\resources\\excel/test"; 	//저장 공간 위치
		System.out.println("fileName : " + fileName);
		
		//엑셀 파일 저장
		Excel.writeFile(file,savePath, fileName);
		
		List<Object> list = new ArrayList<Object>();
		//엑셀 파일 불러오기(Cell데이터 가져오기)
		list = Excel.getExcelDataMap(savePath,fileName);
		
		System.out.println("list : " + list);
		model.addAttribute("list", list);
		return "seat/seat";
	}
	
}
