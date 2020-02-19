package com.webproject.essuyo.domain;

public class SeatVO {

	private int seatNum; 		/* 좌석 번호  */
	private int locX; 			/* x축 위치   */
	private int locY; 			/* y축 위치   */

	public int getSeatNum() {
		return seatNum;
	}
	
	public void setSeatNum(int seatNum) {
		this.seatNum = seatNum;
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
	
	@Override
	public String toString() {
		return null;
	}
}
