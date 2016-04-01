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
			case 'follow':
				$user_id = $_GET['user_id'];
				$this->follow($user_id);
				break;

			case 'unfollow':
				$user_id = $_GET['user_id'];
				$this->unfollow($user_id);
				break;

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

	public function follow($id) {
		// Exit if no user is logged in
		if (!isset($_SESSION['username'])) {
			exit();
		}

		// Exit if user already follows them
		$user = user::load_by_username($_SESSION['username']);
		if ($user->follows($id)) {
			exit();
		}

		// Create the follow object to be saved to the database, then save
		$follow = new follow();
		$follow->set('user_id', $id);
		$follow->set('follower_id', $user->get('id'));
		$follow->save();

		// Redirect to show page or update with AJAX
		header('Location: '.BASE_URL.'/users/'.$id);
	}

	public function unfollow($id) {
		// Exit if no user is logged in
		if (!isset($_SESSION['username'])) {
			exit();
		}

		// Exit if user already doesn't follow them
		$user = user::load_by_username($_SESSION['username']);
		if (!$user->follows($id)) {
			exit();
		}

		// Create the follow object to be deleted from the database, then delete
		$follow = new follow();
		$follow->set('user_id', $id);
		$follow->set('follower_id', $user->get('id'));
		$follow->delete();

		// Redirect to show page or update with AJAX
		header('Location: '.BASE_URL.'/users/'.$id);
	}

	public function followers($user_id) {

	}

	public function following($user_id) {

	}
}
