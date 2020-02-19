package com.webproject.essuyo.domain;

public class MainVO {
	
	private int id; /* 번호 */
	private String name; /* 이름 */
	private int count;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	@Override
	public String toString() {
		return "MainVO [id=" + id + ", name=" + name +", count=" +count +  "]";
	}
	
}


