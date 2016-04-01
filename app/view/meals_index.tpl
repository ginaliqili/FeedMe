<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">

	<title>FeedMe</title>

	<!--Font Awesome -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/styles.css">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/meals_show_styles.css">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/meal_show_styles.css">

	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
	<script type="text/javascript" src="<?= BASE_URL ?>/public/js/scripts.js"></script>
</head>

<body>
	<div id="wrapper">
		<header>
			<nav id="authenticate">
				<?php
				if (!isset($_SESSION['username'])) {
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
				<?php } ?>
			</nav>

			<nav id="breadcrumb">
				<a href="<?= BASE_URL ?>">Home</a>
				<i class="fa fa-caret-right"></i>
				<a href="<?= BASE_URL ?>/meals">Meals</a>
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
			<div id="menu_bar" style="position: fixed; float: left; padding: 10px; width: auto;">
				<div class="btn-group-vertical" role="group">
					<button type="button" class="btn btn-default"><a style="color: inherit;" href="<?= BASE_URL ?>"><i class="fa fa-home"></i>&nbsp;Home</a></button>

					<?php
					$current_user = user::load_by_username($_SESSION['username']);
					if ($current_user != null) {
					?>
					<form method="GET" action="<?= BASE_URL ?>/meals/new">
						<button type="submit button" class="btn btn-default"><i class="fa fa-cutlery"></i>&nbsp;Create Meal</button>
					</form>

					<form method="GET" action="<?= BASE_URL ?>/users/<?= $current_user->get('id') ?>/following">
						<button type="submit button" class="btn btn-default"><i class="fa fa-users"></i>&nbsp;Following</button>
					</form>

					<form method="GET" action="<?= BASE_URL ?>/users/<?= $current_user->get('id') ?>/followers">
						<button type="submit button" class="btn btn-default"><i class="fa fa-users"></i>&nbsp;Followers</button>
					</form>

					<button id="favorites" type="button" class="btn btn-default"><i class="fa fa-heart"></i>&nbsp;Favorites</button>
					<?php } ?>
				</div>
			</div>

			<div id="favorites_bar" style="position: fixed; left: 88%; padding: 10px; width: auto;">
				<ul class="list-group">
					<?php
					if (isset($_SESSION['username'])) {
						if ($favorites != null) {
						foreach($favorites as $favorite) {
							$meal_id = $favorite->get('meal_id');
							$meal_title = $favorite->get('meal_title');
					?>
					<a href="<?= BASE_URL ?>/meals/<?= $meal_id ?>"><li class="list-group-item"><?= $meal_title ?></li></a>
					<?php }}} ?>
				</ul>
			</div>

			<div id="main_heading">
				<h1>This should fill you up</h1>
			</div>

			<div id="main_content">
				<?php
				if ($meals != null) {
					foreach($meals as $meal) {
						$meal_id = $meal->get('id');
						$meal_title = $meal->get('title');
						$meal_creator = user::load_by_id($meal->get('creator_id'));
						$meal_description = $meal->get('description');
						$meal_meal_type = $meal->get('meal_type');
						$meal_food_type = $meal->get('food_type');
						$meal_time_to_prepare = $meal->get('time_to_prepare');
						$meal_image_url = $meal->get('image_url');
				?>
				<div class="meal_content">
					<div class="meal_title">
						<h2><?= $meal_title ?></h2>
					</div>

					<div class="meal_creator">
						<h3>Submitted by:&nbsp;</h3>
						<a href="<?= BASE_URL ?>/users/<?= $meal_creator->get('id') ?>"><?= $meal_creator->get('username') ?></a>
					</div>

					<div class="meal_info">
						<div class="meal_image">
							<img id="meal_image" src="<?= $meal_image_url ?>" alt="<?= $meal_title ?>"/>
						</div>

						<div class="meal_description">
							<h4>Description:</h4>
							<p><?= $meal_description ?></p>
						</div>

						<div class="meal_type">
							<h4>Meal Type:</h4>
							<p><?= $meal_meal_type ?></p>
						</div>

						<div class="food_type">
							<h4>Food Type:</h4>
							<p><?= $meal_food_type ?></p>
						</div>

						<div class="prepare_time">
							<h4>Time to Prepare:</h4>
							<p><?= $meal_time_to_prepare ?></p>
						</div>

						<div class="meal_decision">
							<form method="GET" action="<?= BASE_URL ?>/meals/<?= $meal_id ?>">
								<button type="submit button" class="btn btn-success btn-primary btn-lg">Eat Now</button>
							</form>
				<?php
						if (isset($_SESSION['username']) && $meal_creator->get('username') == $_SESSION['username']) {
				?>
							<form method="GET" action="<?= BASE_URL ?>/meals/<?= $meal_id ?>/edit">
								<button id="meal_edit" type="submit button" class="btn btn-primary btn-lg">Edit</button>
							</form>

							<form method="POST" action="<?= BASE_URL ?>/meals/<?= $meal_id ?>/destroy">
								<button id="meal_delete" type="submit button" class="btn btn-primary btn-lg">Delete</button>
							</form>
				<?php } ?>
						</div>
					</div>
				</div>
				<?php }} ?>
			</div>

			<div id="main_decision">
				<button id="something_else" type="button submit" class="btn btn-primary btn-lg">Feed Me something else</button>
				<button id="matching_food" type="button submit" class="btn btn-primary btn-lg">Show me all matching food</button>
			</div>
		</div>

		<footer>
			<p>Copyright 2016: All Rights Reserved</p>
		</footer>
	</div>
</body>

</html>
