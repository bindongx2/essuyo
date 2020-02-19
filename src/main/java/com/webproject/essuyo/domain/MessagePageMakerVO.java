package com.webproject.essuyo.domain;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class MessagePageMakerVO {
	
	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	private int displayPageNum = 10;
	
	private MessageCriteriaVO cri;
	private MessageListCriVO listCri;

	// 전체 게시물
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		
		calcData();
	}
	
	public void calcData() {
		endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);
		
		startPage = (endPage - displayPageNum) + 1;
		
		int tempEndPage = (int) (Math.ceil(totalCount / (double) cri.getPerPageNum()));
		
		if(endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		
		prev = startPage == 1 ? false : true;
		
		next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
	
	}
	
	public String makeQuery(int page) {
		
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
									  .queryParam("page", page)
									  .queryParam("perPageNum", cri.getPerPageNum())
									  .build();
		return uriComponents.toUriString();
	}
	
	// UserID 게시물
	public void setListTotalCount(int totalCount) {
		this.totalCount = totalCount;
		
		listCalcData();
	}
		
	public void listCalcData() {
		endPage = (int) (Math.ceil(listCri.getPage() / (double) displayPageNum) * displayPageNum);
		
		startPage = (endPage - displayPageNum) + 1;
		
		int tempEndPage = (int) (Math.ceil(totalCount / (double) listCri.getPerPageNum()));
		
		if(endPage > tempEndPage) {
			endPage = tempEndPage;
		}
				
		prev = startPage == 1 ? false : true;

		next = endPage * listCri.getPerPageNum() >= totalCount ? false : true;
	}
	
	public String listMakeQuery(int page) {
		
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
									  .queryParam("page", page)
									  .queryParam("perPageNum", listCri.getPerPageNum())
									  .build();
		return uriComponents.toUriString();
	}

	public int getTotalCount() {
		return totalCount;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

	// 전체 쪽지
	public MessageCriteriaVO getCri() {
		return cri;
	}

	public void setCri(MessageCriteriaVO cri) {
		this.cri = cri;
	}
	
	// 보낸, 받은 쪽지
	public MessageListCriVO  getListCri() {
		return listCri;
	}

	public void setListCri(MessageListCriVO  listCri) {
		this.listCri = listCri;
	}
	
	
	@Override
	public String toString() {
		String result = "게시물 인덱스 번호" + listCri.getPage() + "[ totalCount : " + totalCount + ", startPage : " + startPage + ", endPage : " 
					+ endPage + ", prev : " + prev + ", next : " + next + ", displayPageNum : " 
					+ displayPageNum + "]";
		return result;
	}
	
	
}
