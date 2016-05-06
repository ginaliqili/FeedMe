<?php

include_once '../global.php';

// Get the identifier for the page we want to load
$action = $_GET['action'];

// Instantiate a meal controller and route it
$mc = new meal_controller();
$mc->route($action);

class meal_controller {
	// Route us to the appropriate class method for this action
	public function route($action) {
		switch($action) {
			case 'index':
				$this->index();
				break;

			case 'show':
				$meal_id = $_GET['meal_id'];
				$this->show($meal_id);
				break;

			case 'new':
				$this->new2();
				break;

			case 'create':
				$this->create();
				break;

			case 'edit':
				$meal_id = $_GET['meal_id'];
				$this->edit($meal_id);
				break;

			case 'update':
				$meal_id = $_GET['meal_id'];
				$this->update($meal_id);
				break;

			case 'destroy':
				$meal_id = $_GET['meal_id'];
				$this->destroy($meal_id);
				break;

			case 'search':
				$this->search();
				break;

			case 'favorite':
				$meal_id = $_GET['meal_id'];
				$meal_title = $_GET['meal_title'];
				$this->favorite($meal_id, $meal_title);
				break;

			case 'show_favs':
				$this->show_favs();
				break;

			case 'unfavorite':
				$fav_id = $_GET['fav_id'];
				$this->unfavorite($fav_id);
				break;

			case 'search_API':
				$this->search_API();
				break;

			case 'import':
	 			$this->import();
	 			break;

	 		case 'create_import':
	 			$meal_id = $_GET['meal_id'];
	 			$meal_type = $_GET['meal_type'];
	 			$food_type = $_GET['food_type'];
	 			$title = $_GET['title'];
	 			$time_to_prepare = $_GET['time'];
	 			$image = $_GET['image'];
	 			$this->create_import($meal_id, $meal_type, $food_type, $title, $image, $time_to_prepare);
	 			break;
		}
	}

  public function index() {
		// Get all favorites
		if (isset($_SESSION['username'])) {
			$favorites = favorite::load_all();
		}
		else {
			$favorites = null;
		}

		// Get all meals
		$meals = meal::load_all();

		include_once SYSTEM_PATH.'/view/meals_index.tpl';
  }

  public function show($id) {
		// Get all favorites
		if (isset($_SESSION['username'])) {
			$favorites = favorite::load_all();
		}
		else {
			$favorites = null;
		}

		// Get data for this meal
		$meal = meal::load_by_id($id);

		// Get the creator of this meal
		$creator = user::load_by_id($meal->get('creator_id'));

		include_once SYSTEM_PATH.'/view/meals_show.tpl';
  }

	public function new2() {
		// Get all favorites
		if (isset($_SESSION['username'])) {
			$favorites = favorite::load_all();
		}
		else {
			$favorites = null;
		}

		include_once SYSTEM_PATH.'/view/meals_new.tpl';
	}

	public function create() {
		// Retrieve the meal's creator
		$creator = user::load_by_username($_SESSION['username']);

		// Convert ingredient titles to ingredients
		$ingredient_titles = array_key_exists('ingredients', $_POST) ? $_POST['ingredients'] : null;
		if ($ingredient_titles != null) {
			// Initialize an array of ingredients
			$ingredients = array();

			// Loop through the ingredient titles
			foreach($ingredient_titles as $title) {
				// Fetch the ingredient
				$ingredient = ingredient::load_by_title($title);

				// Check if the ingredient exists
				if ($ingredient == null) {
					// Create and save the ingredient if it doesn't exist
					$ingredient = new ingredient(array(
						'title' => $title));
					$ingredient->save();
				}

				// Add the ingredient to this meal's ingredients
				$ingredients[] = $ingredient;
			}
		}

		// Create array of attributes
		$attributes = array(
			'title' => $_POST['title'],
			'description' => $_POST['description'],
			'meal_type' => $_POST['meal_type'],
			'food_type' => $_POST['food_type'],
			'time_to_prepare' => $_POST['time_to_prepare'],
			'instructions' => $_POST['instructions'],
			'creator_id' => $creator->get('id'),
			'image_url' => self::generate_image_url($_POST['title']),
			'ingredients' => $ingredients);

		// Create a new meal with the appropriate attributes
		$meal = new meal($attributes);

		// Save the new meal and create an associated event
		if ($meal->save()) {
			$event = new event(array(
					'creator_id' => $meal->get('creator_id'),
					'type' => 'meal',
					'action' => 'created',
					'reference_id' => $meal->get('id')));
			$event->save();
		}

		// Redirect to the meal's show page
		header('Location: ' . BASE_URL . '/meals/' . $meal->get('id'));
	}

	public function edit($id) {
		// Get all favorites
		if (isset($_SESSION['username'])) {
			$favorites = favorite::load_all();
		}
		else {
			$favorites = null;
		}

		// Get data for this meal
		$meal = meal::load_by_id($id);

		include_once SYSTEM_PATH.'/view/meals_edit.tpl';
	}

