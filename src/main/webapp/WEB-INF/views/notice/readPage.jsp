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
						<h4 class="page-title">공지사항</h4>
					</div>
				</div>

				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-4 col-xlg-3 col-md-5">
							<div class="card">
								<div class="card-body">
									<form role="form" method="post">
										<input type="hidden" name='noticeNum' value="${noticeVO.noticeNum}">
									</form>
										<div class="box-body">
											<div class="form-group">
												<label for="exampleInputEmail1">작성자</label>
												<input type="text" name="userID" class="form-control" value="${noticeVO.userID}" readonly="readonly">
											</div>
											
											<div class="form-group">
												<label for="exampleInputEmail1">제목</label>
												<input type="text" name="title" class="form-control" value="${noticeVO.title}" readonly="readonly">
											</div>
											<div class="form-group">
												<label for="exampleInputPassword">내용</label>
												<textarea class="form-control" name="content" row="3"  readonly="readonly">${noticeVO.content}</textarea>
											</div>

										</div>
										
									<form role="form" action="modifyPage" method="post">
										<input type='hidden' name='noticeNum' value="${noticeVO.noticeNum }">
										<input type='hidden' name='page' value="${cri.page }">
										<input type='hidden' name='perPageNum' value="${cri.perPageNum }">
									</form>		
								
									<div class="box-footer">
									<c:choose>
										<c:when test="${!empty sessionScope.companyLogin}">
											<button type="submit" class="btn btn-warning modifyBtn">수정</button>
											<button type="submit" class="btn btn-danger removeBtn">삭제</button>
											<button type="submit" class="btn btn-primary goListBtn">목록</button>
										</c:when>
									</c:choose>
									</div>
								
									
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- jquery 추가 -->
	<script src="/resources/js/jquery/jquery-3.2.1.min.js"></script>
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
			
			$(".modifyBtn").on("click", function(){
				formObj.attr("action","/notice/modifyPage");
				formObj.attr("method","get");
				formObj.submit();
			});
			
			$(".removeBtn").on("click", function(){
				formObj.attr("action", "/notice/removePage");
				formObj.submit();
			});

			$(".goListBtn").on("click", function(){
				formObj.attr("method", "get");
				formObj.attr("action", "/notice/listPage");
				formObj.submit();
			})
		});
	</script>
	
	
		
	
</body>
</html>