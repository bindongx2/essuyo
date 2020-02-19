package com.webproject.essuyo.domain;

public class SQLParamVO {

	private String type;
	private int id;
	private int start;
	private int limit;


	
	
	public SQLParamVO() {

	}
	public SQLParamVO(String type, int id) {
		this.type = type;
		this.id = id;
	}
	
	public SQLParamVO(String type, int id,int start) {
		this.type = type;
		this.id = id;
		this.start = start;
	}
	
	public SQLParamVO(String type, int id, int start, int limit) {
		this.type = type;
		this.id = id;
		this.start = start;
		this.limit = limit;
	}
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getLimit() {
		return limit;
	}
	public void setLimit(int limit) {
		this.limit = limit;
	}
	
	
	@Override
	public String toString() {
		return "SQLParamVO [type=" + type + ", id=" + id + ", start=" + start + ", limit=" + limit + "]";
	}
	


}
