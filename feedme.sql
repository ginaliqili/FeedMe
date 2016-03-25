-- phpMyAdmin SQL Dump
-- version 4.4.15.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 25, 2016 at 04:26 PM
-- Server version: 5.5.46
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

CREATE TABLE IF NOT EXISTS `favorite` (
  `id` int(11) NOT NULL,
  `meal_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `meal_title` varchar(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `favorite`
--

INSERT INTO `favorite` (`id`, `meal_id`, `user_id`, `meal_title`) VALUES
(1, 4, 1, 'snack');

-- --------------------------------------------------------

--
-- Table structure for table `meal`
--

CREATE TABLE IF NOT EXISTS `meal` (
  `id` int(11) unsigned NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `meal_type` varchar(50) NOT NULL,
  `food_type` varchar(50) NOT NULL,
  `time_to_prepare` varchar(50) NOT NULL,
  `instructions` text NOT NULL,
  `creator_id` int(11) unsigned NOT NULL,
  `image_url` varchar(200) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meal`
--

INSERT INTO `meal` (`id`, `title`, `description`, `meal_type`, `food_type`, `time_to_prepare`, `instructions`, `creator_id`, `image_url`, `date_created`) VALUES
(1, 'breakfast', 'breakfast', 'breakfast', 'breakfast', '3', 'breakfast', 1, 'https://farm6.staticflickr.com/5255/5401391062_083df5192b_n.jpg', '2016-03-25 05:16:06'),
(2, 'lunch', 'lunch', 'lunch', 'lunch', 'lunch', 'lunch', 1, 'https://farm4.staticflickr.com/3945/14982184464_bee60019d5_n.jpg', '2016-03-25 05:44:59'),
(3, 'dinner', 'dinner', 'dinner', 'dinner', 'dinner', 'dinner', 1, 'https://farm9.staticflickr.com/8344/8239121613_30b4b8a560_n.jpg', '2016-03-25 05:58:17'),
(4, 'snack', 'snack', 'snack', 'snack', 'snack', 'snack', 1, 'https://farm4.staticflickr.com/3282/3025165554_4d7b931623_n.jpg', '2016-03-25 07:37:35'),
(6, 'Apple', '', '', '', '', '', 1, 'https://farm3.staticflickr.com/2950/15165630350_d6c66a346c_n.jpg', '2016-03-25 14:36:50');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) unsigned NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(200) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`) VALUES
(1, 'hihi', 'hi', 'Gina', 'Li', 'ginali');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `favorite`
--
ALTER TABLE `favorite`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `meal`
--
ALTER TABLE `meal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `creator_id` (`creator_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `favorite`
--
ALTER TABLE `favorite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `meal`
--
ALTER TABLE `meal`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `meal`
--
ALTER TABLE `meal`
  ADD CONSTRAINT `meal_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
