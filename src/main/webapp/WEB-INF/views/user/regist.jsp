<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>


<title>Essuyo</title>
<link rel="icon" type="image/png" sizes="16x16" href="/resources/images/backpack.png">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="/resources/css/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="/resources/css/simple-line-icons.css">
<link rel="stylesheet" href="/resources/css/themify-icons.css">
<link rel="stylesheet" href="/resources/css/set1.css">
<link rel="stylesheet" href="/resources/css/style.css">
<link rel="stylesheet" href="/resources/css/login.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

</head>
<body>
	
	<%@ include file="/pageframe/header.jsp"%>
<div class="wrapper fadeInDown">
		<div id="formContent">
			<!-- Tabs Titles -->

			<!-- Icon -->
			<div class="fadeIn first">
				<img src="/resources/images/backpack.png" id="icon" alt="User Icon" />
				<h1 style="color: #0d0d0d">회원 가입</h1>
			</div>

			<!-- Login Form -->

			<form id="registForm" method="post" enctype="multipart/form-data" action="/user/regist">
				<input type="hidden" name="isCheckedEmail" id="isCheckedEmail" value="N" />
				<input type="email" id="email" name="email" class="fadeIn second" placeholder="이메일" onchange="checkToN()" required>
				<input type="password" id="password" name="password" class="fadeIn second" minlength="4" data-msg-minlength="최소 {0} 자리 이상 입력해야 합니다." maxlength="12" placeholder="비밀번호" required>
				<input type="password" id="passwordCheck" class="fadeIn second" placeholder="비밀번호를 다시 입력해 주세요" equalTo="#password" required>
				<input type="text" id="name" name="name" class="fadeIn second" placeholder="이름" required>
				<input type="text" id="age" name="age" class="fadeIn second" placeholder="나이" required>
				<input type="text" id="juso" name="juso" class="fadeIn second" placeholder="주소" required>
				<input type="text" id="phoneNo" name="phoneNo" class="fadeIn second" placeholder="핸드폰번호" required>
				<select class="fadeIn second form-control" id="gender" name="gender" required>
						<option selected="selected" value="">성별</option>
						<option value="남">남</option>
						<option value="여">여</option>
				</select>
							
				<input	type="submit" class="fadeIn fourth" onclick="doReg();" value="회원가입">
			</form>

			<!-- Remind Passowrd -->
			<div id="formFooter">	
				<a class="underlineHover" href="/login">로그인</a>
			</div>

		</div>
	</div>

	
	<%@ include file="/pageframe/footer.jsp"%>

	<script src="/resources/js/jquery/jquery-3.2.1.min.js"></script>
	<script src="/resources/js/popper/popper.min.js"></script>
	<script src="/resources/js/bootstrap/bootstrap.min.js"></script>
	<script src="/resources/js/jquery/jquery.validate.js"></script>
	<script src="/resources/js/jquery/additional-methods.js"></script>
	<script src="/resources/js/jquery/messages_ko.js"></script>
	<script src="/resources/js/utility.js"></script>



ㅍ<script>
		$(document).ready(function(){
			$("#registForm").validate();

			// 버튼을 눌렀을 때 이메일의 유효성, 중복은 검사하는 기능. 지금은 
			/* 	$("#btnCheckId").click(function() {
					
					checkEmail();
				}); */

			$('#email').focusout(function() {
				checkEmail();
			});
		});

		//이메일 칸을 변경했을 경우 다시 이메일 체크를 받게 만드는 기능
		function checkToN() {
			document.getElementById("isCheckedEmail").value = 'N';

		}

		function checkEmail() {
			var email = $("#email").val();

			if (!email_check(email)) {
				myAlert("잘못된 이메일 형식", "형식에 맞는 이메일 주소를 입력해주세요.");
			} else {
				var url = "/api/checkId";
				$.post(url, {
					email : email
				}, function(json) {
					myAlert("이메일 중복체크", json.msg);

					//이메일을 사용할 수 있으면 isCheckedEmail의 값을 Y로 해준다
					if (json.code == 99) {
						$("#isCheckedEmail").val("Y");
					}
				});
			}
		}
		
		//실패하면, 일단 다시 회원가입 페이지로 가게 함
		function doReg() {

			if ($("#isCheckedEmail").val() == "N") {
				myAlert("ERROR", "Email 중복 검사를 통과해야 합니다.");
			}
			if ($("#registForm").valid()) {
				document.getElementById('registForm').submit();
			}

		}
		//정규식으로 이메일을 체크하는 함수
		function email_check(email) {

			var regex = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
			return (email != '' && email != 'undefined' && regex.test(email));

		}
	</script>

</body>

</html>