	public function update($id) {
		// Convert ingredient titles to ingredients
		$ingredient_titles = array_key_exists('ingredients', $_POST) ? $_POST['ingredients'] : null;
		if ($ingredient_titles != null) {
			// Initialize an array of ingredients
			$ingredients = array();

			// Loop through the ingredient titles
			foreach($ingredient_titles as $title) {
				// Fetch the ingredient
				$ingredient = ingredient::load_by_title($title);

				// Check if the ingredient exists
				if ($ingredient == null) {
					// Create and save the ingredient if it doesn't exist
					$ingredient = new ingredient(array(
						'title' => $title));
					$ingredient->save();
				}

				// Add the ingredient to this meal's ingredients
				$ingredients[] = $ingredient;
			}
		}

		// Create array of attributes
		$attributes = array(
			'title' => $_POST['title'],
			'description' => $_POST['description'],
			'meal_type' => $_POST['meal_type'],
			'food_type' => $_POST['food_type'],
			'time_to_prepare' => $_POST['time_to_prepare'],
			'instructions' => $_POST['instructions'],
			'ingredients' => $ingredients);

		// Get data for this meal
		$meal = meal::load_by_id($id);

		// Update meal data
		$meal->set('title', $attributes['title']);
		$meal->set('description', $attributes['description']);
		$meal->set('meal_type', $attributes['meal_type']);
		$meal->set('food_type', $attributes['food_type']);
		$meal->set('time_to_prepare', $attributes['time_to_prepare']);
		$meal->set('instructions', $attributes['instructions']);
		$meal->set('ingredients', $attributes['ingredients']);

		// Save the meal and create an associated event
		if ($meal->save()) {
			$event = new event(array(
					'creator_id' => $meal->get('creator_id'),
					'type' => 'meal',
					'action' => 'edited',
					'reference_id' => $meal->get('id')));
			$event->save();
		}

		// Redirect to show page
		header('Location: ' . BASE_URL . '/meals/' . $id);
	}

	public function destroy($id) {
		// Get data for this meal
		$meal = meal::load_by_id($id);

		// Delete the meal
		$meal->delete();

		// Redirect to index page
		header('Location: ' . BASE_URL . '/meals/');
	}

	public function search() {
		// Get all favorites
		if (isset($_SESSION['username'])) {
			$favorites = favorite::load_all();
		}
		else {
			$favorites = null;
		}

		// Generate the search parameters
		$parameters = array(
			'title' => array_key_exists('title', $_GET) ? $_GET['title'] : null,
			'meal_type' => array_key_exists('meal_type', $_GET) ? $_GET['meal_type'] : null,
			'food_type' => array_key_exists('food_type', $_GET) ? $_GET['food_type'] : null,
			'time_to_prepare' => array_key_exists('time_to_prepare', $_GET) ? $_GET['time_to_prepare'] : null,
			'allergies' => array_key_exists('allergies', $_GET) ? $_GET['allergies'] : null,
			'ingredients' => array_key_exists('ingredients', $_GET) ? $_GET['ingredients'] : null);

		//echo $parameters['time_to_prepare'];

		$time_query_string2 = explode(" ", $parameters['time_to_prepare']);

		// Execute the search
		$meals = meal::search($parameters);
		
		// Render the search results
		include_once SYSTEM_PATH.'/view/meals_index.tpl';
	}

	public function favorite($meal_id, $meal_title) {
		header('Content-Type: application/json'); // set the header to hint the response type (JSON) for JQuery's Ajax method
		// Get the user id
		$user = user::load_by_username($_SESSION['username']);
		$user_id = $user->get('id');

		// Create a new favorite
		$favorite = new favorite();
		$favorite->set('meal_id', $meal_id);
		$favorite->set('meal_title', $meal_title);
		$favorite->set('user_id', $user_id);

		// Save the favorite, create an associated event, and echo JSON response
		if ($favorite->save()) {
			$event = new event(array(
					'creator_id' => $user_id,
					'type' => 'meal',
					'action' => 'favorited',
					'reference_id' => $meal_id));
			$event->save();

			echo json_encode(array(
				'success' => 'success',
				'check' => 'inserted'
			));
		}
		else {
			echo json_encode(array(
				'success' => 'success',
				'check' => 'not inserted'
			));
		}
	}

	public function show_favs()
	{
		if (isset($_SESSION['username'])) {
			$favorites = favorite::load_all();
			$meals = array();
			$favs = array();

			if ($favorites != NULL)
			{
				foreach( $favorites as $fav)
				{
					$meal_id = $fav->get('meal_id');
					$favs[] = $fav->get('id');
					$meals[] = meal::load_by_id($meal_id);
				}
			}
		}
		else {
			$favorites = null;
			$meals = null;
			$favs = null;
		}
		include_once SYSTEM_PATH.'/view/meals_favorites.tpl';
	}

	public function unfavorite($fav_id)
	{

		$meal = favorite::load_by_id($fav_id);

		// Delete the meal
		$meal->delete();

		// Redirect to index page
		header('Location: ' . BASE_URL . '/meals/favorites');
	}

