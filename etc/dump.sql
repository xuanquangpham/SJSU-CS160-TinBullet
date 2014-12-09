-- CREATE DATABASE  IF NOT EXISTS `StickyNotes` /*!40100 DEFAULT CHARACTER SET utf8 */;
-- USE `StickyNotes`;
-- MySQL dump 10.13  Distrib 5.6.13, for osx10.6 (i386)
--
-- Host: 127.0.0.1    Database: StickyNotes
-- ------------------------------------------------------
-- Server version	5.6.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `boards`
--

DROP TABLE IF EXISTS `boards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boards`
--

LOCK TABLES `boards` WRITE;
/*!40000 ALTER TABLE `boards` DISABLE KEYS */;
INSERT INTO `boards` VALUES (1,'CS160'),(2,'CS174'),(3,'CS175'),(4,'CS100W'),(5,'CS149');
/*!40000 ALTER TABLE `boards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discussion`
--

DROP TABLE IF EXISTS `discussion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discussion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `author_id` int(11) DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `post_id_idx` (`post_id`),
  KEY `author_id_idx` (`author_id`),
  CONSTRAINT `author_discussion_id` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `post_discussion_id` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discussion`
--

LOCK TABLES `discussion` WRITE;
/*!40000 ALTER TABLE `discussion` DISABLE KEYS */;
INSERT INTO `discussion` VALUES (1,'Reply for welcome message',2,1,'2014-10-10 23:59:59',1),(2,'Reply for message 1',2,1,'2014-10-10 23:59:59',2),(3,'Reply for message 1',3,1,'2014-10-10 23:59:59',3),(4,'Reply for message 2',3,2,'2014-10-10 23:59:59',1),(5,'Reply for message 2',4,2,'2014-10-10 23:59:59',2),(6,'Reply for message 3',2,3,'2014-10-10 23:59:59',2),(7,'Reply for message 4',3,4,'2014-10-10 23:59:59',3),(8,'Reply for message 4',3,4,'2014-10-10 23:59:59',1),(9,'Reply for message 5',4,5,'2014-10-10 23:59:59',1);
/*!40000 ALTER TABLE `discussion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) DEFAULT NULL,
  `content` text,
  `date` datetime DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `board_id` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `seen` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id_idx` (`author_id`),
  KEY `board_id_idx` (`board_id`),
  CONSTRAINT `author_id` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `post_board_id` FOREIGN KEY (`board_id`) REFERENCES `boards` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,'Welcome to StickyNotes','Already as necessary as pencils and paper clips, Sticky Notes just got more useful. In Windows 7, you can format a note’s text, change its color with a click, and speedily resize, collapse, and flip through notes.If youve got a Tablet PC or a touchscreen, Windows 7 Sticky Notes support pen and touch input, too—you can even switch between different input methods within the space of a single note. Sticky Notes is available only in the Home Premium, Professional, Ultimate, and Enterprise editions of Windows 7.','2014-10-10 23:59:59',1,1,1,1,'quangpham');
INSERT INTO `post` VALUES (2,'Post-it Notes','Post-it Notes, those little yellow pads of sticky-backed paper, changed the world, or at least the way people who live in it leave reminders to themselves and others. When the layers of notes (now multicolor) start to resemble cedar shingles, its time to clean your computer monitor. That brings up an important point: as big an improvement as sticky notes have been over the old paper napkin method, software versions like Sticky Notes may be better still. For one thing, Sticky Notes lets you organize, search, store, and back up your notes; set reminders, priorities, and alarms; and customize its look and behavior. Plus itll never get lost in your desk drawer or behind your coffee mug. Sticky Notes is free to try, with a few features disabled, but at $4.99 the full version easily passes the Lunch Test, costing about what youd pay for a sandwich and drink from the local carry-out.','2014-10-10 23:59:59',1,1,1,2,'quangpham');
INSERT INTO `post` VALUES (3,'Application','The Sticky Notes application allows you to create electronic sticky notes directly on your Windows desktop. The Sticky Notes are just like paper post-it notes for your computer. Jot down tasks, messages, ideas, appointments, phone numbers, birthdays in a note and stick it on the desktop. A note can be positioned anywhere you wish, or hidden in your task bar, then searched and displayed later. Notes can be re-sized. The notes contents can be formatted to include fonts, colors, transparency and hyperlinks. Also notes have a click thru capability. Once on screen, notes will remain where placed until closed, even through reboots. Alarms','2014-10-10 23:59:59',2,1,2,3,'steven');
INSERT INTO `post` VALUES (4,'Installation Process','Sticky Notes doesnt require any installation process or additional components and it does not use the registry. Download the zip file and create a new folder in C:\Program Files and name it StickyNotes. Extract the contents of the downloaded file to C:\Program Files\StickyNotes. Click on the StickyNotes.exe. Sticky Notes icon will appear in the Windows System Tray (bottom corner to the right of the Windows taskbar). To start up Sticky Notes every time Windows boots up, add Sticky Notes to your Start-up group. To do this click the button "Create a shortcut in the start-up group" in the Options dialog','2014-10-10 23:59:59',3,1,3,1,'derek');
INSERT INTO `post` VALUES (5,'Guide','To open a new sticky note, double click on the Sticky Notes icon in the system tray/notification area. To access the application menu, right click on the Sticky Notes tray icon. To access the note menu, click on the down arrow in the upper left hand corner. By default, Sticky Notes will stay on top of other windows as indicated by the pin. To toggle that setting, click on the pin once. To close a sticky note, click on the small red power button in the upper right hand corner. Sticky Note saves all of your sticky notes in a .dat file, so dont worry if you closed a sticky note accidentally, you can always retrieve using the Search window.','2014-10-10 23:59:59',1,2,1,1,'quangpham');
INSERT INTO `post` VALUES (6,'System tray','Sticky Notes resides in the system tray; right-clicking its icon opens the programs main menu, where users create and manage Notes and the programs settings. However, you can also configure hot keys to make Sticky Notes even faster and easier to use by clicking Program Settings and selecting the Hotkeys tab (you can also set General Settings, configure Notes, and more). We clicked Create a New Note, and a new note popped up with the cursor ready. You dont have to click Save or do anything to slow you down; a few quick keystrokes and then click the red Exit button, and Sticky Notes automatically saves your note. When wed saved a few Notes, we clicked the menu to view Recent Notes, Arrange Notes (cascade or tile) and Search them. Need help? Click Help: Help appears.','2014-10-10 23:59:59',2,2,2,2,'steven');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_board`
--

DROP TABLE IF EXISTS `user_board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_board` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `board_id` int(11) DEFAULT NULL,
  `permission` int(11) DEFAULT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `board_id_idx` (`board_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `board_id` FOREIGN KEY (`board_id`) REFERENCES `boards` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_board`
--

LOCK TABLES `user_board` WRITE;
/*!40000 ALTER TABLE `user_board` DISABLE KEYS */;
INSERT INTO `user_board` VALUES (1,1,1,1),(2,2,1,1),(3,3,1,1),(4,4,1,1),(5,1,2,1),(6,2,2,1);
/*!40000 ALTER TABLE `user_board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) DEFAULT NULL,
  `firstname` varchar(45) DEFAULT NULL,
  `lastname` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'quangpham','Quang','Pham','xuanquangpham@yahoo.com','welcome'),(2,'steven','Zheyu','Liu','stevenliu92@yahoo.com','welcome'),(3,'derek','Pang','Derek','derek@yahoo.com','welcome'),(4,'joseph','Matteucci','Joseph','joseph@yahoo.com','welcome');
INSERT INTO `users` VALUES (5,'huypham','Huy','Pham','huypham@yahoo.com','welcome'),(6,'alex','Alex','Jobs','alex@yahoo.com','welcome');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-11-12 16:45:17
