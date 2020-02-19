package com.webproject.essuyo.domain;

import java.util.Date;

public class QnAVO {
	private int id;
	private String title;
	private String content;
	private Date regDate;
	private String userId;
	private int viewCount;

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

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	@Override
	public String toString() {
		return "QnAVO [id=" + id + ", title=" + title + ", content=" + content + ", regDate=" + regDate + ", userId="
				+ userId + ", viewCount=" + viewCount + "]";
	}
}
