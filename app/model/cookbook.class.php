<?php

class cookbook extends db_object {
  // Name of database table
  const DB_TABLE = 'cookbook';

  // Database fields
  protected $id;
  protected $meal_id;
  protected $page_number;

  // Constructor
  public function __construct($args = array()) {
    $default_args = array(
      'id' => null,
      'meal_id' => null,
      'page_number' => null);

    $args += $default_args;

    $this->id = $args['id'];
    $this->meal_id = $args['meal_id'];
    $this->page_number = $args['page_number'];
  }

  // Save changes to object
  public function save() {
      $db = db::instance();

      $db_properties = array(
        'id' => $this->id,
        'meal_id' => $this->meal_id,
        'page_number' => $this->page_number);

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

  //get array of page numbers
  public function get_page_numbers() {
    $db = db::instance();
    return $db->get_page_numbers($this, __CLASS__, self::DB_TABLE);
  }

}
