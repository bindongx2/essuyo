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
	<link rel="stylesheet" href="/resources/css/bootstrap/bootstrap.min.css">
	<link rel="stylesheet" href="/resources/css/simple-line-icons.css">
	<link rel="stylesheet" href="/resources/css/themify-icons.css">
	<link rel="stylesheet" href="/resources/css/set1.css">
	<link rel="stylesheet" href="/resources/css/swiper.min.css">
	<link rel="stylesheet" href="/resources/css/magnific-popup.css">
	<link rel="stylesheet" href="/resources/css/style.css">
	<link rel="stylesheet" href="/resources/css/tab.css">
	
	
<!-- 맵 정보창 css -->
 <style type="text/css">
@import url(http://fonts.googleapis.com/css?family=Reenie+Beanie);
.iw_inner {
	width:250px;
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
}
</style>

	
</head>
<body>	
	<%@ include file="/pageframe/header.jsp"%>

	<div>
		<!-- Swiper -->
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<c:forEach items="${company.image}" var="imageUrl">
					<div class="swiper-slide">
						<a href="${imageUrl}" class="grid image-link"> 
							<img src="${imageUrl}" class="img-fluid" alt="#">
						</a>
					</div>
				</c:forEach>

			</div>
			<div class="swiper-pagination swiper-pagination-white"></div>
			<div class="swiper-button-next swiper-button-white"></div>
			<div class="swiper-button-prev swiper-button-white"></div>
		</div>
	</div>
	
	<section class="reserve-block">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<h5>${company.name}</h5>
					<br>
					<p class="reserve-description">${company.discription}</p>
				</div>
				<div class="col-md-6">
					<div class="reserve-seat-block">
					<c:choose>
						<c:when test="${company.score <= 2}">
							<div class="reserve-rating-red">
								<span>${company.score}</span>
							</div>
						</c:when>
						<c:when test="${company.score <= 4}">
							<div class="reserve-rating-orange">
								<span>${company.score}</span>
							</div>
						</c:when>
						<c:otherwise>
							<div class="reserve-rating">
								<span>${company.score}</span>
							</div>
						</c:otherwise>
					</c:choose>
						
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<div class="container">
		<ul class="tabs">
			<li class="tab-link current" data-tab="tab-1">판매 상품</li>
			<li class="tab-link" data-tab="tab-2">댓글</li>
		</ul>
	</div>
	
	
	<section class="light-bg booking-details_wrap">
		<div class="container">
			<div class="row">
				<div class="col-md-8 responsive-wrap">

					<div id="tab-1" class="tab-content current">
						<div class="booking-checkbox_wrap">
							<div class="row">
								<c:forEach var="item" items="${company.facility}">
									<div class="col-md-4">
										<label class="custom-checkbox"> <span
											class="ti-check-box"></span> <span
											class="custom-control-description">${item}</span>
										</label>
									</div>
								</c:forEach>
							</div>


							<hr>

							<div id="product-list"></div>

						</div>

					</div>
					<div id="tab-2" class="tab-content">
						<div class="booking-checkbox_wrap">
				
				<div class="booking-checkbox_wrap mt-4">
							
								<h5>총 댓글 ${company.review}개</h5>
								<hr>
								
								 <c:if test="${ !empty sessionScope.login}">
								<form role="form" method="POST"	action="/comment/writerComment" onsubmit="return checkValue();">
								
								<div class="customer-review_wrap">
									<div class="customer-img">
										<img id="writeUserImage" src="" class="img-fluid comment-image-size" alt="">
									</div>
									<div class="customer-content-wrap">
										<div class="customer-content">
											<div class="customer-review">
												<input type="text" name='title' id='title' class="form-control" placeholder="제목">
											</div>
											
											
												<select	name="score" id="score">
													<option value="0">☆☆☆☆☆</option>
													<option value="1">★☆☆☆☆</option>
													<option value="2">★★☆☆☆</option>
													<option value="3">★★★☆☆</option>
													<option value="4">★★★★☆</option>
													<option value="5">★★★★★</option>
												</select> 
										
										</div>
										<textarea class="form-control" name="content" id='content' rows="3"placeholder="내용"></textarea>
									</div>
								</div>
									<button type="submit" class="btn btn-info"	style="float: right;">댓글달기</button>
													
							
								
								<input type="hidden" name='companyId' value="${company.id}">
								</form>

									<hr>
								</c:if>
						</div>
							<div id="comment-list" style="overflow-y:auto;overflow-x:hidden;height:600px;" class="booking-checkbox_wrap mt-4">
							</div>
						</div>
						
						
					</div>
				</div>
				<div class="col-md-4 responsive-wrap">
					<div class="contact-info">
						<div id="map" style="width:100%;height:400px;"></div>

						<div class="address">
							<span class="icon-location-pin"></span>
							<p>${company.address}</p>
						</div>
						<div class="address">
							<span class="icon-screen-smartphone"></span>
							<p>${company.number}</p>
						</div>
						<div class="address">
							<span class="icon-link"></span>
							<p>${company.homepage}</p>
						</div>
						<div class="address">
							<span class="icon-clock"></span>
							<p>${company.time}<br>
								<c:choose>
									<c:when test="${company.state == '영업중'}">
										<span class="open-now">${company.state}</span>
									</c:when>
									<c:when test="${company.state == '영업종료'}">
										<span class="closed-now">${company.state}</span>
									</c:when>
								</c:choose>


							</p>
						</div>
						<a href="/message/register?receiverID=${user.id}"
							class="btn btn-outline-danger btn-contact">메시지 보내기</a>
					</div>
					<div class="follow">
						<div class="follow-img">
							<img style="max-width: 45%" src="${user.image}" class="img-fluid"
								alt="${user.name}">
							<h6>${user.name}</h6>
							<span>${user.comment}</span>
						</div>
						<ul class="social-counts">
							<li></li>
							<li>
								<h6 id="good-count">${user.good}</h6> <span>좋아요</span>
							</li>
							<li></li>
						</ul>
						<a href="javascript:goodCount()">좋아요!</a>
					</div>
				</div>
			</div>
		</div>
	</section>
	

	<%@ include file="/pageframe/footer.jsp"%>

	<script src="/resources/js/jquery/jquery-3.2.1.min.js"></script>
	<script src="/resources/js/popper/popper.min.js"></script>
	<script src="/resources/js/jquery/jquery.magnific-popup.js"></script>
	<script src="/resources/js/swiper.min.js"></script>
	<script src="/resources/js/utility.js"></script>
	<script src="/resources/js/handlebars.min.js"></script>
	<script src="/resources/js/bootstrap/bootstrap.min.js"></script>
	
	<script type="template" id="comment-modify-template">
	   <div class="customer-review_wrap">
       <div class="customer-img">
           <img src="{{image}}" class="img-fluid comment-image-size" alt="{{name}}">
           <p>{{name}}</p>
           <span>{{totalReply}} Reviews</span>
       </div>
       <div class="customer-content-wrap">
           <div class="customer-content">
               <div class="customer-review">
                   <h6>{{title}}</h6>
                   <p>등록 날짜 : {{regDate}}</p>
               </div>
               <div class="customer-rating">{{score}}</div>
           </div>
           <p class="customer-text">{{content}}</p>
       </div>

		<a href="/comment/removeComment?id={{id}}&commentId={{commentId}}"> 
			<i class="icon-trash"></i>
		</a> 
   </div>
   <hr>
	</script>
	
		<script type="template" id="comment-template">
	   <div class="customer-review_wrap">
       <div class="customer-img">
           <img src="{{image}}" class="img-fluid comment-image-size" alt="{{name}}">
           <p>{{name}}</p>
           <span>{{totalReply}} Reviews</span>
       </div>
       <div class="customer-content-wrap">
           <div class="customer-content">
               <div class="customer-review">
                   <h6>{{title}}</h6>
                   <p>등록 날짜 : {{regDate}}</p>
               </div>
               <div class="customer-rating">{{score}}</div>
           </div>
           <p class="customer-text">{{content}}</p>
          
           <span><span id="help-count-{{commentId}}">{{helpful}}</span>명이 이 댓글에 도움을 받았습니다.</span>
           <a href="javascript:helpCount({{commentId}})"><span class="icon-like"></span>Helpful</a>
       </div>
   </div>
   <hr>
	</script>
	

	<script type="template" id="product-template">
	<div class="booking-checkbox_wrap">
	<div class="featured-place-wrap">
		<a href="/product/reservation?company={{companyId}}&product={{productId}}"> 
			<img src="{{url}}" class="img-fluid company-image-size" alt="#">
			
			<div class="featured-title-box">
				<h6>{{name}}</h6>
				<h6>{{data}}</h6>
				<i class="icon-direction"></i><p> {{discription}}</p>
		

				<ul>
					<li><span class="icon-calendar"></span>
						<p>{{saleDate}}</p></li>
					<li><span class="icon-wallet"></span>
						<p>{{price}} 원</p></li>

				</ul>
				<div class="bottom-icons">
					<div class="open-now">{{state}}</div>
				</div>
			</div>
		</a>
	</div>
</div>
	</script>
	
		<script>
	    var commentStartNum = 1;
	    var commentMaxNum = 0;
		$(document).ready(function() {
			
			requestCommentList("company",commentStartNum);
			
			$("#comment-list").scroll( function() { 
	      		var elem = $(this);
	      		if ( Math.floor(elem[0].scrollHeight - elem.scrollTop()) == elem.outerHeight()){
	      			
	      			if( commentMaxNum !=commentStartNum){
	      				commentStartNum += 1;      			
						requestCommentList("company",commentStartNum);
	      			}
	      		}
	      	});
			

					$('ul.tabs li').click(function() {
						var tab_id = $(this).attr('data-tab');

						$('ul.tabs li').removeClass('current');
						$('.tab-content').removeClass('current');

						$(this).addClass('current');
						$("#" + tab_id).addClass('current');

					});

					var requestURL = "/api/productList/" + ${company.id};

					Ajax("GET", requestURL, function(dataList) {

				
							dataList.forEach(function(data) {
								var tempData = {};

								tempData['companyId'] = ${company.id};
								tempData['productId'] = data.id;
								tempData['url'] = data.url[0];
								tempData['name'] = data.name;
								tempData['discription'] = data.discription;
								tempData['saleDate'] = data.saleStartDate + " ~ " + data.saleEndDate;
								tempData['state'] = data.state;
								tempData['price'] = dotSplit(data.price);

								makeHTML("#product-template", "#product-list",	tempData);
							});
					
					});

					if( "" != "${sessionScope.login}" ){
				    		requestURL = "/api/loginImage";
							Ajax("GET", requestURL, function(data) {
								
								$("#writeUserImage").attr("src",data);
								$("#writeUserImage").attr("alt","사진");
							});
				      }
				

				
					
					// 수정 버튼
					var modiForm = $("form[role='ModifyForm']");
					$("#modifyBtn").on("click",function(){
						var id = document.getElementById("ModifyId").value;
						modiForm.attr("action","/message/modifyComment?" + id);
						modiForm.submit();
					});
					
				});
		
		
		function goodCount(){
			Ajax("GET", "/api/good/${user.id}", function(data) {
				$("#good-count").text(data);
			});
		}
		
		function checkValue() {
			var title = document.getElementById("title").value;
			var content = document.getElementById("content").value;

			if (title == "" || title == null) {
				myAlert("ERROR", "제목을 입력해주세요!");

				return false;
			}
			if (content == "" || content == null) {
				myAlert("ERROR", "댓글 내용을 입력해주세요!");

				return false;
			}
		}
		function helpCount(commentId){
			Ajax("GET", "/api/helpful/"+commentId, function(data) {
				$("#help-count-"+commentId).text(data);
			});
		}
	function requestCommentList(type, startNum){
		
		requestURL = "/api/commentList/" + type + "/" + startNum + "/" + ${company.id};
		Ajax("GET", requestURL, function(dataList) {
			
			commentMaxNum = dataList.maxCount;
			
			if( dataList.commentList.length ){
				dataList.commentList.forEach(function(data) {

					var tempData = {};
				
					tempData['id'] = ${company.id};
					tempData['commentId'] = data.id;
					tempData['image'] = data.imageUrl;
					tempData['name'] = data.name;
					tempData['title'] = data.title;
					tempData['regDate'] = data.regDate;
					tempData['score'] = data.score;
					tempData['content'] = data.content;
					tempData['helpful'] = data.helpful;
					tempData['state'] = data.state;
					tempData['totalReply'] = data.totalReply;
				
					if( "${sessionScope.login}" == data.commentUserEmail )
						makeHTML("#comment-modify-template", "#comment-list", tempData);
					else
						makeHTML("#comment-template", "#comment-list", tempData);
				});
			}
		});
		
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
			},
		});
		
		if ($('.image-link').length) {
			$('.image-link').magnificPopup({
				type : 'image',
				gallery : {
					enabled : true
				}
			});
		}
		if ($('.image-link2').length) {
			$('.image-link2').magnificPopup({
				type : 'image',
				gallery : {
					enabled : true
				}
			});
		}
	</script>
	
		<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=4fwo13nag1&submodules=geocoder&callback=initMap"></script>
