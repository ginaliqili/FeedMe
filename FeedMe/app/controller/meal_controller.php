<?php

include_once '../global.php';

// get the identifier for the page we want to load
$action = $_GET['action'];

// instantiate a meal controller and route it
$mc = new meal_controller();
$mc->route($action);

class meal_controller {
	// route us to the appropriate class method for this action
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
				$this->new();
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

			case 'search_API':
				$this->search_API();
				break;

			case 'import':
	 			$this->import();
	 			break;

		}
	}

  public function index() {
		// get all favorites
		if (isset($_SESSION['username'])) {
				$favorites = favorite::load_all();
		}
		else {
			$favorites = null;
		}


		// get all meals
		$meals = meal::load_all();

		include_once SYSTEM_PATH.'/view/meals_index.tpl';
  }

  public function show($id) {
		// get all favorites
		if (isset($_SESSION['username'])) {
				$favorites = favorite::load_all();
		}
		else {
			$favorites = null;
		}
		// get data for this meal
		$meal = meal::load_by_id($id);

		// get data for creator of meal
		$creator = user::load_by_id($meal->get('creator_id'));

		// determine the creator's username
		if ($creator != null) {
			$creator_username = $creator->get('username');
		}
		else {
			$creator_username = null;
		}

		include_once SYSTEM_PATH.'/view/meals_show.tpl';
  }

	public function new() {
		include_once SYSTEM_PATH.'/view/meals_new.tpl';
	}

	public function create() {
		// create array of attributes
		$attributes = array(
			'title' => $_POST['title'],
			'description' => $_POST['description'],
			'meal_type' => $_POST['meal_type'],
			'food_type' => $_POST['food_type'],
			'time_to_prepare' => $_POST['time_to_prepare'],
			'instructions' => $_POST['instructions'],
			'image_url' => self::generate_image_url($_POST['title']));

		// create a new meal with the appropriate attributes
		$meal = new meal($attributes);

		// set the creator_id
		$creator = user::load_by_username($_SESSION['username']);
		$meal->set('creator_id', $creator->get('id'));

		// save the new meal
		$meal->save();

		// redirect to show page
		header('Location: ' . BASE_URL . '/meals/' . $meal->get('id'));
	}

	public function edit($id) {
		// get data for this meal
		$meal = meal::load_by_id($id);

		include_once SYSTEM_PATH.'/view/meals_edit.tpl';
	}

	public function update($id) {
		// create array of attributes
		$attributes = array(
			'title' => $_POST['title'],
			'description' => $_POST['description'],
			'meal_type' => $_POST['meal_type'],
			'food_type' => $_POST['food_type'],
			'time_to_prepare' => $_POST['time_to_prepare'],
			'instructions' => $_POST['instructions']);

		// get data for this meal
		$meal = meal::load_by_id($id);

		// update meal data
		$meal->set('title', $attributes['title']);
		$meal->set('description', $attributes['description']);
		$meal->set('meal_type', $attributes['meal_type']);
		$meal->set('food_type', $attributes['food_type']);
		$meal->set('time_to_prepare', $attributes['time_to_prepare']);
		$meal->set('instructions', $attributes['instructions']);

		// save the meal
		$meal->save();

		// redirect to show page
		header('Location: ' . BASE_URL . '/meals/' . $id);
	}

	public function destroy($id) {
		// get data for this meal
		$meal = meal::load_by_id($id);

		// delete the meal
		$meal->delete();

		// redirect to index page
		header('Location: ' . BASE_URL . '/meals/');
	}

	public function search() {
		// Generate the search parameters
		$parameters = array(
			'meal_type' => array_key_exists('meal_type', $_POST) ? $_POST['meal_type'] : null,
			'food_type' => $_POST['food_type'],
			'time_to_prepare' => $_POST['time_to_prepare']);

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

		// save the favorite and eccho json
		if ($favorite->save()) {
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

		// Decode JSON into php associative array
		$arr = json_decode($json, true);

		// Return the image url
		return $arr['photos']['photo'][0]['url_n'];
	}


	public function search_API()
	{
		require_once SYSTEM_PATH.'/unirest-php-master/src/Unirest.php';

		$endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/search?";
		$therest = '';

		if ($_POST['title'] != NULL)
		{
			if ($_POST['food_type'] != NULL)
			{
			 	$therest .= '&cuisine='.$_POST['food_type'];
			 	$food_type = $_POST['food_type'];
			}
			else
			{
				$food_type = "American";
			}
			if ($_POST['meal_type'] != NULL)
			{
			 	$therest .= '&type='.$_POST['meal_type'];
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


		//title, description, meal type, food type, time to prepare, image. 

			foreach($arr['results'] as $food) 
			{
				$time = true;
				if (($_POST['time_to_prepare'] != NULL) && ($food['readyInMinutes'] >= $_POST['time_to_prepare']))
				{
					$time = false;
					$time_to_prepare = $food['readyInMinutes'];
				}

				if ($time)
				{
					$mealid = $food['id'];
					

					$image = $baseUri.$food['image'];

					$title = $food['title']; 

					$readyInMinutes = $food['readyInMinutes'];
								

					$endpoint = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/";
					$therest = $mealid."/summary";
					// These code snippets use an open-source library.
					$response = Unirest\Request::get($endpoint.$therest,
					  array(
					    "X-Mashape-Key" => "cBEkw8VH7smshkE2V2900492f46Lp1G5mvWjsnj5VsCoxCsRpr"
					  )
					);

					$arr_summ = json_decode($response->raw_body, true);

					$description = $arr_summ['summary'];		
				

					$meal = array( 'title' => $title, 'description' => $description, 
									'meal_type' => $meal_type, 'food_type' => $food_type,
									'time_to_prepare' => $readyInMinutes, 
									'image_url' => $image);
					$meals[] = $meal;
				}
			}
		}

		else
		{
			$_SESSION['error'] = "Please enter a title query";
		}

 		include_once SYSTEM_PATH.'/view/food.tpl';
	}

	public function import() {

		$_SESSION['error'] = '';

 		include_once SYSTEM_PATH.'/view/meals_import.tpl';
 
 	}
}
