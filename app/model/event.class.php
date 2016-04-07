<?php

class event extends db_object {
  // Name of database table
  const DB_TABLE = 'event';

  // Database fields
  protected $id;
  protected $user_id;
  protected $date_created;
  // Attributes
  protected $type;
  protected $action;
  protected $reference_id;

  // Constructor
  public function __construct($args = array()) {
    $default_args = array(
      'id' => null,
      'user_id' => null,
      'date_created' => null,
      'type' => null,
      'action' => null,
      'reference_id' => null);

    $args += $default_args;

    $this->id = $args['id'];
    $this->user_id = $args['user_id'];
    $this->date_created = $args['date_created'];
    $this->type = $args['type'];
    $this->action = $args['action'];
    $this->reference_id = $args['reference_id'];
  }

  // Save changes to object
  public function save() {
    $db = db::instance();

    // Set the properties for the parent event
    $parent_properties = array(
      'user_id' => $this->user_id,
      'date_created' => $this->follower_id);

    // Instantiate the parent event
    $parent = new Event($parent_properties);

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
    $child = new Event($child_properties);

    // Store the child event
    $db->store($child, __CLASS__, $child_table, $child_properties);
  }
}
