<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
 /* 변수 선언 */
 String filePath = "";
 String srcFileName = "";

%>

<%
	String save_dir = "contextPath" + filePath;
	
	File dir = new File(save_dir);
	
	if(!dir.exists()){
		dir.mkdirs();
	}
	
	String filename = "";
	filename = srcFileName;
	
	try{
		File file = new File(save_dir + "/" + filename);
		
		if(file.isFile()){
			byte[] b = new byte[1024];      	//이진파일을 다루려면 getString 하면 안되고, getBytes를 해야 합니다.
			filename = new String(filename.getBytes("utf-8"), "8859_1");
			response.reset();
			response.setContentType("application;");
			response.setHeader("Content-Disposition", "attachment; filename=" + filename + ";");
			
			
			BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
			BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
			
			int read = 0;
			while((read = fin.read(b)) != -1){
				outs.write(b, 0, read);			//write() ==> Buffer에  담은 것을 파일에 I/O합니다.
						
			}
			
			outs.close();
			fin.close();
		}		
	}catch(Exception e){
		e.printStackTrace();
	}


%>
