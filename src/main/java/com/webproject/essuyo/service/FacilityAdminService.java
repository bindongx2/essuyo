package com.webproject.essuyo.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public interface FacilityAdminService {
	
	public List<String> selectById(int companyId) throws Exception;
	
	public void insertToAdmin(Map<String, Object> map) throws Exception;
	
	public void deleteFacAdmin(int companyId) throws Exception;

}
