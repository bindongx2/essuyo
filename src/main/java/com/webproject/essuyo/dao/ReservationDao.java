package com.webproject.essuyo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.webproject.essuyo.domain.ReservationVO;
import com.webproject.essuyo.domain.SQLParamVO;

@Repository
public class ReservationDao {

	@Autowired
	private SqlSession sqlSession;
	private String NAME_SPACE = "mappers.Reservation";
	
	public int insert(ReservationVO reservationInfo) throws Exception{
		return sqlSession.insert(NAME_SPACE + ".insert", reservationInfo);
	}
	
	public List<ReservationVO> select(SQLParamVO param) throws Exception{
		return sqlSession.selectList(NAME_SPACE + ".selectLimitById", param);
	}
	
	public List<ReservationVO> selectNotState(SQLParamVO param) throws Exception{
		return sqlSession.selectList(NAME_SPACE + ".selectNotStateById", param);
	}
	
		
	public int selectTotalPrice(SQLParamVO param) throws Exception{
		return sqlSession.selectOne(NAME_SPACE + ".selectTotalPrice", param);
	}
	
	
	public List<Map<String,Integer>> selectMonthlyPrice(SQLParamVO params) throws Exception{
		return sqlSession.selectList(NAME_SPACE + ".selectMonthlyPrice" , params);
	}
	
	public List<Map<String,Integer>> selectMonthlyReservationCount(SQLParamVO params) throws Exception{
		return sqlSession.selectList(NAME_SPACE + ".selectMonthlyReservationCount" , params);
	}
	
	public List<Map<String,Object>> selectCategoryCount(SQLParamVO params) throws Exception{
		return sqlSession.selectList(NAME_SPACE + ".selectCategoryReservationCount" , params);
	}
	
	public List<Map<String,Object>> selectComprehensiveReservation(SQLParamVO params) throws Exception{
		return sqlSession.selectList(NAME_SPACE + ".selectComprehensiveReservation" , params);
	}
	
	public List<Map<String,Object>> selectGenderReservationCount(int id) throws Exception{
		return sqlSession.selectList(NAME_SPACE + ".selectGenderReservationCount" , id);
	}
	
	public int update(ReservationVO param) throws Exception{
		return sqlSession.update(NAME_SPACE + ".update", param);
	}
	
	public int selectCount(SQLParamVO param) throws Exception{
		return sqlSession.selectOne(NAME_SPACE + ".selectReservationCount", param);
	}
		
		
	
	

}
