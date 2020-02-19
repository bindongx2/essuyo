package com.webproject.essuyo.utility;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

public class Excel{

	//엑셀파일을 읽어서 Workbook객체에 리턴한다.
	public static Workbook getWorkbook(String filePath) {
			
			FileInputStream fis = null;
			
			try {
				fis = new FileInputStream(filePath);
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
			
			Workbook wb = null;
			
			
			if(filePath.toUpperCase().endsWith(".XLS")) {
				try {
					wb = new HSSFWorkbook(fis);
				} catch (IOException e) {
					e.printStackTrace();
				}
				
			}else if(filePath.toUpperCase().endsWith(".XLSX")) {
				try {
					wb = new XSSFWorkbook(fis);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			return wb;
		}
	
	//엑셀파일에 셀값들 가져오기
	@RequestMapping(value ="/excel/file", method= RequestMethod.POST)
	public static List<Object> getExcelDataMap(String savePath, String fileName){
		System.out.println("ExcelDataMap !!! Cell데이터 가져오기@@");
		
		String filePath = savePath + "/" + fileName;
		System.out.println("filePath : " + filePath);
//		List<List<String>> resultList = new ArrayList<List<String>>();
		List<Object> cellList = new ArrayList<>();
		InputStream is = null;
		OutputStream os = null;
		
		try {
			if(filePath.toUpperCase().endsWith(".XLS")) {
				System.out.println("ExcelDataMap !!! XlS확장자@@");
				
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
						int cells = row.getLastCellNum();				//빈셀 인식해서 셀에 저장된 마지막 숫자 계산
						System.out.println("cell count : " + cells);
						
		                for(int c = 0; c < cells; c++){
		                    cell = row.getCell(c);
		                    if(cell != null){
			                    Map<String, Object> map = new HashMap<String, Object>();
		                    	cell.setCellType(CellType.STRING);
		                    	map.put("x",i);
		                    	map.put("y", c);
		                    	map.put("value", cell);
		                    	
		                        cellList.add(map);      
		                    }else{
//		                        cellList.add("");
		                    }
		                }
		                
		                System.out.println("cellList : " + cellList);
					}	
				}
				book.close();
				
			}else if(filePath.toUpperCase().endsWith(".XLSX")) {
				System.out.println("ExcelDataMap !!! XlSX확장자@@");
				is = new FileInputStream(filePath);
				XSSFWorkbook book = new XSSFWorkbook(is);
				XSSFSheet sheet = book.getSheetAt(0);
				XSSFRow row;
				XSSFCell cell;
				
				System.out.println("row count : " + sheet.getPhysicalNumberOfRows());

				for(int i = 0; i< sheet.getPhysicalNumberOfRows();i++) {
					row = sheet.getRow(i);
					
					if(row != null){
						// 셀값을 저장할 리스트
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
				
			}	
		
		}catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		} finally {
			if(os != null) try { os.close(); } catch (IOException e) { };
			if(is != null) try { is.close(); } catch (IOException e) { };
		}
		
		return cellList;
	}
	
	
	//파일, 파일이름으로 지정된 위치(SAVE_PATH)에 파일 생성
	public static boolean writeFile(MultipartFile multipartFile,String savePath, String fileName)throws IOException{
		boolean result = false;
		
		byte[] data = multipartFile.getBytes();
		FileOutputStream fos = new FileOutputStream(savePath + "/" + fileName);
		fos.write(data);
		fos.close();
		System.out.println("파일생성 성공!");
		return result;
	}
	
}
