<?php

include_once '../global.php';

// Get the identifier for the page we want to load
$action = $_GET['action'];

// Instantiate a site controller and route it
$sc = new site_controller();
$sc->route($action);

class site_controller {
	// Route us to the appropriate class method for this action
	public function route($action) {
		switch($action) {
			case 'home':
				$this->home();
				break;

			case 'login':
				$this->login();
				break;

			case 'logout':
				$this->logout();
				break;
		}
	}

  public function home() {
		// Get all favorites and relevant events
		if (isset($_SESSION['username'])) {
			$favorites = favorite::load_all();
			$events = event::load_relevant(user::load_by_username($_SESSION['username'])->get('id'));
		}
		else {
			$favorites = null;
			$events = null;
		}

		include_once SYSTEM_PATH.'/view/index.tpl';
  }

	public function login() {
		$username = $_POST['username'];
		$password = $_POST['password'];

		$user = user::load_by_username($username);

		if ($user == null) {
			// Username not found
			$_SESSION['error'] = "Incorrect username.";
		}
		elseif ($user->get('password') != $password) {
			// Passwords don't match
			$_SESSION['error'] = "Incorrect password.";
		}
		else {
			// Log in when password matches
			$_SESSION['username'] = $username;

			// Check if admin
			if($user->get('admin') == 1) {
				$_SESSION['admin'] = 1;
			} else {
				$_SESSION['admin'] = 0;
			}

			// Send success notice
			$_SESSION['success'] = "You are logged in as ".$username.".";
		}

		// Redirect to home page
		header('Location: '.BASE_URL);
	}

	public function logout() {
		// Erase the session
		unset($_SESSION['username']);
		session_destroy();

		// Redirect to home page
		header('Location: '.BASE_URL);
	}
}
