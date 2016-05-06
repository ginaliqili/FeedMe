<?php

class cookbook extends db_object {
  // Name of database table
  const DB_TABLE = 'cookbooks';

  // Database fields
  protected $id;
  protected $title;

  // Constructor
  public function __construct($args = array()) {
    $default_args = array(
      'id' => null,
      'title' => '');

    $args += $default_args;

    $this->id = $args['id'];
    $this->title = $args['title'];
  }

  // Save changes to object
  public function save() {
    $db = db::instance();

    // Omit id and any timestamps
    $db_properties = array(
      'title' => $this->title);
    $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);

    // Return successful save
    return true;
  }

  // Load user by ID
  public static function load_by_id($id) {
    $db = db::instance();
    $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
    return $obj;
  }

  // Load user by username
  public static function load_by_title($username=null) {
    if($title === null) {
      return null;
    }

    $query = sprintf(" SELECT id FROM %s WHERE title = '%s' ",
      self::DB_TABLE,
      $username);
    $db = db::instance();
    $result = $db->lookup($query);
    if(!mysqli_num_rows($result)) {
      return null;
    }
    else {
      $row = mysqli_fetch_assoc($result);
      $obj = self::load_by_id($row['id']);
      return ($obj);
    }
  }


  // Load all users
  public static function load_all($limit=null) {
    $query = sprintf(" SELECT id FROM %s ORDER BY title ASC ",
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
