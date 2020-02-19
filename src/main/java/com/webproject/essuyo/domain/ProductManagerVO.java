package com.webproject.essuyo.domain;

public class ProductManagerVO {
	private int id;
	private String saleDate;
	private int count;
	private int productId;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSaleDate() {
		return saleDate;
	}
	public void setSaleDate(String saleDate) {
		this.saleDate = saleDate;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	@Override
	public String toString() {
		return "ProductManagerVO [id=" + id + ", saleDate=" + saleDate + ", count=" + count + ", productId=" + productId
				+ "]";
	}
	
	
	
	

}
