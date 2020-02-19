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
     
                <div class="row">
                    <!-- column -->
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">예약 리스트  <a href="javascript:refreshList('reservation')"><span class="icon-refresh"></span></a></h4>
                            </div>
                            <div id="scroll-reservation"class="table-responsive" style="overflow:auto; height:210px;">
                                <table class="table table-hover">
                                    <thead>
                                        <tr id="reservation-columns">
                        
                                        </tr>
                                    </thead>
                                    <tbody id="reservation-list">
                               
                                        
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <!-- column -->
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">최근 댓글 목록   <a href="javascript:refreshList('comment')"><span class="icon-refresh"></span></a>
                                
                                </h4>
                            </div>
                            
                            <div id="comment-list" class="comment-widgets" style="height:430px;">
                       
                     
                              
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
    <script src="../resources/js/userpage/pages/dashboards/dashboard1.js"></script>  <!-- 차트에 들어가는 함수 js -->
    <script src="../resources/js/chartist/chartist.min.js"></script>
    <script src="../resources/js/chartist/chartist-plugin-tooltip.min.js"></script>
    <script src="../resources/js/utility.js"></script>
    <script src="../resources/js/handlebars.min.js"></script>

  
    <script type="template" id="comment-user-template">
	  
	<div class="d-flex flex-row comment-row">

        <div class="p-2">
	         <a href="/company/detail?id={{companyId}}"> <img src="{{imageUrl}}" alt="#" width="50" class="rounded-circle"></a>
	     </div>
        <div class="comment-text w-100">
            <h6 class="font-medium">{{title}}</h6>
            <span class="m-b-15 d-block">{{content}}</span>
            <div class="comment-footer">
                <span class="text-muted float-right">{{regDate}}</span>
             </div>
        </div>
	  </div>

    </script>
     <script type="template" id="comment-company-template">
	  
	<div class="d-flex flex-row comment-row">

        <div class="p-2">
	         <a href="/message/register?receiverID={{typeId}}"> <img src="{{imageUrl}}" alt="#" width="50" class="rounded-circle"> </a>
	     </div>
        <div class="comment-text w-100">
            <h6 class="font-medium">{{title}}</h6>
            <span class="m-b-15 d-block">{{content}}</span>
            <div class="comment-footer">
                <span class="text-muted float-right">{{regDate}}</span>
             </div>
        </div>
	  </div>

    </script>
    
    <script type="template" id="reservation-company-template" >
		<tr>
  		   <td class="txt-oflo"><a href="/company/detail?id={{companyId}}">{{typeName}}</a></td>
		   <td class="txt-oflo">{{productName}}</td>
           <td><span class="label label-{{stateClass}} label-rounded">{{state}}</span> </td>
           <td class="txt-oflo">{{resDate}}</td>
           <td><span class="font-medium">{{totalPrice}} 원</span></td>
		   <td><span class="font-medium"><a href="javascript:calcelReservation({{id}});">예약 취소</a></span></td>
        </tr>
	</script>
	
	 <script type="template" id="reservation-user-template" >
		<tr>
  		    <td class="txt-oflo"><a href="/message/register?receiverID={{typeId}}">{{typeName}}</a></td>
		   <td class="txt-oflo">{{productName}}</td>
           <td><span class="label label-{{stateClass}} label-rounded">{{state}}</span> </td>
           <td class="txt-oflo">{{resDate}}</td>
           <td><span class="font-medium">{{totalPrice}} 원</span></td>
 		
        </tr>
	</script>
	
	
	
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
    	
    	var dounutChart = ${dounutChart};
	   	setDounutChart(dounutChart);
	   	
	   	var monthsPaymentList = ${MonthsPaymentList};
    	setSparkline(monthsPaymentList);
    
    	
    	//< 유저 타입에 따라 예약 리스트 컬럼명 변경
    	setHTMLReservationColumns(type);
        
    	//< Ajax
    	requestReservationList(type,reservationStartNum);
    	requestCommentList(type,commentStartNum);
    	
    	//< 스크롤 
      	$("#scroll-reservation").scroll( function() { 
      		var elem = $(this);
      		if ( Math.floor(elem[0].scrollHeight - elem.scrollTop()) == elem.outerHeight()){
      			
      			if( reservationMaxNum != reservationStartNum){
      				reservationStartNum += 1;      			
    				requestReservationList(type,reservationStartNum);
      			}
      		}
      	});
    	
     	$("#comment-list").scroll( function() { 
      		var elem = $(this);
      		if ( Math.floor(elem[0].scrollHeight - elem.scrollTop()) == elem.outerHeight()){
      			
      			if( commentMaxNum !=commentStartNum){
      				commentStartNum += 1;      			
					requestCommentList(type,commentStartNum);
      			}
      		}
      	});
     	
      	

    	
  });
    
    function requestReservationList(type,startPageNum){
    	var requestURL = "/api/reservationList/" + type + "/" + startPageNum +"/" + ${id};
    	Ajax("GET",requestURL,function(responseData){
    		
    		if( responseData != ""){
    			
    			reservationMaxNum = responseData.maxCount;
        		
       		 responseData.reservationList.forEach(function(data){
   				var tempData = {};
   				
   				tempData['id'] = data.id;
   				tempData['typeId'] = data.typeId;
   				tempData['typeName'] = data.typeName;
   				tempData['companyId'] = data.companyId;
   				tempData['productId'] = data.productId;
   				tempData['productName'] = data.productName;
   				tempData['state'] = data.state;
   			
   				if(  data.state == "성공" ){
   					tempData['stateClass'] = "success";
   				}else if(  data.state == "취소" ){
   					tempData['stateClass'] = "danger";
   				}else if(  data.state == "완료" ){
   					tempData['stateClass'] = "info";
   				}
   				tempData['resDate'] = data.resDate;
   				tempData['totalPrice'] = dotSplit(data.totalPrice);
   						
   				if( type == "user")
   					makeHTML("#reservation-company-template", "#reservation-list", tempData);
   				else
   					makeHTML("#reservation-user-template", "#reservation-list", tempData);
   				
   			
   			});
       			if( reservationStartNum == 1)
       			 	$("#scroll-reservation").scrollTop(0);
    			
    		}
    		
		});
    }
	function requestCommentList(type,startPageNum){
		var requestURL = "/api/commentList/" + type + "/" + startPageNum +"/" + ${id};
		Ajax("GET",requestURL,function(responseData){
			
			if( responseData != ""){
				
				commentMaxNum = responseData.maxCount;
			
				responseData.commentList.forEach(function(data){
					
	    				var tempData = {};
	        			tempData['imageUrl'] = data.imageUrl;
	        			tempData['title'] = data.title;
	        			tempData['content'] = data.content;
	        			tempData['regDate'] = data.regDate;

	        			if( type == "user"){
	        				tempData['companyId'] = data.companyId;
	        				makeHTML("#comment-user-template", "#comment-list", tempData);
	        			}else{
	        				makeHTML("#comment-company-template", "#comment-list", tempData);
	        			}
	       
	        			
	        				
					});
				
				if( commentStartNum == 1)
				 	$("#scroll-reservation").scrollTop(0);
				
			}
 	
		}); 
    }
    
    function refreshList(type){
    	if("reservation" == type){
    		$("#reservation-list").empty();
    	    reservationStartNum = 1;
    	    requestReservationList("${userType}",reservationStartNum);
     	}else if( "comment" == type){
    		$("#comment-list").empty();
    		commentStartNum = 1;
    		requestCommentList("${userType}",commentStartNum);
    	}
    	
    }
    
    function calcelReservation(id){
    	var requestURL = "/api/cancel/reservation/"+ id;
		Ajax("GET",requestURL,function(result){
			
			var type = "${userType}";
			
			if( result == true ){
				myAlert("SUCCESS !" ,"예약이 취소되었습니다.");
				$("#reservation-list").empty();
				requestReservationList(type,1);
			}else{
				myAlert("ERROR !" ,"예약 취소가 실패하였습니다.");
			}
		});			
    }
    </script>

</body>

</html>