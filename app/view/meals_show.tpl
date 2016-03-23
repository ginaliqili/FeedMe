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
				<a><?= $meal->get('title') ?></a>
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
				<div class="meal_content">
					<div class="meal_title">
						<h2><?= $meal->get('title') ?></h2>
					</div>

					<div class="meal_creator">
						<h3>Submitted by:&nbsp;</h3>
						<p><?= $creator_username ?></p>
					</div>

					<div class="meal_info">
						<div class="meal_image">
							<img id="meal_image" src="<?= $meal_image_url ?>" alt="<?= $meal->get('title') ?>"/>
						</div>

						<div class="meal_description">
							<h4>Description:</h4>
							<p><?= $meal->get('description') ?></p>
						</div>

						<div class="meal_type">
							<h4>Meal Type:</h4>
							<p><?= $meal->get('meal_type') ?></p>
						</div>

						<div class="food_type">
							<h4>Food Type:</h4>
							<p><?= $meal->get('food_type') ?></p>
						</div>

						<div class="prepare_time">
							<h4>Time to Prepare:</h4>
							<p><?= $meal->get('time_to_prepare') ?></p>
						</div>

						<?php
						if (isset($_SESSION['username']) && $creator_username == $_SESSION['username']) {
						echo '
						<div class="meal_decision">
							<form method="GET" action="'.BASE_URL.'/meals/'.$meal->get('id').'/edit">
								<button id="meal_edit" class="red_button" type="submit">Edit</button>
							</form>
							<form method="POST" action="'.BASE_URL.'/meals/'.$meal->get('id').'/destroy">
								<button id="meal_delete" class="red_button" type="submit">Delete</button>
							</form>
						</div>';}
						?>
					</div>
				</div>
			</div>
		</div>

		<footer>
			<p>Copyright 2016: All Rights Reserved</p>
		</footer>
	</div>
</body>

</html>
