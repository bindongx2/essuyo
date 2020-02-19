package com.webproject.essuyo.service;


import org.springframework.stereotype.Service;

import com.webproject.essuyo.domain.BusinessVO;

@Service
public interface BusinessService {

	public BusinessVO selectById(int id) throws Exception;
	
	public void insertEmpty() throws Exception;
	
	//비지니스 테이블을 입력할때 라스트 인서트로 컴퍼니 아이디까지 같이 넣어주는 서비스
	public void insertWithCId() throws Exception;
}
