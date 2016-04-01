<?php

include_once '../global.php';

// Get the identifier for the page we want to load
$action = $_GET['action'];

// Instantiate a follow controller and route it
$fc = new follow_controller();
$fc->route($action);

class follow_controller {
	// Route us to the appropriate class method for this action
	public function route($action) {
		switch($action) {
			case 'followers':
				$user_id = $_GET['user_id'];
				$this->followers($user_id);
				break;

			case 'following':
				$user_id = $_GET['user_id'];
				$this->following($user_id);
				break;
		}
	}

	public function followers($user_id) {

	}

	public function following($user_id) {

	}
}
