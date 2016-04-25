<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">

	<title>FeedMe</title>

	<!--Font Awesome -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/styles.css">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/index_styles.css">

	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
	<script type="text/javascript" src="<?= BASE_URL ?>/public/js/scripts.js"></script>
	<script type="text/javascript" src="<?= BASE_URL ?>/public/js/index_scripts.js"></script>
	<input type="hidden" name="BASE_URL" value="<?= BASE_URL ?>" />
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
				<span>Home</span>
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
						<?php }}} ?>
					</ul>
				</div>
			</div>

			<div id="main_heading">
				<h1>Hungry?</h1>
				<h2>Fill out the following fields to be fed!</h2>
			</div>

			<form id="search_form" method="POST" action="<?= BASE_URL ?>/meals/search">
				<div id="main_content">
					<div id="meal_content">
						<table id="meal_options">
							<tr>
								<td>
									<h3>Meal Type:</h3>
									<div>
										<?php
										foreach(MEAL_TYPES as $meal_type) {
										?>
										<input type="checkbox" name="meal_type[]" value="<?= $meal_type ?>">&nbsp;<?= $meal_type ?><br>
										<?php } ?>
									</div>
								</td>

								<td>
									<h3>Food Type:</h3>
									<select name='food_type'>
										<option selected="selected"></option>
										<?php
										foreach(FOOD_TYPES as $food_type) {
										?>
										<option value="<?= $food_type ?>"><?= $food_type ?></option>
										<?php } ?>
									</select>
								</td>

								<td>
									<h3>Time to Prepare:</h3>
									<select name='time_to_prepare'>
										<option selected="selected"></option>
										<?php
										foreach(TIMES_TO_PREPARE as $time_to_prepare) {
										?>
										<option value="<?= $time_to_prepare ?>"><?= $time_to_prepare ?></option>
										<?php } ?>
									</select>
								</td>

								<td>
									<h3>Food Allergies:</h3>
									<div>
										<div id="new_allergies">
											<input id="new_allergy" type="text" placeholder="enter a food allergy" />
											<button id="submit_allergy" type="button">+</button>
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
									<div>
										<h3>Advanced Meal Settings:</h3>
										<button id="display_advanced" type="button">Display</button>
									</div>
								</td>

								<td class="advanced_options">
									<h4>Enter Ingredients:</h4>
									<div id="new_ingredients">
										<input id="new_ingredient" type="text" placeholder="enter an ingredient" />
										<button id="submit_ingredient" type="button">+</button>
									</div>

									<div id="select_ingredients">
										<select id="ingredients_listbox" multiple="multiple">
										</select>
									</div>
								</td>

								<td class="advanced_options">
									<h4>Rating:</h4>
									<?php
									foreach(MEAL_RATINGS as $rating) {
									?>
									<input type="radio" name="meal_rating" value="<?= $rating ?>">&nbsp;<?= $rating ?><br>
									<?php } ?>
								</td>
							</tr>
						</table>

						<br>

						<div id="main_submission">
							<button id="feed_me" type="button" class="btn btn-success btn-lg">Feed Me</button>
						</div>
					</div>
				</div>
			</form>

			<?php
			if ($events != null) {
			?>
			<div id="activity_feed" class="list-group">
				<?php
				foreach ($events as $event) {
				?>
				<div class="event">
					<span class="list-group-item" href="#">
						<span>
							<?php
							echo format_event($event);
							?>
						</span>
					</span>
				</div>
				<?php } ?>
			</div>
			<?php } ?>
		</div>
	</div>

	<footer>
		<p>Copyright 2016: All Rights Reserved</p>
	</footer>
</body>

</html>
