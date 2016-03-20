<?php

class meal extends db_object {
    // name of database table
    const DB_TABLE = 'meal';

    // database fields
    protected $id;
    protected $title;
    protected $description;
    protected $meal_type;
    protected $food_type;
    protected $time_to_prepare;
    protected $instructions;
    protected $creator_id;
    protected $date_created;

    // constructor
    public function __construct($args = array()) {
        // TODO: Ingredients (many-to-many)
        $default_args = array(
            'id' => null,
            'title' => '',
            'description' => '',
            'meal_type' => '',
            'food_type' => '',
            'time_to_prepare' => '',
            'instructions' => '',
            'creator_id' => 0,
            'date_created' => null);

        $args += $default_args;

        $this->id = $args['id'];
        $this->title = $args['title'];
        $this->description = $args['description'];
        $this->meal_type = $args['meal_type'];
        $this->food_type = $args['food_type'];
        $this->time_to_prepare = $args['time_to_prepare'];
        $this->instructions = $args['instructions'];
        $this->creator_id = $args['creator_id'];
        $this->date_created = $args['date_created'];
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
        $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
        return $obj;
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
