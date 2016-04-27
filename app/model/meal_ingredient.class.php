<?php

class meal_ingredient extends db_object {
  // Name of database table
  const DB_TABLE = 'meal_ingredient';

  // Database fields
  protected $id;
  protected $meal_id;
  protected $ingredient_id;

  // Constructor
  public function __construct($args = array()) {
    $default_args = array(
      'id' => null,
      'meal_id' => null,
      'ingredient_id' => null);

    $args += $default_args;

    // Set database fields
    $this->id = $args['id'];
    $this->meal_id = $args['meal_id'];
    $this->ingredient_id = $args['ingredient_id'];
  }

  // Save changes to a meal_ingredient
  public function save() {
    $db = db::instance();

    // Create an array of properties to store in the database
    $db_properties = array(
        'meal_id' => $this->meal_id,
        'ingredient_id' => $this->ingredient_id);
    $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);

    // Return successful save
    return true;
  }

  // Delete a meal_ingredient
  public function delete() {
    $db = db::instance();

    // Generate deletion query
    $query = sprintf(" DELETE FROM %s WHERE id = '%s' ",
      self::DB_TABLE,
      $this->id);

    // Execute the deletion
    $result = $db->lookup($query);

    // Return deletion result
    return $result;
  }

  // Load meal_ingredient by ID
  public static function load_by_id($id) {
    $db = db::instance();

    // Fetch the meal_ingredient's basic attributes from database
    $meal_ingredient = $db->fetchById($id, __CLASS__, self::DB_TABLE);

    // Return the meal_ingredient
    return $meal_ingredient;
  }

  // Load meal_ingredient by $meal_id and $ingredient_id
  public static function load_by_relationship($meal_id, $ingredient_id) {
    $db = db::instance();

    // Generate search query
    $query = sprintf("SELECT * FROM %s WHERE meal_id = '%s' AND ingredient_id = '%s';",
      self::DB_TABLE,
      $follower_id,
      $ingredient_id);

    // Execute the search
    $result = $db->lookup($query);

    // Return the meal_ingredient
    if(!mysqli_num_rows($result)) {
      return null;
    }
    else {
      return self::load_by_id(mysqli_fetch_assoc($result)['id']);
    }
  }

  // Load meal_ingredients by meal_id
  public static function load_by_meal_id($id) {
    $db = db::instance();
    $meal_ingredients = $db->fetchByAttribute('meal_id', $id, __CLASS__, self::DB_TABLE);
    return $meal_ingredients;
  }

  // Load meal_ingredients by ingredient_id
  public static function load_by_ingredient_id($id) {
    $db = db::instance();
    $meal_ingredients = $db->fetchByAttribute('ingredient_id', $id, __CLASS__, self::DB_TABLE);
    return $meal_ingredients;
  }

  // Check if a meal_ingredient relationship exists between $meal_id and $ingredient_id
  public static function exists($meal_id, $ingredient_id) {
    $db = db::instance();

    // Generate search query
    $query = sprintf("SELECT * FROM %s WHERE meal_id = '%s' AND ingredient_id = '%s';",
      self::DB_TABLE,
      $follower_id,
      $ingredient_id);

    // Execute the search
    $result = $db->lookup($query);

    // Return whether this meal_ingredient relationship exists
    return (mysqli_num_rows($result) > 0);
  }
}
