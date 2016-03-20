<?php

include_once '../global.php';

// get the identifier for the page we want to load
$action = $_GET['action'];

// instantiate a user controller and route it
$uc = new user_controller();
$uc->route($action);

class user_controller {
	// route us to the appropriate class method for this action
	public function route($action) {
		switch($action) {
			case 'new':
				$this->new();
				break;

			case 'create':
				$attributes = array(
					'username' => $_POST['username'],
					'password' => $_POST['password'],
					'email' => $_POST['email'],
					'first_name' => $_POST['first_name'],
					'last_name' => $_POST['last_name']);
				$this->create($attributes);
				break;
		}
	}

	public function new() {
		include_once SYSTEM_PATH.'/view/users_new.tpl';
	}

	public function create($attributes) {
		// create a new user with the appropriate attributes
		$user = new user($attributes);

		// save the new user
		$user->save();

		// log the user in
		$_SESSION['username'] = $user->get('username');
		$_SESSION['error'] = "You are logged in as ".$user->get('username').".";

		// redirect to home page
		header('Location: '.BASE_URL);
	}
}
