package com.webproject.essuyo.domain;

import java.io.Serializable;

public class MessageCriteriaVO implements Serializable{
	private int page;
	private int perPageNum;
	
	public MessageCriteriaVO() {
		this.page = 1;
		this.perPageNum = 10;
	}

	public void setPage(int page) {
		if(page <= 0) {
			this.page = 1;
			return;
		}
		
		this.page = page;
	}
	
	public int getPage() {
		return page;
	}

	public void setPerPageNum(int perPageNum) {
		
		if(perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		
		this.perPageNum = perPageNum;
	}
	
	// MyBatis SQL Mapper
	public int getPageStart() {
		return (this.page - 1) * perPageNum;
	}

	public int getPerPageNum() {
		return perPageNum;
	}
	
	@Override
	public String toString() {
		String result = "Criteria [page = " + page + ", perPageNum = " + perPageNum + "]";
		return result;
	}
	

}
