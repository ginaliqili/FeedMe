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

		// Get data for creator of meal
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
		// Create array of attributes
		$attributes = array(
			'title' => $_POST['title'],
			'description' => $_POST['description'],
			'meal_type' => $_POST['meal_type'],
			'food_type' => $_POST['food_type'],
			'time_to_prepare' => $_POST['time_to_prepare'],
			'instructions' => $_POST['instructions'],
			'image_url' => self::generate_image_url($_POST['title']));

		// Create a new meal with the appropriate attributes
		$meal = new meal($attributes);

		// Set the creator_id
		$creator = user::load_by_username($_SESSION['username']);
		$meal->set('creator_id', $creator->get('id'));

		// Save the new meal and create an associated event
		if ($meal->save()) {
			$event = new event(array(
					'creator_id' => $meal->get('creator_id'),
					'type' => 'meal',
					'action' => 'created',
					'reference_id' => $meal->get('id')));
			$event->save();
		}

		// Redirect to show page
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
		// Create array of attributes
		$attributes = array(
			'title' => $_POST['title'],
			'description' => $_POST['description'],
			'meal_type' => $_POST['meal_type'],
			'food_type' => $_POST['food_type'],
			'time_to_prepare' => $_POST['time_to_prepare'],
			'instructions' => $_POST['instructions']);

		// Get data for this meal
		$meal = meal::load_by_id($id);

		// Update meal data
		$meal->set('title', $attributes['title']);
		$meal->set('description', $attributes['description']);
		$meal->set('meal_type', $attributes['meal_type']);
		$meal->set('food_type', $attributes['food_type']);
		$meal->set('time_to_prepare', $attributes['time_to_prepare']);
		$meal->set('instructions', $attributes['instructions']);

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
}
