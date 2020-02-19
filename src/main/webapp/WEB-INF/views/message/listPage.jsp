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

.pagination a:hover:not(.active) {
    background-color: #ddd;
    border-radius: 5px;
}
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
					<div class="col-5 align-self-center">
						<h4 class="page-title">전체 메시지함</h4>
					</div>
				</div>

				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-12 col-xlg-12 col-md-12">
							<div class="card">
								<div class="card-body">
									<form role="form" method="get">
										<div>
											<button type="submit" class="btn allBtn"
												style="float: left; text-align: center; text-color: white; background-color: #D8D8D8; border-radius: 1px;">
												전체 메시지함</button>
											<button type="submit" class="btn sentBtn"
												style="float: left; text-align: center; text-color: white; background-color: #D8D8D8; border-radius: 1px;">
												받은 메시지함</button>
											<button type="submit" class="btn receivedBtn"
												style="float: left; text-align: center; text-color: white; background-color: #D8D8D8; border-radius: 1px;">
												보낸 메시지함</button>
										</div>


										<div class="table-responsive">

											<table class="table table-hover">
												<thead>
													<tr>
														<th scope="col">번호</th>
														<th scope="col">제목</th>
														<th scope="col">받은사람</th>
														<th scope="col">보낸사람</th>
														<th scope="col">보낸 날짜</th>
														<th scope="col">확인</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${list }" var="MessageVO">
														<tr>
															<td>${MessageVO.megNum }</td>
															<td><a href='/message/readPage${pageMaker.listMakeQuery(pageMaker.listCri.page)}&megNum=${MessageVO.megNum }'>
																	${MessageVO.title } </a></td>
															<td>${MessageVO.receiverID }</td>
															<td>${MessageVO.userID }</td>
															<td><fmt:formatDate pattern="yyyy-MM-dd hh:mm"	value="${MessageVO.sendDate }" /></td>

															<c:if test="${MessageVO.readCheck == 1 }">
																<td><strong><span class="badge bg-red">읽음</span></strong></td>
															</c:if>
															<c:if test="${MessageVO.readCheck == 0 }">
																<td><span class="badge bg-red">읽지 않음</span></td>
															</c:if>
														</tr>
													</c:forEach>

												</tbody>
											</table>
										</div>


										<div class="pageNum" align="center">
											<ul class="pagination">
												<c:if test="${pageMaker.prev }">
													<li><a
														href="listPage${pageMaker.listMakeQuery(pageMaker.startPage -1) }">&laquo;</a>
													</li>
												</c:if>

												<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
													<li>
														<a href="listPage${pageMaker.listMakeQuery(idx)}">${idx }</a>
													</li>
												</c:forEach>

												<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
												<li><a href="listPage${pageMaker.listMakeQuery(pageMaker.endPage+1)}">&raquo;</a></li>
											</c:if>
											</ul>
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
	<script src="/resources/js/jquery/jquery-3.2.1.min.js"></script>
	<script src="../resources/js/jquery/jquery.min.js"></script>
	<script src="../resources/js/popper/umd/popper.min.js"></script>
	<script src="../resources/js/bootstrap/bootstrap.min.js"></script>
	<script src="../resources/js/sparkline.js"></script>
	<script src="../resources/js/userpage/waves.js"></script>
	<script src="../resources/js/userpage/sidebarmenu.js"></script>
	<script src="../resources/js/userpage/custom.min.js"></script>
	<script src="../resources/js/utility.js"></script>

	<script>
		var result = '${msg}';

		if (result == 'SUCCESS') {
			myAlert("DELETE","삭제가 완료되었습니다.");
		}
	</script>


	<script>
		$(document).ready(function() {
			var formObj = $("form[role='form']");

			console.log(formObj);
			$(".allBtn").on("click", function() {
				formObj.attr("action", "/message/listPage");
				formObj.submit();
			});
			console.log(formObj);
			$(".sentBtn").on("click", function() {
				formObj.attr("action", "/message/recevieMeg");
				formObj.submit();
			});
			console.log(formObj);
			$(".receivedBtn").on("click", function() {
				formObj.attr("action", "/message/sendMeg");
				formObj.submit();
			});
		});
	
	</script>

</body>
</html>