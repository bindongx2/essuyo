package com.webproject.essuyo.dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.webproject.essuyo.domain.ProductManagerVO;
import com.webproject.essuyo.domain.ProductVO;

@Repository
public class ProductDao { 

	@Autowired
	private SqlSession sqlSession;
	private String NAME_SPACE = "mappers.Product";
	
	
	public ProductVO selectByProductId(int id) throws Exception{
		return sqlSession.selectOne(NAME_SPACE + ".selectById" , id);
	}
	
	public List<ProductVO> selectByCompanyId(int id) throws Exception{
		return sqlSession.selectList(NAME_SPACE + ".selectByCompanyId" , id);
	}
	
	public int insert(ProductVO param) throws Exception{
		return sqlSession.insert(NAME_SPACE + ".insert" , param);
	}
	
	public int update(ProductVO product) throws Exception{
		return sqlSession.selectOne(NAME_SPACE + ".updateById" , product);
	}
		
	public List<ProductManagerVO> selectManagerByProductId(int id) throws Exception{
		return sqlSession.selectList(NAME_SPACE + ".selectManagerByProductId" , id);
	}
	
	public List<String> selectManagerDisableDateList(int id) throws Exception{
		return sqlSession.selectList(NAME_SPACE + ".selectManagerDisableDate" , id);
	}
	
	public int insertManager(ProductManagerVO param) throws Exception{
		return sqlSession.insert(NAME_SPACE + ".insertManager" , param);
	}
	
	public int insertManager(List<ProductManagerVO> param) throws Exception{
		return sqlSession.insert(NAME_SPACE + ".insertManager" , param);
	}
	
	public int updateManager(ProductManagerVO param) throws Exception{
		return sqlSession.update(NAME_SPACE + ".updateManager" , param);
	}

	public int insertAdmin(Map<String,Integer> param) throws Exception{
		return sqlSession.insert(NAME_SPACE + ".insertAdmin" , param);
	}
	
	public int delete(int id) throws Exception{
		return sqlSession.insert(NAME_SPACE + ".delete" , id);
	}

}