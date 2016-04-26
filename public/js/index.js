$(document).ready(function(){
	// Get the BASE_URL
	var BASE_URL = $("input[name='BASE_URL']").val();

	// Start the activity feed AJAX refresh
	var timer = setInterval(function() {
		// AJAX GET request to retrieve the events
		$.get(BASE_URL + '/events').done(function(data) {
			// Work with the response
			$('#activity_feed').html(data);
		});
	}, 5000);

	// Show advanced meal settings
	$('#display_advanced').click(function() {
		$('.advanced_options').toggle();
	});
});
