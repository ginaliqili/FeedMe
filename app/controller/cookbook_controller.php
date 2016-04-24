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

		// Get data for the user being viewed
		$user = user::load_by_username($_SESSION['username']);

		include_once SYSTEM_PATH.'/view/cookbooks_index.tpl';

  }

	public function destroy_confirm() {

	}

	public function destroy($id) {
		// Get data for this meal
		$meal = meal::load_by_id($id);

		// Delete the meal
		$meal->delete();

		// Redirect to index page
		header('Location: ' . BASE_URL . '/cookbooks/');

	}

}
