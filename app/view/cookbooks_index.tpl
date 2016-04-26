<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">

	<title>FeedMe</title>

	<!--Font Awesome -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
	<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/styles.css">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/cookbook_styles.css">

	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

	<script type="text/javascript" src="<?= BASE_URL ?>/public/js/scripts.js"></script>
	<script type="text/javascript" src="<?= BASE_URL ?>/public/js/turn.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){

		$('.submit_changes').hide();

		$('.meal_edit').click(function(){
			$('.edit').show();
			$('.set').hide();
			$(this).hide();
			$('.submit_changes').show();

		});

		loadTurnJS();

		var get_page_numbers = "<?= BASE_URL ?>/cookbooks/get_page_numbers";
		//$.get(get_page_numbers, function(data) {
			//console.log(data);
			var num_meals = $('#num_meals').val();
			console.log(num_meals);
			//var parsed = JSON.parse(data);
			for (var i = 0; i < num_meals; i++) {
				var elems = document.getElementsByClassName('jump');
				var counter = 3;
				var page = 3;
				for (var i = 0; i < num_meals; i++) {
					page += 1;
					counter += 1;
					elems[i].id = counter
					elems[i].setAttribute("font-size", page);
					$('#' + elems[i].id).click(function() {
						console.log(this.id);
							$(".flipbook").turn("page", this.id);
					});
				}

			}

		//});

		$('.toc').click(function() {
			$(".flipbook").turn("page", 2);
		});

		var meal_id = $('#meal_id').val();
		var meal_title = $('#meal_title').val();

		var favorite_action = "<?= BASE_URL ?>/meals/" + meal_id + "/favorite";
		var destroy_action = "<?= BASE_URL ?>/cookbooks/" + meal_id + "/destroy";
		// event handler for meal id for favorite
		$('.favorite').click(function(){
			alert(meal_title);
			// AJAX GET request to insert favorite into user's favorite list
			$.get(favorite_action, { "meal_id": meal_id, "meal_title": meal_title } );
		});
		// event handler for meak destroy in cookbook
		$('#delete_confirm').click(function(){
			var curr_page = $('#curr_page');
			// AJAX GET request to insert favorite into user's favorite list
			$.get(destroy_action, { "meal_id": $('#meal_delete').val() } )
			.done(function(data){
				if (data.success == 'success') {
					if (data.check == 'deleted') {
						$(curr_page).hide();
					}
				}
			});
		});
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
						<button type="submit button" class="btn btn-default"><i class="fa fa-book"></i>&nbsp;Cookbooks&nbsp;&nbsp;&nbsp;</button>
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

			<div id="main_content">
				<div class="flipbook-viewport">
					<div class="container">
						<div class="flipbook">
							<div style="background-image: url(<?= BASE_URL ?>/public/img/book_cover.jpg)">
								<div style="width: 100px; margin: 0 auto; position: relative; top: 33%;" id="cookbook_title">
									<h3><?= $_SESSION['username']?>'s Cookbook</h3>
								</div>
							</div>
							<div style="background-color: white">
								<h3>Table of Contents</h3>
								<?php
								$page_count = 3;
								$id = 0;
								$meals = meal::load_by_user($user->get('id'));
								$num_meals = sizeof($meals);
								if ($meals != null) {
									foreach($meals as $meal) {
										$meal_id = $meal->get('id');
										$page_count += 1;
										$cookbook = new cookbook();
										$cookbook->set('meal_id', $meal_id);
										$cookbook->set('page_number', $page_count);
										$cookbook->save();
										$id += 1;
										$cookbook_item = cookbook::load_by_id($id);
										$cookbook_id = $cookbook->get('id') + 2;
								?>
								<br />
								<table class="table_of_contents">
									<tbody>
										<tr>
											<td class="title">
												<span><?= $meal->get('title') ?></span>
											</td>
											<td class="page_number">
												<button class="jump btn">page <?= $page_count ?></button><br />
												<input id="num_meals" type="hidden" value="<?= $num_meals ?>">
											</td>
										</tr>
									</tbody>
								</table>

								<?php }

								} ?>
							</div>

							<div style="bakcground-color: white">
								<h3>Add a New Meal</h3>
								<form method="POST" action="<?= BASE_URL ?>/meals/create">
									<div class="meal_content">
										<div class="input-group title">
											<span class="input-group-addon"><i class="fa fa-pencil-square-o"></i></span>
											<input class="form-control" type="text" name="title" placeholder="Title">
										</div>

										<br>

										<div class="input-group description">
											<span class="input-group-addon"><i class="fa fa-pencil-square-o"></i></span>
											<textarea class="form-control" name="description" placeholder="Description"></textarea>
										</div>

										<br>

										<div class="input-group meal_type">
											<span class="input-group-addon"><i class="fa fa-cutlery"></i></span>
											<input class="form-control" type="text" name="meal_type" placeholder="Meal Type">
										</div>

										<br>

										<div class="input-group food_type">
											<span class="input-group-addon"><i class="fa fa-globe"></i></span>
											<input class="form-control" type="text" name="food_type" placeholder="Food Type">
										</div>

										<br>

										<div class="input-group time_to_prepare">
											<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
											<input class="form-control" type="text" name="time_to_prepare" placeholder="Time to Prepare">
										</div>

										<br>

										<div class="input-group instructions">
											<span class="input-group-addon"><i class="fa fa-pencil-square-o"></i></span>
											<textarea class="form-control" name="instructions" placeholder="Instructions"></textarea>
										</div>

										<br>

										<button type="button submit" class="btn btn-success btn-lg">Create Meal</button>
									</div>
								</form>
							</div>

								<?php
								$meals = meal::load_by_user($user->get('id'));
								if ($meals != null) {
									foreach($meals as $meal) {
								?>
								<div id="curr_page" style="background-color: white">
									<button class="btn btn-secondary toc">Table of Contents</button>
								<span class="usermeals">
								<span class="meal_info">
									<form method="POST" action="<?= BASE_URL ?>/cookbooks/<?= $meal->get('id') ?>/update">
									<h3>
										<span class="set"><?= $meal->get('title') ?></span>
										<span class="edit2">
											<input class="edit" type="text" name = "title" value="<?= $meal->get('title') ?>">
										</span>
									</h3>
									<span class="meal_image">
										<img id="meal_image" src="<?= $meal->get('image_url') ?>" alt="<?= $meal->get('title') ?>"/>
									</span>

									<span class="meal_description">

										<h4>Description:</h4>
										<span class="set"><p><?= $meal->get('description') ?></p></span>
										<span class="edit2">
											<input class="edit" type="text" name = "description" value="<?= $meal->get('description') ?>">
										</span>
									</span>

									<span class="meal_type">
										<h4>Meal Type:</h4>
										<span class="set"><p><?= $meal->get('meal_type') ?></p></span>
										<span class="edit2">
											<input class="edit" type="text" name = "meal_type" value="<?= $meal->get('meal_type') ?>">
										</span>
									</span>

									<span class="food_type">
										<h4>Food Type:</h4>
										<span class="set"><p><?= $meal->get('food_type') ?></p></span>
										<span class="edit2">
											<input class="edit" type="text" name = "food_type" value="<?= $meal->get('food_type') ?>">
										</span>
									</span>

									<span class="prepare_time">
										<h4>Time to Prepare:</h4>
										<span class="set"><p><?= $meal->get('time_to_prepare') ?></p></span>
										<span class="edit2">
											<input class="edit" type="text" name = "time_to_prepare" value="<?= $meal->get('time_to_prepare') ?>">
										</span>
									</span>

									<span class="meal_decision">

										<?php
										if (isset($_SESSION['username'])) {
										?>
										<input type="hidden" id="meal_id" name="meal_id" value="<?= $meal->get('id') ?>">
										<input type="hidden" id="meal_title" name="meal_title" value="<?= $meal->get('title') ?>">


										<?php
											if ($user->get('username') == $_SESSION['username'] ||
												(isset($_SESSION['admin']) && ($_SESSION['admin'] == 1))) {
										?>
											<button type="button" class="meal_edit btn btn-primary btn-lg">Edit</button>
											<button type="submit button" class="submit_changes btn btn-primary btn-lg">Submit Changes</button>
										<?php }
										} ?>
									</span>
								</form>

								<form method="GET" action="<?= BASE_URL ?>/cookbooks/<?= $meal->get('id') ?>/destroy">
									<button id="eat_now" type="submit button" class="btn btn-primary btn-lg">Delete</button>
								</form>

								<form method="GET" action="<?= BASE_URL ?>/meals/<?= $meal->get('id') ?>">
									<button id="eat_now" type="submit button" class="btn btn-primary btn-lg btn-success">Eat Now</button>
								</form>


								</span>
							</span>
						</div>
								<?php }}
								else {
									echo 'This user does not have any recipes yet';
								} ?>

							<div style="background-color: white"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<footer>
		<p>Copyright 2016: All Rights Reserved</p>
	</footer>

</body>

</html>
