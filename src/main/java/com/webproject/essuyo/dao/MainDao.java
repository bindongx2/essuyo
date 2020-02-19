package com.webproject.essuyo.dao;



import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.webproject.essuyo.domain.CompanyVO;

@Repository
public class MainDao {
	
	@Inject
	private SqlSession session;
	private static String namespace = "com.webproject.essuyo.dao.MainDao";

	public List<CompanyVO> getMain() throws Exception{
		return session.selectList(namespace + ".selectOne");
	}
	
	public List<Map<String,Object>> getMainCount() throws Exception{
		return session.selectList(namespace + ".count");
		
	}
	
}
