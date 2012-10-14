-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 15, 2012 at 12:10 AM
-- Server version: 5.5.24
-- PHP Version: 5.3.10-1ubuntu3.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `nextsis`
--

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE IF NOT EXISTS `person` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (4,294,967,295 possible values). This can serve as a public or internal identifier.',
  `local_id` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `surname` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The surname of the person.',
  `first_name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'This stores the first name of the person.',
  `middle_name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'This is to store a person''s middle name.',
  `common_name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The name the person is commonly known by.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `local_id` (`local_id`),
  KEY `surname` (`surname`),
  KEY `first_name` (`first_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Person table (stores all people - students, staff, parents, administrators...)' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `person_school`
--

CREATE TABLE IF NOT EXISTS `person_school` (
  `person_id` int(10) unsigned NOT NULL COMMENT 'Foreign key from person table',
  `school_id` mediumint(8) unsigned NOT NULL COMMENT 'Foriegn key from school table',
  PRIMARY KEY (`person_id`,`school_id`),
  KEY `school_id` (`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Link table between person and school for many-to-many';

-- --------------------------------------------------------

--
-- Table structure for table `school`
--

CREATE TABLE IF NOT EXISTS `school` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores school details (to support multiple schools)' AUTO_INCREMENT=1 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `person_school`
--
ALTER TABLE `person_school`
  ADD CONSTRAINT `person_school_ibfk_3` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `person_school_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
