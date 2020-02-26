package com.webproject.essuyo.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.webproject.essuyo.domain.SeatVO;
import com.webproject.essuyo.service.SeatService;
import com.webproject.essuyo.utility.CommonUtil;
import com.webproject.essuyo.utility.Excel;

@Controller
@RequestMapping("/seat")
public class SeatController {

	private static final Logger logger = LoggerFactory.getLogger(SeatController.class);
	

	@Autowired
	private SeatService seatService;
	
	
	@RequestMapping(value = "/seat", method = RequestMethod.GET)
	public String  SeatGET(SeatVO seatVO, HttpServletRequest request, Model model) throws Exception{
		logger.info("SeatGET@@@@");	
		return "seat/seat";
	}
	
	@RequestMapping(value = "/selectListSeat", method = RequestMethod.POST)
	public @ResponseBody ModelAndView   selectListSeat(SeatVO seatVO, HttpServletRequest request, Model model) throws Exception{
		logger.info("selectListSeat@@@@");	
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());
		List<SeatVO> list = new ArrayList<SeatVO>();
		
		list = seatService.selectListSeat();
		mv.addObject(list);
		return mv;
	}
	
	

	@RequestMapping(value ="/saveSeat", method= RequestMethod.POST)
	public @ResponseBody ModelAndView saveSeat(HttpServletRequest request, Model model) throws Exception{
		logger.info("saveSeat@@@@");	
		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());
		List<SeatVO> seatList = new ArrayList<SeatVO>();
		
		String[] x = request.getParameterValues("x[]");
		String[] y = request.getParameterValues("y[]");
		String[] num = request.getParameterValues("num[]");
		String[] isFac = request.getParameterValues("isFac[]");
		String[] facBGColor = request.getParameterValues("facBGColor[]");
		
		if(num != null && num.length>0) {
			for(int i=0; i<num.length; i++) {
					SeatVO seatVO = new SeatVO();
					seatVO.setLocX(Integer.parseInt(x[i]));
					seatVO.setLocY(Integer.parseInt(y[i]));
					seatVO.setSeatNum(num[i]);
					seatVO.setIs_FAC(isFac[i]);
					seatVO.setFacBGColor(facBGColor[i]);
					seatList.add(seatVO);
			}
		}
		
		seatService.saveSeat(seatList);
		
		
		return mv;
	}
	
	@RequestMapping(value ="/saveExcelSeat", method= RequestMethod.POST)
	public String saveExcelSeat(HttpServletRequest request, Model model, @RequestParam("file") MultipartFile file) throws Exception{
		logger.info("saveExcelSeat@@@@");	
		
		String fileName = file.getOriginalFilename();		//파일 이름
		String savePath = "C:\\Users\\HSJ\\workspace\\essuyo\\src\\main\\webapp\\resources\\excel\\test"; 	//저장 공간 위치
		System.out.println("fileName : " + fileName);
		
		//엑셀 파일 저장
		Excel.writeFile(file,savePath, fileName);
		
		//엑셀 파일 불러오기(Cell데이터 가져오기)
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list = Excel.getExcelDataMap(savePath,fileName);
		System.out.println("엑셀 데이터 가져와서 Controller 입성!!! ");
		
		seatService.deleteSeat();				// 좌석 먼저 모두 삭제
		
		for(int i=0; i< list.size(); i++) {
			int x = (int) list.get(i).get("locX");
			int y = (int) list.get(i).get("locY");
			String seatNum = (String) list.get(i).get("seatNum");
			
			String facBGColor = "";
			String IS_FAC = "";
			boolean checkNum = CommonUtil.CheckNumber(seatNum);		//문자열이 숫자 인지 문자인지 체크 함수 
			if(checkNum) {
				 facBGColor = "#0CBD25"; 
				 IS_FAC = "N";
			}else {
				 facBGColor = "#AA9854";
				 IS_FAC = "Y";
			}
			
			seatService.excelSeat(x, y, seatNum, facBGColor, IS_FAC);	//좌석 DB에 셋팅
		}
		return "seat/seat";
	}
}
