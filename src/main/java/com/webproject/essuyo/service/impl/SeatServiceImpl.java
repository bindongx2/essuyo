package com.webproject.essuyo.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webproject.essuyo.dao.SeatDao;
import com.webproject.essuyo.domain.SeatVO;
import com.webproject.essuyo.service.SeatService;

@Service
public class SeatServiceImpl implements SeatService{
	
	private Logger logger = LoggerFactory.getLogger(SeatServiceImpl.class);

	@Autowired
	private SeatDao seatDao; 

	
	@Override
	public List<SeatVO> selectListSeat() throws Exception {
		return seatDao.selectListSeat();
	}
	
	
	@Override
	public void saveSeat(List<SeatVO> seatList) throws Exception {
		logger.info("SeatServiceImpl 진입@@@@@@");
		Map<String, Object> param = new HashMap<>();
		Map<String, Object> param1 = new HashMap<>();
		
		for(int i=0; i<seatList.size(); i++) {
			param.put("locX", seatList.get(i).getLocX());
			param.put("locY", seatList.get(i).getLocY());
			param.put("seatNum", seatList.get(i).getSeatNum());
			param.put("facBGColor", seatList.get(i).getFacBGColor());
			param.put("IS_FAC", seatList.get(i).getIs_FAC());
			
			param1.put("locX", seatList.get(i).getLocX());
			param1.put("locY", seatList.get(i).getLocY());
			int chkCount = seatDao.chkSeat(param1); //DB에 있는지 없는지 체크 로직
			if (chkCount == 0) {	
				seatDao.regSeat(param);		// 기존에 없던 좌석 추가
			}else {
				seatDao.modSeat(param);		// 기존에 있던 좌석 변경
			}
		}
	}
	
	@Override
	public void excelSeat(int x, int y, String seatNum, String facBGColor,String IS_FAC) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("locX", x);
		param.put("locY", y);
		param.put("seatNum", seatNum);
		param.put("facBGColor", facBGColor);
		param.put("IS_FAC", IS_FAC);
		seatDao.excelSeat(param);
	}

	@Override
	public void deleteSeat() throws Exception {
		seatDao.deleteSeat();
	}

	
}
