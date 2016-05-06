<?php

include_once '../global.php';

// Get the identifier for the page we want to load
$action = $_GET['action'];

// Instantiate a cookbook controller and route it
$cc = new cookbooks_controller();
$cc->route($action);

class cookbooks_controller {
	// Route us to the appropriate class method for this action
	public function route($action) {
		switch($action) {
			case 'index':
				$this->index();
				break;

			case 'create':
        $this->create();
        break;

			case 'add':
				$cookbook_id = $_GET['cookbook_id'];
				$meal_id = $_GET['meal_id'];
				$this->add($cookbook_id, $meal_id);
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
      $cookbooks = cookbook::load_all();
		}
		else {
			$favorites = null;
      $cookbooks = null;
		}

		// Get data for the user being viewed
		$user = user::load_by_username($_SESSION['username']);

		include_once SYSTEM_PATH.'/view/cookbooks_index2.tpl';

  }

  public function create() {
    $user = user::load_by_username($_SESSION['username']);
    $user_id = $user->get('id');
    // Create array of attributes
    $attributes = array(
      'title' => $_POST['title']);

    // Create a new user with the appropriate attributes
    $cookbook = new cookbook($attributes);

    // Save the new user
    $cookbook->save();

    // Redirect to home page
    header('Location: '.BASE_URL .'/cookbooks2');
  }

	public function add($cookbook_id, $meal_id) {
		$attributes = array(
			'cookbook_id' => $cookbook_id,
			'meal_id' => $meal_id
		);
      $cookbook_item = new cookbook_item($attributes);
			$cookbook_item->save();
	}



}
