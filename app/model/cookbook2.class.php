<?php

class cookbook2 extends db_object {
  // Name of database table
  const DB_TABLE = 'cookbook2';

  // Database fields
  protected $id;
  protected $meal_id;

  // Constructor
  public function __construct($args = array()) {
    $default_args = array(
      'id' => null,
      'meal_id' => null,

    $args += $default_args;

    $this->id = $args['id'];
    $this->meal_id = $args['meal_id'];
  }

  // Save changes to object
  public function save() {
      $db = db::instance();

      $db_properties = array(
        'id' => $this->id,
        'meal_id' => $this->meal_id);

      $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);

      // Return successful save
      return true;
  }

  // Load cookbook item by ID
  public static function load_by_id($id) {
    $db = db::instance();
    $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
    return $obj;
  }

  // truncate cookbook table
  public function truncate() {
    $db = db::instance();
    $db->truncate($this, __CLASS__, self::DB_TABLE);
  }


}
