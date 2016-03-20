<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">

	<title>FeedMe</title>

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
				<a href="<?= BASE_URL ?>/meals">Meals</a>
				<a href="<?= BASE_URL ?>/meals/<?= $meal->get('id') ?>"><?= $meal->get('title') ?></a>
				<a> Edit </a>
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
			<div id="main_content">
				<form method="POST" action="<?= BASE_URL ?>/meals/<?= $meal->get('id') ?>/update">
					<div class="meal_content">
						<div class="title">
							<label>Title:
								<input type="text" name="title" value="<?= $meal->get('title') ?>">
							</label>
						</div>

						<div class="description">
							<label>Description:
								<input type="textarea" name="description" value="<?= $meal->get('description') ?>">
							</label>
						</div>

						<div class="meal_type">
							<label>Meal Type:
								<input type="text" name="meal_type" value="<?= $meal->get('meal_type') ?>">
							</label>
						</div>

						<div class="food_type">
							<label>Food Type:
								<input type="text" name="food_type" value="<?= $meal->get('food_type') ?>">
							</label>
						</div>

						<div class="time_to_prepare">
							<label>Time to Prepare:
								<input type="text" name="time_to_prepare" value="<?= $meal->get('time_to_prepare') ?>">
							</label>
						</div>

						<div class="instructions">
							<label>Instructions:
								<input type="textarea" name="instructions" value="<?= $meal->get('instructions') ?>">
							</label>
						</div>
					</div>
					<button class="red_button shadow_button" type="submit">Update Meal</button>
				</form>
			</div>
		</div>

		<footer>
			<p>Copyright 2016: All Rights Reserved</p>
		</footer>
	</div>
</body>

</html>
