<!DOCTYPE html>
<html style="background-image: none;">
<head>
  <title>Hello Bubble Chart</title>
  <meta charset="utf-8">

  <link href='http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,600,200italic,600italic&subset=latin,vietnamese' rel='stylesheet' type='text/css'>

   <style>
    .bubbleChart {
      min-width: 100px;
      max-width: 700px;
      height: 700px;
      margin: 0 auto;
    }
    .bubbleChart svg{
      background: white;
    }
  </style>

  <title>FeedMe</title>

  <!--Font Awesome -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
  <link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/styles.css">
  <link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/show_styles.css">

  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

  <script type="text/javascript" src="<?= BASE_URL ?>/public/js/scripts.js"></script>
  <script type="text/javascript">
    $(document).ready(function(){
      var meal_id = $('#meal_id').val();
      var meal_title = $('#meal_title').val();

      var favorite_check = "<?= BASE_URL ?>/meals/" + meal_id + "/favorite_check";
      var favorite_action = "<?= BASE_URL ?>/meals/" + meal_id + "/favorite";
      // event handler for meal id for favorite
      $('#favorite').click(function(){
        // AJAX GET request to insert favorite into user's favorite list
        $.get(favorite_action, { "meal_id": meal_id, "meal_title": meal_title} );
      });
      // $("#not_a_decision a").click(function(e){
      //  e.preventDefault();
      // });
    });
  </script>

  <script src="http://phuonghuynh.github.io/js/bower_components/jquery/dist/jquery.min.js"></script>
  <script src="http://phuonghuynh.github.io/js/bower_components/d3/d3.min.js"></script>
  <script src="http://phuonghuynh.github.io/js/bower_components/d3-transform/src/d3-transform.js"></script>
  <script src="http://phuonghuynh.github.io/js/bower_components/cafej/src/extarray.js"></script>
  <script src="http://phuonghuynh.github.io/js/bower_components/cafej/src/misc.js"></script>
  <script src="http://phuonghuynh.github.io/js/bower_components/cafej/src/micro-observer.js"></script>
  <script src="http://phuonghuynh.github.io/js/bower_components/microplugin/src/microplugin.js"></script>
  <!-- <script src="http://phuonghuynh.github.io/js/bower_components/bubble-chart/src/bubble-chart.js"></script> -->
  <!-- <script src="http://phuonghuynh.github.io/js/bower_components/bubble-chart/src/plugins/central-click/central-click.js"></script -->

  <script type="text/javascript" src="<?= BASE_URL ?>/public/js/bubble-chart.js"></script>

  <script type="text/javascript" src="<?= BASE_URL ?>/public/js/central-click.js"></script>

  <script type="text/javascript" src="<?= BASE_URL ?>/public/js/lines.js"></script>

 <!--  <script src="http://phuonghuynh.github.io/js/bower_components/bubble-chart/src/plugins/lines/lines.js"></script> -->
  <script>
  $(document).ready(function () {
  var bubbleChart = new d3.svg.BubbleChart({
    supportResponsive: true,
    //container: => use @default
    size: 600,
    //viewBoxSize: => use @default
    innerRadius: 600 / 3.5,
    //outerRadius: => use @default
    radiusMin: 50,
    //radiusMax: use @default
    //intersectDelta: use @default
    //intersectInc: use @default
    //circleColor: use @default
    data: {
      items:
      //   {text: "Java", count: "382"},
      //   {text: ".Net", count: "382"},
      //   {text: "Php", count: "170"},
      //   {text: "Ruby", count: "123"},
      //   {text: "D", count: "12"},
      //   {text: "Python", count: "170"},
      //   {text: "C/C++", count: "382"},
      //   {text: "Pascal", count: "10"},
      //   {text: "Something", count: "170"},

      <?php
        echo $json_meals;
      ?>,

      eval: function (item) {return item.count;},
      classed: function (item) {return item.text.split(" ").join("");},
      title: function (item) {return item.text.split(" ").join("_")},
      func_id: function(item) {return item.id;},
      func_meal_type: function(item) {return item.meal_type;},
      func_food_type: function(item) {return item.food_type;},
      func_image: function(item) {return item.image_url;}
    },
    plugins: [
      {
        name: "central-click",
        options: {
          text: "(Import this meal)",
          style: {
            "font-size": "12px",
            "font-style": "italic",
            "font-family": "Source Sans Pro, sans-serif",
            //"font-weight": "700",
            "text-anchor": "middle",
            "fill": "white"
          },
          attr: {dy: "65px"},
          centralClick: function() {
            alert("Here is more details!!");
          }
        }
      },
      {
        name: "lines",
        options: {
          format: [
            {// Line #0
              textField: "count",
              classed: {count: true},
              style: {
                "font-size": "28px",
                "font-family": "Source Sans Pro, sans-serif",
                "text-anchor": "middle"
                //fill: "white"
              },
              attr: {
                dy: "0px",
                x: function (d) {return d.cx;},
                y: function (d) {return d.cy;}

              }
            },
            {// Line #1
              textField: "text",
              classed: {text: true},
              style: {
                "font-size": "14px",
                "font-family": "Source Sans Pro, sans-serif",
                "text-anchor": "middle"
                //fill: "white"
              },
              attr: {
                dy: "20px",
                x: function (d) {return d.cx;},
                y: function (d) {return d.cy;},
                // textLength: function(d) {return d.r * 1.8},
                // lengthAdjust: "spacingAndGlyphs"
              }
            }
          ],
          centralFormat: [
            {// Line #0
              style: {"font-size": "50px"},
              attr: {}
            },
            {// Line #1
              style: {"font-size": "30px"},
              attr: {
                dy: "40px",
              // textLength: function(d) {return d.r * 1.8},
              // lengthAdjust: "spacingAndGlyphs"
              }
            }
          ]
        }
      }]
  });
});

