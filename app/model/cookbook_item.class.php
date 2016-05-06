<?php

class cookbook_item extends db_object {
  // Name of database table
  const DB_TABLE = 'cookbook_item';

  // Database fields
  protected $id;
  protected $cookbook_id;
  protected $meal_id;


  // Constructor
  public function __construct($args = array()) {
    $default_args = array(
      'id' => null,
      'cookbook_id' => null,
      'meal_id' => null);

    $args += $default_args;

    $this->id = $args['id'];
    $this->cookbook_id = $args['cookbook_id'];
    $this->meal_id = $args['meal_id'];

  }

  // Save changes to object
  public function save() {
    $db = db::instance();

    // Omit id and any timestamps
    $db_properties = array(
      'cookbook_id' => $this->cookbook_id,
      'meal_id' => %this->meal_id);
    $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);

    // Return successful save
    return true;
  }

  // Load cookbook_item by ID
  public static function load_by_id($id) {
    $db = db::instance();
    $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
    return $obj;
  }


  // Load all users
  public static function load_all($limit=null) {
    $query = sprintf(" SELECT id FROM %s ORDER BY id ASC ",
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
}
