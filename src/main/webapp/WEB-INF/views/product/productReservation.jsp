<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.webproject.essuyo.utility.CommonUtil" %>
<!DOCTYPE html>
<html >
<head>
	<title>Essuyo</title>
	<link rel="icon" type="image/png" sizes="16x16" href="/resources/images/backpack.png">
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" 
	  integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<link rel="stylesheet" href="/resources/css/simple-line-icons.css">
	<link rel="stylesheet" href="/resources/css/themify-icons.css">
	<link rel="stylesheet" href="/resources/css/set1.css">
	<link rel="stylesheet" href="/resources/css/swiper.min.css">
	<link rel="stylesheet" href="/resources/css/magnific-popup.css">
	<link rel="stylesheet" href="/resources/css/style.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

</head>
<body>
	
	<%@ include file="/pageframe/header.jsp"%>
	
<section class="reserve-block">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<h5>${product.name}</h5>
					<br>
					<span class="icon-direction"></span><p class="reserve-description">${product.discription}</p>
				</div>
				<div class="col-md-6">
					<div class="reserve-seat-block">
					<c:choose>
						<c:when test="${product.state == '예약불가'}">
							<div class="reserve-rating reserve-rating-red">
								<span>${product.state}</span>
							</div>
						</c:when>
						<c:otherwise>
							<div class="reserve-rating">
								<span>${product.state}</span>
							</div>
						</c:otherwise>
					</c:choose>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<section class="light-bg booking-details_wrap">
		<div class="container">
		
		<div class="row">
				<div class="col-md-12 responsive-wrap">
					<!-- Swiper -->
					<div class="swiper-container">
						<div id="image-list" class="swiper-wrapper">
							
							<c:forEach items="${product.url}" var="item">
							 	<div class="swiper-slide">
							 	
								<a href="${item}" class="grid image-link">  
									<img src="${item}" class="img-fluid" alt="#">
								</a>
							</div>
							</c:forEach>
							
							
						</div>
						<!-- Add Pagination -->
						<div class="swiper-pagination swiper-pagination-white"></div>
						<!-- Add Arrows -->
						<div class="swiper-button-next swiper-button-white"></div>
						<div class="swiper-button-prev swiper-button-white"></div>
					</div>
				</div>
			</div>
			
			<hr>
			<form id="reservation-info" action="/product/reserve" method="POST">
			
			<div class="row">
			 
			 	<div class="col-md-8 responsive-wrap">
					
							<input type="hidden" id="companyId" name="companyId" value="${company.id}">
							<input type="hidden" id="productId" name="productId" value="${product.id}" >
						
							
							<div id="item" class="booking-checkbox_wrap">	
								<div class="row">
									<div class="col-md-12">
										<p style="font-size:20px"><span class="icon-bulb"></span>&nbsp;&nbsp;예약 날짜</p>
											<c:choose>	
												<c:when test="${company.type == '숙박' or company.type == '차량대여'}">
													<input style="width: 48%;" type="text" name="resDate" id="startDate" class="input-border" placeholder="시작일 " readOnly>
                                    			    <input style="width: 48%;" type="text" id="endDate"  class="input-border" placeholder="종료일" readOnly>
 
												</c:when>
												<c:when test="${company.type == '식당' or company.type == '문화'}">
														<input type="text"  name="resDate" id="startDate" placeholder="날짜선택" class="input-border" readOnly>
														<br><br>
														<p style="font-size:20px"><span class="icon-bulb"></span>&nbsp;&nbsp;수량</p>
													<ul>
														<li style="display:inline-block"><a id="minus" class="nav-link" href="javascript:void(0)"><span class="icon-minus"></span></a></li>
														<li style="display:inline-block"><input id="count" name="count" style="text-align:center; border:none;"size="2" type="text" value="0" readOnly></li> 
														<li style="display:inline-block"><a id="plus" class="nav-link" href="javascript:void(0)"><span class="icon-plus"></span></a></li>
													</ul>
												</c:when>
											</c:choose>
									</div>
								</div>
							</div>
				</div>
		
				<div class="col-md-4 responsive-wrap">
						<div class="contact-info">
							<div class="address">
								<span class="icon-calendar"></span>
								<p>예약 날짜</p>
						
								<c:choose>
									<c:when test="${company.type == '숙박' or company.type == '차량대여'}">
										<p><div class= "toggle-string" style="display:none">
											<span id="reservation-date"></span><br>
											<input type="text" size="1" style=" text-align:center; border:none" id="productCount" name="productCount"  readOnly>
											<span>박</span>
										</div></p>
									</c:when>
									<c:when test="${company.type == '식당' or company.type == '문화'}">
										<p><div class= "toggle-string" style="display:none">
											<span id="reservation-date"></span><br>
											<input type="text" size="2" style=" text-align:center; border:none" id="productCount" name="productCount"  readOnly>
											<span>개</span>
										</div></p>
									</c:when>
								</c:choose>
							</div>					
						</div>
					
						<div class="follow">
							<div class="follow-img">
								<h6>결제 금액</h6>
								<div class="toggle-string2" style=" font-size:25px; display:none; color:red">
									<input type="hidden" id="totalPrice" name="totalPrice" >
									<span id="totalPriceSrc"></span>
								</div>
							</div>
							
							<!-- javascript:void(0)는 온클릭시 페이지 이동을 하지 않을때 사용 -->
							<a id="res-submit" href="javascript:void(0)" class="btn btn-outline-danger btn-contact">예약하기</a>
							<a id="res-submit10" href="javascript:void(0)" class="btn btn-outline-danger btn-contact">결제하기</a>
						</div>
				</div>
			
			</div>
	</form>
			<hr>
			
			<div class="row">
				<div class="col-md-12 responsive-wrap">

					<div  class="booking-checkbox_wrap">
						<h5>취소규정 및 약관동의</h5>
						<div class="custom-control custom-checkbox">
                                            <input type="checkbox" class="custom-control-input" id="customCheck1">
                                            <label class="custom-control-label" for="customCheck1">취소규정 및 약관에 모두 동의합니다.</label>
                        </div>
                        
                        <div style="display: none" id="cancel">         
						<ul>
							<li>결제와 동시예 예약이 확정됩니다.</li>
							<li>투숙일 이전 취소 시에는 쿠폰이 반환되며, 투숙일 이후에는 반환되지 않습니다.</li>
							<li>예약 변경을 위한 취소시에도 취소수수료가 부과되오니 양해하여 주시기 바랍니다.</li>
							<li>노쇼(No-Show: 사전 연락없이 예약된 숙소를 이용하지 않음)의 경우 요금이 100% 정상 청구됩니다.</li>
							<li>성수기 요금이 확정되지 않았거나 요금표가 잘못 등록된 경우 예약이 취소될 수 있습니다.</li>
							<li>예약 상품에 대한 문의사항은 판매자를 통해 문의해 주시길 바랍니다.</li>
							</ul>
						
                       	 </div>  
                        
							<h5><a class="nav-link" href="javascript:cancelSlideToggle()">
                              	  		 <span id="arrow-silde" class="icon-arrow-down"></span>
                 			</a></h5>
						</div>

					</div>
				</div>
		</div>
	</section>
	
	<%@ include file="/pageframe/footer.jsp"%>

	<!-- 결제API -->
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	
	<script src="https://code.jquery.com/jquery-3.3.1.js"
  			integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
  			crossorigin="anonymous"></script>
	<script src="/resources/js/popper/popper.min.js"></script>
	<script src="/resources/js/bootstrap/bootstrap.min.js"></script>
	<script src="/resources/js/utility.js"></script>
	<script src="/resources/js/jquery/jquery.magnific-popup.js"></script>
	<script src="/resources/js/swiper.min.js"></script>
	<script	src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"
 			integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="
 			crossorigin="anonymous"></script>
 			
	<script src="/resources/js/datepicker-ko.js"></script>
	

	<script>
	var disabledDays = [];
