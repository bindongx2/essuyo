package com.webproject.essuyo.domain;

public class ProductVO {

	private int id; 				/* 번호 */
	private String name;			/* 이름 */
	private String saleStartDate;	/* 판매 시작 일자 */
	private String saleEndDate;	/* 판매 종료 일자  */
	private String discription; 	/* 설명 */
	private int price; 				/* 가격 */
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
	public String getSaleStartDate() {
		return saleStartDate;
	}
	public void setSaleStartDate(String saleStartDate) {
		this.saleStartDate = saleStartDate;
	}
	public String getSaleEndDate() {
		return saleEndDate;
	}
	public void setSaleEndDate(String saleEndDate) {
		this.saleEndDate = saleEndDate;
	}
	public String getDiscription() {
		return discription;
	}
	public void setDiscription(String discription) {
		this.discription = discription;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	@Override
	public String toString() {
		return "ProductVO [id=" + id + ", name=" + name + ", saleStartDate=" + saleStartDate + ", saleEndDate="
				+ saleEndDate + ", discription=" + discription + ", price=" + price + "]";
	}
	
	

	
}
