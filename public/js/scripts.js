$(document).ready(function(){
	// Removes sample text from a textbox input
	$('input[type=text], textarea').click(function(){
		$(this).val('');
	});

	// Shows Favorites bar
	$('#favorites').click(function() {
		$('#favorites_bar').toggle();
	});

	$('#meal_form').on('submit', function(e){
        e.preventDefault();
				var a=document.getElementsByClassName('form-control').value();
				if (a=="")
					{
					alert("Please Fill All Required Field");

					}
					else {
						//this.submit();
					}
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
