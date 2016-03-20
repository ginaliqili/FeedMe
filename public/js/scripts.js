$(document).ready(function(){
	// Removes sample text from a textbox input
	$('input[type=text], textarea').click(function(){
		$(this).val('');
	});

	// Displays additional found meals when clicked
	$('button#matching_food').click(function(){
		$('.hidden').show();
		$('#main_decision').hide();
	})
});
