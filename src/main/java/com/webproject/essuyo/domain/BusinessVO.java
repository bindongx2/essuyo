package com.webproject.essuyo.domain;

public class BusinessVO {

	private int id;
	private int good;
	private String comment;
	private int companyId;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getGood() {
		return good;
	}
	public void setGood(int good) {
		this.good = good;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public int getCompanyId() {
		return companyId;
	}
	public void setCompanyId(int companyId) {
		this.companyId = companyId;
	}
	@Override
	public String toString() {
		return "BusinessVO [id=" + id + ", good=" + good + ", comment=" + comment + ", companyId=" + companyId + "]";
	}

}
