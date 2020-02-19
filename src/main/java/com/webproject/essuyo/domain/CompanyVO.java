package com.webproject.essuyo.domain;

public class CompanyVO {

	private int id; /* 번호 */
	private String name; /* 이름 */
	private String type; /* 회사 종류 */
	private String discription; /* 설명 */
	private float score; /* 점수 */
	private String address; /* 주소 */
	private String number; /* 전화번호 */
	private String homepage; /* 홈페이지 */
	private String state; /* 영업상태 */
	private String time; /* 영업시간 */
	private int areaListId; /* 지역명목록번호 */
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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDiscription() {
		return discription;
	}
	public void setDiscription(String discription) {
		this.discription = discription;
	}
	public float getScore() {
		return score;
	}
	public void setScore(float score) {
		this.score = score;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public String getHomepage() {
		return homepage;
	}
	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}

	public int getAreaListId() {
		return areaListId;
	}
	public void setAreaListId(int areaListId) {
		this.areaListId = areaListId;
	}
	@Override
	public String toString() {
		return "CompanyVO [id=" + id + ", name=" + name + ", type=" + type + ", discription=" + discription + ", score="
				+ score + ", address=" + address + ", number=" + number + ", homepage=" + homepage + ", state=" + state
				+ ", time=" + time + ", areaListId=" + areaListId + "]";
	}

}
