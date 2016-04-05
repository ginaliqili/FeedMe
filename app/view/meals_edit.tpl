<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">

	<title>FeedMe</title>

	<!--Font Awesome -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/styles.css">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/show_styles.css">

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
				<i class="fa fa-caret-right"></i>
				<a href="<?= BASE_URL ?>/meals/<?= $meal->get('id') ?>"><?= $meal->get('title') ?></a>
				<i class="fa fa-caret-right"></i>
				<span>Edit</span>
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
				<?php
				$current_user = isset($_SESSION['username']) ? user::load_by_username($_SESSION['username']) : null;
				if ($current_user != null) {
				?>
				<div class="btn-group-vertical" role="group">
					<button type="button" class="btn btn-default"><a style="color: inherit;" href="<?= BASE_URL ?>"><i class="fa fa-home"></i>&nbsp;Home</a></button>

					<form method="GET" action="<?= BASE_URL ?>/meals/new">
						<button type="submit button" class="btn btn-default"><i class="fa fa-cutlery"></i>&nbsp;Create Meal</button>
					</form>

					<form method="GET" action="<?= BASE_URL ?>/users/<?= $current_user->get('id') ?>/following">
						<button type="submit button" class="btn btn-default"><i class="fa fa-users"></i>&nbsp;Following&nbsp;&nbsp;&nbsp;</button>
					</form>

					<form method="GET" action="<?= BASE_URL ?>/users/<?= $current_user->get('id') ?>/followers">
						<button type="submit button" class="btn btn-default"><i class="fa fa-users"></i>&nbsp;Followers&nbsp;&nbsp;&nbsp;</button>
					</form>

					<?php
					if ($_SESSION['admin'] == 1) {
					?>
					<form method="GET" action="<?= BASE_URL ?>/users">
						<button type="submit button" class="btn btn-default"><i class="fa fa-list"></i>&nbsp;Users List&nbsp;&nbsp;&nbsp;</button>
					</form>
					<?php } ?>

					<button id="favorites" type="button" class="btn btn-default"><i class="fa fa-heart"></i>&nbsp;Favorites</button>
				</div>
				<?php } ?>
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
				<h1>Update <?= $meal->get('title') ?></h1>
			</div>

			<div id="main_content">
				<form method="POST" action="<?= BASE_URL ?>/meals/<?= $meal->get('id') ?>/update">
					<div class="meal_content">
						<div class="input-group title">
							<span class="input-group-addon"><i class="fa fa-pencil-square-o"></i></span>
							<input class="form-control" type="text" name="title" value="<?= $meal->get('title') ?>" placeholder="Title">
						</div>

						<br>

						<div class="input-group description">
							<span class="input-group-addon"><i class="fa fa-pencil-square-o"></i></span>
							<textarea class="form-control" name="description" value="<?= $meal->get('description') ?>" placeholder="Description"></textarea>
						</div>

						<br>

						<div class="input-group meal_type">
							<span class="input-group-addon"><i class="fa fa-cutlery"></i></span>
							<input class="form-control" type="text" name="meal_type" value="<?= $meal->get('meal_type') ?>" placeholder="Meal Type">
						</div>

						<br>

						<div class="input-group food_type">
							<span class="input-group-addon"><i class="fa fa-globe"></i></span>
							<input class="form-control" type="text" name="food_type" value="<?= $meal->get('food_type') ?>" placeholder="Food Type">
						</div>

						<br>

						<div class="input-group time_to_prepare">
							<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
							<input class="form-control" type="text" name="time_to_prepare" value="<?= $meal->get('time_to_prepare') ?>" placeholder="Time to Prepare">
						</div>

						<br>

						<div class="input-group instructions">
							<span class="input-group-addon"><i class="fa fa-pencil-square-o"></i></span>
							<textarea class="form-control" name="instructions" value="<?= $meal->get('instructions') ?>" placeholder="Instructions"></textarea>
						</div>

						<br>

						<button type="button submit" class="btn btn-success btn-lg">Update Meal</button>
					</div>
				</form>
			</div>
		</div>

		<footer>
			<p>Copyright 2016: All Rights Reserved</p>
		</footer>
	</div>
</body>

</html>
