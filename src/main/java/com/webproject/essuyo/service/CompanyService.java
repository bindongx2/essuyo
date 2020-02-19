package com.webproject.essuyo.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.webproject.essuyo.domain.CompanyVO;

@Service
public interface CompanyService {

	public CompanyVO getCompanyVO(int companyId);

	public Map<String, Object> getSimpleCompanyInfo(int companyId);

	public Map<String, Object> getDetailCompanyInfo(int companyId);
	
	public List<Map<String, Object>> getRankCompanyInfoList();
	
	//판매리스트
	public Map<String, Object> getList(int start, String value, String type, String name) throws Exception;
	
	public Map<String,Object> getAllCompanyCount();
	
	public List<String> getCompanyFacility(int companyId) throws Exception;

	//	이미지 
	public List<String> getImagePath(int companyId) throws Exception;
	
	public int selectId() throws Exception;
	
	public void companyImgInsert(int cId) throws Exception;
	
	public int updateScore(int companyId);

}
