<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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

	<div id="main-wrapper" data-navbarbg="skin6" data-theme="light" data-layout="vertical" data-sidebartype="full" data-boxed-layout="full">

		<%@ include file="/pageframe/admin-navigation.jsp"%>

		<div class="page-wrapper">
		
		<div class="page-breadcrumb">
				<div class="row">
					<div class="col-5 align-self-center">
							<h4 class="page-title">개인 사업장 관리</h4>
					</div>
				</div>
			</div>
			
			<div class="container-fluid">
				<c:choose>
					<c:when test="${empty sessionScope.companyLogin}">
						<div class="page-breadcrumb">
							<div class="row">
							
								<div class="col-12 align-self-center">
									<a href="/user/businessStart"><img style="margin-left: auto; margin-right: auto; display: block; width: 300px;"
									src="../resources/images/business-icon.png"></a>
								</div>
							</div>
							<div class="row">
								<div class="col-12 align-self-center">
									<h3 style="color:#4F5467; text-align: center;">사업 시작 하기</h3>
								</div>
							</div>
									
							
						</div>
					</c:when>
					<c:when test="${!empty sessionScope.companyLogin}">
						<div class="card">
							<div class="card-body">
								<h4 class="card-title">사업자 정보 입력 및 수정</h4>
								<h5 class="card-subtitle">요구사항에 따라 빈 칸을 채워주세요</h5>

								<c:choose>
									<c:when test="${cvo == null || cvo == ''}">
										<form class="form-horizontal m-t-30" id="registForm"
											name="registForm" method="post" enctype="multipart/form-data"
											action="/user/companyUpdate" >
										</form>
									</c:when>
									<c:when test="${cvo != null || cvo != ''}">
										<form class="form-horizontal m-t-30" id="registForm"
											name="registForm" method="post" enctype="multipart/form-data"
											action="/user/companyModify">
										</form>
									</c:when>

								</c:choose>


								<div class="form-group">
									<label>[회사명] </label> <input value="${cvo.name}" type="text"
										id="name" name="name" class="form-control" placeholder="회사명"
										required>
								</div>

								<div class="form-group">
									<label>[회사 업종]</label> <select class="custom-select col-12"
										id="type" name="type" required>
										<option selected="selected" value="">업종 선택</option>
										<option value="숙박">숙박</option>
										<option value="식당">식당</option>
										<option value="문화">문화</option>
										<option value="차량대여">차량대여</option>
									</select>
								</div>
								<div class="form-group">
									<label>[회사 소개문]<span class="help"> ※ 250자 이내로
											입력해 주세요</span></label>
									<textarea name="discription" id="discription"
										class="form-control" rows="5" onkeyup="len_chk()"></textarea>
								</div>

								<div class="form-group">
									<label>[회사 주소] </label> <input value="${cvo.address }"
										type="text" id="address" name="address" class="form-control"
										placeholder="회사주소" required>
								</div>
								<div class="form-group">
									<label>[회사 소재 지역]</label> <select class="custom-select col-12"
										id="areaListId" name="areaListId" required>
										<option selected="selected" value="">지역 선택</option>
										<option value="1">서울</option>
										<option value="2">부산</option>
										<option value="3">광주</option>
										<option value="4">강원도</option>
									</select>
								</div>
								<div class="form-group">

								<label>[사업장 시설 구비 여부]  <br><span class="help"> ※ 해당 사항이 없으실 경우 체크하지 않으시면 됩니다.</span><br><span class="help"> ${facStr }</span></label><br>
								
									<input type="hidden" name="facIds" value="no">
									<input type='checkbox' name='facIds' value='1' />주차공간<br>
									<input type='checkbox' name='facIds' value='2' />와이파이/인터넷<br>
									<input type='checkbox' name='facIds' value='3' />금연구역<br>
									<input type='checkbox' name='facIds' value='4' />신용카드<br>
								</div>
								<div class="form-group">
									<label>[회사 전화번호] <span class="help"> 예)
											010-1234-5793 혹은, 02-123-4567</span></label> <input value="${cvo.number }"
										type="text" id="number" name="number" class="form-control"
										placeholder="회사 전화번호"
										pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" maxlength="13"
										required>
								</div>

								<div class="form-group">
									<label>[회사 홈페이지] <span class="help"> 예)
											www.example.com 혹은, www.example.co.kr</span></label> <input
										value="${cvo.homepage }" type="text" id="homepage"
										name="homepage" class="form-control" placeholder="회사 홈페이지"
										required>
								</div>
								<div class="form-group">
									<label>[영업 상태]</label> <select class="custom-select col-12"
										id="state" name="state" required>
										<option selected="selected" value="">영업상태</option>
										<option value="영업중">영업중</option>
										<option value="영업종료">영업종료</option>
									</select>
								</div>

								<div class="form-group">

									<label>[회사 이미지 업로드] </label><br> <span class="help">
									※1. 이미지는 최소 3장, 최대 12장까지 업로드할 수 있습니다. <br>
									※2. 선택한 이미지 파일을 취소하시고 싶으실 경우, 다시 파일 선택 버튼을 눌러, 취소 버튼을 누르시면, 이미지 선택을 취소할 수 있습니다.<br>
									<c:if test="${cvo != null || cvo != ''}"> ※3. 새 이미지를 업로드 하시면 기존 이미지들은 삭제됩니다.<br>
									</c:if></span>
									<br>

									<!-- 정보를 새로 입력할 때는 required가 달린 input을 보여준다 -->
									<!-- 기존 정보를 수정할 때는 required가 없는 input을 보여줘서, 굳이 이미지를 업로드 하지 않아도 되게 한다 -->
									<c:choose>
										<c:when test="${cvo == null || cvo == ''}">
											<input type="file" multiple="multiple" class="imgsShow"
												name="imgs" required accept="image/png, image/jpeg">
											<br>
											<input type="file" multiple="multiple" class="imgsShow"
												name="imgs" required accept="image/png, image/jpeg">
											<br>
											<input type="file" multiple="multiple" class="imgsShow"
												name="imgs" required accept="image/png, image/jpeg">
											<br>
										</c:when>
										<c:when test="${cvo != null || cvo != ''}">
											<input type="file" multiple="multiple" class="imgsShow"
												name="imgs" accept="image/png, image/jpeg">
											<br>
											<input type="file" multiple="multiple" class="imgsShow"
												name="imgs" accept="image/png, image/jpeg">
											<br>
											<input type="file" multiple="multiple" class="imgsShow"
												name="imgs" accept="image/png, image/jpeg">
											<br>
										</c:when>
									</c:choose>
									<button type="button" name="show" id="show"
										onclick="showMore();">More</button>
									<input type="file" multiple="multiple" class="imgsHide"
										name="imgs" accept="image/png, image/jpeg"><br> <input
										type="file" multiple="multiple" class="imgsHide" name="imgs"
										accept="image/png, image/jpeg"><br> <input
										type="file" multiple="multiple" class="imgsHide" name="imgs"
										accept="image/png, image/jpeg"><br> <input
										type="file" multiple="multiple" class="imgsHide" name="imgs"
										accept="image/png, image/jpeg"><br> <input
										type="file" multiple="multiple" class="imgsHide" name="imgs"
										accept="image/png, image/jpeg"><br> <input
										type="file" multiple="multiple" class="imgsHide" name="imgs"
										accept="image/png, image/jpeg"><br> <input
										type="file" multiple="multiple" class="imgsHide" name="imgs"
										accept="image/png, image/jpeg"><br> <input
										type="file" multiple="multiple" class="imgsHide" name="imgs"
										accept="image/png, image/jpeg"><br> <input
										type="file" multiple="multiple" class="imgsHide" name="imgs"
										accept="image/png, image/jpeg"><br>

								</div>

								<div class="form-group">
									<label>[영업 시간] </label><span class="help"> 예) 09:00 ~
										18:00 혹은, All Time, 상시 영업</span><input value="${cvo.time }"
										type="text" id="time" name="time" class="form-control"
										placeholder="영업시간" required>
								</div>
								<!-- 컴퍼니 아이디의 존재 여부에 따라 정보 입력과 정보 수정을 나눠서 표시한다 -->

								<c:choose>
									<c:when test="${cvo == null || cvo == ''}">
										<button type="submit">정보 입력</button>
									</c:when>
									<c:when test="${cvo != null || cvo != ''}">
										<button type="submit">정보 수정</button>
									</c:when>
								</c:choose>

								</form>

								<!-- Column -->
							</div>
						</div>

					</c:when>

				</c:choose>
				</div>
					
					
						<footer class="footer text-center">
							All Rights Reserved by Nice admin. Designed and Developed by <a href="https://wrappixel.com">WrapPixel</a>.
						</footer>
			</div>
	</div>

				<script src="../resources/js/jquery/jquery.min.js"></script>
				<script type="text/javascript" src="../resources/js/jquery/jquery-3.3.1.js"></script>
				<script type="text/javascript" src="../resources/js/jquery/jquery.validate.js"></script>
				<script type="text/javascript" src="../resources/js/jquery/additional-methods.js"></script>
				<script src="../resources/js/popper/umd/popper.min.js"></script>
				<script src="../resources/js/bootstrap/bootstrap.min.js"></script>
				<script src="../resources/js/sparkline.js"></script>
				<script src="../resources/js/userpage/waves.js"></script>
				<script src="../resources/js/userpage/sidebarmenu.js"></script>
				<script src="../resources/js/userpage/custom.min.js"></script>
				<script src="../resources/js/utility.js"></script>
				<script type="text/javascript" src="../resources/js/jquery/messages_ko.js"></script>

				<script>
					$(function() {
						$("#registForm").validate();

						var discription = document
								.getElementById('discription');

						discription.value = '${cvo.discription}';

						//이미지 업로드 인풋 숨기기
						$(".imgsHide").hide();
						//이미지 추가하기
						$("#show").click(function() {

							$(".imgsHide").show('1500'); //천천히 보이기

							$(this).hide('fast');//more버튼 숨기기

						});

						var cvoId = "${cvo.id}";

					});

					function companyModify() {

						if ($("#registForm").valid()) {
							var url = "/user/companyModify";
							$.post(url, $("#registForm").serialize());
						}
					}

					//글자수 제한 체크 
					function len_chk() {
						var frm = document.registForm.discription;

						if (frm.value.length > 250) {
							myAlert("글자수 제한", "250자 이내로 작성하셔야 합니다.");
							frm.value = frm.value.substring(0, 250);
							frm.focus();
						}

					}
				</script>
</body>

</html>