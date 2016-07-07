$(document).ready(function(){
	// Displays a different matching meal when clicked
	$('button#something_else').click(function(){
		// Get the current meal element
		var current_meal = $('.shown_meal');

		// Update the current meal's classes
		current_meal.removeClass('shown_meal');
		current_meal.addClass('hidden_meal');

		// Get the total number of meals found
		var num_meals = $("input[name='num_meals']").val();

		// Randomly generate the ID of the next meal to show
		var next_meal_id = "meal_" + Math.floor(Math.random() * num_meals);

		// Get the next meal element
		var next_meal = $('#' + next_meal_id);

		// Update the next meal's classes
		next_meal.removeClass('hidden_meal');
		next_meal.addClass('shown_meal');
	});

	// Displays additional found meals when clicked
	$('button#matching_food').click(function(){
		// Display the hidden meals
		$('.hidden_meal').show();

		// Remove the meal decision section
		$('#main_decision').hide();
	});
});
