<?php

class meal extends db_object {
  // Name of database table
  const DB_TABLE = 'meal';

  // Database fields
  protected $id;
  protected $title;
  protected $description;
  protected $meal_type;
  protected $food_type;
  protected $time_to_prepare;
  protected $instructions;
  protected $creator_id;
  protected $image_url;
  protected $date_created;
  // Advanced attributes (can have multiple values: need relational tables)
  protected $ingredients;

  // Constructor
  public function __construct($args = array()) {
    $default_args = array(
      'id' => null,
      'title' => '',
      'description' => '',
      'meal_type' => '',
      'food_type' => '',
      'time_to_prepare' => '',
      'instructions' => '',
      'creator_id' => 0,
      'image_url' => '',
      'date_created' => null,
      'ingredients' => null);

    $args += $default_args;

    // Set database fields
    $this->id = $args['id'];
    $this->title = $args['title'];
    $this->description = $args['description'];
    $this->meal_type = $args['meal_type'];
    $this->food_type = $args['food_type'];
    $this->time_to_prepare = $args['time_to_prepare'];
    $this->instructions = $args['instructions'];
    $this->creator_id = $args['creator_id'];
    $this->image_url = $args['image_url'];
    $this->date_created = $args['date_created'];
    // Set advanced attributes
    $this->ingredients = $args['ingredients'];
  }

  // Save changes to a meal
  public function save() {
    $db = db::instance();

    // Create an array of properties to store in the database
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

    // Fetch this meal's old meal_ingredients
    $meal_ingredients = meal_ingredient::load_by_meal_id($this->id);

    // Delete the old ingredients that are no longer associated with this meal
    if ($meal_ingredients != null) {
      // Iterate through this meal's old ingredients
      foreach ($meal_ingredients as $meal_ingredient) {
        // Retrieve the old ingredient
        $ingredient = ingredient::load_by_id($meal_ingredient->get('ingredient_id'));

        // Check if this old ingredient is no longer associated with this meal
        if (!in_array($ingredient, $this->ingredients)) {
          // Delete associated meal_ingredient
          $meal_ingredient->delete();
        }
      }
    }

    // Attach the new ingredients that are associated with this meal
    foreach($this->ingredients as $ingredient) {
      if (!meal_ingredient::exists($this->id, $ingredient->get('id'))) {
        // Create and save the associated meal_ingredient
        $meal_ingredient = new meal_ingredient(array(
          'meal_id' => $this->id,
          'ingredient_id' => $ingredient->get('id')));
        $meal_ingredient->save();
      }
    }

    // Return successful save
    return true;
  }

  // Delete a meal
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

