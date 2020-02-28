package com.webproject.essuyo.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.webproject.essuyo.domain.SeatVO;

@Repository
public class SeatDao {

	@Inject
	private SqlSession session;

	private static String namespace = "com.webproject.essuyo.dao.SeatDao";
	
	public List<SeatVO> selectListSeat() throws Exception{
		return session.selectList(namespace + ".selectListSeat");
		
	}
	
	public int chkSeat(Map<String, Object> param) throws Exception{
		return session.selectOne(namespace + ".chkSeat", param);
		
	}
	
	public List<SeatVO> regSeat(Map<String, Object> param) throws Exception{
		return session.selectList(namespace + ".regSeat", param);
		
	}
	
	public List<SeatVO> modSeat(Map<String, Object> param) throws Exception{
		return session.selectList(namespace + ".modSeat", param);
		
	}
	
	public List<SeatVO> excelSeat(Map<String, Object> param) throws Exception {
		return session.selectList(namespace + ".excelSaveSeat", param);
	}
	
	public void deleteSeat() throws Exception {
		session.delete(namespace + ".deleteSeat");
	}
	

}