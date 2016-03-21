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

			case 'create_check':
				$this->create_check();
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
		$_SESSION['error'] = "You successfully registered as ".$_SESSION['username'].".";

		// redirect to home page
		header('Location: '.BASE_URL);
	}

	public function create_check() {
		// set the header to hint the response type (JSON) for JQuery's Ajax method
		header('Content-Type: application/json');

		// get the username data
		$username = $_GET['username'];

		// make sure it's a real username
		if(is_null($username) || $username == '') {
			echo json_encode(array('error' => 'Invalid username.'));
		}
		else {
			// okay, it's a real username. Is it available?
			$user = user::load_by_username($username);
			if(is_null($user)) {
				// $user is null, so username is available!
				echo json_encode(array(
					'success' => 'success',
					'check' => 'available'
				));
			}
			else {
				echo json_encode(array(
					'success' => 'success',
					'check' => 'unavailable'
				));
			}
		}
	}
}
