package com.webproject.essuyo.domain;

public class SeatVO {

	private int locX; 				/* x축 위치   */
	private int locY; 				/* y축 위치   */
	private String seatNum; 		/* 좌석 번호  */
	private String facBGColor; 		/* 배경 색깔  */
	private String is_FAC; 			/* 좌석,시설물 구분값   */

	@Override
	public String toString() {
		return null;
	}

	public int getLocX() {
		return locX;
	}

	public void setLocX(int locX) {
		this.locX = locX;
	}

	public int getLocY() {
		return locY;
	}

	public void setLocY(int locY) {
		this.locY = locY;
	}

	public String getSeatNum() {
		return seatNum;
	}

	public void setSeatNum(String seatNum) {
		this.seatNum = seatNum;
	}

	public String getFacBGColor() {
		return facBGColor;
	}

	public void setFacBGColor(String facBGColor) {
		this.facBGColor = facBGColor;
	}


	public String getIs_FAC() {
		return is_FAC;
	}

	public void setIs_FAC(String is_FAC) {
		this.is_FAC = is_FAC;
	}
	
}
