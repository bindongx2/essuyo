<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!-- Favicon icon -->
<link rel="icon" type="image/png" sizes="16x16"
	href="/resources/images/favicon.png">
<link href="/resources/css/chartist/chartist.min.css" rel="stylesheet">
<link href="/resources/css/style.min.css" rel="stylesheet">
<link href="/resources/css/simple-line-icons.css" rel="stylesheet">

<title>댓글 관리</title>
</head>
<body>
	<%@ include file="/pageframe/header.jsp"%>

	<form role="form" method="POST" action="/comment/writerComment"
		onsubmit="return checkValue();">
		<div class="box-body">
			<div class="form-group">
				<label for="exInputWriter"> WRITER </label>
				<!-- 발송자 아이디 받아오기 -->
				<input type="text" name='userId' class="form-control"
					value="${commentVO.userId }" readonly="readonly">
			</div>
			<div class="form-group">
				<input type="hidden" name='companyId'
					value="${commentVO.companyId }">
			</div>
			<div class="form-group">
				<label for="exInputTitle"> TITLE </label> <input type="text" id="title"
					name='title' class="form-control" placeholder="Enter Title">
			</div>
			<div class="form-group">
				<label for="exInputContent"> CONTENT </label>
				<textarea class="form-control" name="content" rows="3" id="content"
					placeholder="Enter Content"></textarea>
			</div>
			<div class="form-group">
				<label for="exInputWriter"> SCORE </label> <select name="score" 
					id="score">
					<option value="0">☆☆☆☆☆</option>
					<option value="1">★☆☆☆☆</option>
					<option value="2">★★☆☆☆</option>
					<option value="3">★★★☆☆</option>
					<option value="4">★★★★☆</option>
					<option value="5">★★★★★</option>
				</select>
			</div>

		</div>

		<div class="box-footer">
			<button type="submit" class="btn btn-primary"
				style="float: right; text-align: center; text-color: white; background-color: gray; border-radius: 5px gray;">
				SEND</button>
			<button type="button" class="btn btn-cancel"
				Onclick="javascript:history.back(-1)"
				style="float: left; text-align: center; text-color: white; background-color: gray; border-radius: 5px gray;">
				CANCEL</button>
		</div>
	</form>

	<%@ include file="/pageframe/footer.jsp"%>

	<script type="text/javascript">
		$(document).ready(function() {
			var formObj = $("form[role='form']");

			console.log(formObj);
			$(".btn-primary").on("click", function() {
				formObj.attr("action", "/comment/writerComment");
				formObj.submit();
			});
		});
		function checkValue() {
			var title = document.getElementById("title").value;
			var content = document.getElementById("content").value;

			if (title == "" || title == null) {
				myAlert("ERROR", "제목을 입력해주세요!");
				title.focus();
				return false;
			}
			if (content == "" || content == null) {
				myAlert("ERROR", "댓글 내용을 입력해주세요!");
				content.focus();
				return false;
			}
		}
	</script>

</body>
</html>