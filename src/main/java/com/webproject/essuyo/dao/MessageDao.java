package com.webproject.essuyo.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.webproject.essuyo.domain.MessageListCriVO;
import com.webproject.essuyo.domain.MessageReadVO;
import com.webproject.essuyo.domain.MessageVO;

@Repository
public class MessageDao {
	@Inject
	private SqlSession session;
	
	private static String namespace = "mappers.MessageMapper";
	
	public void create(MessageVO vo) throws Exception{
		session.insert(namespace + ".create", vo);
	}
	
	public MessageVO read(Integer megNum) throws Exception{
		return session.selectOne(namespace + ".read", megNum);
		
	}
	
	public void delete(Integer megNum) throws Exception{
		session.delete(namespace + ".delete", megNum);
	}
	
	public List<MessageVO> listAll() throws Exception{
		return session.selectList(namespace + ".listAll");
		
	}
	
	/*public List<MessageVO> listPage(int page) throws Exception{
	
		if(page <= 0) {
			page = 1;
		}
		
		page = (page -1) *10;
		
		return session.selectList(namespace + ".listPage", page);
	}*/
	
	
	public List<MessageVO> listCriteria(MessageListCriVO cri)throws Exception{
				
		return session.selectList(namespace + ".listCriteria", cri);
		
	}
	
	public int countPaging(MessageListCriVO cri) throws Exception{
		
		return session.selectOne(namespace + ".countPaging", cri);
	}
	
	// 조회수 카운트
	public void updateReadCheck(Integer megNum, String userID) throws Exception{
		MessageReadVO vo = new MessageReadVO(megNum, userID);
		
		session.update(namespace + ".updateReadCheck", vo);
	}

	
	
	// 보낸 쪽지함 페이징 처리
	public List<MessageVO> sendCri(MessageListCriVO listCri)throws Exception{
		
		return session.selectList(namespace + ".sendCri", listCri);
		
	}
	// 받은 쪽지함 페이징 처리
	public List<MessageVO> recevieCri(MessageListCriVO listCri)throws Exception{
		
		return session.selectList(namespace + ".recevieCri", listCri);
	
	}
	
	
	// 보낸 쪽지함 페이징 처리를 위한 게시물 개수 검색
	public int sendCountPaging(String userID) throws Exception{
		
		return session.selectOne(namespace + ".sendCountPaging", userID);
	}
	
	// 받은 쪽지함 페이징 처리를 위한 게시물 개수 검색	
	public int recevieCountPaging(String userID) throws Exception{
		
		return session.selectOne(namespace + ".recevieCountPaging", userID);
	}
}
