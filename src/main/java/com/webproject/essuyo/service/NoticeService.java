package com.webproject.essuyo.service;

import java.util.List;

import com.webproject.essuyo.domain.NoticeCriteria;
import com.webproject.essuyo.domain.NoticeVO;

public interface NoticeService {
	
	public void regist(NoticeVO notice) throws Exception;
	
	public NoticeVO read(Integer noticeNum) throws Exception;
	
	public void modify(NoticeVO notice) throws Exception;
	
	public void remove(Integer noticeNum) throws Exception;
	
	public List<NoticeVO> listAll() throws Exception;
	
	public List<NoticeVO> listCriteria(NoticeCriteria cri) throws Exception;
	
	public int listCountCriteria(NoticeCriteria cri) throws Exception;
}
