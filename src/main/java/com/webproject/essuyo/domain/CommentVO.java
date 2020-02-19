package com.webproject.essuyo.domain;

public class CommentVO {
	
	private int id;
	private String title;
	private String content;
	private int helpful;
	private int score;
	private String modDate;
	private String regDate;
	private int userId;
	private int companyId;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public int getHelpful() {
		return helpful;
	}
	public void setHelpful(int helpful) {
		this.helpful = helpful;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getModDate() {
		return modDate;
	}
	public void setModDate(String modDate) {
		this.modDate = modDate;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getCompanyId() {
		return companyId;
	}
	public void setCompanyId(int companyId) {
		this.companyId = companyId;
	}
	@Override
	public String toString() {
		return "CommentVO [id=" + id + ", title=" + title + ", content=" + content + ", helpful="
				+ helpful + ", score=" + score + ", modDate=" + modDate + ", regDate=" + regDate + ", userId=" + userId
				+ ", companyId=" + companyId + "]";
	}
	
	

}
