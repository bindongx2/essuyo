/**
 * 일반 숫자표기를 원화 표기로 변환한다.
 * ex) 1000000 -> 1,000,000
 */
function dotSplit(number) {
			
			var tempNum = number;
			var priceAry = [];
			var count = 0;
			var result = "";
			
			if ( tempNum == 0 ) return "0";
			
			while(tempNum > 0)
			{
				priceAry.push(tempNum%10);
				tempNum /= 10;
				tempNum = parseInt(tempNum);
				count++;
				
				if( count%3 == 0 && tempNum > 0 )
				{
					priceAry.push(",");
				}
			}
			
			
			priceAry.reverse();
			priceAry.forEach(function(v,i){
				result += v;
			});	
			return result;
			
}

/**
 * Handelbars 라이브러리를 통해 template HTML을 생성한다.
 * 파라미터 
 * 1. templateName : script에 정의되어있는 HTML templte의 ID (ex) "#templateName"
 * 1. appendName   : 변환된 HTML을(결과물) 표시할 element ID (ex) "#appendName"
 * 1. data 		   : HTML 템플릿에 매핑할 data
 */

function makeHTML(templateName, appendName, data){
	var templateHTML = $(templateName).html();
	var compiler = Handlebars.compile(templateHTML);
	var resultHTML = compiler(data);
	
	
	$(appendName).append(resultHTML);
}


function Ajax(method,requestUrl,sendData,success){
	$.ajax({
		type : method,
		url : requestUrl,
		data : sendData,
		success : success,
		error : function(error){
			alert("Ajax error : " + error);
		}
	});
}

function Ajax(method,requestUrl,success){
	$.ajax({
		type : method,
		url : requestUrl,
		success : success,
		error : function(request,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

function myAlert( title, message){
	$(".overlay").show();
	$("#myModal").css("display", "block");
	
	$("#modal-title").text(title);
	$("#modal-body").text(message);
	
}

function ColseMyAlert(){
	$(".overlay").hide();
	$("#myModal").css("display", "none");
}

function ImageThumbnail(imageElementId,inputFileId){
	
	var elImage = document.querySelector(inputFileId);
		elImage.addEventListener("change", function(evt){
		
		var imageCount = evt.target.files.length;
		
		if( imageCount == 1){
		 var image = evt.target.files[0];
		 
		    if(!valideImageType(image)) { 
		    	evt.target.value="";
		    	myAlert("ERROR !", "파일이 이미지 타입이 아닙니다.");
		        return;
		    }
		    
		    //이렇게 넣으면 이미지 정보가 화면에 노출됩니다.
		    var elImage = document.querySelector(imageElementId);
		    elImage.src = window.URL.createObjectURL(image);
		    
		}else{
			var min = $(inputFileId).data("min");
			var max = $(inputFileId).data("max");
			
			if( min > imageCount ){
				myAlert("WARRING !","최소 3개이상 선택해주세요");
				evt.target.value="";
				return;
			}else if( max < imageCount){
				myAlert("WARRING !","최대 "+ evt.target.dataset.max +"개 이상 선택 할 수 없습니다.");
				evt.target.value="";
				return;
			}
			
			for(var i=0; i < imageCount; i++){
				 var image = evt.target.files[i];
				 
				    if(!valideImageType(image)) { 
				    	myAlert("ERROR !", "파일이 이미지 타입이 아닙니다.");
				    	evt.target.value="";
				        return;
				    }
				    //이렇게 넣으면 이미지 정보가 화면에 노출됩니다.
				    var elImage = document.querySelector(imageElementId+i);
				    elImage.src = window.URL.createObjectURL(image);
			}
			
		}
		    


	});
}



function valideImageType(image) {
	const result = ([ 'image/jpeg',
					  'image/png',
					  'image/jpg' ].indexOf(image.type) > -1);
	return result;
}

function getDateRange(startDate, endDate, listDate)

{

    var dateMove = new Date(startDate);

    var strDate = startDate;

    

    if (startDate == endDate)

    {

        var strDate = dateMove.toISOString().slice(0,10);

        listDate.push(strDate);

    }

    else

    {

        while (strDate < endDate)

        {

            var strDate = dateMove.toISOString().slice(0, 10);

            listDate.push(strDate);

            dateMove.setDate(dateMove.getDate() + 1);
        }
    }
    return listDate;
};

//ajax 통신 공통 함수
function getAjaxJSON(url, dataObj){
	var r = null;
	$.ajax(
		url,
		{
		async : false,
		data : dataObj,
		method : "POST",
		error : function(){
			alert("ajax 에러 발생");
		}, success : function(returnData){
			r = returnData;
		}
	});
	return r;
};
