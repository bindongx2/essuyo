package com.webproject.essuyo.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webproject.essuyo.dao.HorseDao;
import com.webproject.essuyo.domain.CompanyVO;
import com.webproject.essuyo.domain.HorseVO;
import com.webproject.essuyo.service.HorseService;


@Service
public class HorseServiceImpl implements HorseService {
	
	
	@Autowired
	private HorseDao horseDao;
	
	@Override
	public double rate(int total_money, int part_money) {
		//total_money : 배팅한 총 금액
        //part_money  : 어떤 한 파트에 배팅한 금액
//        double rate = total_money / part_money;	 //배당률	
        double rate = 1.2;	 //배당률	
  	
		return rate;
	}

	
	@Override
	public List<HorseVO> horseList() {
		List<HorseVO> list = null;
		
		try {
			list = horseDao.listAll();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
