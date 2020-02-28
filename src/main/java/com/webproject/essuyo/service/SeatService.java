package com.webproject.essuyo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.webproject.essuyo.domain.SeatVO;

@Service
public interface SeatService {

	public List<SeatVO> selectListSeat() throws Exception;			//엑셀파일 값 불러와서 데이터 저장
	
	
	public void saveSeat(List<SeatVO> seatList) throws Exception;	// 좌석 저장
	
	public void excelSeat(int x, int y, String seatNum, String facBGColor, String IS_FAC) throws Exception;		//엑셀파일 값 불러와서 데이터 저장
	
	public void deleteSeat() throws Exception;	// 전체 좌석 데이터값 삭제
	


}
