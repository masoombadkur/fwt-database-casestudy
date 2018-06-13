/*
SQLyog Ultimate v10.00 Beta1
MySQL - 5.1.56-community : Database - fwp-crs
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`fwp-crs` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `fwp-crs`;

/*Table structure for table `car` */

DROP TABLE IF EXISTS `car`;

CREATE TABLE `car` (
  `car_id` int(5) NOT NULL AUTO_INCREMENT,
  `category_id` int(5) NOT NULL,
  `brand` varchar(20) NOT NULL,
  `model_name` varchar(10) NOT NULL,
  `production_year` year(4) DEFAULT NULL,
  `mileage` int(2) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`car_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `car_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `car` */

/*Table structure for table `car_equipment` */

DROP TABLE IF EXISTS `car_equipment`;

CREATE TABLE `car_equipment` (
  `car_equipment_id` int(5) NOT NULL AUTO_INCREMENT,
  `car_id` int(5) DEFAULT NULL,
  `equipment_id` int(5) DEFAULT NULL,
  PRIMARY KEY (`car_equipment_id`),
  KEY `car_id` (`car_id`),
  KEY `equipment_id` (`equipment_id`),
  CONSTRAINT `car_equipment_ibfk_1` FOREIGN KEY (`car_id`) REFERENCES `car` (`car_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `car_equipment_ibfk_2` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`equipment_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `car_equipment` */

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `category_id` int(5) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `category` */

/*Table structure for table `city` */

DROP TABLE IF EXISTS `city`;

CREATE TABLE `city` (
  `city_id` int(5) NOT NULL AUTO_INCREMENT,
  `city_name` varchar(50) NOT NULL,
  PRIMARY KEY (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `city` */

/*Table structure for table `customer` */

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
  `customer_id` int(5) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(50) NOT NULL,
  `customer_age` int(2) NOT NULL,
  `license_no` varchar(15) DEFAULT NULL,
  `is_valid` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `customer` */

/*Table structure for table `equipment` */

DROP TABLE IF EXISTS `equipment`;

CREATE TABLE `equipment` (
  `equipment_id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`equipment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `equipment` */

/*Table structure for table `equipment_rent` */

DROP TABLE IF EXISTS `equipment_rent`;

CREATE TABLE `equipment_rent` (
  `equipment_rent_id` int(5) NOT NULL AUTO_INCREMENT,
  `equipment_id` int(5) DEFAULT NULL,
  `rent_id` int(5) DEFAULT NULL,
  PRIMARY KEY (`equipment_rent_id`),
  KEY `equipment_id` (`equipment_id`),
  KEY `rent_id` (`rent_id`),
  CONSTRAINT `equipment_rent_ibfk_1` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`equipment_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `equipment_rent_ibfk_2` FOREIGN KEY (`rent_id`) REFERENCES `rent` (`rent_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `equipment_rent` */

/*Table structure for table `insurance` */

DROP TABLE IF EXISTS `insurance`;

CREATE TABLE `insurance` (
  `insurance_id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `policy` varchar(20) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`insurance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `insurance` */

/*Table structure for table `location` */

DROP TABLE IF EXISTS `location`;

CREATE TABLE `location` (
  `location_id` int(5) NOT NULL AUTO_INCREMENT,
  `location_name` varchar(50) NOT NULL,
  `city_id` int(5) DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  KEY `city_id` (`city_id`),
  CONSTRAINT `location_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `location` */

/*Table structure for table `price` */

DROP TABLE IF EXISTS `price`;

CREATE TABLE `price` (
  `price_id` int(5) NOT NULL AUTO_INCREMENT,
  `category` varchar(50) DEFAULT NULL,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`price_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `price` */

/*Table structure for table `rent` */

DROP TABLE IF EXISTS `rent`;

CREATE TABLE `rent` (
  `rent_id` int(5) NOT NULL AUTO_INCREMENT,
  `car_id` int(5) DEFAULT NULL,
  `reservation_id` int(5) DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `price_id` int(5) DEFAULT NULL,
  PRIMARY KEY (`rent_id`),
  UNIQUE KEY `reservation_id` (`reservation_id`),
  KEY `car_id` (`car_id`),
  KEY `price_id` (`price_id`),
  CONSTRAINT `rent_ibfk_1` FOREIGN KEY (`car_id`) REFERENCES `car` (`car_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rent_ibfk_2` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`reservation_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rent_ibfk_3` FOREIGN KEY (`price_id`) REFERENCES `price` (`price_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `rent` */

/*Table structure for table `rent_insurance` */

DROP TABLE IF EXISTS `rent_insurance`;

CREATE TABLE `rent_insurance` (
  `rent_insurance_id` int(5) NOT NULL AUTO_INCREMENT,
  `rent_id` int(5) DEFAULT NULL,
  `insurance_id` int(5) DEFAULT NULL,
  PRIMARY KEY (`rent_insurance_id`),
  KEY `rent_id` (`rent_id`),
  KEY `insurance_id` (`insurance_id`),
  CONSTRAINT `rent_insurance_ibfk_1` FOREIGN KEY (`rent_id`) REFERENCES `rent` (`rent_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rent_insurance_ibfk_2` FOREIGN KEY (`insurance_id`) REFERENCES `insurance` (`insurance_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `rent_insurance` */

/*Table structure for table `reservation` */

DROP TABLE IF EXISTS `reservation`;

CREATE TABLE `reservation` (
  `reservation_id` int(5) NOT NULL AUTO_INCREMENT,
  `customer_id` int(5) DEFAULT NULL,
  `category_id` int(5) DEFAULT NULL,
  `drop_off_location_id` int(5) DEFAULT NULL,
  `pick_up_location_id` int(5) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  PRIMARY KEY (`reservation_id`),
  KEY `customer_id` (`customer_id`),
  KEY `category_id` (`category_id`),
  KEY `drop_off_location_id` (`drop_off_location_id`),
  KEY `pick_up_location_id` (`pick_up_location_id`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reservation_ibfk_3` FOREIGN KEY (`drop_off_location_id`) REFERENCES `location` (`location_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reservation_ibfk_4` FOREIGN KEY (`pick_up_location_id`) REFERENCES `location` (`location_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `reservation` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