	private static function generate_image_url($meal_title){
		$endpoint = "https://api.flickr.com/services/rest/?";

		// Here's the full API call
		$url = $endpoint.
					"method=flickr.photos.search&".
					"api_key=5eb81d061626db798d0aa6aae242c8e1&".
					"text=".urlencode($meal_title)."&".
					"extras=url_n&".
					"sort=relevance&".
					"safe_search=1&".
					"page=1&".
					"per_page=1&".
					"format=json&".
					"nojsoncallback=1";

		// Download results from Flickr API
		$json = file_get_contents($url);

		// Decode JSON into PHP associative array
		$arr = json_decode($json, true);

		// Return the image URL
		return $arr['photos']['photo'][0]['url_n'];
	}


	public function search_API()
	{
		require_once SYSTEM_PATH.'/unirest-php-master/src/Unirest.php';

		$endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/search?";
		$therest = '';

		if ($_POST['title'] != NULL)
		{
			$querytitle = $_POST['title'];
			if ($_POST['food_type'] != "nothing")
			{
			 	$therest .= '&cuisine='.$_POST['food_type'];
			 	$food_type = $_POST['food_type'];
			}
			else
			{
			 	$food_type = "American";
			}
			if ($_POST['meal_type'] != "nothing")
			{
				if ($_POST['meal_type'] == 'lunch' || $_POST['meal_type'] == 'dinner')
				{
					$therest .= '&type=main+course';
				}
				else
				{
			 		$therest .= '&type='.$_POST['meal_type'];
				}
			 	$meal_type = $_POST['meal_type'];
			}
			else
			{
				$meal_type = "Dinner";
			}

			$therest .= '&query='.$_POST['title'];
			$therest = substr($therest, 1);

			// These code snippets use an open-source library.
			$response = Unirest\Request::get($endpoint.$therest,
			  array(
			    "X-Mashape-Key" => "cBEkw8VH7smshkE2V2900492f46Lp1G5mvWjsnj5VsCoxCsRpr"
			  )
			);

			$arr = json_decode($response->raw_body, true);

			$baseUri = $arr['baseUri'];

			$food = null;
			$meals = array();

			if ($_POST['time_to_prepare'] != NULL)
			{
				foreach($arr['results'] as $meal)
				{
					if ($meal['readyInMinutes'] <= $_POST['time_to_prepare'])
					{
						$meals[] = $meal;
					}
				}
			}
			else if ($arr != null)
			{
				$meals = $arr['results'];
			}

			if ($arr != null)
			{
				foreach ($meals as $meal)
				{
					$time_to_prepare = $meal['readyInMinutes'];
					$mealid = $meal['id'];
					$image = $baseUri.$meal['image'];

					$title = $meal['title'];

					$readyInMinutes = $meal['readyInMinutes'];

						$json = array('text' => $title, 'count' => $readyInMinutes, 'id' => $mealid, 'meal_type' => $meal_type, 'food_type' => $food_type, 'image_url' => $image);
						$j[] = $json;
				}
				$json_meals = json_encode($j);
			}
			else
			{
				$_SESSION['error'] = "There are no matches to your search";
			}
		}
		else
		{
			$_SESSION['error'] = "Please enter a title query";
			echo $_SESSION['error'];
		}


 		include_once SYSTEM_PATH.'/view/meals_upload.tpl';
	}

	public function import() {

		$_SESSION['error'] = '';

 		include_once SYSTEM_PATH.'/view/meals_import.tpl';

 	}

 	public function create_import($meal_id, $meal_type, $food_type, $title, $image, $time_to_prepare)
 	{
 		require_once SYSTEM_PATH.'/unirest-php-master/src/Unirest.php';


 		$title = str_replace('_', ' ', $title);

 		$endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/";
		$therest = $meal_id."/summary";

		$response = Unirest\Request::get($endpoint.$therest,
		  array("X-Mashape-Key" => "cBEkw8VH7smshkE2V2900492f46Lp1G5mvWjsnj5VsCoxCsRpr"));

		$arr_summ = json_decode($response->raw_body, true);

		$description = $arr_summ['summary'];

		$description = str_replace('href', 'id', $description);

		$instructions = "no instructions yet";


		if ($time_to_prepare == 60)
		{
			$time_to_prepare = "1 Hour";
		}
		else if ($time_to_prepare < 60)
			$time_to_prepare += " Minutes";
		else
		{
			$time_to_prepare = "More than 1 Hour";
		}

		$attributes = array(
					'title' => $title,
					'description' => $description,
					'meal_type' => $meal_type,
					'food_type' => $food_type,
					'time_to_prepare' => $time_to_prepare,
					'instructions'=> $instructions,
					'image_url' => $image
					);

		// // Create a new meal with the appropriate attributes
		$meal = new meal($attributes);

		// // Set the creator_id
		$creator = user::load_by_username($_SESSION['username']);
		$meal->set('creator_id', $creator->get('id'));


		// Save the new meal and create an associated event
		if ($meal->save()) {
			$event = new event(array(
					'creator_id' => $meal->get('creator_id'),
					'type' => 'meal',
					'action' => 'imported',
					'reference_id' => $meal->get('id')));
			$event->save();
		}

		// // Redirect to show page
		header('Location: ' . BASE_URL . '/meals/' . $meal->get('id'));
 	}
}
