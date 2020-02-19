<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%
	out.println("@@@@@   파일업로드   @@@@@ " );
	String path = request.getRealPath("File");
	out.println("절대경로 : " + path);
	
	int size = 1024 * 1024 * 10;
	String fileName = "";
	String originalFileName = "";
	
	try{
		MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
		
		 // 전송한 전체 파일이름들을 가져온다.
        Enumeration files = multi.getFileNames();
        String str = (String)files.nextElement();
        
        //파일명 중복이 발생했을 때 정책에 의해 뒤에 1,2,3 처럼 숫자가 붙어 고유 파일명을 생성한다.
        // 이때 생성된 이름을 FilesystemName이라고 하여 그 이름 정보를 가져온다. (중복 처리)
        fileName = multi.getFilesystemName(str);
        //실제 파일 이름을 가져온다.
        originalFileName = multi.getOriginalFileName(str);

	}catch(Exception e){
        e.printStackTrace();
    }

%>

<script>
	$(document).ready(function(){
		alert("1");
	});
</script>