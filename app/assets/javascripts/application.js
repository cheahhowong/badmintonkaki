// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require underscore
//= require gmaps/google
//= require_tree .

$(document).ready(function(){
	$("#").submit(function(event){
		event.preventDefault();
		$form = $(event.target)
		$formSubmit = $form.find('input[type="submit"]')
		$formSubmit.val('loading')
		$.ajax({
			url: $form.attr('action'),
			method: $form.attr('method'), 
			data: $form.serialize(),
			dataType: "JSON",
			success: function(response){
				
				if(response['saved']==true){
					$formSubmit.val('Shorten')
					let x = "<tr><td><a href=\""+response.long_url+"\">"+response.long_url+"</a></td>"+"<td><a href=\""+response.short_url+"\">https://roxasbitly.herokuapp.com/"+response.short_url+"</a></td>"+"<td><a href=\""+response.count+"\">"+response.count+"</a></td></tr>"
					$('#table table').append(x)
				}
				else {
					alert("Please enter valid URL!")
					$formSubmit.val('Shorten')
				}
			},
			
		});
	});
});