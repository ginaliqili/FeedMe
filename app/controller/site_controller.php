<?php

include_once '../global.php';

// get the identifier for the page we want to load
$action = $_GET['action'];

// instantiate a site controller and route it
$sc = new site_controller();
$sc->route($action);

class site_controller {
	// route us to the appropriate class method for this action
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
		// get all favorites
		if (isset($_SESSION['username'])) {
				$user = user::load_by_username($_SESSION['username']);
				$favorites = favorite::load_all();
		}
		else {
			$favorites = null;
		}

		include_once SYSTEM_PATH.'/view/index.tpl';
  }

	public function login() {
		$username = $_POST['username'];
		$password = $_POST['password'];

		$user = user::load_by_username($username);

		if ($user == null) {
			// username not found
			$_SESSION['error'] = "Incorrect username.";
		}
		elseif ($user->get('password') != $password) {
			// passwords don't match
			$_SESSION['error'] = "Incorrect password.";
		}
		else {
			// log in when password matches
			$_SESSION['username'] = $username;
			$_SESSION['error'] = "You are logged in as ".$username.".";
		}

		// redirect to home page
		header('Location: '.BASE_URL);
	}

	public function logout() {
		// erase the session
		unset($_SESSION['username']);
		session_destroy();

		// redirect to home page
		header('Location: '.BASE_URL);
	}
}
