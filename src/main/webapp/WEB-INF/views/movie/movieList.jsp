<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Essuyo</title>


<link rel="icon" type="image/png" sizes="16x16" href="/resources/images/backpack.png">
<link rel="stylesheet" href="/resources/css/bootstrap/bootstrap.min.css">
<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,400i,500,700,900"
	rel="stylesheet">
<!-- Simple line Icon -->
<link rel="stylesheet" href="/resources/css/simple-line-icons.css">
<!-- Themify Icon -->
<link rel="stylesheet" href="/resources/css/themify-icons.css">
<!-- Hover Effects -->
<link rel="stylesheet" href="/resources/css/set1.css">
<!-- Main CSS -->
<link rel="stylesheet" href="/resources/css/style.css">
<link rel="stylesheet" href="/resources/css/check-box.css">

<!-- 맵 정보창 css -->
 <style type="text/css">
@import url(http://fonts.googleapis.com/css?family=Reenie+Beanie);
#detailInfo {
	width:180px;
	padding:5px;
	margin:auto;
	position:relative;
	background-color:#fe6;
	background:-webkit-gradient(linear, 0% 0%, 0% 100%, from(#fe6), to(#f6ef97), color-stop(.6,#f5da41));
	background:-moz-linear-gradient(top, #fe6, #f5da41, #f6ef97);
	text-shadow:0 1px 0 #F6EF97;
	box-shadow:0 0 5px rgba(0,0,0,.2);
	-webkit-box-shadow:0 0 5px rgba(0,0,0,.2);
	-moz-box-shadow:0 0 5px rgba(0,0,0,.2);
	font-style:italic;
	text-align:center;
}
</style>
</head>
<body>
	<!--============================= HEADER =============================-->
	<%@ include file="/pageframe/header.jsp"%>
	<!--============================= DETAIL =============================-->
	<section>
		<div class="container-fluid">
			<div class="row">
			
				<div class=" responsive-wrap">
					<div class="row detail-filter-wrap">
						<div class="col-md-4 featured-responsive">
						</div>
						<!-- 필터 -->
						<div class="col-md-8 featured-responsive">
							<div class="detail-filter">
								<button class="btn btn-success" id="search">검색</button>
								<div class="map-responsive-wrap">
									<a class="map-icon" href="#"><span
										class="icon-location-pin"></span></a>
								</div>
							</div>
						</div>
					</div>
          
					<!-- 필터 세부사항 div -->
					<div class="row detail-checkbox-wrap">
						
						<div class="col-sm-12 col-md-6 col-lg-4 col-xl-3">
							<label class="custom-control availability-checkbox checkbox-day">
							<input type="checkbox" value="1" name="filter" class="custom-control-input">
								<span class="custom-control-indicator"></span>
								<span> 주차 여부 </span>
							</label>
						</div>
								
						<div class="col-sm-12 col-md-6 col-lg-4 col-xl-3">
							<label class="custom-control availability-checkbox checkbox-day">
							<input type="checkbox" value="2" name="filter" class="custom-control-input">
								<span class="custom-control-indicator"></span>
								<span> wifi 여부 </span>
							</label>
						</div>
						
						<div class="col-sm-12 col-md-6 col-lg-4 col-xl-3">
							<label class="custom-control availability-checkbox checkbox-day">
							<input type="checkbox" value="3" name="filter" class="custom-control-input">
								<span class="custom-control-indicator"></span>
								<span> 흡연  여부 </span>
							</label>
						</div>
						
						<div class="col-sm-12 col-md-6 col-lg-4 col-xl-3">
							<label class="custom-control availability-checkbox checkbox-day">
							<input type="checkbox" value="4" name="filter" class="custom-control-input">
								<span class="custom-control-indicator"></span>
								<span> 카드  여부 </span>
							</label>
						</div>
					</div>	
					
					
							<!-- 판매리스트 div -->
					<div id="salesList" class="row light-bg detail-options-wrap">
						</div>
					</div>

					<!-- 맵 div -->
					<div class="col-md-5 responsive-wrap map-wrap" style="padding-left: 120px; text-align: center;">
						<div style="padding-top: 200px;">
							<input type="text" class = "btn btn-outline-secondary"  style="width: 100px; height: 50px;" value ="12시">
							<input type="text" class = "btn btn-outline-secondary"  style="width: 100px; height: 50px;" value ="14시">
							<input type="text" class = "btn btn-outline-secondary"  style="width: 100px; height: 50px;" value ="14시">
							<input type="text" class = "btn btn-outline-secondary"  style="width: 100px; height: 50px;" value ="14시">
						</div>
						
						<div style="padding-top: 20px;">
							<input type="text" class = "btn btn-outline-secondary"  style="width: 100px; height: 50px;" value ="13시">
							<input type="text" class = "btn btn-outline-secondary"  style="width: 100px; height: 50px;" value ="14시">
							<input type="text" class = "btn btn-outline-secondary"  style="width: 100px; height: 50px;" value ="14시">
							<input type="text" class = "btn btn-outline-secondary"  style="width: 100px; height: 50px;" value ="14시">
						</div>
						
						<div style="padding-top: 20px;">
							<input type="text" class = "btn btn-outline-secondary"  style="width: 100px; height: 50px;" value ="14시">
							<input type="text" class = "btn btn-outline-secondary"  style="width: 100px; height: 50px;" value ="14시">
							<input type="text" class = "btn btn-outline-secondary"  style="width: 100px; height: 50px;" value ="14시">
							<input type="text" class = "btn btn-outline-secondary"  style="width: 100px; height: 50px;" value ="14시">
						</div>
						
					</div>			
			</div>

		</div>
	</section>
	
	<!--//END DETAIL -->
	<!--============================= FOOTER =============================-->
<%-- 	<%@ include file="/pageframe/footer.jsp"%> --%>
	<!--//END FOOTER -->

	<!-- jQuery, Bootstrap JS. -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="/resources/js/jquery/jquery-3.2.1.min.js"></script>
	<script src="/resources/js/popper/popper.min.js"></script>
	<script src="/resources/js/bootstrap/bootstrap.min.js"></script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

	<!-- 	지도API JS -->
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=4fwo13nag1&callback=initMap&submodules=geocoder"></script>
	


	<!-- ajaxJQuery -->
	<script>
	
		function ajax_fuc() {
			
			var values = document.getElementsByName("filter");
			var value = "";
			for(var i=0; i<values.length;i++){
				if(values[i].checked){
					value = value + values[i].value+",";
				}
			}
			
			value = value.slice(0, value.length -1);	
		
			
			$.ajax({
				type : 'GET',
				url : encodeURI('/api/list?start=' + start + "&value=" + value + "&type="+type + "&name="+ name),
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "GET"
				},		 
	            
				success : function(data) {					
					var salesCount = data.salesCount;
					$("#type1").text(type);
					
					if(salesCount === undefined){
						$("#count1").text("");	
					}else{
						$("#count1").text(salesCount+"개의 검색된");				
					}
					
					if(salesCount == 0){
			         	var source1 = $("#templateNone").html();
						var template = Handlebars.compile(source1);						
						$("#salesList").append(template());
						
					} else {
		
						var source = $("#template").html();
						var template = Handlebars.compile(source);
						data.sales.forEach(function(data2) {
							$("#salesList").append(template(data2));
							
							if (data2.score >= 4) {
								$(".score_info").attr('class', 'featured-rating-green');
							} else if (data2.score >= 2) {
								$(".score_info").attr('class', 'featured-rating-orange');
							} else {
								$(".score_info").attr('class', 'featured-rating');
							}
							
							if (data2.state == "영업중") {
								$(".state-info").attr('class', 'open-now');
							} else {
								$(".state-info").attr('class','closed-now');
							}
						});
					}
				}				
			});	
		}		
	</script>	
	
	<script>
// 		var start = 0;
// 		var value="";
// 		var type=${type};
// 		var name=${name};
		
// 		$(document).ready(function() {
// 			ajax_fuc();	
					
				
// 		$(window).scroll(function() {
			
// 				var scrollTop = $(window).scrollTop();
// 				var document_height = $(document).height();
// 				var window_height = $(window).height();
				
// 				scrollTop = Math.round(scrollTop);  //윈7 크롬만 소수로 나타내서 에러 발생!
// 				if ( scrollTop == document_height - window_height) {
// 					start++;	
// 					ajax_fuc();			
// 		   		 }
// 		});
// 			    if(type != "전체"){	    	
// 					$("#search").click(function() {
// 						$("#salesList").html("");
						
// 						//마커 지우기
// 						 for (var i = 0; i < markers.length; i++) {
// 						        markers[i].setMap(null);
// 					    }
						 
// 						start = 0;
// 						ajax_fuc();
// 		 			});
// 			    }
		    
// 		});
	</script>
 
	<!-- 판매리스트 소스 -->
	<script id=template type="text/x-handlerbars-template">
	 <div class="col-sm-6 col-lg-12 col-xl-6 featured-responsive">
								<div class="featured-place-wrap">
									<a href="/company/detail?id={{id}}"> <img	src="{{image}}" class="img-fluid" alt="#">
										<span class="score_info">{{score}}</span>
										<div class="featured-title-box">
											<h6>{{name}}</h6>
											<p>{{type}}</p>
											<span>• </span>
											<p>{{commentCount}}개의 댓글 수</p>
																						
											<ul>
												<li><span class="icon-location-pin"></span>
													<p>{{address}}</p></li>
												<li><span class="icon-screen-smartphone"></span>
													<p>{{number}}</p></li>
												<li><span class="icon-link"></span>
													<p>{{homepage}}</p></li>
 											</ul>
											<div class="bottom-icons">
												<div class="state-info">{{state}}</div>
											</div>
										</div>
									</a>
								</div>		
</div>			
</script>

<script id=templateNone type="text/x-handlerbars-template">
 <div class="col-sm-12 col-lg-12 col-xl-12 featured-responsive">
								<div class="featured-place-wrap">
									<div>
	<div class="featured-title-box">
	<div class="bottom-icons">
	<div class="featured-title-box">
	<div class="bottom-icons">
	<div class="featured-title-box">
	<div class="bottom-icons">
    <div class="featured-title-box">
	<div class="bottom-icons">
								<div class="state-info"></div>
											</div>a
										</div>
						           </div>
					         	</div>		
</div>			 
</script>
</body>
	
</html>
