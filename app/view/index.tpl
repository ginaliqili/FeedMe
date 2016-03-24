<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">

	<title>FeedMe</title>

	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/styles.css">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/index_styles.css">

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
				<a>Home</a>
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
				<h1>Hungry?</h1>
				<h2>Fill out the following fields to be fed!</h2>
			</div>

			<form method="POST" action="<?= BASE_URL ?>/meals/search">

				<div id="main_content">
					<div id="meal_content">
						<div id="meal_type">
							<h3>Meal Type:</h3>
							<div>
								<input type="checkbox" name="meal_type[]" value="Breakfast">Breakfast<br>
								<input type="checkbox" name="meal_type[]" value="Lunch">Lunch<br>
								<input type="checkbox" name="meal_type[]" value="Dinner">Dinner<br>
							</div>
						</div>

						<div id="food_type">
							<h3>Food Type:</h3>
							<select name='food_type'>
								<option selected="selected"></option>
								<option value="American">American</option>
							</select>
						</div>

						<div id="time_to_prepare">
							<h3>Time to Prepare:</h3>
							<select name='time_to_prepare'>
								<option selected="selected"></option>
								<option value = "1 Hour">1 Hour</option>
							</select>
						</div>

						<div id="food_allergies">
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
						</div>

						<div id="advanced_settings">
							<h3>Advanced Meal Settings:</h3>
							<button type="button">Display</button>
						</div>
					</div>
				</div>

				<div id="main_submission">
					<button class="red_button shadow_button" type="submit">Feed Me</button>
				</div>

			</form>

		</div>

		<footer>
			<p>Copyright 2016: All Rights Reserved</p>
		</footer>
	</div>
</body>

</html>
