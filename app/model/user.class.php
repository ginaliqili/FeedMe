<?php

class user extends db_object {
    // name of database table
    const DB_TABLE = 'user';

    // database fields
    protected $id;
    protected $username;
    protected $password;
    protected $first_name;
    protected $last_name;
    protected $email;

    // constructor
    public function __construct($args = array()) {
        $default_args = array(
            'id' => null,
            'username' => '',
            'password' => '',
            'email' => null,
            'first_name' => null,
            'last_name' => null);

        $args += $default_args;

        $this->id = $args['id'];
        $this->username = $args['username'];
        $this->password = $args['password'];
        $this->email = $args['email'];
        $this->first_name = $args['first_name'];
        $this->last_name = $args['last_name'];
    }

    // save changes to object
    public function save() {
        $db = db::instance();
        // omit id and any timestamps
        $db_properties = array(
            'username' => $this->username,
            'password' => $this->password,
            'email' => $this->email,
            'first_name' => $this->first_name,
            'last_name' => $this->last_name);
        $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
    }

    // Check if this user follows user with $user_id
    public function follows($user_id) {
      return follow::exists($this->id, $user_id);
    }

    // Check if this user is followed by user with $user_id
    public function followed_by($user_id) {
      return follow::exists($user_id, $this->id);
    }

    // load object by ID
    public static function load_by_id($id) {
        $db = db::instance();
        $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
        return $obj;
    }

    // load user by username
    public static function load_by_username($username=null) {
        if($username === null) {
            return null;
        }

        $query = sprintf(" SELECT id FROM %s WHERE username = '%s' ",
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
}
