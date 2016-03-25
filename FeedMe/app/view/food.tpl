<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">

	<title>FeedMe</title>

	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/styles.css">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/meals_show_styles.css">
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
				<a>Meals</a>
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
					$_SESSION['error'] = '';
				}
			}

			else
			{
				if (isset($_SESSION['username'])) 
				{
					
					if ($meals != null) 
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
							<div id="meal_1" class="meal_content">
								<div class="meal_title">
									<h2>'.$meal_title.'</h2>
								</div>
									<div class="meal_creator">
									<h3>Uploaded from:&nbsp;</h3>
									<p>Spoonacular API</p>
								</div>
									<div class="meal_info">
									<div class="meal_image">
										<img id="meal_image" src="'.$meal_image_url.'" alt="'.$meal_title.'"/>
									</div>
									<div class="meal_description">
										<h4>Description:</h4>
										<p>'.$meal_description.'</p>
									</div>
									<div class="meal_type">
										<h4>Meal Type:</h4>
										<p>'.$meal_meal_type.'</p>
									</div>
									<div class="food_type">
										<h4>Food Type:</h4>
										<p>'.$meal_food_type.'</p>
									</div>
									<div class="prepare_time">
										<h4>Time to Prepare:</h4>
										<p>'.$meal_time_to_prepare.'</p>
									</div>

									<form method="POST" action="'.BASE_URL.'/meals/import" >
								
									<button id="meal_edit" class="red_button" type="submit">Upload</button>
									</form>
								 </div>
							</div>';								
						}//end foreach 
					}//end if 
				} //end if 
				else
				{
					echo 
					'<h2>Log in to upload a meal</h2>';
					if ($meals != null) 
					{
						foreach($meals as $meal) 
						{
							$meal_title = $meal['title'];
							$meal_description = $meal['description'];
							$meal_meal_type = $meal['meal_type'];
							$meal_food_type = $meal['food_type'];
							$meal_time_to_prepare = $meal['time_to_prepare'];
							$meal_image_url = $meal['image_url'];
							echo '
							<div id="meal_1" class="meal_content">
								<div class="meal_title">
									<h2>'.$meal_title.'</h2>
								</div>
									<div class="meal_creator">
									<h3>Uploaded from:&nbsp;</h3>
									<p>Spoonacular API</p>
								</div>
									<div class="meal_info">
									<div class="meal_image">
										<img id="meal_image" src="'.$meal_image_url.'" alt="'.$meal_title.'"/>
									</div>
									<div class="meal_description">
										<h4>Description:</h4>
										<p>'.$meal_description.'</p>
									</div>
									<div class="meal_type">
										<h4>Meal Type:</h4>
										<p>'.$meal_meal_type.'</p>
									</div>
									<div class="food_type">
										<h4>Food Type:</h4>
										<p>'.$meal_food_type.'</p>
									</div>
									<div class="prepare_time">
										<h4>Time to Prepare:</h4>
										<p>'.$meal_time_to_prepare.'</p>
									</div> 
									<button id="meal_edit" class="red_button" type="submit">Upload</button>
												</form>
								</div>
							</div>';								
						}//end foreach 
					} //end if 

				} //end else
			}//end else
		?>
			</div>
		</div>

		<footer>
			<p>Copyright 2016: All Rights Reserved</p>
		</footer>
	</div>
</body>

</html>
