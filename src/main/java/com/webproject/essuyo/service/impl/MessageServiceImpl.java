package com.webproject.essuyo.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webproject.essuyo.dao.MessageDao;
import com.webproject.essuyo.domain.MessageListCriVO;
import com.webproject.essuyo.domain.MessagePageMakerVO;
import com.webproject.essuyo.domain.MessageVO;
import com.webproject.essuyo.service.MessageService;

@Service
public class MessageServiceImpl implements MessageService {

	@Inject
	private MessageDao dao;
	
	@Autowired
	private MessageService messageService;
	
	@Override
	public void regist(MessageVO message) throws Exception {
		dao.create(message);
	}

	@Override
	public MessageVO read(Integer megNum, String userID) throws Exception {
		
		dao.updateReadCheck(megNum, userID);
		return dao.read(megNum);
	}

	@Override
	public void remove(Integer megNum) throws Exception {
	
		dao.delete(megNum);
	}

	@Override
	public List<MessageVO> listAll() throws Exception {
		
		return dao.listAll();
	}

	@Override
	public List<MessageVO> listCriteria(MessageListCriVO cri) throws Exception {
		
		return dao.listCriteria(cri);
	}

	@Override
	public int listCountCriteria(MessageListCriVO cri) throws Exception {
		
		return dao.countPaging(cri);
	}
	
	
	// 보낸 쪽지함 페이징 처리	
	@Override
	public List<MessageVO> sendCri(MessageListCriVO listCri) throws Exception {
		
		return dao.sendCri(listCri);
	}

	// 받은 쪽지함 페이징 처리
	@Override
	public List<MessageVO> recevieCri(MessageListCriVO listCri) throws Exception {
		
		return dao.recevieCri(listCri);
	}
	
	// 받은 쪽지함 게시물 수 검색
	@Override
	public int sendCountPaging(String userID) throws Exception {
		
		return dao.sendCountPaging(userID);
	}
	
	// 받은 쪽지함 게시물 수 검색
	@Override
	public int recevieCountPaging(String userID) throws Exception {
		
		return dao.recevieCountPaging(userID);
	}

	@Override
	public Map<String, Object> getMegList(MessageListCriVO listCri) throws Exception {

		MessagePageMakerVO pageMaker = new MessagePageMakerVO();
		int sPage = (listCri.getPage()-1)*10;
		listCri.setPage(sPage);
		pageMaker.setListCri(listCri);
		pageMaker.setListTotalCount(messageService.recevieCountPaging(listCri.getUserID()));

		Map<String, Object> resultMap = new HashMap<>();
		List<MessageVO> list = dao.recevieCri(listCri);	
		List<Object> salesList = new ArrayList<>();
		
	
			for(MessageVO vo : list) {
				Map<String, Object> salesMap = new HashMap<>();
				salesMap.put("megNum", vo.getMegNum());
				salesMap.put("title", vo.getTitle());
				salesMap.put("sendDate", vo.getSendDate());
				salesMap.put("readCheck", vo.getReadCheck());
				salesMap.put("content", vo.getContent());
				salesMap.put("userID", vo.getUserID());
				salesMap.put("receiverID", vo.getReceiverID());
				
				
				salesList.add(salesMap);
				}
			
		resultMap.put("sales", salesList);
		
		return resultMap;
	}

}
