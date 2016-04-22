$(document).ready(function(){
	// Get the BASE_URL
	var BASE_URL = $("input[name='BASE_URL']").val();

	// Start the activity feed AJAX refresh
	var timer = setInterval(function() {
		// AJAX GET request to see if username is available
		$.get(BASE_URL + '/events').done(function(data) {
			// Work with the response
			$('#activity_feed').html(data);
		});
	}, 5000);

	// Store the allergies and ingredients for this search session
	var allergies = [];
	var ingredients = [];

	// Add a new allergy
	$('#submit_allergy').click(function() {
		// Get the submitted allergy
		var allergy = $('#new_allergy').val();

		// Clear the field for a new allergy
		$('#new_allergy').val("enter another allergy");

		// Validate the submission
		if (allergy != "" && allergy != null) {
			// Add to the list of allergies
			allergies.push(allergy);

			// Add to the HTML listbox
			$('#allergies_listbox').append($('<option/>', {
				value: allergy,
				text: allergy
			}));
		}
	});

	// Add a new ingredient
	$('#submit_ingredient').click(function() {
		// Get the submitted ingredient
		var ingredient = $('#new_ingredient').val();

		// Clear the field for a new ingredient
		$('#new_ingredient').val("enter another ingredient");

		// Validate the submission
		if (ingredient != "" && ingredient != null) {
			// Add to the list of ingredients
			ingredients.push(ingredient);

			// Add to the HTML listbox
			$('#ingredients_listbox').append($('<option/>', {
				value: ingredient,
				text: ingredient
			}));
		}
	});

	// Show advanced meal settings
	$('#display_advanced').click(function() {
		$('.advanced_options').toggle();
	});
});
