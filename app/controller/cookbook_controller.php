<?php

include_once '../global.php';

// Get the identifier for the page we want to load
$action = $_GET['action'];

// Instantiate a cookbook controller and route it
$cc = new cookbook_controller();
$cc->route($action);

class cookbook_controller {
	// Route us to the appropriate class method for this action
	public function route($action) {
		switch($action) {
			case 'index':
				$this->index();
				break;

			case 'destroy':
				$meal_id = $_GET['meal_id'];
				$this->destroy($meal_id);
				break;

			case 'update':
				$meal_id = $_GET['meal_id'];
				$this->update($meal_id);
				break;

		}
	}

  public function index() {
		if (!isset($_SESSION['username'])) {
			exit();
		}
		// Get all favorites
		if (isset($_SESSION['username'])) {
			$favorites = favorite::load_all();
		}
		else {
			$favorites = null;
		}

		// Get data for the user being viewed
		$user = user::load_by_username($_SESSION['username']);

		include_once SYSTEM_PATH.'/view/cookbooks_index.tpl';

  }

	// same as destroy in meal controller, but redirects to cookbook
	public function destroy($id) {
		// Get data for this meal
		$meal = meal::load_by_id($id);

		// Delete the meal
		$meal->delete();

		// Redirect to index page
		header('Location: ' . BASE_URL . '/cookbooks/');

	}

	// same as update in the meal controller, but redirects to cookbook
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
		header('Location: ' . BASE_URL . '/cookbooks/');
	}


}
