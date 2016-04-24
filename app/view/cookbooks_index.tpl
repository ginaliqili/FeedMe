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
		$('#meal_delete').click(function() {
    	$('#myModal').modal();
		});

		loadTurnJS();

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
							<div style="background-image: url(<?= BASE_URL ?>/public/img/book_cover.jpg)"></div>
								<?php
								$meals = meal::load_by_user($user->get('id'));
								if ($meals != null) {
									foreach($meals as $meal) {
								?>
								<div id="curr_page" style="background-color: white">
								<span class="usermeals">
								<span class="meal_info">

									<h3><?= $meal->get('title') ?></h3>
									<span class="meal_image">
										<img id="meal_image" src="<?= $meal->get('image_url') ?>" alt="<?= $meal->get('title') ?>"/>
									</span>

									<span class="meal_description">

										<h4>Description:</h4>
										<p><?= $meal->get('description') ?></p>
									</span>

									<span class="meal_type">
										<h4>Meal Type:</h4>
										<p><?= $meal->get('meal_type') ?></p>
									</span>

									<span class="food_type">
										<h4>Food Type:</h4>
										<p><?= $meal->get('food_type') ?></p>
									</span>

									<span class="prepare_time">
										<h4>Time to Prepare:</h4>
										<p><?= $meal->get('time_to_prepare') ?></p>
									</span>

									<span class="meal_decision">
										<?php
										if (isset($_SESSION['username'])) {
										?>
										<input type="hidden" id="meal_id" name="meal_id" value="<?= $meal->get('id') ?>">
										<input type="hidden" id="meal_title" name="meal_title" value="<?= $meal->get('title') ?>">

										<button class="favorite" type="submit button" class="btn btn-success btn-primary btn-lg">Favorite</button>
										<?php
											if ($user->get('username') == $_SESSION['username'] ||
												(isset($_SESSION['admin']) && ($_SESSION['admin'] == 1))) {
										?>
										<form method="GET" action="<?= BASE_URL ?>/meals/<?= $meal->get('id') ?>/edit">
											<button id="meal_edit" type="submit button" class="btn btn-primary btn-lg">Edit</button>
										</form>

										<form method="GET" action="<?= BASE_URL ?>/cookbooks/<?= $meal->get('id') ?>/destroy">
											<button id="meal_destroy" type="submit button" class="btn btn-primary btn-lg">Delete</button>
										</form>

											<button id="meal_delete" value="<?= $meal->get('id') ?>" type="submit button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#delete_modal">Delete</button>
										<?php }
										} ?>
									</span>
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

<!-- Modal -->
<div class="modal fade" id="myModal" >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Delete</h4>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete meal this meal?</p?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button id="delete_confirm" type="button" class="btn btn-primary btn-danger" data-dismiss="modal">Delete</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>

</html>
