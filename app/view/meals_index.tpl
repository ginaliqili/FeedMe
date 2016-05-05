<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">

	<title>FeedMe</title>

	<!--Font Awesome -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/styles.css">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/show_styles.css">

	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
	<script type="text/javascript" src="<?= BASE_URL ?>/public/js/scripts.js"></script>
	<script type="text/javascript" src="<?= BASE_URL ?>/public/js/meals_index.js"></script>
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
				<span>Meals</span>
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
			<div id="menu_bar">
				<?php
				$current_user = isset($_SESSION['username']) ? user::load_by_username($_SESSION['username']) : null;
				if ($current_user != null) {
				?>
				<div id="home" class="btn-group-vertical" role="group">
					<button type="button" class="btn btn-default"><a href="<?= BASE_URL ?>"><i class="fa fa-home"></i>&nbsp;Home&nbsp;</a></button>

					<form method="GET" action="<?= BASE_URL ?>/meals/new">
						<button type="submit button" class="btn btn-default"><i class="fa fa-cutlery"></i>&nbsp;Create Meal&nbsp;</button>
					</form>

					<form method="GET" action="<?= BASE_URL ?>/meals/import">
						<button type="submit button" class="btn btn-default"><i class="fa fa-cloud-download"></i>&nbsp;Import Meal</button>
					</form>

					<form method="GET" action="<?= BASE_URL ?>/users/<?= $current_user->get('id') ?>">
						<button type="submit button" class="btn btn-default"><i class="fa fa-user"></i>&nbsp;View Profile&nbsp;</button>
					</form>

					<form method="GET" action="<?= BASE_URL ?>/cookbooks">
						<button type="submit button" class="btn btn-default"><i class="fa fa-book"></i>&nbsp;Cookbook&nbsp;&nbsp;&nbsp;&nbsp;</button>
					</form>

					<form method="GET" action="<?= BASE_URL ?>/users/<?= $current_user->get('id') ?>/following">
						<button type="submit button" class="btn btn-default"><i class="fa fa-users"></i>&nbsp;Following&nbsp;&nbsp;&nbsp;&nbsp;</button>
					</form>

					<form method="GET" action="<?= BASE_URL ?>/users/<?= $current_user->get('id') ?>/followers">
						<button type="submit button" class="btn btn-default"><i class="fa fa-users"></i>&nbsp;Followers&nbsp;&nbsp;&nbsp;&nbsp;</button>
					</form>

					<?php
					if ($_SESSION['admin'] == 1) {
					?>
					<form method="GET" action="<?= BASE_URL ?>/users">
						<button type="submit button" class="btn btn-default"><i class="fa fa-list"></i>&nbsp;Users List&nbsp;&nbsp;&nbsp;&nbsp;</button>
					</form>
					<?php } ?>

					<button id="favorites" type="button" class="btn btn-default"><i class="fa fa-heart"></i>&nbsp;Favorites</button>
				</div>
				<?php } ?>
				<div id="favorites_bar">
					<ul class="list-group">
						<?php
						if (isset($_SESSION['username'])) {
							if ($favorites != null) {
							foreach($favorites as $favorite) {
								$meal_id = $favorite->get('meal_id');
								$meal_title = $favorite->get('meal_title');
						?>
						<a href="<?= BASE_URL ?>/meals/<?= $meal_id ?>"><li class="list-group-item"><?= $meal_title ?></li></a>
						<?php }
						?>

						<a href="<?= BASE_URL ?>/meals/favorites"><li class="list-group-item">Edit Favorites</li></a>

						<?php } } ?>
					</ul>
				</div>
			</div>

			<div id="main_heading">
				<?php
				if ($meals != null) {
				?>
				<h1>This should fill you up</h1>
				<?php
				} else {
				?>
				<h1>No meals were found</h1>
				<?php } ?>
			</div>

			<div id="main_content">
				<?php
				if ($meals != null) {
					$num_meals = count($meals);
					for($i = 0; $i < $num_meals; $i++) {
						$meal = $meals[$i];
						$meal_id = $meal->get('id');
						$meal_title = $meal->get('title');
						$meal_creator = user::load_by_id($meal->get('creator_id'));
						$meal_description = $meal->get('description');
						$meal_meal_type = $meal->get('meal_type');
						$meal_food_type = $meal->get('food_type');
						$meal_time_to_prepare = $meal->get('time_to_prepare');
						$meal_image_url = $meal->get('image_url');
				?>
				<input type="hidden" name="num_meals" value="<?= $num_meals ?>" />

				<div class="meal_content <?php echo ($i > 0 ? 'hidden_meal' : 'shown_meal'); ?>" id="meal_<?= $i ?>">
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
							if (isset($_SESSION['username']) &&
								($meal_creator->get('username') == $_SESSION['username'] ||
								(isset($_SESSION['admin']) && ($_SESSION['admin'] == 1)))) {
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

			<?php
			if ($meals != null) {
			?>
			<div id="main_decision">
				<button id="something_else" type="button submit" class="btn btn-primary btn-lg">Feed me something else</button>
				<button id="matching_food" type="button submit" class="btn btn-primary btn-lg">Show me all matching food</button>
			</div>
			<?php } ?>
		</div>
	</div>

	<footer>
		<p>Copyright 2016: All Rights Reserved</p>
	</footer>
</body>

</html>
