package com.webproject.essuyo.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.webproject.essuyo.dao.NoticeDao;
import com.webproject.essuyo.domain.NoticeCriteria;
import com.webproject.essuyo.domain.NoticeVO;
import com.webproject.essuyo.service.NoticeService;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Inject
	private NoticeDao dao;
	
	@Override
	public void regist(NoticeVO notice) throws Exception {
		dao.create(notice);
	}

	@Override
	public NoticeVO read(Integer noticeNum) throws Exception {
		return dao.read(noticeNum);
	}

	@Override
	public void modify(NoticeVO notice) throws Exception {
		dao.update(notice);
	}
		
	@Override
	public void remove(Integer noticeNum) throws Exception {
		dao.delete(noticeNum);
	}

	@Override
	public List<NoticeVO> listAll() throws Exception {
		return dao.listAll();
	}

	@Override
	public List<NoticeVO> listCriteria(NoticeCriteria cri) throws Exception {
		return dao.listCriteria(cri);
	}
	
	@Override
	public int listCountCriteria(NoticeCriteria cri) throws Exception {
		return dao.countPaging(cri);
	}

}
