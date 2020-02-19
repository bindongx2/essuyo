package com.webproject.essuyo.domain;

public class HorseVO {

	private int id; /* 번호 */
	private String horse_name; /* 이름 */

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getHorse_name() {
		return horse_name;
	}
	
	public void setHorse_name(String horse_name) {
		this.horse_name = horse_name;
	}
	@Override
	public String toString() {
		return "HorseVO [id=" + id + ", name=" + horse_name +  "]";
	}

}