$(document).ready(function() {
	
			Ajax("GET","/api/disableDate/${product.id}", function(data){
				disabledDays = data;
			});
			
			$("#startDate").datepicker({
					showAnim : "slideDown",
					minDate : 0,
					maxDate : new Date("${product.saleEndDate}"),
					beforeShowDay: disableAllTheseDays,
					onSelect : function(dateText, inst) {
						 calReserveResult();
					}
			});
			
			$("#endDate").datepicker({
					showAnim : "slideDown",
					minDate : 0,
					maxDate : new Date("${product.saleEndDate}"),
					beforeShowDay: disableAllTheseDays,
					onSelect : function(dateText, inst) {
						calReserveResult();
					}
			});
	
			$("#plus").on("click", function() {
				var count = parseInt($("#count").val());
				if( count <= 9){
					count += 1;
					$("#count").val(count);
								
					$(".toggle-string").show();
					$("#productCount").val(count);
					calTotalPrice(count);
					
				}
			});
			
			$("#minus").on("click", function() {
				var count = parseInt($("#count").val());
				if( count != 0){
					count -= 1;
					$("#count").val(count);
					
					$(".toggle-string").show();
					$("#productCount").val(count);
					calTotalPrice(count);	
				}			
			});
			
			//예약하기 버튼 클릭시 온클릭함수
			$("#res-submit").on("click", function() {
				
				var productCount = $("#productCount").val();
				var agree = $('input:checkbox[id="customCheck1"]').is(":checked");
				if(productCount != "" && agree == true){
					  $("#reservation-info").submit();
				}else{
					if( productCount == "" && agree == false )
						myAlert("INFOMATION !","날짜,수량 선택 및 취소규정에 동의해 주세요");
					else if( agree == false )
						myAlert("INFOMATION !","취소규정에 동의해 주세요");
					else if( productCount == "" )
						myAlert("INFOMATION !","하루이상 날짜 혹은 수량을 선택해 주세요");
				}
			});
			
			
			//결제하기 버튼 클릭시 온클릭함수
			$("#res-submit10").on("click", function() {
					//오늘 날짜 8자리수로 표현(20180601)
					var today = new Date();
					var dd = today.getDate();
					var mm = today.getMonth()+1; 	//January is 0!
					var yyyy = today.getFullYear();
					if(dd<10) {
					    dd='0'+dd
					} 
					if(mm<10) {
					    mm='0'+mm
					} 
					today = yyyy + mm + dd;    //ex) 2018/06/01
					
					var productCount = $("#productCount").val();
					var totalPrice = productCount * parseInt("${product.price}");
					var agree = $('input:checkbox[id="customCheck1"]').is(":checked");
					
					if(productCount != "" && agree == true){
						var IMP = window.IMP; // 생략해도 괜찮습니다.
						IMP.init("imp66707057"); // "imp00000000" 대신 발급받은 "가맹점 식별코드"를 사용합니다.
						
						// IMP.request_pay(param, callback) 호출
						IMP.request_pay({ // param
						    pg: "html	5_inicis",
						    pay_method: "card",
						    merchant_uid: "ORD"+today+"-" + "${sessionScope.zeroPlusId}",  // ORD20190601-00001
						    name: "${company.name}",
						    amount:  totalPrice,	
						    buyer_email: "${sessionScope.login}",
						    buyer_name: "${sessionScope.name}",
						    buyer_tel: "${sessionScope.phoneNo}",
						    buyer_addr: "${sessionScope.juso}",
						    buyer_postcode: "${sessionScope.zeroPlusId}"				   // 기본키(id)값 앞에 5자리까지 0 추가    ex)id=12 --> 00012
						}, function (rsp) { // callback
							 if (rsp.success) { // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
							       alert("결제에 성공했습니다.");
							    } else {
							        alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
							    }
						});
					}else{
						if( productCount == "" && agree == false )
							myAlert("INFOMATION !","날짜,수량 선택 및 취소규정에 동의해 주세요");
						else if( agree == false )
							myAlert("INFOMATION !","취소규정에 동의해 주세요");
						else if( productCount == "" )
							myAlert("INFOMATION !","하루이상 날짜 혹은 수량을 선택해 주세요");
					}
			});
});

		function disableAllTheseDays(date) {
			var m = date.getMonth(), d = date.getDate(), y = date.getFullYear();
				for (i = 0; i < disabledDays.length; i++) {
					        if($.inArray(y + '-' +(m+1) + '-' + d,disabledDays) != -1) {
					            return [false];
				      		  }
				}
					    return [true];
			}
		
	
		function calTotalPrice(count){
			var totalPrice = count * parseInt("${product.price}");
			$("#totalPrice").val( totalPrice );
			
			totalPrice = dotSplit(totalPrice);
			$("#totalPriceSrc").text( totalPrice + "원");
		}
		
		function cancelSlideToggle(){
			var className =  $('#arrow-silde').attr("class");
			if( className == "icon-arrow-down"){
				 $('#arrow-silde').attr("class","icon-arrow-up");
			}else{
				 $('#arrow-silde').attr("class","icon-arrow-down");
			}
				
			$('#cancel').slideToggle();
		}
		function checkDate(startDate, endDate){
			
			var listDate = [];
			var returnType = true;
			getDateRange(startDate, endDate, listDate);
		
			listDate.forEach(function(data){
				
				
				for (i = 0; i < disabledDays.length; i++) {
				      if(data == disabledDays[i]) {
				    	  	returnType = false;
			           	 	break;
		   		  		}
				}
			});
			return returnType;
			
		}
		function calReserveResult(){
			
			var startDate = $("#startDate").val();
			var endDate = $("#endDate").val();
			
			
			
			
								
			if( startDate != "" && endDate != undefined && endDate != ""){
				
				if( checkDate(startDate,endDate) == false){
					$("#startDate").val("");
					$("#endDate").val("");
					myAlert("IMFOMATION !","연속된 날짜여야만 예약이 가능합니다.\n예약날짜 중간에 예약불가 날짜가 있습니다.");
					return;
				}
				
				var count = calDayCount(startDate,endDate);
				if( count > 0){
					$(".toggle-string").show();
					$(".toggle-string2").show();
					
					$("#reservation-date").text(startDate + " ~ " + endDate);
					$("#productCount").val(count);
			
					calTotalPrice(count);
				}else if( count < 0 ){
					myAlert("WARRNING !","종료 날짜보다 시작날짜가 클수 없습니다.");
					$("#startDate").val("");
					$("#endDate").val("");
					$("#productCount").val("");
					$(".toggle-string").hide();
				}
				else{
					myAlert("WARRNING !","1박이상 선택해주세요");
					$("#productCount").val("");
					$(".toggle-string").hide();
				}
			}else{
				$(".toggle-string2").show();
				$("#reservation-date").text(startDate);
			}
		}
		
		
		function calDayCount(startDate, endDate){
			var startDateAry = startDate.split("-");
			var endDateAry = endDate.split("-");
			var start = new Date(startDateAry[0],
					startDateAry[1], startDateAry[2]);
			var end = new Date(endDateAry[0],
					endDateAry[1], endDateAry[2]);
			var result = end - start;
			var day = 1000 * 60 * 60 * 24;
			return parseInt(result /= day);
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
	<script>
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
	
</body>

</html>
