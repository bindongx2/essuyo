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
			<div id="map" style="width: 1502px;height: 800px"></div>
		</div>
	</section>
	
	<div>
	<img src="">
	</div>	

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
		
		$(document).ready(function() {
			var inputString = prompt('주소를 입력해주세요.', '서울특별시 관악구'); 
// 			var inputString = prompt('주소를 입력해주세요.', 'ex) 서울특별시 관악구(기본적으로 구 까지 쓰세요.)'); 
			ajax_mask(inputString);		
		});
		
	
		function ajax_mask(add){
			var param = "address=" + add;
			$.ajax({
				type : 'GET',
				data : param,
				url : encodeURI('https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/storesByAddr/json'),
				success : function(data){
					var count = data.count;
					var obj = data.stores;
					
					var markers = [];
					var map = new naver.maps.Map('map', {
					    zoom: 15
					});
					
					$.each(obj,function(key,value) {
						
						var address = value.addr;
						var name = value.name;
						var lat = value.lat;
						var lng = value.lng;
						var remain_stat = value.remain_stat;	//수량 구분값
						var created_at = value.created_at;		//데이터 변경일자
						var stock_at = value.stock_at;			//입고 날짜 및 시간
						var type = value.type;					// 01:약국 , 02:우체국 , 03:농협
						
						var icon_url;
						var stock_at_val;
						
						if(stock_at == null){
							stock_at = " ";
						}
						
						
						if(remain_stat == 'plenty'){		// 100개 이상
							icon_url = "/resources/images/mask/pharmgreen.png";
							stock_at_val = "많음(100개 이상)";
						}else if(remain_stat == 'some'){ 	// 30개이상 100개미만
							icon_url = "/resources/images/mask/pharmyellow.png";
							stock_at_val = "보통(30~100개)";
						}else if(remain_stat == 'few'){ 	// 2개이상 30개미만
							icon_url = "/resources/images/mask/pharmred.png";
							stock_at_val = "적음(1~30개)";
						}else{								// 1개이하
							icon_url = "/resources/images/mask/pharmgray.png";
							stock_at_val = "없음(0~1개)";
						}
						
						
						var point = new naver.maps.LatLng(lat, lng);						
						var marker = new naver.maps.Marker({
							map: map,	
							position: point,
							icon: {
							    url: icon_url //마커 URL
							}	

			 			});
						
						

						var contentString = [
						        '<div class="iw_inner">',
						        '   <h4 style="text-align :center; border-bottom: solid 2px; ">' + name + '</h4>',
						        '   <p>재고 갯수 : '+ stock_at_val +'<br />',
						        '   업데이트 시간  : '+ stock_at +'<br />',
						        '   </p>',
						        '</div>'
						    ].join('');
						
						var infoWindow = new naver.maps.InfoWindow({
				            anchorSkew: true,
				           	content : contentString,
				            backgroundColor: "#eee",
				            borderColor: "#606FAA",
				            borderWidth: 3
				        });
						

			 			naver.maps.Event.addListener(marker, "click", function(e) {
				        	infoWindow.open(map,point);        	
				        });
			 			markers.push(marker);
			 		    map.setCenter(point);  
			 			
					});
	
				},
				
				beforeSend:function(){ //이미지 보여주기 처리
			        $('.wrap-loading').removeClass('display-none');
			    },
			    
			    complete:function(){  //이미지 감추기 처리
			        $('.wrap-loading').addClass('display-none');
			    }

			});
		}
	
		
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
</body>
	
</html>
