<?php

class meal extends db_object {
  // Name of database table
  const DB_TABLE = 'meal';

  // Database fields
  protected $id;
  protected $title;
  protected $description;
  protected $time_to_prepare;
  protected $instructions;
  protected $creator_id;
  protected $image_url;
  protected $date_created;
  // Advanced attributes (can have multiple values: need relational tables)
  protected $meal_type;
  protected $food_type;
  protected $ingredients;

  // Constructor
  public function __construct($args = array()) {
    $default_args = array(
      'id' => null,
      'title' => '',
      'description' => '',
      'time_to_prepare' => '',
      'instructions' => '',
      'creator_id' => 0,
      'image_url' => '',
      'date_created' => null,
      'meal_type' => '',
      'food_type' => '',
      'ingredients' => '');

    $args += $default_args;

    // Set database fields
    $this->id = $args['id'];
    $this->title = $args['title'];
    $this->description = $args['description'];
    $this->time_to_prepare = $args['time_to_prepare'];
    $this->instructions = $args['instructions'];
    $this->creator_id = $args['creator_id'];
    $this->image_url = $args['image_url'];
    $this->date_created = $args['date_created'];
    // Set advanced attributes
    $this->meal_type = $args['meal_type'];
    $this->food_type = $args['food_type'];
    $this->ingredients = $args['ingredients'];
  }

  // Save changes to a meal
  public function save() {
    $db = db::instance();

    // Omit id and any timestamps
    $db_properties = array(
        'title' => $this->title,
        'description' => $this->description,
        'meal_type' => $this->meal_type,
        'food_type' => $this->food_type,
        'time_to_prepare' => $this->time_to_prepare,
        'instructions' => $this->instructions,
        'creator_id' => $this->creator_id,
        'image_url' => $this->image_url);
    $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);

    // Return successful save
    return true;
  }

  // Delete a meal
  public function delete() {
    // Generate deletion query
    $query = sprintf(" DELETE FROM %s WHERE id = '%s' ",
    self::DB_TABLE,
    $this->id);
    $db = db::instance();

    // Execute the deletion
    $result = $db->lookup($query);

    // Return deletion result
    return $result;
  }

  // Load meal by ID
  public static function load_by_id($id) {
    $db = db::instance();

    // Fetch the meal's basic attributes from database
    $meal = $db->fetchById($id, __CLASS__, self::DB_TABLE);

    // Return the meal
    return $meal;
  }

  // Load meal by user_id
  public static function load_by_user($user_id) {
    $query = sprintf(" SELECT id FROM %s WHERE creator_id = %s",
      self::DB_TABLE, $user_id);
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

    // Return the meal
    return $meals;
  }

  // Load all meals
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

  public static function search($parameters) {
    // Create a database instance
    $db = db::instance();

    // Build the base query
    $base_query = sprintf(" SELECT * FROM %s",
      self::DB_TABLE);

    // Store the custom search queries
    $search_queries = array();

    // Search by meal type
    if ($parameters['meal_type'] != null) {
      $meal_type_query = $base_query . sprintf(" WHERE meal_type = '%s'",
        $parameters['meal_type']);
      $search_queries[] = $meal_type_query;
    }

    // Search by food type
    if ($parameters['food_type'] != null) {
      $food_type_query = $base_query . sprintf(" WHERE food_type = '%s'",
        $parameters['food_type']);
      $search_queries[] = $food_type_query;
    }

    // Search by time to prepare
    if ($parameters['time_to_prepare'] != null) {
      $time_to_prepare_query = $base_query . sprintf(" WHERE time_to_prepare = '%s'",
        $parameters['time_to_prepare']);
      $search_queries[] = $time_to_prepare_query;
    }

    // Store the retrieved meals
    $meals = array();

    // Check if any custom search queries were generated
    if (!empty($search_queries)) {
      // Execute the custom search queries
      for ($index = 0; $index < count($search_queries); $index++) {
        // Get the next query
        $query = $search_queries[$index];

        // Execute the query
        $result = $db->lookup($query);

        // Check for query results
        if(mysqli_num_rows($result)) {
          // Store the results
          $results = array();

          // Convert results into meals
          while ($row = mysqli_fetch_assoc($result)) {
              $results[] = new meal($row);
          }

          // Merge the query results
          if ($index == 0) {
            $meals = $results;
          }
          else {
            // Intersect object arrays using inline comparator function
            /* It would be better to use a SQL Intersect statement, but it's
            not supported by MySQL */
            $meals = array_uintersect($meals, $results, function($obj1, $obj2) {
              if ($obj1 == $obj2) {
                return 0;
              }
              if ($obj1 > $obj2) {
                return 1;
              }
              return -1;
            });
          }
        }
      }
    }
    else {
      // Use the base query to get all meals
      $result = $db->lookup($base_query);

      // Parse the results from the database
      if(mysqli_num_rows($result)) {
        while ($row = mysqli_fetch_assoc($result)) {
            $meals[] = new meal($row);
        }
      }
    }

    // Return the retrieved meals
    return $meals;
  }
}
