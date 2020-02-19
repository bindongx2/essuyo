package com.webproject.essuyo.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.webproject.essuyo.domain.NoticeCriteria;
import com.webproject.essuyo.domain.NoticeVO;

@Repository
public class NoticeDao {
	@Inject
	private SqlSession session;
	
	private static String namespace = "mappers.NoticeMapper";
	
	public void create(NoticeVO vo) throws Exception{
		session.insert(namespace + ".create", vo);
	}
	
	public NoticeVO read(Integer noticeNum) throws Exception{
		return session.selectOne(namespace + ".read", noticeNum);
	}
	
	public void update(NoticeVO vo) throws Exception{
		session.update(namespace + ".update", vo);
	}
	
	public void delete(Integer noticeNum) throws Exception{
		session.delete(namespace + ".delete", noticeNum);
	}
	
	public List<NoticeVO> listAll() throws Exception{
		return session.selectList(namespace + ".listAll");
	}
	
	public List<NoticeVO> listPage(int page) throws Exception{
		if (page <= 0 ) {
			page =1;
		}
		page = (page - 1) * 10;
		
		return session.selectList(namespace + ".listPage", page);
	}
	
	public List<NoticeVO> listCriteria(NoticeCriteria cri) throws Exception{
		return session.selectList(namespace + ".listCriteria", cri);
	}
	
	public int countPaging(NoticeCriteria cri) throws Exception{
		return session.selectOne(namespace + ".countPaging", cri);
	};
}




