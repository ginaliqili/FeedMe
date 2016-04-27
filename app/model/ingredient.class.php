<?php

class ingredient extends db_object {
  // Name of database table
  const DB_TABLE = 'ingredient';

  // Database fields
  protected $id;
  protected $title;

  // Constructor
  public function __construct($args = array()) {
    $default_args = array(
      'id' => null,
      'title' => '');

    $args += $default_args;

    // Set database fields
    $this->id = $args['id'];
    $this->title = $args['title'];
  }

  // Save changes to an ingredient
  public function save() {
    $db = db::instance();

    // Create an array of properties to store in the database
    $db_properties = array(
        'title' => $this->title);
    $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);

    // Return successful save
    return true;
  }

  // Delete an ingredient
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

  // Load ingredient by ID
  public static function load_by_id($id) {
    $db = db::instance();

    // Fetch the ingredient's basic attributes from database
    $ingredient = $db->fetchById($id, __CLASS__, self::DB_TABLE);

    // Return the ingredient
    return $ingredient;
  }

  // Load all ingredients
  public static function load_all($limit=null) {
    $query = sprintf(" SELECT id FROM %s ",
      self::DB_TABLE);
    $db = db::instance();
    $result = $db->lookup($query);
    if(!mysqli_num_rows($result)) {
      return null;
    }
    else {
      $objects = array();
      while ($row = mysqli_fetch_assoc($result)) {
        $objects[] = self::load_by_id($row['id']);
      }
      return ($objects);
    }
  }

  // Check if an ingredient exists with $title
  public static function load_by_title($title) {
    $db = db::instance();

    // Generate search query
    $query = sprintf("SELECT * FROM %s WHERE title = '%s';",
      self::DB_TABLE,
      $title);

    // Execute the search
    $result = $db->lookup($query);

    // Return the ingredient
    if(!mysqli_num_rows($result)) {
      return null;
    }
    else {
      return self::load_by_id(mysqli_fetch_assoc($result)['id']);
    }
  }
}
