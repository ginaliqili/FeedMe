// Store the allergies and ingredients for this session
var allergies = [];
var ingredients = [];

$(document).ready(function(){
	// Add existing ingredients from a meal's edit page to the ingredients array
	$('#ingredients_listbox option').each(function() {
		// Get the ingredient
		var ingredient = $(this).val();

		// Add to the list of ingredients
		ingredients.push(ingredient);
	});

	// Add a new allergy
	$('#submit_allergy').click(function() {
		// Get the submitted allergy
		var allergy = $('#new_allergy').val();

		// Validate the submission
		if (allergy != "" && allergy != null) {
			// Clear the field for a new allergy
			$('#new_allergy').val("");
			$('#new_allergy').attr("placeholder", "Enter another allergy");

			// Add to the list of allergies
			allergies.push(allergy);

			// Add to the HTML listbox
			$('#allergies_listbox').append($('<option/>', {
				value: allergy,
				text: allergy
			}));
		}
	});

	// Remove allergies
	$('#remove_allergy').click(function() {
		// Remove each selected allergy
		$('#allergies_listbox option:selected').each(function() {
			// Get the allergy
			var allergy = $(this).val();

			// Remove the allergy from the allergies array
			var index = allergies.indexOf(allergy);
			allergies.splice(index, 1);

			// Remove the option for this allergy
			$(this).remove();
		});
	});

	// Add a new ingredient
	$('#submit_ingredient').click(function() {
		// Get the submitted ingredient
		var ingredient = $('#new_ingredient').val();

		// Validate the submission
		if (ingredient != "" && ingredient != null) {
			// Clear the field for a new ingredient
			$('#new_ingredient').val("");
			$('#new_ingredient').attr("placeholder", "Enter another ingredient");

			// Add to the list of ingredients
			ingredients.push(ingredient);

			// Add to the HTML listbox
			$('#ingredients_listbox').append($('<option/>', {
				value: ingredient,
				text: ingredient
			}));
		}
	});

	// Remove ingredients
	$('#remove_ingredient').click(function() {
		// Remove each selected ingredient
		$('#ingredients_listbox option:selected').each(function() {
			// Get the ingredient
			var ingredient = $(this).val();

			// Remove the ingredient from the ingredients array
			var index = ingredients.indexOf(ingredient);
			ingredients.splice(index, 1);

			// Remove the option for this ingredient
			$(this).remove();
		});
	});

	// Submit the form
	$('#submit_form').click(function() {
		// Get the form element
		var form = $('#meal_form');

		// Append the allergies & ingredients to the form
		$.each(allergies, function(i, allergy) {
			form.append($('<input type="hidden">').attr({
				name: "allergies[]",
				value: allergy
			}));
		});
		$.each(ingredients, function(i, ingredient) {
			form.append($('<input type="hidden">').attr({
				name: "ingredients[]",
				value: ingredient
			}));
		});

		// Submit the form
		form.submit();
	});
});
