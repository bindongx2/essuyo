package com.webproject.essuyo.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webproject.essuyo.dao.FacilityAdminDao;
import com.webproject.essuyo.service.FacilityAdminService;

@Service
public class FacilityAdminServiceImpl implements FacilityAdminService {
	
	@Autowired
	private FacilityAdminDao fadao;

	@Override
	public void insertToAdmin(Map<String, Object> map) throws Exception {
		
		fadao.insertToAdmin(map);

	}

	@Override
	public void deleteFacAdmin(int companyId) throws Exception {
		
		fadao.deleteFacAdmin(companyId);		
	}

	@Override
	public List<String> selectById(int companyId) throws Exception {
		
		return fadao.selectById(companyId);
	}

}
