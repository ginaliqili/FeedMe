<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">

	<title>FeedMe</title>

	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/styles.css">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/meals_show_styles.css">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/meal_show_styles.css">

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
	<script type="text/javascript" src="<?= BASE_URL ?>/public/js/scripts.js"></script>

	<script type="text/javascript">
		$(document).ready(function(){
			var meal_id = $('#meal_id').val();
			var meal_title = $('#meal_title').val();

			var favorite_check = "<?= BASE_URL ?>/meals/" + meal_id + "/favorite_check";
			var favorite_action = "<?= BASE_URL ?>/meals/" + meal_id + "/favorite";
			// event handler for meal id for favorite
			$('#favorite').click(function(){
				// AJAX GET request to insert favorite into user's favorite list
				$.get(
					favorite_action,
					{ "meal_id": meal_id, "meal_title": meal_title} )
					.done(function(data){
						if(data.success == 'success') {
							// successfully reached the server
							if(data.check == 'inserted') {
								//alert("inserted");

							} else {
								//alert("not inserted");
							}
						} else if(data.error != '') {
							alert("Error");
						} })
					.fail(function(){
							alert("Ajax error: could not reach server.");
					});
			});
		});
	</script>

</head>

<body>
	<div id="wrapper">
		<header>
			<nav id="authenticate">
				<?php
					if (!isset($_SESSION['username']) || $_SESSION['username'] == '') {
				?>

				<form method="POST" action="<?= BASE_URL ?>/login">
					<label>Username: <input type="text" name="username"></label>
					<label>Password: <input type="password" name="password"></label>
					<button type="submit">Log in</button>
				</form>
				<form method="POST" action="<?= BASE_URL ?>/signup">
					<button type="submit">Sign Up</button>
				</form>

				<?php
				} else {
				?>

				<p>Logged in as <strong><?= $_SESSION['username'] ?></strong></p>
				<form method="POST" action="<?= BASE_URL ?>/logout">
					<button type="submit">Log out?</button>
				</form>
				<form method="GET" action="<?= BASE_URL ?>/meals/new">
					<button type="submit">Create Meal</button>
				</form>

				<?php
				}
				?>
			</nav>

			<nav id="breadcrumb">
				<a href="<?= BASE_URL ?>">Home</a>
				<a>Meals</a>
			</nav>

			<div id="search">
				<p>Know what you're looking for?</p>
				<input type="text" value="Tasty meal.."/>
				<form method="GET" action="<?= BASE_URL ?>/meals">
					<button type="submit">Search</button>
				</form>
			</div>
		</header>

		<div id="content">
			<div id="main_heading">
				<h1>This should fill you up</h1>
			</div>

		<div id="main_content">
			<?php

			if ($_SESSION['error'] != null)
			{
			    if ($_SESSION['error'] != '')
				{
					echo $_SESSION['error'];
					$_SESSION['error'] = '';
				}
			}

			else if ($meals != null) 
			{
				foreach($meals as $meal) 
				{
						
					$meal_title = $meal['title'];
					$meal_description = $meal['description'];
					$meal_meal_type = $meal['meal_type'];
					$meal_food_type = $meal['food_type'];
					$meal_time_to_prepare = $meal['time_to_prepare'];
					$meal_image_url = $meal['image_url'];
					$instructions = "no instructions yet";

					echo '
					<form method="POST" action="'.BASE_URL.'/meals/create_import" >
						<div id="meal_1" class="meal_content">
							<div class="meal_title">
								<h2>'.$meal_title.'</h2>
							</div>
							<div class="meal_creator">
							<h3>Uploaded from:&nbsp;</h3>
							<p>Spoonacular API</p>
							</div>
						<div class="meal_info">
								<input type = "hidden" name = "title" value = "<?= $title ?>"> 
								<input type = "hidden" name = "instructions" value = "'.$instructions.'">
								<input type="hidden" name="image_url" value="'.$meal_image_url.'">
								<div class="meal_image">
									<img id="meal_image" src="'.$meal_image_url.'" alt = "meal image" />
								</div>
								<div class="meal_description">
									<h4>Description:</h4>
									<input type = "hidden" name = "description" value = "'. $meal_description .'">
									'.$meal_description.'
								</div>
								<div class="meal_type">
									<h4>Meal Type:</h4>
									<input type = "hidden" name = "meal_type" value = "'.$meal_meal_type.'">
									'.$meal_meal_type.'
								</div>
								<div class="food_type">
									<h4>Food Type:</h4>
									<input type = "hidden" name = "food_type" value = "'.$meal_food_type.'">'.$meal_food_type.'
								</div>
								<div class="prepare_time">
									<h4>Time to Prepare:</h4>
									<input type = "hidden" name = "time_to_prepare" value = "'.$meal_time_to_prepare.'">
									'.$meal_time_to_prepare.'
								</div>
								';
							if (isset($_SESSION['username'])) 
							{ 
							echo '
							<button id="meal_edit" class="red_button" type="submit">Upload</button> 
							';}'
							</div>
						</div>
					</form>
							<!-- <form>
								<input type="hidden" id="querytitle" name = "querytitle" value="'.$querytitle.'">
								<input type="hidden" id=""
							</form> -->
					 ';								
				}//end foreach 
			}//end else if
		?>
			</div> <!-- end main content -->
		</div> <!-- end content -->

		<footer>
			<p>Copyright 2016: All Rights Reserved</p>
		</footer>
	</div> <!-- end wrapper -->
</body>

</html>
