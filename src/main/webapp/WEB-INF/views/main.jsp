<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Essuyo</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="icon" type="image/png" sizes="16x16" href="/resources/images/backpack.png">
	<link rel="stylesheet" href="resources/css/bootstrap/bootstrap.min.css">
	<link rel="stylesheet" href="resources/css/simple-line-icons.css">
	<link rel="stylesheet" href="resources/css/themify-icons.css">
	<link rel="stylesheet" href="resources/css/set1.css">
	<link rel="stylesheet" href="resources/css/style.css">
	<link rel="stylesheet" href="resources/css/tab.css">
</head>
<body>
		
	<%@ include file="/pageframe/header.jsp"%>


	<section class="slider d-flex align-items-center">
		<div class="container">
			<div class="row d-flex justify-content-center">
				<div class="col-md-12">
					<div class="slider-title_box">
						<div class="row">
							<div class="col-md-12">
								<div class="slider-content_wrap">
									<h1>여행에 모든것 Essuyo!</h1>
									<h5>여행 통합 예약 시스템</h5>
								</div>
							</div>
						</div>
						
						<div class="row d-flex justify-content-center">
							<div class="col-md-10">
								<form class="form-wrap mt-4">
									<div class="btn-group" role="group" aria-label="Basic example">
										<input list="list" placeholder="선택" name="type"
											class="btn-group1" id="listValue">
										<datalist id="list">
											<option value="숙박">
											<option value="식당">
											<option value="문화">
											<option value="차량대여">
										</datalist>
													
										<input type="text" placeholder="ex) 지역:서울,부산,광주,강원도" class="btn-group2" id="inputValue">
									
										
										
										<button type="button" class="btn-form" onclick="button_click()">
											<span class="icon-magnifier search-icon"></span>검색<i
												class="pe-7s-angle-right"></i>
										</button>
									</div>
								</form>
						
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section class="main-block">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-5">
					<div class="styled-heading">
						<h3>카테고리 종류</h3>
					</div>
					<div class="row justify-content-center">
				<div class="col-md-6">
					<div class="featured-btn-wrap">
						<a href='/company/list?type="전체"' class="btn btn-danger">전체 카테고리 검색</a>
					</div>
				</div>
			</div>
				</div>
			</div>
			<div class="row">
			
			<div class="col-md-1">
			</div>

				<div class="col-md-5">
					<div class="row find-img-align">
						<div class="col-md-12">
							<div class="find-place-img_wrap">
								<div class="grid">
									<figure class="effect-ruby">
										<a href="/company/list?type='숙박'"> <img
											src="resources/images/menu-hotel.png" class="img-fluid"
											alt="img13" />
											<figcaption>
												<h5>숙박</h5>
												<p>${companyCount.hotel}개의 목록</p>
											</figcaption></a>
									</figure>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-12">
							<div class="find-place-img_wrap">
								<div class="grid">
									<figure class="effect-ruby">
										<a href="/company/list?type='문화'"> <img
											src="resources/images/menu-museum.png" class="img-fluid"
											alt="img13" />
											<figcaption>
												<h5>문화</h5>
												<p>${companyCount.museum}개의 목록</p>
										</figcaption></a>
									</figure>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="col-md-5">
					<div class="row find-img-align">
						<div class="col-md-12">
							<div class="find-place-img_wrap">
								<div class="grid">
									<figure class="effect-ruby">
										<a href="/company/list?type='식당'"> <img
											src="resources/images/menu-restraunt.png" class="img-fluid"
											alt="img13" />
											<figcaption>
												<h5>식당</h5>
												<p>${companyCount.food}개의 목록</p>
											</figcaption></a>
									</figure>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							<div class="find-place-img_wrap">
								<div class="grid">
									<figure class="effect-ruby">
								<a href="/company/list?type='차량대여'"> <img
											src="resources/images/menu-rentcar.png" class="img-fluid"
											alt="img13" />
											<figcaption>
												<h5>차량대여</h5>
												<p>${companyCount.car}개의 목록</p>
										</figcaption></a>
									</figure>
								</div>
							</div>
						</div>
					</div>
				</div>
				
	<div class="col-md-1">
	</div>
				</div>
				</div>
	</section>



	<section class="main-block light-bg">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-5">
					<div class="styled-heading">
						<h3>랭킹 & 순위</h3>
					</div>
				</div>
			</div>
			<div class="row" style="color: olivedrab">
						
			<c:if test="${ !empty rankCompanyList}" >
			<c:forEach items="${rankCompanyList}" var="company">
				<div class="col-md-3 featured-responsive">
					<h5 style="text-align: center">${company.rankTitle}</h5>
					
							<div class="featured-place-wrap">
								<a href="/company/detail?id=${company.id}"> 
									<img src="${company.image}" class="img-fluid" alt="#">
										<c:choose>
											<c:when test="${company.score <= 2}">
												 <span class="featured-rating">${company.score}</span>
											</c:when>
											<c:when test="${company.score <= 4}">
												 <span class="featured-rating-orange">${company.score}</span>
											</c:when>
											<c:otherwise>
												 <span class="featured-rating-green">${company.score}</span>
											</c:otherwise>
										</c:choose>
										
							<div class="featured-title-box">
								<h6>${company.name}</h6>
								<p>${company.type}</p>
								<span>• </span>
								<p>댓글 ${company.review}개</p>
								<ul>
									<li><span class="icon-location-pin"></span>
										<p>${company.address}</p></li>
									<li><span class="icon-screen-smartphone"></span>
										<p>${company.number}</p></li>
									<li><span class="icon-link"></span>
										<p>${company.homepage}</p></li>

								</ul>
								<div class="bottom-icons">
									<c:choose>
										<c:when test="${company.state == '영업중'}">
											<div class="open-now">${company.state}</div>
										</c:when>
										<c:when test="${company.state == '영업종료'}">
											<div class="closed-now">${company.state}</div>
										</c:when>
									</c:choose>
								</div>
							</div>
						</a>
					</div>
				</div>
				</c:forEach>
			</c:if>
		
			</div>
	
		</div>
	</section>


	<%@ include file="/pageframe/footer.jsp"%>
	<script src="resources/js/jquery/jquery-3.2.1.min.js"></script>
	<script src="resources/js/popper/popper.min.js"></script>
	<script src="resources/js/bootstrap/bootstrap.min.js"></script>
	
	<script>
		$(window).scroll(function() {
			// 100 = The point you would like to fade the nav in.
			if ($(window).scrollTop() > 100) {
				$('.fixed').addClass('is-sticky');
			} else {
				$('.fixed').removeClass('is-sticky');
			}
			;
		});
	</script>
	
<!-- 	검색창 JQuery -->
	<script>
	function button_click() {
		var type = document.getElementById("listValue").value;
		var name =document.getElementById("inputValue").value;
		if(type != "" &&( name != "" &&(name =="서울"|| name=="부산"||name=="광주"||name=="강원도"))){
			document.location.href = "company/list?type=" +'"'+ type+'"' +"&name="+'"'+ name+'"';
		}
	};
	
	$(document).ready(function() {
		var cell = $("div [x='1'][y='2']");
		var seat = $("<input type='text'>");
		seat.attr("x",1);
		seat.attr("y",2);
		cell.append(seat);
	
	});
	
	</script>
</body>

</html>