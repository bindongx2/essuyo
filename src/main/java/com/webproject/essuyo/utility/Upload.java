package com.webproject.essuyo.utility;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.core.io.FileSystemResource;
import org.springframework.web.servlet.view.document.AbstractXlsView;

import net.sf.jxls.transformer.XLSTransformer;


public class Upload extends AbstractXlsView {
	
	@Override
	protected void buildExcelDocument(Map<String, Object> map, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setHeader("Content-Type", "application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename=cert06.xls");
		
		InputStream is = null;
		OutputStream os = null;
		String filePath = "C:\\Users\\HSJ\\git\\essuyo\\src\\main\\webapp\\resources\\excel\\cert06.xls";
//		String filePath = "../../git/essuyo/src/main/webapp/resources/excel/cert06.xls";
		
		try {	
		is = new FileSystemResource(filePath).getInputStream();
		os = response.getOutputStream();
		
		XLSTransformer transformer = new XLSTransformer();
		
			Workbook excel = transformer.transformXLS(is, map);
			excel.write(os);
			os.flush();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		} finally {
			if(os != null) try { os.close(); } catch (IOException e) { };
			if(is != null) try { is.close(); } catch (IOException e) { };
			
		}
		
		
	}
}
