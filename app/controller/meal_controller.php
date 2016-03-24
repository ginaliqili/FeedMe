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
		}
	}

  public function index() {
		// get all meals
		$meals = meal::load_all();

		include_once SYSTEM_PATH.'/view/meals_index.tpl';
  }

  public function show($id) {
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

		// get a random meal image from flickr
		$meal_image_url = self::get_meal_image($meal->get('title'));

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
			'instructions' => $_POST['instructions']);

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
		$parameters = array(
			'meal_type' => array_key_exists('meal_type', $_POST) ? $_POST['meal_type'] : null,
			'food_type' => $_POST['food_type'],
			'time_to_prepare' => $_POST['time_to_prepare']);

		$meals = meal::search($parameters);

		include_once SYSTEM_PATH.'/view/meals_index.tpl';
	}

	private static function get_meal_image($meal_title){
		$endpoint = "https://api.flickr.com/services/rest/?";

		// here's the full API call
		$url = $endpoint.
					"method=flickr.photos.search&".
					"api_key=5eb81d061626db798d0aa6aae242c8e1&".
					"text=".urlencode($meal_title)."&".
					"extras=url_n&". // return URL to small image (320 px longest side)
					"sort=relevance&". // sort by relevance
					"safe_search=1&".
					"page=1&".
					"per_page=1&".
					"format=json&".
					"nojsoncallback=1";

		// download results from Flickr API
		$json = file_get_contents($url);

		// decode JSON into php associative array
		$arr = json_decode($json, true);

		// return the picture
		return $arr['photos']['photo'][0]['url_n'];
	}
}
