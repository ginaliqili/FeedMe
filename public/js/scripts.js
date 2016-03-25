$(document).ready(function(){

	// Removes sample text from a textbox input
	$('input[type=text], textarea').click(function(){
		$(this).val('');
	});

	// Displays additional found meals when clicked
	$('button#matching_food').click(function(){
		$('.hidden').show();
		$('#main_decision').hide();
	});



// Displays advanced meal settings
$('#display').toggle(function() {
	$('.advanced').show();
})

// Shows Favorites bar
$('#favorites').click(function() {
	$('#favorites_bar').toggle();
})



	// // event handler for username textbox on Register page
	// $('#register #uname').blur(function(){
	// 	var textbox = $(this); // remember our trigger textbox
	//
	// 	// first, remove any status classes attached to this textbox
	// 	$(textbox).removeClass('unavailable').removeClass('available');
	//
	// 	// ajax GET request to see if username is available
	// 	$.get('http://localhost/apps/FeedMe/users/create/check', { "username": $(textbox).val() })
	// 		.done(function(data){
	// 			if(data.success == 'success') {
	// 				// successfully reached the server
	// 				if(data.check == 'available') {
	// 					$(textbox).addClass('available');
	// 				} else {
	// 					$(textbox).addClass('unavailable');
	// 				}
	// 			}}).fail(function(){
	// 				alert("Ajax error: could not reach server.");
	// 		});
	// });
});
