package com.webproject.essuyo.utility;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellType;


public class Download {
	
	public static List<List<String>> getExcelDataMap(){
		List<List<String>> resultList = new ArrayList<List<String>>();
		
		InputStream is = null;
		OutputStream os = null;
		
		try {
			String filePath = "C:\\Users\\HSJ\\git\\essuyo\\src\\main\\webapp\\resources\\excel\\test.xls";
				
			is = new FileInputStream(filePath);
			HSSFWorkbook book = new HSSFWorkbook(is);
			HSSFSheet sheet = book.getSheetAt(0);
			HSSFRow row;		//행
			HSSFCell cell;		//셀
			
			System.out.println("row count : " + sheet.getPhysicalNumberOfRows());
			for(int i = 0; i< sheet.getPhysicalNumberOfRows();i++) {
				row = sheet.getRow(i);
				
				if(row != null){
					// 셀값을 저장할 리스트
					List<String> cellList = new ArrayList<String>();
//					int cells = row.getPhysicalNumberOfCells();		
					int cells = row.getLastCellNum();				//빈셀 인식해서 셀에 저장된 마지막 숫자 계산
					System.out.println("cell count : " + cells);
					
	                for(int c = 0; c < cells; c++){
	                    cell = row.getCell(c);
	                    System.out.println("셀값 : " + cell);
	                    if(cell != null){
	                    	cell.setCellType(CellType.STRING);
	                        cellList.add(cell.getStringCellValue());      
	                    }else{
	                        cellList.add("");
	                    }
	                }
	                
	                System.out.println(cellList);
				}	
			}
			
		book.close();
		
		}catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		} finally {
			
			if(os != null) try { os.close(); } catch (IOException e) { };
			if(is != null) try { is.close(); } catch (IOException e) { };
			
		}
		
		return resultList;
			
	}
}


