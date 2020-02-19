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
						<h4 class="page-title">메시지 읽기</h4>
					</div>
				</div>

				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-4 col-xlg-3 col-md-5">
							<div class="card">
								<div class="card-body">
									<form role="form" method="get">
										<input type="hidden" name='megNum' value="${messageVO.megNum }">
									
										<div class="box-body">
											<div class="form-group">
												<label for="exInputWriter"> 보낸 사람 </label> 
												<input type="text" id="userID" name="writer" class="form-control"
													value="${messageVO.userID }" readonly="readonly">
											</div>
											<div class="form-group">
												<label for="exInputWriter"> 받은 사람 </label> 
												<input type="text" id="receiverID" name="receiver"
													class="form-control" value="${messageVO.receiverID }" readonly="readonly">
											</div>
											<div class="form-group">
												<label for="exInputTitle"> 제목 </label> 
												<input type="text" name='title' class="form-control" value="${messageVO.title }" readonly="readonly">
											</div>
											<div class="form-group">
												<label for="exInputContent"> 내용 </label>
												<textarea class="form-control" name="content" rows="10"	readonly="readonly">${messageVO.content }</textarea>
											</div>

										</div>

										<div class="box-footer">
											<button type="submit" class="btn btn-info" name="btn-info" Onclick="javascript:history.listCheck()">
												목록</button>
											
												<button type="submit" class="btn btn-warning" name="btn-warning" id="replyBtn">
													<a href="/message/replyPage?userID=${messageVO.receiverID }&receiverID=${messageVO.userID }"
														style="color: white">
														답장
													</a>
												</button>
											
											<button type="submit" class="btn btn-danger" name="btn-danger" style="float: right;">
												삭제</button>
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

	<!-- jquery 추가 -->
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
		
		var referrer = document.referrer;
		
		if (referrer.substring(21) == "/message/recevieMeg?") {
			$(".btn-info").on("click", function() {
			formObj.attr("method", "get");
			formObj.attr("action", "/message/recevieMeg");
			formObj.submit();
			});
		} else if (referrer.substring(21) == "/message/sendMeg?") {
			$(".btn-info").on("click", function() {
				formObj.attr("method", "get");
				formObj.attr("action", "/message/sendMeg");
				formObj.submit();
			});
		} else {
			$(".btn-info").on("click", function() {
				formObj.attr("method", "get");
				formObj.attr("action", "/message/listPage");
				formObj.submit();
			});
		}
		
		$(".btn-danger").on("click", function() {
			formObj.attr("action", "/message/removePage");
			formObj.submit();
		});
		
		// 답장 버튼
		var sender = $('#userID').val();
		var nowUserID = "<%=session.getAttribute("login") %>"
		
		if(sender == nowUserID){
			$("#replyBtn").hide();
		}else{
			$("#replyBtn").show();
		}
	});
	
	function listCheck(){
		var referrer = document.referrer;
		
		if (referrer.substring(21) == "/message/recevieMeg?") {
			$(".btn-info").on("click", function() {
			formObj.attr("method", "get");
			formObj.attr("action", "/message/recevieMeg");
			formObj.submit();
			});
		} else if (referrer.substring(21) == "/message/sendMeg?") {
			$(".btn-info").on("click", function() {
				formObj.attr("method", "get");
				formObj.attr("action", "/message/sendMeg");
				formObj.submit();
			});
		} else {
			$(".btn-info").on("click", function() {
				formObj.attr("method", "get");
				formObj.attr("action", "/message/listPage");
				formObj.submit();
			});
		}
	}
	
	</script>
</body>
</html>