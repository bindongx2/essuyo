<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>

<head>

<title>Essuyo</title>
<link rel="icon" type="image/png" sizes="16x16" href="/resources/images/backpack.png">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR">
<link rel="stylesheet" href="/resources/css/simple-line-icons.css">
<link rel="stylesheet" href="/resources/css/themify-icons.css">
<link rel="stylesheet" href="/resources/css/set1.css">
<link rel="stylesheet" href="/resources/css/swiper.min.css">
<link rel="stylesheet" href="/resources/css/magnific-popup.css">
<link rel="stylesheet" href="/resources/css/style.css">
<link rel="stylesheet" href="/resources/css/style.min.css" >
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	

</head>

<body>
	<%@ include file="/pageframe/header.jsp"%>

	<form id="product-form" action="/product/register" method="POST" enctype="multipart/form-data">
	<section class="reserve-block">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<h5>
						<input class="form-control" type="text" name="name" id="name" placeholder="상품명" >
					</h5>
					<br> <input class="form-control" type="text" name="discription" id="name" placeholder="상품 설명">
				</div>

			</div>
		</div>
	</section>

	<section class="light-bg booking-details_wrap">
		<div class="container">

				<ul>
					<li style="display: inline-block">
						<a id="image-minus" class="nav-link" href="javascript:void(0)">
							<span class="icon-minus"></span>
						</a>
					</li>
					<li style="display: inline-block">
						<div id="imageList" class="row"></div>
					</li>
					<li style="display: inline-block">
						<a id="image-plus" class="nav-link" href="javascript:void(0)">
							<span class="icon-plus"></span>
						</a>
					</li>
				</ul>


				<input type="file" name="fileList" id="multipleFile" data-max="3" data-min="3" multiple/>

			
					
				<div class="row">
					<div class="col-md-8 responsive-wrap">

						<div id="item" class="booking-checkbox_wrap">
							<div class="row">

								<div class="col-md-12">

									<p style="font-size: 20px">
										<span class="icon-calendar"></span>&nbsp;&nbsp;판매 날짜
									</p>

									<input style="width: 48%;" type="text"
										name="saleStartDate" id="startDate" class="input-border" placeholder="시작일" readOnly>
									<input style="width: 48%;" type="text"
										name="saleEndDate" id="endDate" class="input-border" placeholder="종료일" readOnly>

								</div>
								<hr>
								<div class="col-md-12">

									<p style="font-size: 20px">
										<span class="icon-list"></span>&nbsp;&nbsp;수량
									</p>
									<ul>
										<li style="display: inline-block"><a id="minus"
											class="nav-link" href="javascript:void(0)"><span
												class="icon-minus"></span></a></li>
										<li style="display: inline-block"><input id="count"
											name="productCount" style="text-align: center; border: none;"
											size="2" type="text" value="0" readOnly></li>
										<li style="display: inline-block"><a id="plus"
											class="nav-link" href="javascript:void(0)"><span
												class="icon-plus"></span></a></li>
									</ul>
								</div>
								<hr>
								<div class="col-md-12">
									<p style="font-size: 20px">
										<span class="icon-wallet"></span>&nbsp;&nbsp;가격
									</p>
									<input type="text" name="price" id="price" class="form-control">
								</div>
								
								<div class="col-md-10">
									
								</div>
								<div class="col-md-2">
									<input type="submit" class="form-control" value="등록">
								</div>
							</div>
						</div>
					</div>

				</div>
		</div>
	</section>
</form>

	<!--//END BOOKING DETAILS -->

	<script src="/resources/js/jquery/jquery.js"></script>
	<script src="/resources/js/jquery/jquery.min.js"></script>
    <script src="/resources/js/popper/umd/popper.min.js"></script>
    <script src="/resources/js/bootstrap/bootstrap.min.js"></script>
	<script src="/resources/js/jquery/jquery.magnific-popup.js"></script>
	<script src="/resources/js/swiper.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"
		integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="
		crossorigin="anonymous"></script>
	<script src="/resources/js/datepicker-ko.js"></script>
	<script src="/resources/js/utility.js"></script>
	

    
    
	<script>
	
$(document).ready(function() {
		
	initImageFrame();
	
	$("#image-plus").on("click", function() {
		var max = $("#multipleFile").data("max");
		
		if( max < 12 ){
			$("#multipleFile").data("max",max+1);
			initImageFrame();	
		}else{
			myAlert("INFOMATION !" ,"최대 12개 입니다.");
		}
	});
	
	$("#image-minus").on("click", function() {
		var max = $("#multipleFile").data("max");
		var min = $("#multipleFile").data("min");
		if( max > min ){
			$("#multipleFile").data("max",max-1);
			initImageFrame();	
		}else{
			myAlert("INFOMATION !" ,"최소 3개 입니다.");
		}
	});
	
	
			
			$("#startDate").datepicker({
					showAnim : "slideDown",
					minDate : 0,
					maxDate : new Date("${product.saleEndDate}"),
			});

			$("#endDate").datepicker({
					showAnim : "slideDown",
					minDate : 0,
					maxDate : new Date("${product.saleEndDate}"),
			});

	
			$("#plus").on("click", function() {
										
				var count = parseInt($("#count").val());
				if( count <= 9){
					count += 1;
					$("#count").val(count);
								
					$(".toggle-string").show();
					$("#productCount").val(count);
	
					
				}
			});
			$("#minus").on("click", function() {
				var count = parseInt($("#count").val());
				if( count != 0){
					count -= 1;
					$("#count").val(count);
					
					$(".toggle-string").show();
					$("#productCount").val(count);
				}			
			});
			
			//< 유저 썸네일
	   		ImageThumbnail("#productImage-","#multipleFile");
			
});

function initImageFrame(){
	$("#imageList").empty();
	var max = $("#multipleFile").data("max");
	
	for(var i=0; i<max; i++){
		var html = '<div class="col-md-1">'
		+ '<img style="border-style:dashed"'
		+ 'id="productImage-' + i + '" src="/resources/images/placeholder-image.png" class="img-fluid" alt="#"></div>'
		
		$("#imageList").append(html);
	}
}
</script>

	<script>
	var swiper = new Swiper('.swiper-container', {
			slidesPerView : 3,
			slidesPerGroup : 3,
			loop : true,
			loopFillGroupWithBlank : true,
			pagination : {
				el : '.swiper-pagination',
				clickable : true,
			},
			navigation : {
				nextEl : '.swiper-button-next',
				prevEl : '.swiper-button-prev',
			}
		});
	
	</script>
	
	<%@ include file="/pageframe/footer.jsp"%>
</body>

</html>

