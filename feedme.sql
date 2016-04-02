-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 25, 2016 at 05:31 PM
-- Server version: 10.1.10-MariaDB
-- PHP Version: 7.0.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `feedme`
--

-- --------------------------------------------------------

--
-- Table structure for table `favorite`
--

CREATE TABLE `favorite` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `meal_id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `meal_title` varchar(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `favorite`
--

INSERT INTO `favorite` (`id`, `meal_id`, `user_id`, `meal_title`) VALUES
(1, 1, 2, 'Meatloaf'),
(2, 2, 2, 'Banana Brea'),
(3, 5, 1, 'Pho'),
(4, 4, 1, 'White Cake');

-- --------------------------------------------------------

-- Table structure for table `follow`
--

CREATE TABLE `follow` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) UNSIGNED NOT NULL,
  `follower_id` int(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `follow`
--

INSERT INTO `follow` (`id`, `user_id`, `follower_id`) VALUES
(1, 1, 2),
(2, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `meal`
--

CREATE TABLE `meal` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `meal_type` varchar(50) NOT NULL,
  `food_type` varchar(50) NOT NULL,
  `time_to_prepare` varchar(50) NOT NULL,
  `instructions` text NOT NULL,
  `creator_id` int(11) UNSIGNED NOT NULL,
  `image_url` varchar(200) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meal`
--

INSERT INTO `meal` (`id`, `title`, `description`, `meal_type`, `food_type`, `time_to_prepare`, `instructions`, `creator_id`, `image_url`, `date_created`) VALUES
(1, 'Meatloaf', 'Best meatloaf recipe!', 'Dinner', 'American', '15 Minutes', 'Cook beef', 2, 'https://farm8.staticflickr.com/7350/9491525665_366c2be10d_n.jpg', '2016-03-25 16:21:37'),
(2, 'Banana Bread', 'Super moist banana bread', 'Breakfast', 'American', '1 Hour', 'Add flour, water, vanilla, butter, and eggs into a nonstick bread pan. Add walnuts and chocolate chips if desired. Bake for 1 hour.', 2, 'https://farm5.staticflickr.com/4126/5052439919_e76d3562d5_n.jpg', '2016-03-25 16:23:04'),
(3, 'Spaghetti', 'Amazing spaghetti', 'Lunch', 'Italian', '15 Minutes', 'Bring water to boil, add spaghetti noodles and cook. Garnish with italian seasoning, cheese, and tomato sauce.', 2, 'https://farm4.staticflickr.com/3469/5704122117_7d15ce7a60_n.jpg', '2016-03-25 16:24:03'),
(4, 'White Cake', 'My favorite birthday cake', 'Breakfast', 'American', '1 Hour', 'Add cake mix together.', 2, 'https://farm6.staticflickr.com/5190/5693019578_47012d5ec1_n.jpg', '2016-03-25 16:24:42'),
(5, 'Pho', 'Comfort food!', 'Lunch', 'Asian', '45 Minutes', 'Boil noodles and add MSG. Add vegetables and meat of your choice.', 1, 'https://farm3.staticflickr.com/2703/4137159599_22e99e1d89_n.jpg', '2016-03-25 16:25:37');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(200) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `admin` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `admin`) VALUES
(1, 'ginali', 'pw', 'Gina', 'Li', 'ginali@vt.edu', 1),
(2, 'tommydean', 'pw', 'Tommy', 'Dean', 'tommydean@vt.edu', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `favorite`
--
ALTER TABLE `favorite`
  ADD KEY `meal_id` (`meal_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `follow`
--
ALTER TABLE `follow`
  ADD KEY `user_id` (`user_id`),
  ADD KEY `follower_id` (`follower_id`);

--
-- Indexes for table `meal`
--
ALTER TABLE `meal`
  ADD KEY `creator_id` (`creator_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD UNIQUE KEY `username` (`username`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `favorite`
--
ALTER TABLE `favorite`
  ADD CONSTRAINT `favorite_ibfk_1` FOREIGN KEY (`meal_id`) REFERENCES `meal` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `favorite_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `follow`
--
ALTER TABLE `follow`
  ADD CONSTRAINT `follow_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `follow_ibfk_2` FOREIGN KEY (`follower_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `meal`
--
ALTER TABLE `meal`
  ADD CONSTRAINT `meal_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
