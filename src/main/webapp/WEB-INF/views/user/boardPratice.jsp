<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>게시판 연습중</title>
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

.page-title {
	 text-align: center; 
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
					<div class="col-12 align-self-center">
						<h4 class="page-title" >※ 유저 명단 </h4>
					</div>
				</div>

				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-12 col-xlg-12 col-md-12">
							<div class="card">
								<div class="card-body">
									<form role="form" method="get">
										<div class="table-responsive">
										
											<table class="table table-hover">
												<thead>
													<tr>
														<th scope="col">번호</th>
														<th scope="col">제목</th>
														<th scope="col">작성자</th>
														<th scope="col">등록 날짜</th>
													</tr>
												</thead>
												<tbody>
<!-- 												내용 -->
												</tbody>
											</table>
										</div>
										
										
										<!-- 페이징 처리 -->
										<div class="text-center">
											<ul class="pagination">
											
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
		if (result == 'success'){
			alert("처리가 완료되었습니다.");
		}
	</script>
</body>
</html>