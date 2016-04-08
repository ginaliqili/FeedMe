<?php

function format_event($event=null) {
  // Exit when there is no event
  if ($event == null) {
    exit();
  }

  // Retrieve the event's creator
  $creator = user::load_by_id($event->get('creator_id'));

  // Add the creator information to the event entry
  $formatted = sprintf("<a href=%s/users/%s>%s</a> ",
    BASE_URL, $creator->get('id'), $creator->get('username'));

  // Add the action and event type to the event entry
  $formatted = $formatted . sprintf("%s %s ",
    $event->get('action'), $event->get('type'));

  // Add the referenced object information to the event entry
  switch($event->get('type')) {
    case 'meal':
      // Load the associated meal
      $meal = meal::load_by_id($event->get('reference_id'));

      // Add the meal information to the event entry
      $formatted = $formatted . sprintf("<a href=%s/meals/%s>%s</a> ",
        BASE_URL, $meal->get('id'), $meal->get('title'));
      break;

    case 'user':
      // Load the associated user
      $user = user::load_by_id($event->get('reference_id'));

      // Add the user information to the event entry
      $formatted = $formatted . sprintf("<a href=%s/users/%s>%s</a> ",
        BASE_URL, $user->get('id'), $user->get('username'));
      break;

    default:
      $formatted = 'Event formatting not found.';
      break;
  }

  // Add the date created information to the event entry
  $formatted = $formatted . date("F j, Y, g:i a", strtotime($event->get('date_created')));

  // Return the formatted event entry
  return $formatted;
}
