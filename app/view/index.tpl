<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">

	<title>FeedMe</title>

	<!--Font Awesome -->
	<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
	rel="stylesheet" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>public/css/styles.css">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>public/css/index_styles.css">

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
	<script type="text/javascript" src="<?= BASE_URL ?>public/js/scripts.js"></script>
</head>

<body>
	<div id="wrapper">
		<header>
			<nav id="authenticate">
				<?php
					if (!isset($_SESSION['username']) || $_SESSION['username'] == '') {
				?>
				<form method="POST" action="<?= BASE_URL ?>login">
					<label>Username: <input id="username" type="text" name="username"></label>
					<label>Password: <input id="password" type="password" name="password"></label>
					<button type="button submit" class="btn btn-primary btn-sm">Log In</button>
				</form>
				<form method="POST" action="<?= BASE_URL ?>signup">
					<button type="button submit" class="btn btn-primary btn-sm">Sign Up</button>
				</form>
				<?php
				} else {
				?>
				<p>Logged in as <strong><?= $_SESSION['username'] ?></strong></p>
				<form method="POST" action="<?= BASE_URL ?>logout">
					<button type="button submit" class="btn btn-primary btn-sm">Log Out</button>
				</form>
				<?php
				}
				?>
			</nav>

			<nav id="breadcrumb">
				<a href="<?= BASE_URL ?>">Home</a>
			</nav>



			<div id="search">
				<p>Know what you're looking for?</p>
				<input type="text" value="Tasty meal.."/>
				<form method="GET" action="<?= BASE_URL ?>meals">
					<button type="button submit" class="btn btn-primary btn-sm">Search</button>
				</form>
			</div>
		</header>

		<div id="content">

			<div id="menu_bar" style="position: fixed; float: left; padding: 10px; width: auto;">

				<div class="btn-group-vertical" role="group">

					<button type="button" class="btn btn-default"><a style="color: inherit;" href="<?= BASE_URL ?>"><i class="fa fa-home"></i>&nbsp;Home</a></button>

					<?php
					if (isset($_SESSION['username'])) { ?>
					<form method="GET" action="<?= BASE_URL ?>meals/new">
						<button type="submit button" class="btn btn-default"><i class="fa fa-cutlery"></i>&nbsp;Create Meal</button>
					</form>
				<?php }; ?>
					<button id="favorites" type="button" class="btn btn-default"><i class="fa fa-heart"></i>&nbsp;Favorites</button>

				</div>


			</div>

			<div id="favorites_bar" style="position: fixed; display: none; left: 88%; padding: 10px; width: auto;">
				<ul class="list-group">

					<?php
					if (isset($_SESSION['username'])) {
					if ($favorites != null) {
					foreach($favorites as $favorite) {
					$meal_id = $favorite->get('meal_id');
					$meal_title = $favorite->get('meal_title');

					echo '
				<a href="'.BASE_URL.'meals/'.$meal_id.'"<li class="list-group-item">'.$meal_title.'</li></a>';}}}?>
				</ul>
			</div>

			<div id="main_heading">
				<h1>Hungry?</h1>
				<h2>Fill out the following fields to be fed!</h2>
			</div>

			<form method="POST" action="<?= BASE_URL ?>meals/search">

				<div id="main_content">
					<div id="meal_content">
						<table id="meal_options">
								<tr>
									<td>
										<h3>Meal Type:</h3>
										<div>
											<input type="checkbox" name="meal_type[]" value="Breakfast">Breakfast<br>
											<input type="checkbox" name="meal_type[]" value="Lunch">Lunch<br>
											<input type="checkbox" name="meal_type[]" value="Dinner">Dinner<br>
										</div>
									</td>


						<td>
							<h3>Food Type:</h3>
							<select name='food_type'>
								<option selected="selected"></option>
								<option value="American">American</option>
							</select>
						</td>

						<td>
							<h3>Time to Prepare:</h3>
							<select name='time_to_prepare'>
								<option selected="selected"></option>
								<option value = "1 Hour">1 Hour</option>
							</select>
						</td>

						<td>
							<h3>Food Allergies:</h3>
							<div>
								<div id="new_allergy">
									<input type="text" value="enter a food allergy" />
									<button type="button">+</button>
								</div>
								<div id="select_allergies">
									<select id="allergies_listbox" multiple="multiple">
									</select>
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<td>
							<div id="advanced_settings">
							<h3>Advanced Meal Settings:</h3>
							<button id="display_adv" type="button">Display</button>
						</div>
					</td>
					<td class="advanced">
						<h4>Enter Ingredients:</h4>
							<div id="new_ingredient">
								<input type="text" value="enter an ingredient" />
								<button type="submit">+</button>
							</div>
							<div id="select_ingredients">
								<select id="ingredients_listbox" multiple="multiple">
									<option>Potato</option>
									<option>Cheese</option>
								</select>
							</div>
						</td>

						<td class="advanced">
							<h4>Occasion Type:</h4>

								<input type="checkbox" name="meal_type" value="Casual">Casual<br>
								<input type="checkbox" name="meal_type" value="Fancy">Fancy<br>
								<input type="checkbox" name="meal_type" value="Quick">Outdoor<br>

						</td>

						<td class="advanced">
							<h4>Rating:</h4>

								<input type="checkbox" name="meal_type" value="5">5 star<br>
								<input type="checkbox" name="meal_type" value="4">4 star<br>
								<input type="checkbox" name="meal_type" value="3">3 star (and below)<br>

						</td>

					</tr>
				</table>
					</div>
				</div>

				<br>
				<div id="main_submission">
					<button type="button submit" class="btn btn-success btn-lg">Feed Me</button>
				</div>

			</form>

		</div>

		<footer>
			<p>Copyright 2016: All Rights Reserved</p>
		</footer>
	</div>
</body>

</html>
