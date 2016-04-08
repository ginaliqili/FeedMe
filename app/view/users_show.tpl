<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">

	<title>FeedMe</title>

	<!--Font Awesome -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/styles.css">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/show_styles.css">

	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

	<script type="text/javascript" src="<?= BASE_URL ?>/public/js/scripts.js"></script>
  <script type="text/javascript">



		$(document).ready(function(){
	      <?php
		     $admin = $user->get('admin');
		     $recipeaccess = $user->get('recipeaccess');
		     echo "var admin = '{$admin}';";
		     echo "var recipeaccess = '{$recipeaccess}';";
		  ?>

			$('#admin_edit').click(function(){
		        $('.set').hide();
		        $('.edit').show();
		        $('#showmeals').hide();
						$('#show_followers').hide();
						$('#show_following').hide();
		        $(this).hide();

		     if (admin == 1)
		      	$("#user_type option[value='1']").prop('selected', true);

		     if (recipeaccess == 1)
		     	$("#recipeaccess").prop('checked', true);
			});

			$('#showmeals').click(function(){
				$('.followers_view').hide();
				$('.following_view').hide();

				if ($(this).text() == "Hide User's Uploaded Meals")
					$(this).text("Show User's Uploaded Meals");
				else
					$(this).text("Hide User's Uploaded Meals");

				$('.usermeals').toggle();

			});

			$('#show_followers').click(function(){
				$('.usermeals').hide();
				$('.following_view').hide();

				$('.followers_view').toggle();

			});

			$('#show_following').click(function(){
				$('.usermeals').hide();
				$('.followers_view').hide();

				$('.following_view').toggle();

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
				<span>Users</span>
				<i class="fa fa-caret-right"></i>
				<span><?= $user->get('username') ?></span>
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
					<button type="button" class="btn btn-default"><a href="<?= BASE_URL ?>"><i class="fa fa-home"></i>&nbsp;Home</a></button>

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
				<h1>Users</h1>
			</div>

			<div id="main_content">
				<div class="user_content">
					<div id="username">
						<h2><?= $user->get('username') ?></h2>
					</div>

					<?php
						$current_user = isset($_SESSION['username']) ? user::load_by_username($_SESSION['username']) : null;
						if ($current_user != null && $current_user->get('id') != $user->get('id')) {
							if ($current_user->follows($user->get('id'))) {
						?>
						<form method="POST" action="<?= BASE_URL ?>/users/<?= $user->get('id') ?>/unfollow">
							<button type="button submit" class="btn btn-primary btn-sm">Unfollow</button>
						</form>
						<?php
							} else {
						?>
						<form method="POST" action="<?= BASE_URL ?>/users/<?= $user->get('id') ?>/follow">
							<button type="button submit" class="btn btn-primary btn-sm">Follow</button>
						</form>
					<?php }} ?>

					<?php
					if ($user != null) {
							$user_id = $user->get('id');
	            $username = $user->get('username');
							$password = $user->get('password');
							$first_name = $user->get('first_name');
							$last_name = $user->get('last_name');
	            $email = $user->get('email');
	            $admin = $user->get('admin');
              if ($admin == 1) $user_type = 'admin';
              if ($admin == 0) $user_type = 'registered user';
					?>

					<div class="user_field">
					  <span class="set">First Name:&nbsp;<?= $first_name ?></span>
					</div>

					<div class="user_field">
						<span class="set">Last Name:&nbsp;<?= $last_name ?></span>
					</div>

					<?php
					if (isset($_SESSION['username']) && isset($_SESSION['admin'])) {
						if ($username == $_SESSION['username'] || $_SESSION['admin'] == 1) {
					?>
					<div class="user_field">
					  <span class="set">Password:&nbsp;<?= $password ?></span>
					</div>

					<?php
						}
					}
					?>

					<div class="user_field">
					  <span class="set">Email:&nbsp;<?= $email ?></span>
					</div>

					<div class="user_field">
						<span class="set">User Type:&nbsp;<?= $user_type ?></span>
					</div>

					<form method="POST" action="<?= BASE_URL ?>/users/<?= $user_id ?>/edit">

						<div class = "user_field">
						<span class="edit">
						First Name:&nbsp;
								<input type="text" name = "firstname" value="<?= $first_name ?>">
							</span>
						</div>

						<div class = "user_field">
						<span class="edit">
						Last Name:&nbsp;
								<input type="text" name = "lastname" value="<?= $last_name ?>">
							</span>
						</div>

						<div class = "user_field">
						<span class="edit">
						Password:&nbsp;
								<input type="text" name = "password" value="<?= $password ?>">
							</span>
						</div>

						<div class = "user_field">
						<span class="edit">
						Email:&nbsp;
								<input type="text" name = "email" value="<?= $email ?>">
							</span>
						 </div>

						 <div class = "user_field">
						 <span class="edit">
						 User Type:&nbsp;

						 <?php
								if ($_SESSION['admin'] == 1)
								{
									?>
							<select id="user_type" name = "user_type">
								<option value = 0>Regular User</option>
								<option value = 1>Admin</option>
							</select>
										<?php ;
								}
								else
								{
									echo $user_type;
								}
							?>

						</span>

						<div class="user_field">
						<span class="edit">
							<input type="checkbox" name="recipeaccess" id="recipeaccess" value="true"> Allow other users to view uploaded recipes
						</span>
						</div>
							</div>

							<div class="user_field">
							<span class="edit">
								<input type="submit" value="Submit Changes" class="btn btn-success btn-primary">
							</span>
						</div>

						</form>

						<?php
						if (isset($_SESSION['username'])) {
							if ($_SESSION['username'] == $username || $_SESSION['admin'] == 1) {
							echo '
								 <button id="admin_edit" type="submit button" class="btn btn-success btn-primary" >Edit</button>
							';}}?>

								<?php } ?>

				  <div class="user_field">
						<button type="button submit" id="show_following" class="btn btn-primary btn-sm">Follows</button>
						<button type="button submit" id="show_followers" class="btn btn-primary btn-sm">Followers</button>
				  	<?php
				  	if ($user->get('recipeaccess') == 1) {
				  	?>
				  	<button type="button submit" id="showmeals" class="btn btn-primary btn-sm">Show User's Uploaded Meals</button>
				  	<?php } ?>


            <span class="usermeals">
	            <h2>Uploaded Recipes</h2>
	        		<?php
	          	$meals = meal::load_by_user($user_id);
	          	if ($meals != null) {
	          		foreach($meals as $meal) {
	          	?>
			        <div class="meal_info">
								<div class="meal_image">
									<img id="meal_image" src="<?= $meal->get('image_url') ?>" alt="<?= $meal->get('title') ?>"/>
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

								<div class="meal_decision">
									<?php
									if (isset($_SESSION['username'])) {
									?>
									<input type="hidden" id="meal_id" name="meal_id" value="<?= $meal->get('id') ?>">
									<input type="hidden" id="meal_title" name="meal_title" value="<?= $meal->get('title') ?>">

									<button id="favorite" type="submit button" class="btn btn-success btn-primary btn-lg">Favorite</button>
									<?php
										if ($user->get('username') == $_SESSION['username'] ||
											(isset($_SESSION['admin']) && ($_SESSION['admin'] == 1))) {
									?>
									<form method="GET" action="<?= BASE_URL ?>/meals/<?= $meal->get('id') ?>/edit">
										<button id="meal_edit" type="submit button" class="btn btn-primary btn-lg">Edit</button>
									</form>

									<form method="POST" action="<?= BASE_URL ?>/meals/<?= $meal->get('id') ?>/destroy">
										<button id="meal_delete" type="submit button" class="btn btn-primary btn-lg">Delete</button>
									</form>
									<?php }
									} ?>
								</div>
							</div>
			        <?php }}
			        else {
								echo 'This user does not have any recipes yet';
							} ?>
		        </span>

				  </div>

					<span class="followers_view">
						<h2>Followers</h2>
						<?php
						if ($followers != null) {
							foreach($followers as $follower) {
								$username = $follower->get('username');
								$first_name = $follower->get('first_name');
								$last_name = $follower->get('last_name');
						?>
								<span><a href="<?= BASE_URL ?>/users/<?= $follower->get('id') ?>"><?= $username ?></a></span>
						<?php }} ?>

					</span>

					<span class="following_view">
						<h2>Following</h2>

						<?php
						if ($followers2 != null) {
							foreach($followers2 as $follower2) {
								$username = $follower2->get('username');
								$first_name = $follower2->get('first_name');
								$last_name = $follower2->get('last_name');
						?>
								<span><a href="<?= BASE_URL ?>/users/<?= $follower2->get('id') ?>"><?= $username ?></a></span>
						<?php }} ?>

					</span>


	        </div>
				</div>


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
	</div>

	<footer>
		<p>Copyright 2016: All Rights Reserved</p>
	</footer>
</body>

</html>
