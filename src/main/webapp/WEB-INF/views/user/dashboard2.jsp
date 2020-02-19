<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

	<title>Essuyo</title>
	<link rel="icon" type="image/png" sizes="16x16" href="/resources/images/backpack.png">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="../resources/css/chartist/chartist.min.css" rel="stylesheet">
    <link href="../resources/css/style.min.css" rel="stylesheet">
    <link href="../resources/css/simple-line-icons.css" rel="stylesheet">

</head>

<body>
    <div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>

    <div id="main-wrapper" data-navbarbg="skin6" data-theme="light" data-layout="vertical" data-sidebartype="full" data-boxed-layout="full">
        
        <%@ include file="/pageframe/admin-navigation.jsp" %>
        
        <div class="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-9">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">${lineGraphName}</h4>
                                
                                <c:choose>
                                	<c:when test="${userType == 'user'}">
                                	    <span style="background-color:#137eff" class="font-16 font-medium label label-rounded">숙박</span>
                                 		<span style="background-color:#ced4da" class="font-16 font-medium label label-rounded">차량</span>
                               	 		<span style="background-color:#f4c63d" class="font-16 font-medium label label-rounded">문화</span>
                               	 		<span style="background-color:#d17905" class="font-16 font-medium label label-rounded">식당</span> 
                                    </c:when>
                                	
                                	<c:when test="${userType == 'company'}">
                                		<span style="background-color:#137eff" class="font-16 font-medium label label-rounded">예약건수</span>
                                	</c:when>
                                	
                                </c:choose>
                          
                                <div class="sales ct-charts mt-3"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title m-b-5">${sparkLineName}</h5>
                                <h3 class="font-light" id="totalPayment"></h3>
                                <div class="m-t-20 text-center">
                                    <div id="earnings"></div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title m-b-0">${dounutChartName}</h5>
                                <h4 class="font-light">${totalReservtionCount} 회<span class="font-16 text-success font-medium"></span></h4>
                            	
								              <c:choose>
                                	<c:when test="${userType == 'user'}">
                                	    <span style="background-color:#d70206" class="font-16 font-medium label label-rounded">숙박</span>
                                 		<span style="background-color:#f05b4f" class="font-16 font-medium label label-rounded">차량</span>
                               	 		<span style="background-color:#f4c63d" class="font-16 font-medium label label-rounded">문화</span>
                               	 		<span style="background-color:#d17905" class="font-16 font-medium label label-rounded">식당</span> 
								     </c:when>
                                	
                                	<c:when test="${userType == 'company'}">
                                		 <span style="background-color:#d70206" class="font-16 font-medium label label-rounded">남자</span>
                                		 <span style="background-color:#f05b4f" class="font-16 font-medium label label-rounded">여자</span>
                                	</c:when>
                                	
                                </c:choose>
                                
                                <div class="analyzeReservation ct-charts mt-3"></div>
                            </div>
                        </div>
                    </div>
                </div>
     
            </div>
 
            <footer class="footer text-center">
                All Rights Reserved by Nice admin. Designed and Developed by
                <a href="https://wrappixel.com">WrapPixel</a>.
            </footer>
         </div>
  
    </div>


    <script src="../resources/js/jquery/jquery.min.js"></script>
    <script src="../resources/js/popper/umd/popper.min.js"></script>
    <script src="../resources/js/bootstrap/bootstrap.min.js"></script>
    <script src="../resources/js/sparkline.js"></script>
    <script src="../resources/js/userpage/waves.js"></script>
    <script src="../resources/js/userpage/sidebarmenu.js"></script>
    <script src="../resources/js/userpage/custom.min.js"></script>
    <script src="../resources/js/userpage/pages/dashboards/dashboard1.js"></script>
    <script src="../resources/js/chartist/chartist.min.js"></script>
    <script src="../resources/js/chartist/chartist-plugin-tooltip.min.js"></script>
    <script src="../resources/js/utility.js"></script>
    <script src="../resources/js/handlebars.min.js"></script>

  
 
	
    <script>
    var reservationStartNum = 1;
    var commentStartNum = 1;
    var reservationMaxNum = 0;
    var commentMaxNum = 0;
    
    $(document).ready(function(){
   	
    	var total = "${totalPayment}";
    	$("#totalPayment").text(dotSplit(total) + " 원");
    	var type = "${userType}";
    	
    	//< 차트를 설정한다.
    	var lineGraph = ${lineGraph};
    	setLineGraph(lineGraph);
//     	alert("lineGraph : " + lineGraph); 	// lineGraph : 0,0,0,0,0,5,0,0,0,0,0,0  * 4  (12개월로 나눠서 월마다 예약횟수)
    	var dounutChart = ${dounutChart};
	   	setDounutChart(dounutChart);
// 	   	alert("dounutChart : " + dounutChart);    // dounutChart : 5,3,1,2  (예약 횟수=> 숙박/차량/문화/식당 순)
	   	
	   	var monthsPaymentList = ${MonthsPaymentList};
    	setSparkline(monthsPaymentList);
//     	alert("monthsPaymentList : " + monthsPaymentList); // monthsPaymentList : 0,0,0,0,0,2374000,0,0,0,0,0,0 (월별로 예약금액)
    	
    	
    	//< 유저 타입에 따라 예약 리스트 컬럼명 변경
    	setHTMLReservationColumns(type);
        
    	//< Ajax
    	requestReservationList(type,reservationStartNum);
    	requestCommentList(type,commentStartNum);
    	
  });
    
 
    </script>

</body>

</html>