$(document).ready(function(){
	// Validate meal data
	$('#meal_form').submit(function() {
		var form = document.forms["meal_form"];

		var title = form["title"].value;
		var description = form["description"].value;
		var meal_type = form["meal_type"].value;
		var food_type = form["food_type"].value;
		var time_to_prepare = form["time_to_prepare"].value;
		var instructions = form["instructions"].value;

		if (title == null || title == "",
				description == null || description == "",
				meal_type == null || meal_type == "",
				food_type == null || food_type == "",
				time_to_prepare == null || time_to_prepare == "",
				instructions == null || instructions == "") {
			alert("Please Fill All Required Field");
			return false;
		}
	});
});
