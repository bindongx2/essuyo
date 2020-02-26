package com.webproject.essuyo.utility;

import java.text.SimpleDateFormat;
import java.util.Date;

public class CommonUtil {

	
	
	//핸드폰 번호 포멧팅 (010-0000-0000)
	public static String phoneFormat(String phoneNo) {
		String result = phoneNo.substring(0,3) + "-" + phoneNo.substring(3,7) + "-" + phoneNo.substring(7, phoneNo.length());
		
		return result;
	}
	
	//날짜 포멧팅  (yyyy-MM-dd)
	public static String dateFormat(Date date, String gubun) {
		SimpleDateFormat formating = new SimpleDateFormat("yyyy" + gubun + "MM" + gubun + "dd");
		String result = formating.format(date);
		
		return result;
	}
	
	//숫자 앞에 숫자포함 5자리까지 0으로 채워주는 함수
	public static String plusZero(int no) {
		    String result = String.format("%05d", no);
		    // 출력 결과: 03
		    return result;
	}
	
	//String을 받아서 문자열인지 숫자인지 체크하는 함수
	public static boolean CheckNumber(String str){
		char check;
		
		if(str.equals(""))
		{
			//문자열이 공백인지 확인
			return false;
		}
		
		for(int i = 0; i<str.length(); i++){
			check = str.charAt(i);
			if( check < 48 || check > 58){
				//해당 char값이 숫자가 아닐 경우 false 리턴
				return false;
			}
			
		}
		//해당 String값이 숫자일 경우 true 리턴
		return true;
	}
	
	
	public static int parseInt(String value, int defaultValue) {
		if(value == null || value.trim().equals("")) {
			return defaultValue;
		}else {
			return Integer.parseInt(value);
		}		
		
	}
}
