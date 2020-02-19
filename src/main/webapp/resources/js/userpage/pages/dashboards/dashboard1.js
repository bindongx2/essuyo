/*
Template Name: Admin Pro Admin
Author: Wrappixel
Email: niravjoshi87@gmail.com
File: js
*/
/*$(function() {
    "use strict";

    // ============================================================== 
    // sales ratio
    // ============================================================== 
    var chart = new Chartist.Line('.sales', {
        labels: [1, 2, 3, 4, 5, 6, 7, 8 , 9, 10, 11, 12],
        series: [
            [24, 28, 42, 32, 34, 48, 40, 24, 28, 42, 32, 34],
            [8, 5, 21, 5, 16, 6, 14, 5, 21, 5, 16, 6],
            [0, 15, 21, 30, 46, 56, 64, 21, 30, 46, 56, 64],
            [100, 95, 81, 70, 66, 56, 44, 31, 20, 16, 6, 0]
        ]
    }, {
        low: 0,
        fullWidth: true,
        plugins: [
            Chartist.plugins.tooltip()
        ],
        axisY: {
        	type: Chartist.AutoScaleAxis,
        	offset : 20,
            onlyInteger: true,
            labelInterpolationFnc: function(value) {
                return value + "c";
            }
        },
     

    });

    var seq = 0,
    delays = 30,
    durations = 500;

  // Once the chart is fully created we reset the sequence
  chart.on('created', function() {
    seq = 0;
  });

  // On each drawn element by Chartist we use the Chartist.Svg API to trigger SMIL animations
  chart.on('draw', function(data) {
    seq++;

    if(data.type === 'line') {
      // If the drawn element is a line we do a simple opacity fade in. This could also be achieved using CSS3 animations.
      data.element.animate({
        opacity: {
          // The delay when we like to start the animation
          begin: seq * delays + 1000,
          // Duration of the animation
          dur: durations,
          // The value where the animation should start
          from: 0,
          // The value where it should end
          to: 1
        }
      });
    } else if(data.type === 'label' && data.axis === 'x') {
      data.element.animate({
        y: {
          begin: seq * delays,
          dur: durations,
          from: data.y + 100,
          to: data.y,
          // We can specify an easing function from Chartist.Svg.Easing
          easing: 'easeOutQuart'
        }
      });
    } else if(data.type === 'label' && data.axis === 'y') {
      data.element.animate({
        x: {
          begin: seq * delays,
          dur: durations,
          from: data.x - 100,
          to: data.x,
          easing: 'easeOutQuart'
        }
      });
    } else if(data.type === 'point') {
      data.element.animate({
        x1: {
          begin: seq * delays,
          dur: durations,
          from: data.x - 10,
          to: data.x,
          easing: 'easeOutQuart'
        },
        x2: {
          begin: seq * delays,
          dur: durations,
          from: data.x - 10,
          to: data.x,
          easing: 'easeOutQuart'
        },
        opacity: {
          begin: seq * delays,
          dur: durations,
          from: 0,
          to: 1,
          easing: 'easeOutQuart'
        }
      });
    } 
  });


  var sum = function(a, b) { return a + b };
  var seriesData = [28, 32, 10, 30];
  var chartPie = new Chartist.Pie('.analyzeReservation', {
	  series: seriesData,
	  labels: [28,32,10,30]
	}, {
		
	  donut: true,
	  showLabel: true,
	  labelInterpolationFnc: function(value) {
		  	var cal = (value / seriesData.reduce(sum)) * 100;
		  	return cal.toFixed(1) + "%";
		  }
	});

  chartPie.on('draw', function(data) {
	  if(data.type === 'slice') {
	    // Get the total path length in order to use for dash array animation
	    var pathLength = data.element._node.getTotalLength();

	    // Set a dasharray that matches the path length as prerequisite to animate dashoffset
	    data.element.attr({
	      'stroke-dasharray': pathLength + 'px ' + pathLength + 'px'
	    });

	    // Create animation definition while also assigning an ID to the animation for later sync usage
	    var animationDefinition = {
	      'stroke-dashoffset': {
	        id: 'anim' + data.index,
	        dur: 1000,
	        from: -pathLength + 'px',
	        to:  '0px',
	        easing: Chartist.Svg.Easing.easeOutQuint,
	        // We need to use `fill: 'freeze'` otherwise our animation will fall back to initial (not visible)
	        fill: 'freeze'
	      }
	    };

	    // If this was not the first slice, we need to time the animation so that it uses the end sync event of the previous animation
	    if(data.index !== 0) {
	      animationDefinition['stroke-dashoffset'].begin = 'anim' + (data.index - 1) + '.end';
	    }

	    // We need to set an initial value before the animation starts as we are not in guided mode which would do that for us
	    data.element.attr({
	      'stroke-dashoffset': -pathLength + 'px'
	    });

	    // We can't use guided mode as the animations need to rely on setting begin manually
	    // See http://gionkunz.github.io/chartist-js/api-documentation.html#chartistsvg-function-animate
	    data.element.animate(animationDefinition, false);
	  }
	});
	
    var chart = [chart,chartPie];

    
    
    
    // ============================================================== 
    // Our Visitor
    // ============================================================== 
    var sparklineLogin = function() {
        $('#earnings').sparkline([6, 10, 9, 11, 9, 10, 12, 10, 9, 11, 9, 10], {
            type: 'bar',
            height: '40',
            barWidth: '4',
            width: '100%',
            resize: true,
            barSpacing: '8',
            barColor: '#137eff'
        });
    };
    var sparkResize;

    $(window).resize(function(e) {
        clearTimeout(sparkResize);
        sparkResize = setTimeout(sparklineLogin, 500);
    });
    sparklineLogin();
});
*/

