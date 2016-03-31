<?php

include_once '../global.php';

// Get the identifier for the page we want to load
$action = $_GET['action'];

// Instantiate a user controller and route it
$uc = new user_controller();
$uc->route($action);

class user_controller {
	// Route us to the appropriate class method for this action
	public function route($action) {
		switch($action) {
			case 'show':
				$user_id = $_GET['user_id'];
				$this->show($user_id);
				break;

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

	public function show($id) {
		// Get all favorites
		if (isset($_SESSION['username'])) {
			$favorites = favorite::load_all();
		}
		else {
			$favorites = null;
		}

		// Get data for this user
		$user = user::load_by_id($id);

		include_once SYSTEM_PATH.'/view/users_show.tpl';

	public function new() {
		include_once SYSTEM_PATH.'/view/users_new.tpl';
	}

	public function create($attributes) {
		// Do not create if username is not available
		$user = user::load_by_username($_POST['username']);
		if($user) {
			// $user is not null, so username is not available
			$_SESSION['register_error'] = 'Sorry, username '.$_POST['username'].' is already taken. Please choose another one';

			header('Location: '.BASE_URL.'/signup');
			exit();
		}

		// Create a new user with the appropriate attributes
		$user = new user($attributes);

		// Save the new user
		$user->save();

		// Log the user in
		$_SESSION['username'] = $user->get('username');
		$_SESSION['error'] = "You successfully registered as ".$_SESSION['username'].".";

		// Redirect to home page
		header('Location: '.BASE_URL);
		exit();
	}

	public function create_check() {
		// Set the header to hint the response type (JSON) for JQuery's Ajax method
		header('Content-Type: application/json');

		// Get the username data
		$username = $_GET['username'];

		// Make sure it's a real username
		if(is_null($username) || $username == '') {
			echo json_encode(array('error' => 'Invalid username.'));
		}
		else {
			// Okay, it's a real username. Is it available?
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
