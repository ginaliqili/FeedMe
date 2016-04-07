<?php

class event extends db_object {
  // Name of database table
  const DB_TABLE = 'event';

  // The types of events
  const EVENT_TYPES = array('meal', 'user');

  // Database fields
  protected $id;
  protected $creator_id;
  protected $date_created;
  // Advanced attributes
  protected $type;
  protected $action;
  protected $reference_id;

  // Constructor
  public function __construct($args = array()) {
    $default_args = array(
      'id' => null,
      'creator_id' => null,
      'date_created' => null,
      'type' => null,
      'action' => null,
      'reference_id' => null);

    $args += $default_args;

    // Set database fields
    $this->id = $args['id'];
    $this->creator_id = $args['creator_id'];
    $this->date_created = $args['date_created'];
    // Set advanced attributes
    $this->type = $args['type'];
    $this->action = $args['action'];
    $this->reference_id = $args['reference_id'];
  }

  // Save changes to object
  public function save() {
    $db = db::instance();

    // Set the properties for the parent event
    $parent_properties = array(
      'creator_id' => $this->creator_id,
      'date_created' => $this->follower_id);

    // Instantiate the parent event
    $parent = new event($parent_properties);

    // Store the parent event
    $db->store($parent, __CLASS__, self::DB_TABLE, $parent_properties);

    // Generate child event's attributes
    $child_table = $this->type . '_' . self::DB_TABLE;
    $reference_id_name = $this->type . '_id';

    // Set the properties for the specific event type
    $child_properties = array(
      'event_id' => $parent->id,
      $reference_id_name => $this->reference_id,
      'action' => $this->action);

    // Instantiate the child event
    $child = new event($child_properties);

    // Store the child event
    $db->store($child, __CLASS__, $child_table, $child_properties);

    // Return successful save
    return true;
  }

  // Retrieve all events from the database
  public static function load_all() {
    $db = db::instance();

    // Store all the events
    $events = array();

    // Query each event table
    foreach(self::EVENT_TYPES as $type) {
      // Generate the table name for this event type
      $event_table = $type . '_' . self::DB_TABLE;

      // Generate the query for this event type
      $query = sprintf("SELECT * FROM %s INNER JOIN %s ON %s.id = %s.event_id;",
        self::DB_TABLE, $event_table, self::DB_TABLE, $event_table);

      // Execute the query
      $result = $db->lookup($query);

      // Create associated events
      while($row = mysqli_fetch_assoc($result)) {
        $event = new event($row);
        $event->type = $type;
        $event->reference_id = $row[$type . '_id'];
        $events[] = $event;
      }
    }

    // Order the events by date_created descending
    usort($events, function($obj1, $obj2) {
      if ($obj1->date_created == $obj2->date_created) {
        return 0;
      }
      return ($obj1->date_created < $obj2->date_created) ? 1 : -1;
    });

    // Return the events
    return $events;
  }

  // Retrieve all events from the database created by user with user_id $id
  public static function load_by_creator_id($id) {
    $db = db::instance();

    // Store all the events
    $events = array();

    // Query each event table
    foreach(self::EVENT_TYPES as $type) {
      // Generate the table name for this event type
      $event_table = $type . '_' . self::DB_TABLE;

      // Generate the query for this event type
      $query = sprintf("SELECT * FROM %s INNER JOIN %s ON %s.id = %s.event_id WHERE creator_id = %s;",
        self::DB_TABLE, $event_table, self::DB_TABLE, $event_table, $id);

      // Execute the query
      $result = $db->lookup($query);

      // Create associated events
      while($row = mysqli_fetch_assoc($result)) {
        $event = new event($row);
        $event->type = $type;
        $event->reference_id = $row[$type . '_id'];
        $events[] = $event;
      }
    }

    // Order the events by date_created descending
    usort($events, function($obj1, $obj2) {
      if ($obj1->date_created == $obj2->date_created) {
        return 0;
      }
      return ($obj1->date_created < $obj2->date_created) ? 1 : -1;
    });

    // Return the events
    return $events;
  }

  // Retrieve all events relevant to user with user_id $id
  public static function load_relevant($id) {
    $db = db::instance();

    // Store all the events
    $events = array();

    // Load the the following relationships for user_id $id
    $following = follow::load_by_follower_id($id);

    // Create a list of relevant user_ids
    $relevant_ids = "'" . strval($id) . "'";
    if ($following != null) {
      foreach($following as $follow) {
        $relevant_ids = $relevant_ids . ", '" . strval($follow->get('user_id')) . "'";
      }
    }

    // Query each event table
    foreach(self::EVENT_TYPES as $type) {
      // Generate the table name for this event type
      $event_table = $type . '_' . self::DB_TABLE;

      // Generate the query for this event type
      $query = sprintf("SELECT * FROM %s INNER JOIN %s ON %s.id = %s.event_id WHERE creator_id IN (%s);",
        self::DB_TABLE, $event_table, self::DB_TABLE, $event_table, $relevant_ids);

      // Execute the query
      $result = $db->lookup($query);

      // Create associated events
      while($row = mysqli_fetch_assoc($result)) {
        $event = new event($row);
        $event->type = $type;
        $event->reference_id = $row[$type . '_id'];
        $events[] = $event;
      }
    }

    // Order the events by date_created descending
    usort($events, function($obj1, $obj2) {
      if ($obj1->date_created == $obj2->date_created) {
        return 0;
      }
      return ($obj1->date_created < $obj2->date_created) ? 1 : -1;
    });

    // Return the events
    return $events;
  }
}
