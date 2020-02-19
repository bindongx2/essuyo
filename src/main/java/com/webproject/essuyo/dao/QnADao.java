package com.webproject.essuyo.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.webproject.essuyo.domain.QnACriteriaVO;
import com.webproject.essuyo.domain.QnAVO;

@Repository
public class QnADao {

	@Inject
	private SqlSession session;

	private String namespace = "mappers.QnAMapper";

	public void create(QnAVO vo) throws Exception {
		session.insert(namespace + ".create", vo);
	}

	public QnAVO read(Integer id) throws Exception {
		return session.selectOne(namespace + ".read", id);
	}

	public List<QnAVO> listAll() throws Exception {
		return session.selectList(namespace + ".listAll");
	}

	public void delete(Integer id) throws Exception {
		session.delete(namespace + ".delete", id);
	}
	
	public void update(QnAVO vo) throws Exception{
		session.update(namespace + ".update", vo); 
	}

	public void updateViewCount(int id) throws Exception {
		session.update(namespace + ".updateViewCnt", id);
	}

	public List<QnAVO> listPageCri(int page) throws Exception {

		if (page <= 0) {
			page = 1;
		}

		page = (page - 1) * 10;

		return session.selectList(namespace + ".listPageCri", page);
	}

	public List<QnAVO> listCriteria(QnACriteriaVO cri) throws Exception {
		return session.selectList(namespace + ".listCriteria", cri);
	}

	public int countPaging(QnACriteriaVO cri) throws Exception {
		return session.selectOne(namespace + ".countPaging", cri);
	};

}
