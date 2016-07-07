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

			case 'events':
				$this->events();
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

		include_once SYSTEM_PATH.'/view/helpers.php';
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

	public function events() {
		include_once SYSTEM_PATH.'/view/helpers.php';

		// Set the header to hint the response type (HTML) for JQuery's Ajax method
		header('Content-Type: application/html');

		// Get all relevant events
		if (isset($_SESSION['username'])) {
			$events = event::load_relevant(user::load_by_username($_SESSION['username'])->get('id'));
		}
		else {
			exit();
		}

		// Generate the new HTML for the activity feed
		$events_HTML = '';
		foreach($events as $event) {
			$events_HTML = $events_HTML . "<div class='event'><span class='list-group-item' href='#'><span>";
			$events_HTML = $events_HTML . format_event($event);
			$events_HTML = $events_HTML . "</span></span></div>";
		}

		// Return the new HTML for the activity feed
		echo $events_HTML;
	}
}
