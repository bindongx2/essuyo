package com.webproject.essuyo.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.webproject.essuyo.domain.HorseVO;

@Service
public interface HorseService {

	public double rate(int total_money, int part_money);
	
	public List<HorseVO> horseList();
}
