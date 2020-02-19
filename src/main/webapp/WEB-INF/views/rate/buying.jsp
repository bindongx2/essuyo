<%@page import="com.sun.xml.internal.bind.v2.schemagen.xmlschema.Import"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>배당 사이트</title>
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
						<h4 class="page-title">구매 사이트</h4>
					</div>
				</div>

				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-12 col-xlg-12 col-md-12">
							<div class="card">
								<div class="card-body">
									<form role="form" method="get">
										<div>
										</div>

										<div class="table-responsive">

											<table class="table table-hover">
												<thead>
													<tr>
														<th scope="col">C/S</th>
														<th scope="col">번호</th>
														<th scope="col">말 이름</th>
														<th scope="col">배당률</th>
														<th scope="col">배당률</th>
														<th scope="col">배당률</th>
														<th scope="col">배당률</th>
														<th scope="col">배당률</th>
														<th scope="col">금액</th>
													</tr>
												</thead>
												
												<tbody>
													<c:forEach items="${list}" var="list">
														<tr>
															<td><input type="checkbox"></td>
															<td>${list.id}</td>
															<td>스피드 스타</td>
															<td>${list.id}</td>
															<td>${list.id}</td>
															<td>${list.id}</td>
															<td>${list.horse_name }</td>
															<td>
<!-- 																<input type="text" id="rating" value="0"> -->
															</td>
															<td>
																<input type="text" name="money">
															</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
											<span style = "text-align: right">
												<input style="text-align: right" type="text" id="total_money" value ="0" placeholder="총액">													
											</span>
											
											<span style="text-align: middle">
												<input id = "submit" style="align-content: right; height:30px; width:50px"  type="submit" value="결제" onclick="approve();">
												<input id = "cancel" style="align-content: right; height:30px; width:50px"  type="submit" value="취소">
											 </span>
<!-- 											<input type="hidden" id="total_money"> -->
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
	<script src="../resources/js/bootstrap/bootstrap.min.js"></script>
	<script src="../resources/js/sparkline.js"></script>
	<script src="../resources/js/userpage/waves.js"></script>
	<script src="../resources/js/userpage/sidebarmenu.js"></script>
	<script src="../resources/js/userpage/custom.min.js"></script>
	<script src="../resources/js/utility.js"></script>



	<script>
	$(document).ready(function() {
		
    });
	
		//null일 경우 0으로 받아옴
		function Null2zero(value){
			if(value == null || value == "" || value == "NaN" || value == undefined){
				return 0;
			}
			return value;
		}
		
	
	
	function approve(){
		for(var i=0; i < 5; i++){
		  var total_money = $("#total_money").val();
		  var part_money = $("input[name=money]:eq(" + i + ")").val(); 
		 
		  total_money = parseInt(Null2zero(total_money)) + parseInt(Null2zero(part_money));
		  alert("total_money : " + total_money);
		  $("#total_money").val(total_money);
		}
		
		document.form1.total_money.value = total_money;
// 		alert("test : " + document.form1.total_money.value);
		form1.submit();	
	}
	
	
	</script>
	
	
<form name ="form1" action="main.jsp">
	<input type="hidden" name ="total_money">
</form>
</body>
</html>