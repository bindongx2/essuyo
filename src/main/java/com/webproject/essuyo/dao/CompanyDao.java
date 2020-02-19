package com.webproject.essuyo.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.webproject.essuyo.domain.CompanyVO;
import com.webproject.essuyo.domain.SQLParamVO;

@Repository
public class CompanyDao {

	@Inject
	private SqlSession session;

	private static String namespace = "com.webproject.essuyo.dao.CompanyDao";

	public CompanyVO getCompany(int companyId) throws Exception {
		return session.selectOne(namespace + ".select", companyId);

	}
	
	//판매리스트 전체
	public List<CompanyVO> listAll(SQLParamVO param) throws Exception {
		return session.selectList(namespace + ".listAll", param);

	}
	//판매리스트 타입별
	public List<CompanyVO> listType(SQLParamVO param) throws Exception {
		return session.selectList(namespace + ".listType", param);
		
	}
	
	//필터 기능
	public List<CompanyVO> filter(Map<String,Object> param) throws Exception{
		return session.selectList(namespace+".filter", param);
	}
	
	// 판매리스트  갯수
	public int SalesListCount(Map<String,Object> param) throws Exception{
		return session.selectOne(namespace+".listCount", param);
	}
	
	
	public Integer updateCompanyScore(int id) throws Exception {
		return session.update(namespace + ".score", id);

	}

	public Integer cntReviews(int companyId) throws Exception {
		return session.selectOne(namespace + ".reviews", companyId);
	}
	
	public List<CompanyVO> getRankCompanyList(Map<String, Object> param) throws Exception {
		return session.selectList(namespace + ".selectRankCompany", param);
	}
	
	//이메일로 컴퍼니 아이디를 얻는 DAO
	public int selectId() throws Exception{
		return session.selectOne(namespace+".selectId");
	}
	
	//컴퍼니 이미지 관리 테이블에 입력하는 DAO
	public void companyImgInsert(int cId) throws Exception{
		
		int companyId = cId;
		
		session.insert(namespace+".companyImgInsert", companyId);
	}
	
	
	public List<Map<String,Object>> selectAllCompanyCount() throws Exception{
		return session.selectList(namespace + ".allCompanyCount");
		
	}
	

}