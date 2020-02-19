package com.webproject.essuyo.domain;

import java.io.Serializable;

public class MessageListCriVO implements Serializable{
	

	private static final long serialVersionUID = 1L;
	private int page;
	private int perPageNum;
	private String userID;
	
	
	
	public MessageListCriVO() {
		this.page = 1;
		this.perPageNum = 10;
	}
	
	public MessageListCriVO(String userID, MessageListCriVO cri) {
		this.userID = userID;
		this.page = 1;
		this.perPageNum = 10;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		if(page <= 0) {
			this.page =1;
			return;
		}
		this.page=page;
	}

	public int getPerPageNum() {
		return this.perPageNum;
	}

	public void setPerPageNum(int perPageNum) {
		
		if(perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		
		this.perPageNum = perPageNum;
	}
	
	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}
	
	// MyBatis SQL Mapper
	public int getPageStart() {
		return (this.page -1) * perPageNum;
	}
	
	@Override
	public String toString() {
		String result = "ListCri [page = " + page + ", perPageNum = " + perPageNum + ", userID = " + userID + "]";
		return result;
	}

}
