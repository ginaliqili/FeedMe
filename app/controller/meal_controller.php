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
				$attributes = array(
					'title' => $_POST['title'],
					'description' => $_POST['description'],
					'meal_type' => $_POST['meal_type'],
					'food_type' => $_POST['food_type'],
					'time_to_prepare' => $_POST['time_to_prepare'],
					'instructions' => $_POST['instructions']);
				$this->create($attributes);
				break;

			case 'edit':
				$meal_id = $_GET['meal_id'];
				$this->edit($meal_id);
				break;

			case 'update':
				$meal_id = $_GET['meal_id'];
				$attributes = array(
					'title' => $_POST['title'],
					'description' => $_POST['description'],
					'meal_type' => $_POST['meal_type'],
					'food_type' => $_POST['food_type'],
					'time_to_prepare' => $_POST['time_to_prepare'],
					'instructions' => $_POST['instructions']);
				$this->update($meal_id, $attributes);
				break;

			case 'destroy':
				$meal_id = $_GET['meal_id'];
				$this->destroy($meal_id);
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

		include_once SYSTEM_PATH.'/view/meals_show.tpl';
    }

	public function new() {
		include_once SYSTEM_PATH.'/view/meals_new.tpl';
	}

	public function create($attributes) {
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

	public function update($id, $attributes) {
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
}
