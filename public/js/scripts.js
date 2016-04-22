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
	$('#display_adv').click(function() {
		$('.advanced').show();
	});

	// Shows Favorites bar
	$('#favorites').click(function() {
		$('#favorites_bar').toggle();
	});
});

function loadTurnJS() {
	// Create the flipbook
	$('.flipbook').turn({
		// Width
		width:922,

		// Height
		height:600,

		// Elevation
		elevation: 50,

		// Enable gradients
		gradients: true,

		// Auto center this flipbook
		autoCenter: true
	});
}