<!-- <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=YkyfY8yLi0st2FbjVXIG&callback=initMap&submodules=geocoder"></script> -->

<script>
var map = new naver.maps.Map("map", {
    zoom: 10,
    mapTypeControl: true
});

var infoWindow = new naver.maps.InfoWindow({
    anchorSkew: true
});

map.setCursor('pointer');

// result by latlng coordinate
function searchAddressToCoordinate(address) {
    naver.maps.Service.geocode({
        address: address
    }, function(status, response) {
        if (status === naver.maps.Service.Status.ERROR) {
//             return myAlert('ERROR !' ,"찾을 수 없는 주소 입니다!");
        }

        
        var item = response.result.items[0],
            addrType = item.isRoadAddress ? '[도로명 주소]' : '[지번 주소]',
            point = new naver.maps.Point(item.point.x, item.point.y);
             infoWindow.setContent([
            	  '<div class="iw_inner">',
                  '<h5>${company.name}</h5>',	
                  '<p>' + item.addrdetail.sido + '</p>',
                  '<p>${company.homepage}</p>',
                  '</div>'
            ].join(''));

        map.setCenter(point);
        infoWindow.open(map, point);
    });
}
function initGeocoder() {
    searchAddressToCoordinate('${company.address}');
}

naver.maps.onJSContentLoaded = initGeocoder;
 </script>
	

</body>

</html>