</script>
</head>
<body style="background-image: none">

<header>
      <nav id="authenticate">
        <?php
        if (!isset($_SESSION['username'])) {
        ?>
        <form method="POST" action="<?= BASE_URL ?>/login">
          <label>Username: <input id="username" type="text" name="username"></label>
          <label>Password: <input id="password" type="password" name="password"></label>
          <button type="button submit" class="btn btn-primary btn-sm">Log In</button>
        </form>

        <form method="POST" action="<?= BASE_URL ?>/signup">
          <button type="button submit" class="btn btn-primary btn-sm">Sign Up</button>
        </form>
        <?php
        } else {
        ?>
        <p>Logged in as <strong><?= $_SESSION['username'] ?></strong></p>
        <form method="POST" action="<?= BASE_URL ?>/logout">
          <button type="button submit" class="btn btn-primary btn-sm">Log Out</button>
        </form>
        <?php } ?>
      </nav>

      <nav id="breadcrumb">
        <a href="<?= BASE_URL ?>">Home</a>
        <i class="fa fa-caret-right"></i>
        <a href="<?= BASE_URL ?>/meals">Meals</a>
        <i class="fa fa-caret-right"></i>
        <a href="<?= BASE_URL ?>/meals/import">import</a>
      </nav>

      <div id="search">
				<p>Know what you're looking for?</p>
				<form method="GET" action="<?= BASE_URL ?>/meals/search">
					<input type="text" name="title" placeholder="Tasty Meal.." />
					<button type="submit" class="btn btn-primary btn-sm">Search</button>
				</form>
			</div>
    </header>

    <div id="content">
  <div id="menu_bar">
				<?php
				$current_user = isset($_SESSION['username']) ? user::load_by_username($_SESSION['username']) : null;
				if ($current_user != null) {
				?>
				<div id="home" class="btn-group-vertical" role="group">
					<button type="button" class="btn btn-default"><a href="<?= BASE_URL ?>"><i class="fa fa-home"></i>&nbsp;Home&nbsp;</a></button>

					<form method="GET" action="<?= BASE_URL ?>/meals/new">
						<button type="submit button" class="btn btn-default"><i class="fa fa-cutlery"></i>&nbsp;Create Meal&nbsp;</button>
					</form>

					<form method="GET" action="<?= BASE_URL ?>/meals/import">
						<button type="submit button" class="btn btn-default"><i class="fa fa-cloud-download"></i>&nbsp;Import Meal</button>
					</form>

					<form method="GET" action="<?= BASE_URL ?>/users/<?= $current_user->get('id') ?>">
						<button type="submit button" class="btn btn-default"><i class="fa fa-user"></i>&nbsp;View Profile&nbsp;</button>
					</form>

					<form method="GET" action="<?= BASE_URL ?>/cookbooks">
						<button type="submit button" class="btn btn-default"><i class="fa fa-book"></i>&nbsp;Cookbook&nbsp;&nbsp;&nbsp;&nbsp;</button>
					</form>

					<form method="GET" action="<?= BASE_URL ?>/users/<?= $current_user->get('id') ?>/following">
						<button type="submit button" class="btn btn-default"><i class="fa fa-users"></i>&nbsp;Following&nbsp;&nbsp;&nbsp;&nbsp;</button>
					</form>

					<form method="GET" action="<?= BASE_URL ?>/users/<?= $current_user->get('id') ?>/followers">
						<button type="submit button" class="btn btn-default"><i class="fa fa-users"></i>&nbsp;Followers&nbsp;&nbsp;&nbsp;&nbsp;</button>
					</form>

					<?php
					if ($_SESSION['admin'] == 1) {
					?>
					<form method="GET" action="<?= BASE_URL ?>/users">
						<button type="submit button" class="btn btn-default"><i class="fa fa-list"></i>&nbsp;Users List&nbsp;&nbsp;&nbsp;&nbsp;</button>
					</form>
					<?php } ?>

					<button id="favorites" type="button" class="btn btn-default"><i class="fa fa-heart"></i>&nbsp;Favorites</button>
				</div>
				<?php } ?>
				<div id="favorites_bar">
					<ul class="list-group">
						<?php
						if (isset($_SESSION['username'])) {
							if ($favorites != null) {
							foreach($favorites as $favorite) {
								$meal_id = $favorite->get('meal_id');
								$meal_title = $favorite->get('meal_title');
						?>
						<a href="<?= BASE_URL ?>/meals/<?= $meal_id ?>"><li class="list-group-item"><?= $meal_title ?></li></a>
						<?php }
						?>

						<a href="<?= BASE_URL ?>/meals/favorites"><li class="list-group-item">Edit Favorites</li></a>

						<?php } } ?>
					</ul>
				</div>
			</div>
<div class="bubbleChart"/>
</body>
</html>
