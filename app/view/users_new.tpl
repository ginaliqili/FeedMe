<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">

	<title>FeedMe</title>

	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/styles.css">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/meal_show_styles.css">

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
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
						} else {
							$(textbox).addClass('unavailable');
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
					if (!isset($_SESSION['username']) || $_SESSION['username'] == '') {
				?>

				<form method="POST" action="<?= BASE_URL ?>/login">
					<label>Username: <input type="text" id="username" name="username"></label>
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
				<a href="<?= BASE_URL ?>/meals">Users</a>
				<a>New</a>
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

				<span class="error">
			    <?php
			      if(isset($_SESSION['register_error'])) {
			        if($_SESSION['register_error'] != '') {
			          echo $_SESSION['register_error'];
			        $_SESSION['register_error'] = '';
			        }
			      }
			    ?>
			  </span>

				<form id="register" method="POST" action="<?php echo BASE_URL.'/users/create'; ?>">
					<div class="meal_content">
						<div class="first_name">
							<label>First Name: <input type="text" name="first_name"></label>
						</div>

						<div class="last_name">
							<label>Last Name: <input type="text" name="last_name"></label>
						</div>

						<div class="email">
							<label>Email: <input type="text" name="email"></label>
						</div>

						<div class="username">
							<label>Username: <input type="text" id="uname" name="username"></label>
						</div>

						<div class="password">
							<label>Password: <input type="password" name="password"></label>
						</div>
					</div>
					<button class="red_button shadow_button" type="submit">Create Account</button>
				</form>
			</div>
		</div>

		<footer>
			<p>Copyright 2016: All Rights Reserved</p>
		</footer>
	</div>
</body>

</html>
