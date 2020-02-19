package com.webproject.essuyo.domain;


public class ReservationVO {
	
	private int id ; 			/* 번호 */
	private String productType;
	private String state; 		/* 상태 */
	private int totalPrice; 	/* 총가격 */
	private String resDate;		/* 예약한날짜 */
	private int productCount;	/* 상품 개수 */
	private String regDate;		/* 등록날짜 */
	private int companyId;		/* 회사_번호 */
	private int productId;		/* 상품_번호 */
	private int userId;			/* 사용자_번호 */
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getProductType() {
		return productType;
	}
	public void setProductType(String productType) {
		this.productType = productType;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	public String getResDate() {
		return resDate;
	}
	public void setResDate(String resDate) {
		this.resDate = resDate;
	}
	public int getProductCount() {
		return productCount;
	}
	public void setProductCount(int productCount) {
		this.productCount = productCount;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public int getCompanyId() {
		return companyId;
	}
	public void setCompanyId(int companyId) {
		this.companyId = companyId;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	@Override
	public String toString() {
		return "ReservationVO [id=" + id + ", productType=" + productType + ", state=" + state + ", totalPrice="
				+ totalPrice + ", resDate=" + resDate + ", productCount=" + productCount + ", regDate=" + regDate
				+ ", companyId=" + companyId + ", productId=" + productId + ", userId=" + userId + "]";
	}


}
