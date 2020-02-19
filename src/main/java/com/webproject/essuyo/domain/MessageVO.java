package com.webproject.essuyo.domain;

import java.util.Date;

public class MessageVO {
	private Integer megNum;
	private String title;
	private Date sendDate;
	private int readCheck;
	private String content;
	private String userID;
	private String receiverID;
	
	public Integer getMegNum() {
		return megNum;
	}
	public void setMegNum(Integer megNum) {
		this.megNum = megNum;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getSendDate() {
		return sendDate;
	}
	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}
	public int getReadCheck() {
		return readCheck;
	}
	public void setReadCheck(int readCheck) {
		this.readCheck = readCheck;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getReceiverID() {
		return receiverID;
	}
	public void setReceiverID(String receiverID) {
		this.receiverID = null;
		this.receiverID = receiverID;
	}
	
	@Override
	public String toString() {
		String result = "[megNum = " + megNum + ", title = " + title + ", sendDate = " + sendDate +
				", read_check = " + readCheck + ", content ="  + content + ", userID = " + userID + 
				", receiverID = " + receiverID + "]";
		return result;
	}
	
	
}
