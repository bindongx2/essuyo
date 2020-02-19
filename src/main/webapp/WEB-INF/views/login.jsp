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

</head>
<body>
	
	<%@ include file="/pageframe/header.jsp"%>
	
	<div class="wrapper fadeInDown">
		<div id="formContent">

			<div class="fadeIn first">
				<img src="/resources/images/backpack_.png" id="icon" alt="User Icon" />
				<h1 style="color: #0d0d0d">로그인</h1>
			</div>

			<form id="loginForm" method="post" action="/login">
			
				<input type="email" title="올바르지 않은 이메일 형식입니다." pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" id="email" name="email" class="fadeIn second" placeholder="이메일" required >
				<input type="password" id="password" name="password" class="fadeIn second" minlength="4"
					   data-msg-minlength="최소 {0} 자리 이상 입력해야 합니다."size="30" maxlength="12" placeholder="비밀번호" required>
				<input type="submit" class="fadeIn fourth" value="로그인">
			</form>

			<div id="formFooter">
				<a class="underlineHover" href="/user/regist">회원 가입</a>
			</div>
		</div>
	</div>
	
	
	<%@ include file="/pageframe/footer.jsp"%>

	<script src="/resources/js/jquery/jquery-3.2.1.min.js"></script>
	<script src="/resources/js/popper/popper.min.js"></script>
	<script src="/resources/js/bootstrap/bootstrap.min.js"></script>
 	<script src="/resources/js/jquery/jquery.validate.js"></script>               <!--이메일/비밀번호 검사하는 플러그인제공   -->
	<script src="/resources/js/jquery/additional-methods.js"></script>			  <!--이메일/비밀번호 검사하는 플러그인제공   -->
	<script src="/resources/js/jquery/messages_ko.js"></script>					  <!--이메일/비밀번호 검사하는 플러그인제공   -->
	<script src="/resources/js/utility.js"></script>


	<script>
		$(document).ready(function() {
			$("#password").keyup(function(event) {
				if (event.keyCode == 13) {					//enter의 KeyCode 값이 13   
					doLogin();								//enter키를 입력했다면 doLogin() 실행
				}
			});

			msgCheck();									    //enter키 입력후 메시지를 통해 유효성 확인
		});

		//로그인 기능
		function doLogin() {
			if ($("#loginForm").validate()) {				//valid(),validate() : 폼을 submit하기 전에 검증을 해주는 플러그인(검증을 통과하지 못하면 경구문구와 자동으로 submit방지)
				loginForm.submit();                         //form에 값들을 가지고 submit한 후 다시 login.jsp페이지로 이동
			}
		}

		//로그인 실패시 메시지 띄우는 기능.
		function msgCheck() {
			var msg = "${msg}";

			if (msg === null || msg === "" || msg === undefined) {
				
			} else {	
				myAlert("로그인 실패", msg);
			}
		}
	</script>
	

</body>

</html>
