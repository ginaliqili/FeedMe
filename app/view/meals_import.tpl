<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">

	<title>FeedMe</title>

	<!--Font Awesome -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>


	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/styles.css">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/meal_show_styles.css">

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
	<script type="text/javascript" src="<?= BASE_URL ?>/public/js/scripts.js"></script>
</head>

<body>
	<div id="wrapper">
		<header>
			<nav id="authenticate">
				<?php
					if (!isset($_SESSION['username']) || $_SESSION['username'] == '') {
				?>
				<form method="POST" action="<?= BASE_URL ?>/login">
					<label>Username: <input id="username" type="text" name="username"></label>
					<label>Password: <input id="password" type="password" name="password"></label>
					<button type="button submit" class="btn btn-primary btn-sm">Log In</button>
				</form>
				<form method="POST" action="<?= BASE_URL ?>/signup">
					<button type="button submit" class="btn btn-primary btn-sm">Sign Up</button>
				</form>
				<?php
				} else {
				?>
				<p>Logged in as <strong><?= $_SESSION['username'] ?></strong></p>
				<form method="POST" action="<?= BASE_URL ?>/logout">
					<button type="button submit" class="btn btn-primary btn-sm">Log Out</button>
				</form>
				<?php
				}
				?>
			</nav>

			<nav id="breadcrumb">
				<a href="<?= BASE_URL ?>">Home</a>
				<i class="fa fa-caret-right"></i>
				<a href="<?= BASE_URL ?>/meals">Meals</a>
				<i class="fa fa-caret-right"></i>
				<a href="<?= BASE_URL ?>/meals/new">New</a>
			</nav>



			<div id="search">
				<p>Know what you're looking for?</p>
				<input type="text" value="Tasty meal.."/>
				<form method="GET" action="<?= BASE_URL ?>/meals">
					<button type="button submit" class="btn btn-primary btn-sm">Search</button>
				</form>
			</div>
		</header>

		<div id="content">
			<div id="main_heading">
				<h1>Import a Meal</h1>
        <h2>From Spoonacular</h2>
			</div>
			<div id="main_content">
				<form method="POST" action="<?= BASE_URL ?>/meals/searchapi">
					<div class="meal_content">

						<div class="input-group title">
							<span class="input-group-addon"><i class="fa fa-pencil-square-o"></i></span>
								<input class="form-control" type="text" name="title" placeholder="MANDATORY: Title of Food (e.g: Burger)">
								
						</div>
						<br>

						<div class="input-group meal_type">
							<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
							<!-- <input class="form-control" type="text" name="meal_type" placeholder="Meal Type"> -->
							
							<select name="meal_type">
								<option value='nothing' selected="selected">Meal Type</option>
								<option value="breakfast">Breakfast</option>
								<option value="lunch">Lunch</option>
								<option value="dinner">Dinner</option>
								<option value="dessert">Dessert</option>
							</select>
						</div>
						<br>

						<div class="input-group food_type">
							<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
							<!-- <input class="form-control" type="text" name="food_type" placeholder="Food Type"> -->
							
							<select name="food_type" placeholder = "Title">
								<option value = "nothing" selected = "selected">Food Type</option>
								<option value = "american">American</option>
								<option value="italian">Italian</option>
								<option value="chinese">Chinese</option>
								<option value="spanish">Spanish</option>
								<option value="Thai">Thai</option>
							</select>
						</div>
						<br>

						<div class="input-group time_to_prepare">
							<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
							<input class="form-control" type="text" name="time_to_prepare" placeholder="Time to Prepare in Minutes">
						</div>
						<br>

					</div>
					<br>
					<button type="button submit" class="btn btn-success btn-lg">Import Meal</button>
				</form>
			</div>
		</div>

		<footer>
			<p>Copyright 2016: All Rights Reserved</p>
		</footer>
	</div>
</body>

</html>