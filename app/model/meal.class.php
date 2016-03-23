<?php

class meal extends db_object {
    // name of database table
    const DB_TABLE = 'meal';

    // relationship tables
    const MEAL_MEAL_TYPE_TABLE = 'meal_meal_type';

    // related tables
    const MEAL_TYPE_TABLE = 'meal_type';

    // database fields
    protected $id;
    protected $title;
    protected $description;
    protected $time_to_prepare;
    protected $instructions;
    protected $creator_id;
    protected $date_created;
    // advanced fields
    protected $meal_type;
    protected $food_type;
    protected $ingredients;

    // constructor
    public function __construct($args = array()) {
        // TODO: Ingredients (many-to-many)
        $default_args = array(
            'id' => null,
            'title' => '',
            'description' => '',
            'time_to_prepare' => '',
            'instructions' => '',
            'creator_id' => 0,
            'date_created' => null,
            'meal_type' => '',
            'food_type' => '',
            'ingredients' => '');

        $args += $default_args;

        $this->id = $args['id'];
        $this->title = $args['title'];
        $this->description = $args['description'];
        $this->time_to_prepare = $args['time_to_prepare'];
        $this->instructions = $args['instructions'];
        $this->creator_id = $args['creator_id'];
        $this->date_created = $args['date_created'];

        $this->meal_type = $args['meal_type'];
        $this->food_type = $args['food_type'];
        $this->ingredients = $args['ingredients'];
    }

    // save changes to a meal
    public function save() {
        $db = db::instance();
        // omit id and any timestamps
        $db_properties = array(
            'title' => $this->title,
            'description' => $this->description,
            'meal_type' => $this->meal_type,
            'food_type' => $this->food_type,
            'time_to_prepare' => $this->time_to_prepare,
            'instructions' => $this->instructions,
            'creator_id' => $this->creator_id);
        $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
    }

    // load meal by ID
    public static function load_by_id($id) {
        $db = db::instance();

        // fetch the meal's basic attributes from database
        $meal = $db->fetchById($id, __CLASS__, self::DB_TABLE);


        $query = sprintf("SELECT meal_type_id FROM %s WHERE meal_id = '%s'",
            self::MEAL_MEAL_TYPE_TABLE,
            $id);
        $result = $db->lookup($query);
        if(mysqli_num_rows($result)) {
          $objects = array();
          while ($row = mysqli_fetch_assoc($result)) {
            $objects[] = self::load_by_id($row['id']);
          }

          $meal_types = array();
          foreach($objects as $relationship) {
            $meal_types[] = $db->fetchById($relationship['meal_type_id'], __CLASS__, self::MEAL_TYPE_TABLE);
          }
        }

        // return the meal
        return $meal;
    }

    // load all meals
    public static function load_all($limit=null) {
        $query = sprintf(" SELECT id FROM %s ORDER BY date_created DESC ",
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

    // delete a meal
    public function delete() {
        $query = sprintf(" DELETE FROM %s WHERE id = '%s' ",
            self::DB_TABLE,
            $this->id);
        $db = db::instance();
        $result = $db->lookup($query);
        return $result;
    }
}
