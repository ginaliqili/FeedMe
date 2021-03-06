<?php

class follow extends db_object {
  // Name of database table
  const DB_TABLE = 'follow';

  // Database fields
  protected $id;
  protected $user_id;
  protected $follower_id;

  // Constructor
  public function __construct($args = array()) {
    $default_args = array(
      'id' => null,
      'user_id' => null,
      'follower_id' => null);

    $args += $default_args;

    $this->id = $args['id'];
    $this->user_id = $args['user_id'];
    $this->follower_id = $args['follower_id'];
  }

  // Save changes to object
  public function save() {
    $db = db::instance();

    // Omit id and any timestamps
    $db_properties = array(
      'user_id' => $this->user_id,
      'follower_id' => $this->follower_id);
    $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);

    // Return successful save
    return true;
  }

  // Delete a meal
  public function delete() {
    $db = db::instance();

    // Generate deletion query
    $query = sprintf("DELETE FROM %s WHERE user_id = '%s' AND follower_id = '%s';",
    self::DB_TABLE,
    $this->user_id,
    $this->follower_id);

    // Execute the deletion
    $result = $db->lookup($query);

    // Return deletion result
    return $result;
  }

  // Load follows by user_id
  public static function load_by_user_id($id) {
    $db = db::instance();
    $follows = $db->fetchByAttribute('user_id', $id, __CLASS__, self::DB_TABLE);
    return $follows;
  }

  // Load follows by follower_id
  public static function load_by_follower_id($id) {
    $db = db::instance();
    $follows = $db->fetchByAttribute('follower_id', $id, __CLASS__, self::DB_TABLE);
    return $follows;
  }

  // Check if a follow relationship exists between $follower_id and $user_id
  public static function exists($follower_id, $user_id) {
    $db = db::instance();

    // Generate search query
    $query = sprintf("SELECT * FROM %s WHERE follower_id = '%s' AND user_id = '%s';",
    self::DB_TABLE,
    $follower_id,
    $user_id);

    // Execute the search
    $result = $db->lookup($query);

    // Return whether this follow relationship exists
    return (mysqli_num_rows($result) > 0);
  }
}