  // Load meal by ID
  public static function load_by_id($id) {
    $db = db::instance();

    // Fetch the meal's basic attributes from database
    $meal = $db->fetchById($id, __CLASS__, self::DB_TABLE);

    // Load and set this meal's ingredients
    $meal_ingredients = meal_ingredient::load_by_meal_id($id);
    if ($meal_ingredients != null) {
      $ingredients = array();
      foreach($meal_ingredients as $meal_ingredient) {
        $ingredients[] = ingredient::load_by_id($meal_ingredient->get('ingredient_id'));
      }
      $meal->set('ingredients', $ingredients);
    }

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

  // Perform a search on meals
  public static function search($parameters) {
    // Create a database instance
    $db = db::instance();

    // Build the base query
    $base_query = sprintf(" SELECT * FROM %s",
      self::DB_TABLE);

    // Store the custom search queries
    $search_queries = array();

    // Search by title
    if ($parameters['title'] != null) {
      // Build the query to find the meal with the associated title
      $meal_title_query = $base_query . sprintf(
        " WHERE title = '%s'",
        $parameters['title']);

      // Add this query to the search queries
      $search_queries[] = $meal_title_query;
    }

    // Search by meal type
    if ($parameters['meal_type'] != null) {
      // Build the query to filter for meals with the associated meal type
      $meal_type_query = $base_query . sprintf(
        " WHERE meal_type = '%s'",
        $parameters['meal_type']);

      // Add this query to the search queries
      $search_queries[] = $meal_type_query;
    }

    // Search by food type
    if ($parameters['food_type'] != null) {
      // Build the query to filter for meals with the associated food type
      $food_type_query = $base_query . sprintf(
        " WHERE food_type = '%s'",
        $parameters['food_type']);

      // Add this query to the search queries
      $search_queries[] = $food_type_query;
    }

    // Search by time to prepare
    if ($parameters['time_to_prepare'] != null) {
      // Build the query to filter for meals with the associated time to prepare
      $time_to_prepare_query = $base_query . sprintf(
        " WHERE time_to_prepare = '%s'",
        $parameters['time_to_prepare']);

      // Add this query to the search queries
      $search_queries[] = $time_to_prepare_query;
    }

    // Search by allergies
    if ($parameters['allergies'] != null) {
      // Sanitize the allergies array
      for ($i = 0; $i < count($parameters['allergies']); $i++) {
        $parameters['allergies'][$i] = "'" . $parameters['allergies'][$i] . "'";
      }

      // Serialize the allergies array
      $allergies_str = implode(",", $parameters['allergies']);

      // Build the query to retrieve the associated allergy IDs
      $allergy_ids = sprintf(
        "SELECT id FROM ingredient WHERE title IN (%s)",
        $allergies_str);

      // Build the query to retrieve the associated meal IDs
      $meal_ids = sprintf(
        "SELECT meal_ingredient.meal_id FROM (%s) AS allergies INNER JOIN meal_ingredient ON allergies.id = meal_ingredient.ingredient_id",
        $allergy_ids);

      // Build the query to filter for meals without the associated allergies
      $allergies_query = $base_query . sprintf(
        " WHERE id NOT IN (%s);",
        $meal_ids);

      // Add this query to the search queries
      $search_queries[] = $allergies_query;
    }

    // Search by ingredients
    if ($parameters['ingredients'] != null) {
      // Sanitize the ingredients array
      for ($i = 0; $i < count($parameters['ingredients']); $i++) {
        $parameters['ingredients'][$i] = "'" . $parameters['ingredients'][$i] . "'";
      }

      // Serialize the ingredients array
      $ingredients_str = implode(",", $parameters['ingredients']);

      // Build the query to retrieve the associated ingredient IDs
      $ingredient_ids = sprintf(
        "SELECT id FROM ingredient WHERE title IN (%s)",
        $ingredients_str);

      // Build the query to retrieve the associated meal IDs
      $meal_ids = sprintf(
        "SELECT meal_ingredient.meal_id FROM (%s) AS ingredients INNER JOIN meal_ingredient ON ingredients.id = meal_ingredient.ingredient_id",
        $ingredient_ids);

      // Build the query to filter for meals with the associated ingredients
      $ingredients_query = $base_query . sprintf(
        " WHERE id IN (%s);",
        $meal_ids);

      // Add this query to the search queries
      $search_queries[] = $ingredients_query;
    }

    // Store the retrieved meals
    $meals = array();

    // Check if any search queries were generated
    if (!empty($search_queries)) {
      // Execute the search queries and intersect the results
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
            $meals = array_uintersect($meals, $results, "meal::compare");
          }
        }
        // If no results were found for this query no results were found for the entire search
        else {
          return array();
        }
      }
    }
    // If no search queries were generated use the base query
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

  // Compare two meals
  public static function compare($meal_1, $meal_2) {
    if (!($meal_1 instanceof meal) || !($meal_2 instanceof meal)) {
      return null;
    }
    if ($meal_1 == $meal_2) {
      return 0;
    }
    if ($meal_1 > $meal_2) {
      return 1;
    }
    return -1;
  }
}
