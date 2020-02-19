package com.webproject.essuyo.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.webproject.essuyo.dao.QnADao;
import com.webproject.essuyo.domain.QnACriteriaVO;
import com.webproject.essuyo.domain.QnAVO;
import com.webproject.essuyo.service.QnAService;

@Service
public class QnAServiceImpl implements QnAService {

	@Inject
	private QnADao dao;

	@Override
	public void regist(QnAVO vo) throws Exception {

		dao.create(vo);
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public QnAVO read(Integer id, String userId) throws Exception {
		dao.updateViewCount(id);
		return dao.read(id);
	}

	@Override
	public List<QnAVO> listAll() throws Exception {	

		return dao.listAll();
	}

	@Override
	public void remove(Integer id) throws Exception {
		dao.delete(id);
	}
	
	@Override
	public void update(QnAVO vo) throws Exception{
		dao.update(vo);
	}

	@Override
	public List<QnAVO> listCriteria(QnACriteriaVO cri) throws Exception {
		return dao.listCriteria(cri);
	}

	@Override
	public int listCountCriteria(QnACriteriaVO cri) throws Exception {
		return dao.countPaging(cri);
	}

}
