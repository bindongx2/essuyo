<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>Essuyo</title>
<link rel="icon" type="image/png" sizes="16x16" href="/resources/images/backpack.png">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../resources/css/style.min.css" rel="stylesheet">
<link href="../resources/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR">
<link rel="stylesheet" href="../resources/css/simple-line-icons.css">
<link rel="stylesheet" href="../resources/css/themify-icons.css">
<link rel="stylesheet" href="../resources/css/set1.css">

<style>
.pagination {
	display: inline-block;
}

.pagination a {
	color: black;
	float: left;
	padding: 8px 16px;
	text-decoration: none;
}

.pagination a.active {
	background-color: #4CAF50;
	color: white;
	border-radius: 5px;
}
.pagination a :hover :not(.active){
	background-color : #ddd;
	border-radius : 5px;
}

.page-title { text-align: center; }
</style>



</head>
<body>
	<div class="preloader">
		<div class="lds-ripple">
			<div class="lds-pos"></div>
			<div class="lds-pos"></div>
		</div>
	</div>

	<div id="main-wrapper" data-navbarbg="skin6" data-theme="light"
		data-layout="vertical" data-sidebartype="full"
		data-boxed-layout="full">

		<%@ include file="/pageframe/admin-navigation.jsp"%>

		<div class="page-wrapper">

			<div class="page-breadcrumb">
				<div class="row">
					<div class="col-12 align-self-center">
						<h4 class="page-title">공지사항 등록</h4>
					</div>
				</div>

				
		<form role = "form" method="post">
			<div class = "form-group">
				<label for="exampleInputEmail1">제목</label>
				<input type="text" name='title' class="form-control" placeholder="Enter Title"> 
			</div>
			<div class="form-group">
				<label for="exampleInputPassword">내용</label>
				<textarea for="form-control" name="content" rows="5" placeholder="Enter..."></textarea>
				</div>
			<div class="form-group">
				<label for="exampleInputEmail1">작성자</label>
				<input type="text" name='userID' class="form-control"
				value="${noticeVO.userID }" readonly="readonly">
			</div>
		
			<div class="box-footer">
				<button type="submit" class="btn btn-primary">Submit</button>
			</div>
		</form>
								
			</div>
		</div>
	</div>
	

	<!-- jquery 추가 -->
	<script src="/resources/js/jquery/jquery-3.2.1.min.js"></script>
	<script src="../resources/js/jquery/jquery.min.js"></script>
	<script src="../resources/js/popper/umd/popper.min.js"></script>
	<script src="../resources/js/bootstrap/bootstrap.min.js"></script>
	<script src="../resources/js/sparkline.js"></script>
	<script src="../resources/js/userpage/waves.js"></script>
	<script src="../resources/js/userpage/sidebarmenu.js"></script>
	<script src="../resources/js/userpage/custom.min.js"></script>
	<script src="../resources/js/utility.js"></script>

	<script type="text/javascript">
	$(document).ready(function() {
		var formObj = $("form[role='form']");
		console.log(formObj);
		$(".allBtn").on("click",function() {
			formObj.attr("action","/message/listPage");
			formObj.submit();
		});
			
		console.log(formObj);
		$(".sentBtn").on("click",function() {
			formObj.attr("action","/message/recevieMeg");
			formObj.submit();
		});
		
		console.log(formObj);
		$(".receivedBtn").on("click",function() {
			formObj.attr("action","/message/sendMeg");
			formObj.submit();
		});
	});
	</script>
</body>
</html>