<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">

	<title>FeedMe</title>

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/styles.css">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/index_styles.css">

	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
	<script type="text/javascript" src="<?= BASE_URL ?>/public/js/scripts.js"></script>

	<script type="text/javascript">
		$(document).ready(function(){
			$("#description a").click(function(e){
				e.preventDefault();
				var a_href = $(this).attr('href');
				location.href = 'http://spoonacular.com' + a_href;
			})
		});
	</script>

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

					<?php
					if ($_SESSION['admin'] == 1) {
					?>
					<form method="GET" action="<?= BASE_URL ?>/users">
						<button type="submit button" class="btn btn-default"><i class="fa fa-list"></i>&nbsp;Users List&nbsp;&nbsp;&nbsp;&nbsp;</button>
					</form>
					<?php } ?>


				</div>
				<?php } ?>


			</div>

			<div id="menu_bar_right">
				<div id="right" class="btn-group-vertical" role="group">
					<form method="GET" action="<?= BASE_URL ?>/users/<?= $current_user->get('id') ?>">
						<button type="submit button" class="btn btn-default"><i class="fa fa-user"></i>&nbsp;View Profile&nbsp;</button>
					</form>

					<form method="GET" action="<?= BASE_URL ?>/cookbooks">
						<button type="submit button" class="btn btn-default"><i class="fa fa-book"></i>&nbsp;Cookbooks&nbsp;&nbsp;&nbsp;</button>
					</form>

					<form method="GET" action="<?= BASE_URL ?>/users/<?= $current_user->get('id') ?>/following">
						<button type="submit button" class="btn btn-default"><i class="fa fa-users"></i>&nbsp;Following&nbsp;&nbsp;&nbsp;&nbsp;</button>
					</form>

					<form method="GET" action="<?= BASE_URL ?>/users/<?= $current_user->get('id') ?>/followers">
						<button type="submit button" class="btn btn-default"><i class="fa fa-users"></i>&nbsp;Followers&nbsp;&nbsp;&nbsp;&nbsp;</button>
					</form>

					<button id="favorites" type="button" class="btn btn-default"><i class="fa fa-heart"></i>&nbsp;Favorites</button>
				</div>
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
				<h1>This should fill you up</h1>
			</div>

		<div id="main_content">
			<?php

			if ($_SESSION['error'] != null)
			{
			    if ($_SESSION['error'] != '')
				{
					echo $_SESSION['error'];
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
								<input type = "hidden" name = "title" value = "'.$title.'">
								<input type = "hidden" name = "instructions" value = "'.$instructions.'">
								<input type="hidden" name="image_url" value="'.$meal_image_url.'">
								<div class="meal_image">
									<img id="meal_image" src="'.$meal_image_url.'" alt = "meal image" />
								</div>
								<div id="description" class="meal_description">
									<h4>Description:</h4>

									<input type = "hidden" id="description" name = "description" value = "The recipes description">

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
							<button id="meal_edit" class="btn btn-success btn-lg" type="submit">Upload</button>
							';}'
							</div>
						</div>
					</form>
					 ';
				}//end foreach
			}//end else if
		?>
			</div> <!-- end main content -->
		</div> <!-- end content -->
	</div> <!-- end wrapper -->
	<footer>
		<p>Copyright 2016: All Rights Reserved</p>
	</footer>
</body>

</html>
