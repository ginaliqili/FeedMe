<?php

class favorite extends db_object {
    // name of database table
    const DB_TABLE = 'favorite';

    // database fields
    protected $id;
    protected $meal_id;
    protected $meal_title;
    protected $user_id;


    // constructor
    public function __construct($args = array()) {
        $default_args = array(
            'id' => null,
            'meal_id' => null,
            'meal_title' => null,
            'user_id' => null);

        $args += $default_args;

        $this->id = $args['id'];
        $this->meal_id = $args['meal_id'];
        $this->meal_title = $args['meal_title'];
        $this->user_id = $args['user_id'];

    }

    // save changes to object
    public function save() {
        $db = db::instance();
        $db_properties = array(
            'id' => $this->id,
            'meal_id' => $this->meal_id,
            'meal_title' => $this->meal_title,
            'user_id' => $this->user_id)
            ;
        $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
        return true;
    }



    // load all meals
    public static function load_all($limit=null) {
        $user = user::load_by_username($_SESSION['username']);
        $user_id = $user->get('id');
        $query = sprintf(" SELECT * FROM %s WHERE user_id = $user_id ",
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

    // load favorite by ID
    public static function load_by_id($id) {
        $db = db::instance();
        $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
        return $obj;
    }

    // checks to see if there are duplicate favorites
    public function check_duplicate_favorites($meal_id) {
      $user = user::load_by_username($_SESSION['username']);
      $user_id = $user->get('id');
      $query = sprintf(" SELECT meal_id FROM %s WHERE user_id = $user_id ",
          self::DB_TABLE);
      $db = db::instance();
      $result = $db->lookup($query);
      if(!mysqli_num_rows($result)) {
          return false;
      }
      else {
        foreach ($result as $fav_meal_id) {
          if ($fav_meal_id == $meal_id) {
            return false;
          }
        }
          return true;
    }
  }
}
