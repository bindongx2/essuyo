<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<title>자리 있어요?</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"	content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR">
	<link rel="stylesheet"
		href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
		integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
		crossorigin="anonymous">
	<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/simple-line-icons.css">
	<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/themify-icons.css">
	<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/style.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/css/bootstrap-dialog.min.css">
</head>
<body>
    <div class="dark-bg sticky-top">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                
                    <nav class="navbar navbar-expand-lg navbar-light">
                        <a class="navbar-brand" href="/"><img style="width:50px;height:50px"src="${pageContext.servletContext.contextPath}/resources/images/backpack.png"/></a>
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            				  <span class="icon-menu"></span>
           				 </button>
                        <div class="collapse navbar-collapse justify-content-end" id="navbarNavDropdown">
                            <ul class="navbar-nav">
								<li class="nav-item">
									<a class="nav-link"	href="/company/list?type='숙박'">숙박</a>
								</li>
								<li class="nav-item">
									<a class="nav-link"	href="/company/list?type='식당'">식당</a>
								</li>
								<li class="nav-item">
									<a class="nav-link" href="/company/list?type='문화'">문화</a>
								</li>
								<li class="nav-item">
									<a class="nav-link"	href="/company/list?type='차량대여'">차량대여</a>
								</li>

								<c:choose>
									<c:when test="${ empty sessionScope.login }">
										<li class="nav-item">
											<a class="nav-link" href="/user/regist">회원가입</a>
										</li>
										<li class="nav-item">
											<a class="nav-link"	href="/login">로그인 <i class="icon-login"></i></a>
										</li>
								
									</c:when>

									<c:when test="${ !empty sessionScope.login }">
									<li class="nav-item">
										<ul class="navbar-nav">
											
												<li class="nav-item dropdown">
												<a class="nav-link dropdown-toggle text-muted waves-effect waves-dark pro-pic"
													href="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
													<img id="userImage" src="" alt="user" class="rounded-circle" width="31">
												</a>
													<div class="dropdown-menu dropdown-menu-right user-dd animated">
													<a class="dropdown-item" href="/user/profile">
														<i class="icon-user m-r-5 m-l-5"></i> 프로필</a> 
														
														<a class="dropdown-item" href="/user/dashboard"> 
															<i class="icon-chart m-r-5 m-l-5"></i> 종합화면 </a>

														<c:if test="${ !empty sessionScope.companyLogin}">
															<a class="dropdown-item" href="/user/dashboardCompany">
																<i class="icon-chart m-r-5 m-l-5"></i> 개인사업장 종합화면</a> 
														</c:if>
														
															<a class="dropdown-item" href="/message/listPage"> 
															<i class="icon-envelope-open"></i> 메시지 </a>

													<a class="dropdown-item" href="/logout">
														<i class="icon-logout m-r-5 m-l-5"></i> 로그아웃</a> 
													</div>
												</li>
									
											</ul>
										
										</li>
									</c:when>
								
								</c:choose>
							</ul>
						</div>
					</nav>
				</div>
			</div>
		</div>
	</div>



  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="${pageContext.servletContext.contextPath}/resources/js/utility.js"></script>
  	

<div class="overlay"></div>
<div class="modal" id="myModal" >


  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 id= "modal-title" class="modal-title">${errorMessageTitle}</h4>
        <button type="button" class="close" data-dismiss="modal" onclick='ColseMyAlert()'>&times;</button>
      </div>


      <!-- Modal body -->
      <div id= "modal-body" class="modal-body">
       ${errorMessage}
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" onclick='ColseMyAlert()' data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>

   	
	<script>
	
	if( "${errorMessageTitle}" != "" && "${errorMessage}" != "" ){
		myAlert();
	}
	 	 
	if( "${sessionScope.login}" != "" ){
		Ajax("GET","/api/loginImage",function(data){
		
			$("#userImage").attr("src",data);
		})
	}
	

	
	</script>
</body>
</html>
