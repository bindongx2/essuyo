package com.webproject.essuyo.domain;

public class MessageReadVO {
	
	private Integer megNum;
	private String userID;
	
	public MessageReadVO(Integer megNum, String userID) {
		this.megNum = megNum;
		this.userID = userID;
	}
	public Integer getMegNum() {
		return megNum;
	}
	public void setMegNum(Integer megNum) {
		this.megNum = megNum;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	
	
}
