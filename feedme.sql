-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 26, 2016 at 12:27 AM
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
-- Table structure for table `cookbook`
--

CREATE TABLE `cookbook` (
  `id` int(11) NOT NULL,
  `meal_id` int(11) NOT NULL,
  `page_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cookbook`
--

INSERT INTO `cookbook` (`id`, `meal_id`, `page_number`) VALUES
(1, 46, 3),
(2, 48, 4),
(3, 49, 5);

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE `event` (
  `id` int(11) UNSIGNED NOT NULL,
  `creator_id` int(11) UNSIGNED NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `event`
--

INSERT INTO `event` (`id`, `creator_id`, `date_created`) VALUES
(1, 2, '2016-03-25 16:21:37'),
(2, 2, '2016-03-25 16:23:04'),
(3, 2, '2016-03-25 16:24:03'),
(4, 2, '2016-03-25 16:24:42'),
(5, 1, '2016-03-25 16:25:37'),
(6, 2, '2016-03-25 16:26:37'),
(7, 2, '2016-03-25 16:27:37'),
(8, 1, '2016-03-25 16:28:37'),
(9, 1, '2016-03-25 16:29:37'),
(10, 2, '2016-03-25 16:30:37'),
(11, 1, '2016-03-25 16:31:37'),
(12, 1, '2016-04-08 19:50:12'),
(13, 1, '2016-04-08 19:51:04'),
(14, 1, '2016-04-08 20:27:46'),
(15, 1, '2016-04-21 15:51:55'),
(16, 1, '2016-04-21 21:57:37'),
(17, 1, '2016-04-21 21:57:40'),
(18, 1, '2016-04-21 23:56:46'),
(19, 1, '2016-04-23 21:54:28'),
(20, 1, '2016-04-23 21:54:33'),
(21, 1, '2016-04-23 21:54:51'),
(22, 1, '2016-04-23 22:00:22'),
(23, 1, '2016-04-23 22:39:36'),
(24, 1, '2016-04-23 22:44:21'),
(25, 1, '2016-04-23 22:44:29'),
(26, 1, '2016-04-23 22:52:01'),
(27, 1, '2016-04-23 22:52:21'),
(28, 1, '2016-04-23 22:52:29'),
(29, 1, '2016-04-23 23:11:41'),
(30, 1, '2016-04-23 23:11:44'),
(31, 1, '2016-04-23 23:13:28'),
(32, 1, '2016-04-23 23:14:25'),
(33, 1, '2016-04-23 23:14:34'),
(34, 1, '2016-04-23 23:16:28'),
(35, 1, '2016-04-23 23:16:32'),
(36, 1, '2016-04-23 23:16:35'),
(37, 1, '2016-04-23 23:36:53'),
(38, 1, '2016-04-23 23:38:21'),
(39, 1, '2016-04-23 23:38:25'),
(40, 1, '2016-04-23 23:38:43'),
(41, 1, '2016-04-23 23:39:11'),
(42, 1, '2016-04-23 23:40:12'),
(43, 1, '2016-04-23 23:40:35'),
(44, 1, '2016-04-23 23:40:59'),
(45, 1, '2016-04-23 23:41:02'),
(46, 1, '2016-04-23 23:41:05'),
(47, 1, '2016-04-24 00:20:56'),
(48, 1, '2016-04-24 00:22:26'),
(49, 1, '2016-04-24 00:31:14'),
(50, 1, '2016-04-24 00:32:18'),
(51, 1, '2016-04-24 00:32:22'),
(52, 1, '2016-04-24 00:32:51'),
(53, 1, '2016-04-24 00:32:52'),
(54, 1, '2016-04-24 00:32:56'),
(55, 1, '2016-04-24 00:33:00'),
(56, 1, '2016-04-24 00:33:29'),
(57, 1, '2016-04-24 00:33:31'),
(58, 1, '2016-04-24 00:33:46'),
(59, 1, '2016-04-24 00:34:00'),
(60, 1, '2016-04-24 02:46:21'),
(61, 1, '2016-04-24 02:46:26'),
(62, 1, '2016-04-24 02:46:30'),
(63, 1, '2016-04-24 02:47:11'),
(64, 1, '2016-04-24 02:47:17'),
(65, 1, '2016-04-24 02:47:33'),
(66, 1, '2016-04-24 02:47:52'),
(67, 1, '2016-04-24 02:47:54'),
(68, 1, '2016-04-24 02:50:02'),
(69, 1, '2016-04-24 02:53:28'),
(70, 1, '2016-04-24 02:53:35'),
(71, 1, '2016-04-24 02:53:41'),
(72, 1, '2016-04-24 22:55:08'),
(73, 1, '2016-04-24 23:30:01'),
(74, 1, '2016-04-24 23:30:07'),
(75, 1, '2016-04-25 00:42:43');

-- --------------------------------------------------------

--
-- Table structure for table `favorite`
--

CREATE TABLE `favorite` (
  `id` int(11) UNSIGNED NOT NULL,
  `meal_id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `meal_title` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `favorite`
--

INSERT INTO `favorite` (`id`, `meal_id`, `user_id`, `meal_title`) VALUES
(1, 1, 2, 'Meatloaf'),
(2, 2, 2, 'Banana Bread'),
(4, 4, 1, 'White Cake');

-- --------------------------------------------------------

--
-- Table structure for table `follow`
--

CREATE TABLE `follow` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `follower_id` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `follow`
--

INSERT INTO `follow` (`id`, `user_id`, `follower_id`) VALUES
(1, 1, 2),
(3, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `meal`
--

CREATE TABLE `meal` (
  `id` int(11) UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `meal_type` varchar(50) NOT NULL,
  `food_type` varchar(50) NOT NULL,
  `time_to_prepare` varchar(50) NOT NULL,
  `instructions` text NOT NULL,
  `creator_id` int(11) UNSIGNED NOT NULL,
  `image_url` varchar(200) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meal`
--

INSERT INTO `meal` (`id`, `title`, `description`, `meal_type`, `food_type`, `time_to_prepare`, `instructions`, `creator_id`, `image_url`, `date_created`) VALUES
(1, 'Meatloaf', 'Best meatloaf recipe!', 'Dinner', 'American', '15 Minutes', 'Cook beef', 2, 'https://farm8.staticflickr.com/7350/9491525665_366c2be10d_n.jpg', '2016-03-25 16:21:37'),
(2, 'Banana Bread', 'Super moist banana bread', 'Breakfast', 'American', '1 Hour', 'Add flour, water, vanilla, butter, and eggs into a nonstick bread pan. Add walnuts and chocolate chips if desired. Bake for 1 hour.', 2, 'https://farm5.staticflickr.com/4126/5052439919_e76d3562d5_n.jpg', '2016-03-25 16:23:04'),
(3, 'Spaghetti', 'Amazing spaghetti', 'Lunch', 'Italian', '15 Minutes', 'Bring water to boil, add spaghetti noodles and cook. Garnish with italian seasoning, cheese, and tomato sauce.', 2, 'https://farm4.staticflickr.com/3469/5704122117_7d15ce7a60_n.jpg', '2016-03-25 16:24:03'),
(4, 'White Cake', 'My favorite birthday cake', 'Breakfast', 'American', '1 Hour', 'Add cake mix together.', 2, 'https://farm6.staticflickr.com/5190/5693019578_47012d5ec1_n.jpg', '2016-03-25 16:24:42'),
(46, 'sugar', '', '', '', '', '', 1, '', '2016-04-24 02:53:41'),
(48, 'tommy', '', '', '', '', '', 1, '', '2016-04-24 23:30:01'),
(49, 'gina', '', '', '', '', '', 1, 'https://farm3.staticflickr.com/2303/2115138031_b34d32761d_n.jpg', '2016-04-24 23:30:07');

-- --------------------------------------------------------

--
-- Table structure for table `meal_event`
--

CREATE TABLE `meal_event` (
  `id` int(11) UNSIGNED NOT NULL,
  `event_id` int(11) UNSIGNED NOT NULL,
  `meal_id` int(11) UNSIGNED NOT NULL,
  `action` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meal_event`
--

INSERT INTO `meal_event` (`id`, `event_id`, `meal_id`, `action`) VALUES
(1, 1, 1, 'created'),
(2, 2, 2, 'created'),
(3, 3, 3, 'created'),
(4, 4, 4, 'created'),
(6, 6, 1, 'favorited'),
(7, 7, 2, 'favorited'),
(9, 9, 4, 'favorited'),
(68, 71, 46, 'created'),
(70, 73, 48, 'created'),
(71, 74, 49, 'created');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) UNSIGNED NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(200) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `admin` int(11) NOT NULL DEFAULT '0',
  `recipeaccess` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `admin`, `recipeaccess`) VALUES
(1, 'ginali', 'pw', 'Gina', 'Li', 'ginali@vt.edu', 1, 1),
(2, 'tommydean', 'pw', 'Tommy', 'Dean', 'tommydean@vt.edu', 1, 1),
(3, 'sophiek', 'pw', 'Sophia', 'Kobelja', 'sophia94@vt.edu', 0, 1),
(4, 'jd', 'pw', 'john', 'doe', 'jd@vt.edu', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_event`
--

CREATE TABLE `user_event` (
  `id` int(11) UNSIGNED NOT NULL,
  `event_id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `action` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_event`
--

INSERT INTO `user_event` (`id`, `event_id`, `user_id`, `action`) VALUES
(1, 10, 1, 'followed'),
(2, 11, 2, 'followed'),
(3, 15, 2, 'followed');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cookbook`
--
ALTER TABLE `cookbook`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `favorite`
--
ALTER TABLE `favorite`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meal_id` (`meal_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `follow`
--
ALTER TABLE `follow`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `follower_id` (`follower_id`);

--
-- Indexes for table `meal`
--
ALTER TABLE `meal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `creator_id` (`creator_id`);

--
-- Indexes for table `meal_event`
--
ALTER TABLE `meal_event`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_id` (`event_id`),
  ADD KEY `meal_id` (`meal_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `user_event`
--
ALTER TABLE `user_event`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_id` (`event_id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cookbook`
--
ALTER TABLE `cookbook`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `event`
--
ALTER TABLE `event`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;
--
-- AUTO_INCREMENT for table `favorite`
--
ALTER TABLE `favorite`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `follow`
--
ALTER TABLE `follow`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `meal`
--
ALTER TABLE `meal`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;
--
-- AUTO_INCREMENT for table `meal_event`
--
ALTER TABLE `meal_event`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `user_event`
--
ALTER TABLE `user_event`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
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

--
-- Constraints for table `meal_event`
--
ALTER TABLE `meal_event`
  ADD CONSTRAINT `meal_event_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `meal_event_ibfk_2` FOREIGN KEY (`meal_id`) REFERENCES `meal` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_event`
--
ALTER TABLE `user_event`
  ADD CONSTRAINT `user_event_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_event_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
