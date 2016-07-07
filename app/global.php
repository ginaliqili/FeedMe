<?php

session_start();

set_include_path(dirname(__FILE__)); # include path - don't change

include_once 'config.php';

function __autoload($class_name) {
	require_once 'model/'.$class_name.'.class.php';
}

// Constants
const MEAL_TYPES = ["Breakfast", "Lunch", "Dinner"];
const FOOD_TYPES = ["American", "Carribean", "Chinese", "Ethiopian", "French", "German", "Greek", "Indian", "Italian", "Japanese", "Mediterranean", "Mexican", "Spanish", "Thai"];
const TIMES_TO_PREPARE = ["15 Minutes", "30 Minutes", "45 Minutes", "1 Hour", "More than 1 Hour"];
