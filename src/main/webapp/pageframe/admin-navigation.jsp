 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="../resources/css/style.min.css" rel="stylesheet">
    <link href="../resources/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="../resources/css/simple-line-icons.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR">
</head>
<body>
  <header class="topbar" data-navbarbg="skin6">
            <nav class="navbar top-navbar navbar-expand-md navbar-light">
                <div class="navbar-header" data-logobg="skin5">
                
                    <a class="nav-toggler waves-effect waves-light d-block d-md-none" href="javascript:void(0)">
                        <i class="ti-menu ti-close"></i>
                    </a>

                    <div class="navbar-brand">
                        <a href="/" class="logo">
                            <b class="logo-icon">
                                <img  style="width:50px;height:50px" src="/resources/images/backpack.png" alt="homepage" class="light-logo" /> 
                            </b>
                       
                        </a>
                    </div> 
                    <a class="topbartoggler d-block d-md-none waves-effect waves-light" href="javascript:void(0)" data-toggle="collapse" data-target="#navbarSupportedContent"
                        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <i class="ti-more"></i>
                    </a>
                </div>
            </nav>
        </header>
        
    <aside class="left-sidebar" data-sidebarbg="skin5">
            <!-- Sidebar scroll-->
            <div class="scroll-sidebar">
                <!-- Sidebar navigation-->
                <nav class="sidebar-nav">
                    <ul id="sidebarnav">
                                           <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="/user/dashboard" aria-expanded="false">
                                <i class="icon-chart"></i>
                                <span class="hide-menu">예약 종합화면</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="/user/profile" aria-expanded="false">
                                <i class="icon-user"></i>
                                <span class="hide-menu">회원정보</span>
                            </a>
                        </li>
                        
                           <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="/user/companyUpdate" aria-expanded="false">
                                <i class="icon-briefcase"></i>
                                <span class="hide-menu">개인사업장 관리</span>
                            </a>
                        </li>
                        <c:if test="${ !empty sessionScope.companyLogin}">
                                       
                          <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="/user/dashboardCompany" aria-expanded="false">
                                <i class="icon-chart"></i>
                                <span class="hide-menu">개인사업장 종합화면</span>
                            </a>
                          </li>
                          
                           <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="/product/admin" aria-expanded="false">
                                <i class="icon-social-dropbox"></i>
                                <span class="hide-menu">상품관리</span>
                            </a>
                          </li>
                        </c:if>
                        
                         <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="/message/listPage" aria-expanded="false">
                                <i class="icon-envelope-open"></i>
                                <span class="hide-menu">메시지</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="/notice/listPage" aria-expanded="false">
                                <i class="icon-bell"></i>
                                <span class="hide-menu">공지사항</span>
                            </a>
                        </li>
                        
                         <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="/qna/listPage" aria-expanded="false">
                                <i class="icon-earphones-alt"></i>
                                <span class="hide-menu">Q&A</span>
                            </a>
                        </li>
                        
                         <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="/user/dashboard2" aria-expanded="false">
                                <i class="icon-earphones-alt"></i>
                                <span class="hide-menu">DashBoard(연습중)</span>
                            </a>
                        </li>
                        
                         <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="/user/boardPratice" aria-expanded="false">
                                <i class="icon-earphones-alt"></i>
                                <span class="hide-menu">게시판(연습중)</span>
                            </a>
                        </li>
                        
                         <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="/horse/" aria-expanded="false">
                                <i class="icon-earphones-alt"></i>
                                <span class="hide-menu">배당사이트</span>
                            </a>
                        </li>
                        
                          <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="/logout" aria-expanded="false">
                                <i class="icon-logout"></i>
                                <span class="hide-menu">로그 아웃</span>
                            </a>
                        </li>
                      </ul>
                </nav>
            </div>
        </aside>
        
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="../resources/js/utility.js"></script>
    
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
</script>
</body>
</html>