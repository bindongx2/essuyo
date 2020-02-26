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
	public int chkSeat() throws Exception {
		return seatDao.chkSeat();
	}
	
	@Override
	public void saveSeat(List<SeatVO> seatList) throws Exception {
		logger.info("test@@@@@ : " + seatList);
		
		int chkCount = seatDao.chkSeat();
		if(chkCount == 0) {	//DB에 없는 새로운 값
		}else {
			
		}
//		Map<String, Object> param = new HashMap<>();
//		param.put("locX",1 );
//		param.put("locY", 2);
//		seatDao.saveSeat(param);
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
