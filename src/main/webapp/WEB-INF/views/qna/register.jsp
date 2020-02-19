<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
					<div class="col-5 align-self-center">
						<h4 class="page-title"> Q&A 작성하기</h4>
						<hr>
					</div>
				</div>

				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-4 col-xlg-3 col-md-5">
							<div class="card">
								<div class="card-body">
									<form role="form" method="POST" action="/qna/registerSend"  onsubmit="return checkValue();">
										<div class="box-body">
											<div class="form-group">
												<label for="exInputWriter"> 작성자 </label>
												<!-- 아이디 받아오기 -->
												<input type="text" name='userId' class="form-control"
													value="${qnaVO.userId}" readonly="readonly">
											</div>											
											<div class="form-group">
												<label for="exInputTitle"> 제목 </label>
												 <input type="text"	name='title' class="form-control" id='title' placeholder="Enter Title">
											</div>
											<div class="form-group">
												<label for="exInputContent"> 내용 </label>
												<textarea class="form-control" id=" content" name="content" rows="10" placeholder="Enter Content"></textarea>
											</div>
										</div>
										<div class="box-footer">

											<button type="button" class="btn btn-info" style="float: right;" onclick="nullCheck()">작성</button>
											<button type="button" class="btn btn-danger" Onclick="javascript:history.back(-1)" style="float: left;">취소</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
		<script src="../resources/js/jquery/jquery.min.js"></script>
		<script src="../resources/js/popper/umd/popper.min.js"></script>
		<script src="../resources/js/bootstrap/bootstrap.min.js"></script>
		<script src="../resources/js/sparkline.js"></script>
		<script src="../resources/js/userpage/waves.js"></script>
		<script src="../resources/js/userpage/sidebarmenu.js"></script>
		<script src="../resources/js/userpage/custom.min.js"></script>
		<script src="../resources/js/utility.js"></script>

		<script>
			$(document).ready(function() {
				var formObj = $("form[role='form']");

				console.log(formObj);
				$(".btn-info").on("click", function() {
					formObj.attr("action", "/qna/registerSend");
					formObj.submit();
				});
			});
			
			
			function checkValue() {
				var title = document.getElementById("title").value;

					myAlert("ERROR","제목을 입력해주세요!");
				if (title == "" || title == null) {
					title.focus();
					return false;
				}
				
			}
			
			// 제출 버튼 클릭시 온클릭 함수(제목 null값 체크후 submit)
			function nullCheck(){
				checkValue();
				form.submit();
			}
			
			
		</script>
</body>
</html>