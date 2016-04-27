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
	<script type="text/javascript">
		$(document).ready(function(){
			// event handler for username textbox on Register page
			$('#register #uname').blur(function(){
				var textbox = $(this); // remember our trigger textbox
				// first, remove any status classes attached to this textbox
				$(textbox).removeClass('unavailable').removeClass('available');
				// ajax GET request to see if username is available
				$.get(
					'<?php echo BASE_URL ?>/users/create/check',
					{ "username": $(textbox).val() } )
					.done(function(data){
						if(data.success == 'success') {
							// successfully reached the server
							if(data.check == 'available') {
								$(textbox).addClass('available');
								$('#enabled_button').show();
								$('#create_button').prop('disabled', false);

							} else {
								$(textbox).addClass('unavailable');
								$('#enabled_button').hide();
								$('#create_button').prop('disabled', true);
							}
						}
					 }).fail(function(){
							alert("Ajax error: could not reach server.");
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
				<span>Sign Up</span>
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
			<div id="main_heading">
				<h1>Sign Up for a FeedMe Account</h1>
			</div>

			<div id="main_content">
				<form id="register" method="POST" action="<?php echo BASE_URL.'/users/create'; ?>">
					<div class="user_content">
						<div class="input-group first_name">
							<span class="input-group-addon"><i class="fa fa-smile-o"></i></span>
							<input class="form-control" type="text" name="first_name" placeholder="First Name">
						</div>

						<br>

						<div class="input-group last_name">
							<span class="input-group-addon"><i class="fa fa-smile-o"></i></span>
							<input class="form-control" type="text" name="last_name" placeholder="Last Name">
						</div>

						<br>

						<div class="input-group email">
							<span class="input-group-addon"><i class="fa fa-envelope-o"></i></span>
							<input class="form-control" type="text" name="email" placeholder="Email">
						</div>

						<br>

						<div class="input-group username">
							<span class="input-group-addon"><i class="fa fa-user"></i></span>
							<input class="form-control" type="text" name="username" id="uname" placeholder="Username">
						</div>

						<br>

						<div class="input-group password" id="pw">
							<span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
							<input class="form-control" type="password" name="password" placeholder="Password">
						</div>

						<br>

						<button id="create_button" type="button submit" class="btn btn-success btn-lg">Create Account</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<footer>
		<p>Copyright 2016: All Rights Reserved</p>
	</footer>
</body>

</html>