function setLineGraph(ArrayData){

	 var chart = new Chartist.Line('.sales', {
	        labels: [1, 2, 3, 4, 5, 6, 7, 8 , 9, 10, 11, 12],
	        series: ArrayData
	    }, {
	        low: 0,
	        fullWidth: true,
	        plugins: [
	            Chartist.plugins.tooltip()
	        ],
	        axisY: {
	        	type: Chartist.AutoScaleAxis,
	        	offset : 20,
	            onlyInteger: true,
	            labelInterpolationFnc: function(value) {
	                return value ;
	            }
	        },
	     

	    });

	    var seq = 0,
	    delays = 30,
	    durations = 500;

	  // Once the chart is fully created we reset the sequence
	  chart.on('created', function() {
	    seq = 0;
	  });

	  // On each drawn element by Chartist we use the Chartist.Svg API to trigger SMIL animations
	  chart.on('draw', function(data) {
	    seq++;

	    if(data.type === 'line') {
	      // If the drawn element is a line we do a simple opacity fade in. This could also be achieved using CSS3 animations.
	      data.element.animate({
	        opacity: {
	          // The delay when we like to start the animation
	          begin: seq * delays + 1000,
	          // Duration of the animation
	          dur: durations,
	          // The value where the animation should start
	          from: 0,
	          // The value where it should end
	          to: 1
	        }
	      });
	    } else if(data.type === 'label' && data.axis === 'x') {
	      data.element.animate({
	        y: {
	          begin: seq * delays,
	          dur: durations,
	          from: data.y + 100,
	          to: data.y,
	          // We can specify an easing function from Chartist.Svg.Easing
	          easing: 'easeOutQuart'
	        }
	      });
	    } else if(data.type === 'label' && data.axis === 'y') {
	      data.element.animate({
	        x: {
	          begin: seq * delays,
	          dur: durations,
	          from: data.x - 100,
	          to: data.x,
	          easing: 'easeOutQuart'
	        }
	      });
	    } else if(data.type === 'point') {
	      data.element.animate({
	        x1: {
	          begin: seq * delays,
	          dur: durations,
	          from: data.x - 10,
	          to: data.x,
	          easing: 'easeOutQuart'
	        },
	        x2: {
	          begin: seq * delays,
	          dur: durations,
	          from: data.x - 10,
	          to: data.x,
	          easing: 'easeOutQuart'
	        },
	        opacity: {
	          begin: seq * delays,
	          dur: durations,
	          from: 0,
	          to: 1,
	          easing: 'easeOutQuart'
	        }
	      });
	    } 
	  });
	  
}
function setDounutChart(ArrayData){

	  var sum = function(a, b) { return a + b };
	  var seriesData = ArrayData;
	  var chartPie = new Chartist.Pie('.analyzeReservation', {
		  series: seriesData,
		  
		}, {
		
		  labelInterpolationFnc: function(value) {
			  	var cal = (value / seriesData.reduce(sum)) * 100;
			  	return cal.toFixed(1) + "%";
			  }
		});

	  chartPie.on('draw', function(data) {
		  if(data.type === 'slice') {
		    // Get the total path length in order to use for dash array animation
		    var pathLength = data.element._node.getTotalLength();

		    // Set a dasharray that matches the path length as prerequisite to animate dashoffset
		    data.element.attr({
		      'stroke-dasharray': pathLength + 'px ' + pathLength + 'px'
		    });

		    // Create animation definition while also assigning an ID to the animation for later sync usage
		    var animationDefinition = {
		      'stroke-dashoffset': {
		        id: 'anim' + data.index,
		        dur: 1000,
		        from: -pathLength + 'px',
		        to:  '0px',
		        easing: Chartist.Svg.Easing.easeOutQuint,
		        // We need to use `fill: 'freeze'` otherwise our animation will fall back to initial (not visible)
		        fill: 'freeze'
		      }
		    };

		    // If this was not the first slice, we need to time the animation so that it uses the end sync event of the previous animation
		    if(data.index !== 0) {
		      animationDefinition['stroke-dashoffset'].begin = 'anim' + (data.index - 1) + '.end';
		    }

		    // We need to set an initial value before the animation starts as we are not in guided mode which would do that for us
		    data.element.attr({
		      'stroke-dashoffset': -pathLength + 'px'
		    });

		    // We can't use guided mode as the animations need to rely on setting begin manually
		    // See http://gionkunz.github.io/chartist-js/api-documentation.html#chartistsvg-function-animate
		    data.element.animate(animationDefinition, false);
		  }
		});
}

function setSparkline(ArrayData){
	
	 var sparklineLogin = function() {
	        $('#earnings').sparkline(ArrayData, {
	            type: 'bar',
	            height: '40',
	            barWidth: '4',
	            width: '100%',
	            resize: true,
	            barSpacing: '8',
	            barColor: '#137eff'
	        });
	    };
	    var sparkResize;

	    $(window).resize(function(e) {
	        clearTimeout(sparkResize);
	        sparkResize = setTimeout(sparklineLogin, 500);
	    });
	    sparklineLogin();
	    
}
function setHTMLReservationColumns(type){
	var nameList = [];
	
	if( type == "user" ){
		nameList = ['회사명','상품명','상태','예약날짜','총결제 가격',' '];
	}else if  ( type == "company"){
		nameList = ['예약자명','상품명','상태','예약날짜','총결제 가격'];
	}
	
	nameList.forEach(function(column){
		var html = '<th class="border-top-0">' + column + '</th>';
		$("#reservation-columns").append(html);
	});
	
}

