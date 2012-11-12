-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 13, 2012 at 12:34 AM
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
DROP DATABASE `nextsis`;
CREATE DATABASE `nextsis` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `nextsis`;

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE IF NOT EXISTS `course` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores course names and details.' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `language`
--

CREATE TABLE IF NOT EXISTS `language` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The language primary key (0-65,535).',
  `code` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ISO 639-1 language codes.',
  `subtag` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Tags as defined by IETF BCP 47.',
  `name` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The name of the language.',
  `region` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The region (country or area) spoken in if applicable.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `subtag` (`subtag`),
  UNIQUE KEY `description` (`name`,`region`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Language list table.' AUTO_INCREMENT=9 ;

--
-- Dumping data for table `language`
--

INSERT INTO `language` (`id`, `code`, `subtag`, `name`, `region`) VALUES
(1, 'en', 'US', 'English', 'American'),
(2, 'en', 'GB', 'English', 'British'),
(3, 'ko', 'KR', 'Korean', NULL),
(4, 'km', 'KH', 'Central Khmer', 'Cambodia'),
(5, 'zh', 'CN', 'Chinese', 'China'),
(6, 'es', 'ES', 'Spanish', 'Spain'),
(7, 'fr', 'CA', 'French', 'Canada'),
(8, 'ja', 'JP', 'Japanese', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE IF NOT EXISTS `person` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (4,294,967,295 possible values). This can serve as a public or internal identifier.',
  `local_id` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `surname` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The surname of the person.',
  `first_name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'This stores the first name of the person.',
  `middle_name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'This is to store a person''s middle name.',
  `common_name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The name the person is commonly known by.',
  `title_id` smallint(5) unsigned NOT NULL COMMENT 'Foreign key from person_title table.',
  `gender_id` smallint(3) unsigned NOT NULL COMMENT 'Foreign key from the person_gender table.',
  `username` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The person''s nextSIS username.',
  `password` varchar(252) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The person''s nextSIS password (encrypted).',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `local_id` (`local_id`),
  KEY `surname` (`surname`),
  KEY `first_name` (`first_name`),
  KEY `title_id` (`title_id`),
  KEY `gender_id` (`gender_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Person table (stores all people - students, staff, parents, administrators...)' AUTO_INCREMENT=6 ;

--
-- Dumping data for table `person`
--

INSERT INTO `person` (`id`, `local_id`, `surname`, `first_name`, `middle_name`, `common_name`, `title_id`, `gender_id`, `username`, `password`) VALUES
(5, 'NX-1', 'Smith', 'John', NULL, NULL, 4, 2, 'admin', 'c2ab1dbf445c7aafec65ee0d94ccd05d43e90a9a2b12e6bae8e32e924ba4a0245664350b0e8320a326faa38a93e5fbef36113bbbb72f0c4aa8b046c84c5a09b2');

-- --------------------------------------------------------

--
-- Table structure for table `person_course`
--

CREATE TABLE IF NOT EXISTS `person_course` (
  `person_id` int(8) unsigned NOT NULL COMMENT 'Foreign key from the person table.',
  `course_id` mediumint(8) unsigned NOT NULL COMMENT 'Foreign key form the course table.',
  PRIMARY KEY (`person_id`,`course_id`),
  KEY `course_id` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Link table between person and course for many-to-many.';

-- --------------------------------------------------------

--
-- Table structure for table `person_gender`
--

CREATE TABLE IF NOT EXISTS `person_gender` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (0-65,535).',
  `language_id` smallint(5) unsigned NOT NULL COMMENT 'The primary key from the language table.',
  `label` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The gender of a person.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `label` (`label`),
  KEY `language_id` (`language_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='A person''s gender.' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `person_gender`
--

INSERT INTO `person_gender` (`id`, `language_id`, `label`) VALUES
(1, 1, 'Female'),
(2, 1, 'Male');

-- --------------------------------------------------------

--
-- Table structure for table `person_role`
--

CREATE TABLE IF NOT EXISTS `person_role` (
  `person_id` int(10) unsigned NOT NULL COMMENT 'Foreign key from the person table.',
  `role_id` smallint(5) unsigned NOT NULL COMMENT 'Foreign key from the role table.',
  PRIMARY KEY (`person_id`,`role_id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Link table between person and role to support many-to-many.';

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
-- Table structure for table `person_title`
--

CREATE TABLE IF NOT EXISTS `person_title` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (0-255).',
  `language_id` smallint(5) unsigned NOT NULL COMMENT 'The primary key from the language table.',
  `label` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `label` (`label`),
  KEY `language_id` (`language_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Titles a person can be known by.' AUTO_INCREMENT=6 ;

--
-- Dumping data for table `person_title`
--

INSERT INTO `person_title` (`id`, `language_id`, `label`) VALUES
(1, 1, 'Dr.'),
(2, 1, 'Miss'),
(3, 1, 'Ms.'),
(4, 1, 'Mr.'),
(5, 1, 'Mrs.');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE IF NOT EXISTS `role` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores people''s roles (student, teacher, parent, administrator etc.)' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `school`
--

CREATE TABLE IF NOT EXISTS `school` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores school details (to support multiple schools)' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `school_course`
--

CREATE TABLE IF NOT EXISTS `school_course` (
  `school_id` mediumint(10) unsigned NOT NULL COMMENT 'Foreign key from the school table.',
  `course_id` mediumint(10) unsigned NOT NULL COMMENT 'Foreign key from the course table.',
  PRIMARY KEY (`school_id`,`course_id`),
  KEY `course_id` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='This is a link table between school and course to support many-to-many.';

--
-- Constraints for dumped tables
--

--
-- Constraints for table `person`
--
ALTER TABLE `person`
  ADD CONSTRAINT `person_ibfk_1` FOREIGN KEY (`title_id`) REFERENCES `person_title` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `person_ibfk_2` FOREIGN KEY (`gender_id`) REFERENCES `person_gender` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `person_course`
--
ALTER TABLE `person_course`
  ADD CONSTRAINT `person_course_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `person_course_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `person_gender`
--
ALTER TABLE `person_gender`
  ADD CONSTRAINT `person_gender_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `person_role`
--
ALTER TABLE `person_role`
  ADD CONSTRAINT `person_role_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `person_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `person_school`
--
ALTER TABLE `person_school`
  ADD CONSTRAINT `person_school_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `person_school_ibfk_3` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `person_title`
--
ALTER TABLE `person_title`
  ADD CONSTRAINT `person_title_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `school_course`
--
ALTER TABLE `school_course`
  ADD CONSTRAINT `school_course_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `school_course_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
