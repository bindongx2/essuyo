package com.webproject.essuyo.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.webproject.essuyo.domain.CompanyVO;
import com.webproject.essuyo.domain.HorseVO;
import com.webproject.essuyo.domain.SQLParamVO;

@Repository
public class HorseDao {

	@Inject
	private SqlSession session;

	private static String namespace = "com.webproject.essuyo.dao.HorseDao";

	
	//말 리스트 전체
	public List<HorseVO> listAll() throws Exception {
		return session.selectList(namespace + ".listAll");

	}
	

}