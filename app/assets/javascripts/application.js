// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= requite stc.js
//= require jquery.jqplot.min
//= require_tree ./jqplot
//= require_tree ./rockit
//= require_tree .

$(document).on("focus", "[data-behaviour~='datepicker']", function(e){
    $(this).datepicker({"format": "yyyy-mm-dd", "weekStart": 1, "autoclose": true})
});


function getPriceData() {
	$.ajax({
	  type:'GET',
	  url: '/stocks/new_price_time',
	  dataType: 'json',
	  cache: false,
//	  data: 'auth_token='+ auth_token + '&' + ajax_data + '&name=1',
	  success: function(data) {
		$('#ticker').text(data.time_next) },
//			if ( data.error  ) { str = data.error }
//			else { str = 'data1:' + data.data1 + ' , ' + 'data2:' + data.data2 }
//		    $('#showdata').text ( str ) },
	  onError: function() {
		alert('error');
      },
      onDenied: function() {
		alert('denied') ;
      },
      onComplete: function() {
		alert('complete') ;
      }
	});
}