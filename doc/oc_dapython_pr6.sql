-- MySQL dump 10.13  Distrib 5.5.55, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: oc_dapython_pr6
-- ------------------------------------------------------
-- Server version	5.5.55-0+deb8u1-log

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
-- Table structure for table `boutique`
--

DROP TABLE IF EXISTS `boutique`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boutique` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `adresse` varchar(255) NOT NULL,
  `horaires` tinytext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boutique`
--

LOCK TABLES `boutique` WRITE;
/*!40000 ALTER TABLE `boutique` DISABLE KEYS */;
INSERT INTO `boutique` VALUES (1,'Boutique du nord','12 rue de la frite, 59000 Lille','12h-14h\r\n18h-23h\r\n7j/7'),(2,'Boutique du sud','3 rue de la cigale, 13000 Marseille','12h-15h\r\n19h-22h\r\n7j/7'),(3,'Boutique de l\'est','44 rue de la choucroute, 67000 Strasbourg','11h-13h\r\n18h-22h\r\n7j/7'),(4,'Boutique de l\'ouest','78 rue de la mouette, 29200 Brest','12h-13h\r\n18h-23h\r\n7j/7');
/*!40000 ALTER TABLE `boutique` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_insert_boutique AFTER INSERT ON boutique FOR EACH ROW 
INSERT INTO stock (ingredient_id, boutique_id, quantite) 
    SELECT ingredient.id as ingredient_id, 
    new.id as boutique_id,
    0 as quantity
FROM ingredient */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_delete_boutique AFTER DELETE ON boutique FOR EACH ROW 
DELETE FROM stock WHERE boutique_id = old.id */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `commande`
--

DROP TABLE IF EXISTS `commande`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commande` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `boutique_id` int(10) unsigned NOT NULL,
  `status_id` int(10) unsigned NOT NULL DEFAULT '1',
  `paiement_type_id` int(10) unsigned NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `paiement` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ind_boutique_status` (`boutique_id`,`status_id`),
  KEY `fk_commande_client_id` (`client_id`),
  KEY `fk_commande_status_commande_id` (`status_id`),
  KEY `fk_commande_paiement_type_id` (`paiement_type_id`),
  CONSTRAINT `fk_commande_paiement_type_id` FOREIGN KEY (`paiement_type_id`) REFERENCES `paiement_type` (`id`),
  CONSTRAINT `fk_commande_boutique_id` FOREIGN KEY (`boutique_id`) REFERENCES `boutique` (`id`),
  CONSTRAINT `fk_commande_client_id` FOREIGN KEY (`client_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_commande_status_commande_id` FOREIGN KEY (`status_id`) REFERENCES `status_commande` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commande`
--

LOCK TABLES `commande` WRITE;
/*!40000 ALTER TABLE `commande` DISABLE KEYS */;
INSERT INTO `commande` VALUES (1,1,1,1,3,'2019-02-20 03:05:57',0),(2,2,2,1,3,'2019-02-20 00:31:28',0),(3,3,3,1,4,'2019-02-20 00:43:14',1),(4,4,2,1,3,'2019-02-20 02:00:27',0),(5,5,1,1,1,'2019-02-20 02:33:03',0),(6,6,2,1,1,'2019-02-20 01:41:40',0),(7,7,2,1,2,'2019-02-20 01:05:43',0),(8,8,4,1,2,'2019-02-20 02:37:07',0),(9,9,2,1,3,'2019-02-20 02:41:01',0),(10,10,1,1,3,'2019-02-20 02:53:37',0),(11,1,4,1,1,'2019-02-20 03:42:08',0),(12,2,3,1,2,'2019-02-20 02:53:25',0),(13,3,2,1,2,'2019-02-20 00:46:29',0),(14,4,3,1,1,'2019-02-20 00:45:21',0),(15,5,1,1,1,'2019-02-20 01:15:32',0),(16,6,2,1,2,'2019-02-20 02:04:27',0),(17,7,3,1,4,'2019-02-20 01:37:53',1),(18,8,2,1,1,'2019-02-20 01:05:26',0),(19,9,1,1,3,'2019-02-20 02:22:41',0),(20,10,4,1,4,'2019-02-20 03:48:57',1),(21,1,1,1,3,'2019-02-20 00:53:58',0),(22,2,1,1,4,'2019-02-20 01:25:52',1),(23,3,3,1,2,'2019-02-20 00:49:47',0),(24,4,2,1,3,'2019-02-20 02:04:11',0),(25,5,2,1,1,'2019-02-20 01:54:55',0),(26,6,3,1,3,'2019-02-20 03:07:26',0),(27,7,4,1,4,'2019-02-20 01:21:28',1),(28,8,3,1,3,'2019-02-20 03:25:58',0),(29,9,2,1,1,'2019-02-20 01:37:38',0),(30,10,2,1,3,'2019-02-20 02:39:23',0),(31,1,3,1,1,'2019-02-20 01:12:09',0),(32,2,1,1,1,'2019-02-20 02:41:11',0),(33,3,2,1,1,'2019-02-20 01:43:55',0),(34,4,3,1,4,'2019-02-20 03:31:52',1),(35,5,2,1,3,'2019-02-20 00:59:36',0),(36,6,3,1,3,'2019-02-20 01:24:43',0),(37,7,2,1,3,'2019-02-20 02:14:54',0),(38,8,4,1,3,'2019-02-20 03:03:44',0),(39,9,4,1,4,'2019-02-20 03:28:34',1),(40,10,1,1,1,'2019-02-20 01:09:06',0),(41,1,2,1,3,'2019-02-20 02:07:57',0),(42,2,2,1,2,'2019-02-20 01:00:34',0),(43,3,2,1,2,'2019-02-20 03:37:46',0),(44,4,2,1,4,'2019-02-20 03:13:51',1),(45,5,4,1,3,'2019-02-20 01:52:07',0),(46,6,4,1,2,'2019-02-20 00:58:48',0),(47,7,3,1,2,'2019-02-20 01:01:53',0),(48,8,4,1,3,'2019-02-20 02:13:24',0),(49,9,2,1,2,'2019-02-20 01:31:15',0),(50,10,1,1,2,'2019-02-20 01:50:21',0);
/*!40000 ALTER TABLE `commande` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_update_commande` BEFORE UPDATE ON `commande`
FOR EACH ROW 
BEGIN
	IF new.status_id = 5 AND new.paiement
		THEN SET new.status_id = 6;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `commande_composition`
--

DROP TABLE IF EXISTS `commande_composition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commande_composition` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `commande_id` int(10) unsigned NOT NULL,
  `recette_id` int(10) unsigned NOT NULL,
  `status_id` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_commande_composition_commande_id` (`commande_id`),
  KEY `fk_commande_composition_recette_id` (`recette_id`),
  KEY `fk_commande_composition_status_composition_id` (`status_id`),
  CONSTRAINT `fk_commande_composition_status_composition_id` FOREIGN KEY (`status_id`) REFERENCES `status_composition` (`id`),
  CONSTRAINT `fk_commande_composition_commande_id` FOREIGN KEY (`commande_id`) REFERENCES `commande` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_commande_composition_recette_id` FOREIGN KEY (`recette_id`) REFERENCES `recette` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commande_composition`
--

LOCK TABLES `commande_composition` WRITE;
/*!40000 ALTER TABLE `commande_composition` DISABLE KEYS */;
INSERT INTO `commande_composition` VALUES (1,1,3,1),(2,1,3,1),(3,2,2,1),(4,2,3,1),(5,2,3,1),(6,2,3,1),(7,3,2,1),(8,3,2,1),(9,4,3,1),(10,4,1,1),(11,4,1,1),(12,5,2,1),(13,5,3,1),(14,5,2,1),(15,5,2,1),(16,6,1,1),(17,6,3,1),(18,6,2,1),(19,6,3,1),(20,7,1,1),(21,7,1,1),(22,7,2,1),(23,7,3,1),(24,8,2,1),(25,8,3,1),(26,8,2,1),(27,8,2,1),(28,8,2,1),(29,9,3,1),(30,9,3,1),(31,9,1,1),(32,9,3,1),(33,10,2,1),(34,10,3,1),(35,11,1,1),(36,12,1,1),(37,13,1,1),(38,13,1,1),(39,13,2,1),(40,13,2,1),(41,14,1,1),(42,14,1,1),(43,14,1,1),(44,14,3,1),(45,15,3,1),(46,15,1,1),(47,16,2,1),(48,16,3,1),(49,16,3,1),(50,17,3,1),(51,17,2,1),(52,17,2,1),(53,17,3,1),(54,17,2,1),(55,18,1,1),(56,18,2,1),(57,18,1,1),(58,18,2,1),(59,18,1,1),(60,19,3,1),(61,20,1,1),(62,20,2,1),(63,20,3,1),(64,21,2,1),(65,22,1,1),(66,22,1,1),(67,22,3,1),(68,22,3,1),(69,23,2,1),(70,23,3,1),(71,23,3,1),(72,24,3,1),(73,24,1,1),(74,24,2,1),(75,24,2,1),(76,25,2,1),(77,25,2,1),(78,26,2,1),(79,26,3,1),(80,26,1,1),(81,26,3,1),(82,26,3,1),(83,27,2,1),(84,27,3,1),(85,27,2,1),(86,27,2,1),(87,27,1,1),(88,28,1,1),(89,28,3,1),(90,28,2,1),(91,28,1,1),(92,28,1,1),(93,29,2,1),(94,30,1,1),(95,30,3,1),(96,31,2,1),(97,31,2,1),(98,31,1,1),(99,32,1,1),(100,32,3,1),(101,32,1,1),(102,32,2,1),(103,32,3,1),(104,33,2,1),(105,33,3,1),(106,33,3,1),(107,34,1,1),(108,34,1,1),(109,35,1,1),(110,36,1,1),(111,36,3,1),(112,36,3,1),(113,36,3,1),(114,36,3,1),(115,37,3,1),(116,38,3,1),(117,38,2,1),(118,38,2,1),(119,38,2,1),(120,38,3,1),(121,39,1,1),(122,39,1,1),(123,39,3,1),(124,39,3,1),(125,39,1,1),(126,40,3,1),(127,40,2,1),(128,40,3,1),(129,41,1,1),(130,41,3,1),(131,42,2,1),(132,42,1,1),(133,42,3,1),(134,42,2,1),(135,43,2,1),(136,44,1,1),(137,44,2,1),(138,44,1,1),(139,44,3,1),(140,45,2,1),(141,46,3,1),(142,46,2,1),(143,46,2,1),(144,47,2,1),(145,47,3,1),(146,47,1,1),(147,47,1,1),(148,48,2,1),(149,48,1,1),(150,48,2,1),(151,49,3,1),(152,49,1,1),(153,50,2,1),(154,50,3,1),(155,50,1,1);
/*!40000 ALTER TABLE `commande_composition` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_update_commande_composition` AFTER UPDATE ON `commande_composition`
FOR EACH ROW 
BEGIN
    CASE 
        WHEN new.status_id = 2 
            THEN call retire_ligne_commande_stock(new.id); 
        ELSE BEGIN END; 
    END CASE;
    CALL update_etat_commande(new.commande_id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ingredient`
--

DROP TABLE IF EXISTS `ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingredient` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `unite` varchar(8) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredient`
--

LOCK TABLES `ingredient` WRITE;
/*!40000 ALTER TABLE `ingredient` DISABLE KEYS */;
INSERT INTO `ingredient` VALUES (1,'Pate','boule'),(2,'Coulis de tomate','cl'),(3,'Mozzarella','g'),(4,'Champignon de Paris','g'),(5,'Oignon','g'),(6,'Jambon','g'),(7,'Lardon','g'),(8,'Cheddar','g'),(9,'Fromage de chèvre','g'),(10,'Reblochon','g'),(11,'Créme fraiche','cl'),(12,'Tomate fraiche','g'),(13,'Roquette','g'),(14,'Tomate mariné','g'),(15,'Saumon fumé','g'),(16,'Oeuf','unité');
/*!40000 ALTER TABLE `ingredient` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_insert_ingredient AFTER INSERT ON ingredient FOR EACH ROW 
INSERT INTO stock (ingredient_id, boutique_id, quantite) 
    SELECT new.id as ingredient_id, 
    boutique.id as boutique_id,
    0 as quantity
FROM boutique */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_delete_ingredient AFTER DELETE ON ingredient FOR EACH ROW 
DELETE FROM stock WHERE ingredient_id = old.id */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `paiement_type`
--

DROP TABLE IF EXISTS `paiement_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paiement_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paiement_type`
--

LOCK TABLES `paiement_type` WRITE;
/*!40000 ALTER TABLE `paiement_type` DISABLE KEYS */;
INSERT INTO `paiement_type` VALUES (1,'liquide'),(2,'carte bancaire'),(3,'chèque'),(4,'en ligne');
/*!40000 ALTER TABLE `paiement_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recette`
--

DROP TABLE IF EXISTS `recette`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recette` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `designation_commerciale` text,
  `designation_technique` text,
  `prix` float(4,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recette`
--

LOCK TABLES `recette` WRITE;
/*!40000 ALTER TABLE `recette` DISABLE KEYS */;
INSERT INTO `recette` VALUES (1,'Royale','Coulis de tomate, mozzarella, champignons de Paris frais, oignons, jambon supérieur, lardons fumés','étaler la pâte\r\nmettre les ingrédients\r\nmettre au four\r\nsortir du four',15.90),(2,'4 Fromages','Coulis de tomate, mozzarella, cheddar, fromage de chèvre, reblochon, crème fraîche','étaler la pâte\r\nmettre les ingrédients\r\nmettre au four\r\nsortir du four\r\naérer car ça sent fort le fromage',16.90),(3,'Primavera','Tomate fraîche, mozzarella di latte di Bufala Galbani, roquette, tomates marinées, belles tranches de jambon cru','étaler la pâte\r\nmettre les ingrédients sauf la salade\r\nmettre au four\r\nsortir du four\r\nrajouter la salade',18.90);
/*!40000 ALTER TABLE `recette` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recette_composition`
--

DROP TABLE IF EXISTS `recette_composition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recette_composition` (
  `recette_id` int(10) unsigned NOT NULL,
  `ingredient_id` int(10) unsigned NOT NULL,
  `quantite` int(4) NOT NULL,
  PRIMARY KEY (`recette_id`,`ingredient_id`),
  KEY `fk_recette_composition_ingredient_id` (`ingredient_id`),
  CONSTRAINT `fk_recette_composition_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_recette_composition_recette_id` FOREIGN KEY (`recette_id`) REFERENCES `recette` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recette_composition`
--

LOCK TABLES `recette_composition` WRITE;
/*!40000 ALTER TABLE `recette_composition` DISABLE KEYS */;
INSERT INTO `recette_composition` VALUES (1,1,1),(1,2,50),(1,3,30),(1,4,25),(1,5,12),(1,6,40),(1,7,20),(2,1,1),(2,3,25),(2,8,25),(2,9,25),(2,10,25),(2,11,15),(3,1,1),(3,3,20),(3,12,20),(3,13,10),(3,14,5),(3,16,1);
/*!40000 ALTER TABLE `recette_composition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'directeur'),(2,'pizzaiolo'),(3,'gestionnaire de stock'),(4,'gestionnaire de commande'),(5,'client');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status_commande`
--

DROP TABLE IF EXISTS `status_commande`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status_commande` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status_commande`
--

LOCK TABLES `status_commande` WRITE;
/*!40000 ALTER TABLE `status_commande` DISABLE KEYS */;
INSERT INTO `status_commande` VALUES (1,'validé'),(2,'en préparation'),(3,'prêt'),(4,'en livraison'),(5,'livré'),(6,'terminé');
/*!40000 ALTER TABLE `status_commande` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status_composition`
--

DROP TABLE IF EXISTS `status_composition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status_composition` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `designation` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status_composition`
--

LOCK TABLES `status_composition` WRITE;
/*!40000 ALTER TABLE `status_composition` DISABLE KEYS */;
INSERT INTO `status_composition` VALUES (1,'en attente'),(2,'en préparation'),(3,'prêt');
/*!40000 ALTER TABLE `status_composition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock` (
  `ingredient_id` int(10) unsigned NOT NULL,
  `boutique_id` int(10) unsigned NOT NULL,
  `quantite` int(12) NOT NULL,
  PRIMARY KEY (`ingredient_id`,`boutique_id`),
  KEY `fk_stock_boutique_id` (`boutique_id`),
  CONSTRAINT `fk_stock_boutique_id` FOREIGN KEY (`boutique_id`) REFERENCES `boutique` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_stock_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (1,1,30),(1,2,30),(1,3,30),(1,4,30),(2,1,500),(2,2,500),(2,3,500),(2,4,500),(3,1,750),(3,2,750),(3,3,750),(3,4,750),(4,1,250),(4,2,250),(4,3,250),(4,4,250),(5,1,120),(5,2,120),(5,3,120),(5,4,120),(6,1,400),(6,2,400),(6,3,400),(6,4,400),(7,1,200),(7,2,200),(7,3,200),(7,4,200),(8,1,250),(8,2,250),(8,3,250),(8,4,250),(9,1,250),(9,2,250),(9,3,250),(9,4,250),(10,1,250),(10,2,250),(10,3,250),(10,4,250),(11,1,150),(11,2,150),(11,3,150),(11,4,150),(12,1,200),(12,2,200),(12,3,200),(12,4,200),(13,1,100),(13,2,100),(13,3,100),(13,4,100),(14,1,50),(14,2,50),(14,3,50),(14,4,50),(15,1,0),(15,2,0),(15,3,0),(15,4,0),(16,1,10),(16,2,10),(16,3,10),(16,4,10);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `boutique_id` int(10) unsigned DEFAULT NULL,
  `role_id` int(10) unsigned NOT NULL,
  `login` varchar(255) NOT NULL,
  `telephone` varchar(12) NOT NULL,
  `password` char(64) NOT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `prenom` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_boutique_id` (`boutique_id`),
  KEY `fk_user_role_id` (`role_id`),
  CONSTRAINT `fk_user_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `fk_user_boutique_id` FOREIGN KEY (`boutique_id`) REFERENCES `boutique` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,2,5,'urbano.goor','7045534387','541755f242c73f2183fc3e54755ac732bf39a13c2612fef0ca7e14509bc29bfb','Goor','Urbano','ugoor0@salon.com'),(2,2,5,'cynthia.debow','6147417513','04859a34ad2dc71241971281140bad01053ed25d68ed8bb76c6c0cd5920926b8','Debow','Cynthia','cdebow1@angelfire.com'),(3,1,5,'letti.bezants','4162111400','3104184f14a51c7d421028172bf5baacff9acda66a82d02217b9358765f68785','Bezants','Letti','lbezants2@google.fr'),(4,2,5,'christos.quinton','5373859302','43f0ce5786f986d2e834c82053f0f994d1335568d1ad5e71e33ecefb327afea9','Quinton','Christos','cquinton3@livejournal.com'),(5,3,5,'mag.micka','1099657162','de93585949c4cb46ba8651621e587194ed1831c768e0ce93c4a87b8416100e03','Micka','Mag','mmicka4@bizjournals.com'),(6,1,5,'danice.dominico','9721452240','bb396be6de8e5709aedbc3ec8b6baa1c9003917ad0a03c66149efc498a3774b9','Dominico','Danice','ddominico5@army.mil'),(7,2,5,'jeffie.kibel','1935305298','b56e9ccf9a113ba77f27bb37573588a463415db5b508ec16a7146214982e788e','Kibel','Jeffie','jkibel6@alexa.com'),(8,2,5,'flory.huxham','4954402313','3cfe4de5ffe174f37bd94822986abb19966982195c529399b280fcf4f30705bd','Huxham','Flory','fhuxham7@imageshack.us'),(9,3,5,'lida.zum felde','9507924763','e96142c994071f37a88a8b54106a162868fcaee51f97f5473aee40a8f26534ff','Zum Felde','Lida','lzumfelde8@hatena.ne.jp'),(10,3,5,'erskine.coggings','2276112505','1c4fcdc2e86b1f18a65dabd9f50bbce0a9c6ae770176ef2659537802376a7a7f','Coggings','Erskine','ecoggings9@weather.com'),(11,2,5,'constanta.gwilliam','4868256253','a0f106293f8c12c02d9f31eb9b444da44d49f9e4fc5fa06fcea4b336f8454dfb','Gwilliam','Constanta','cgwilliama@wikia.com'),(12,1,5,'efrem.bohike','4027103963','86d054ff0f83a048a0297a7239b32781f742d2013f7bacb9a51bfcce71417bfe','Bohike','Efrem','ebohikeb@adobe.com'),(13,3,5,'whitney.tieman','4946421992','c669f037860b98bbe711469b0b7cd9dd760c6b4e8fe15d3ee9e613ea147ca7e4','Tieman','Whitney','wtiemanc@bbc.co.uk'),(14,3,5,'hillary.fossitt','3906389040','e2e6edd29d4d313cf43838da89eb666fb15aee589305542f0c5a728990be559d','Fossitt','Hillary','hfossittd@java.com'),(15,1,5,'tibold.mitchall','9147894473','d76d96a19daab75b1c0a97d0781d33b54228a0cbb44f4ad3c4526074ad8f4ce9','Mitchall','Tibold','tmitchalle@flickr.com'),(16,3,5,'elisha.bragginton','9117132141','dc3ba3d886e07870c6abca1e91b3d76bb88163784dd424047e614ef19ef69dfe','Bragginton','Elisha','ebraggintonf@salon.com'),(17,2,5,'oliver.mowbury','4197555133','720cb3f06fa788830bb341d96de6e1684e000f8f1f8ac9624ee6d0cf20d5b912','Mowbury','Oliver','omowburyg@mysql.com'),(18,2,5,'alfy.ellens','8824713678','1ed60a3448a92e1afaea6c160f868260c957b0fa9dce2fd6e9fa68fde413f4b4','Ellens','Alfy','aellensh@youku.com'),(19,3,5,'blaire.joerning','2979603082','746ab7502984f28f809b1f87165f96bf32374ce4bea65bc73faf9823123b982a','Joerning','Blaire','bjoerningi@hexun.com'),(20,1,5,'jessie.pridmore','1607810116','fad16099268bc72a00dea7935b629c82b1270ad14177d99a56296bc82e898ac7','Pridmore','Jessie','jpridmorej@sphinn.com'),(21,1,5,'sumner.rubinov','9903042975','c6f3c2196f7fa676ad8599965c3c6165634599937008544eb1403fee815f51d4','Rubinov','Sumner','srubinovk@craigslist.org'),(22,3,5,'lindie.juett','4874741678','28271374c9487f0bc2d067880c5ec3d29f54e322d33cf4e0b73d32f59690521e','Juett','Lindie','ljuettl@godaddy.com'),(23,3,5,'odo.polland','8862097908','b32f6e0fa332790a1a3e8acb042370c52e74ffaabcde5ba276288dd148048d00','Polland','Odo','opollandm@state.tx.us'),(24,2,5,'jerrie.sellack','3359383411','637b3b47e4924622773c65d7cff26238092c0bd269791e8b37fc216077521c4c','Sellack','Jerrie','jsellackn@myspace.com'),(25,2,5,'homer.dreng','8526700171','8b60bd644d6efd22f5c1dcc2f9b0025b322e0bc03239fe937bfe8d1b56d4f90d','Dreng','Homer','hdrengo@tmall.com'),(26,2,5,'vic.mathet','3292703880','3bfba71c9877c0995ccec380f0f48718497533cdb979eda8f8cdc182474b8a85','Mathet','Vic','vmathetp@gmpg.org'),(27,3,5,'alejoa.aggus','3372010512','6fee0694230979ec81cf14ebe86834c61a30df4ee35222dfdffaeaaa90d9fcee','Aggus','Alejoa','aaggusq@github.com'),(28,3,5,'amara.strathern','1855034211','12e8376b00df5635d32cee552ee4d362b131ffde21d68f5483fd03aec6f8f410','Strathern','Amara','astrathernr@google.ru'),(29,1,5,'bevvy.faudrie','9132846362','4562f176570de89694bac5b298bdcddf28c322a00ec5bdf73f9dd0fbfe435577','Faudrie','Bevvy','bfaudries@nbcnews.com'),(30,3,5,'amitie.stoke','8775145347','e2a39e9e0b4c8091ef424e89953cc37c30a40a74130d88513183a0d23050fcfd','Stoke','Amitie','astoket@paypal.com');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `v_0_chiffre_d_affaire_journée`
--

DROP TABLE IF EXISTS `v_0_chiffre_d_affaire_journée`;
/*!50001 DROP VIEW IF EXISTS `v_0_chiffre_d_affaire_journée`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_0_chiffre_d_affaire_journée` (
  `boutique` tinyint NOT NULL,
  `total` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_0_recettes_possible`
--

DROP TABLE IF EXISTS `v_0_recettes_possible`;
/*!50001 DROP VIEW IF EXISTS `v_0_recettes_possible`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_0_recettes_possible` (
  `boutique` tinyint NOT NULL,
  `nom` tinyint NOT NULL,
  `qte_possible` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_1_commandes_boutique_nord`
--

DROP TABLE IF EXISTS `v_1_commandes_boutique_nord`;
/*!50001 DROP VIEW IF EXISTS `v_1_commandes_boutique_nord`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_1_commandes_boutique_nord` (
  `numero` tinyint NOT NULL,
  `Client` tinyint NOT NULL,
  `Status_commande` tinyint NOT NULL,
  `Mode de paiement` tinyint NOT NULL,
  `Paiement` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_1_stock_boutique_nord`
--

DROP TABLE IF EXISTS `v_1_stock_boutique_nord`;
/*!50001 DROP VIEW IF EXISTS `v_1_stock_boutique_nord`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_1_stock_boutique_nord` (
  `Ingrédient` tinyint NOT NULL,
  `Quantité` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_2_commandes_boutique_sud`
--

DROP TABLE IF EXISTS `v_2_commandes_boutique_sud`;
/*!50001 DROP VIEW IF EXISTS `v_2_commandes_boutique_sud`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_2_commandes_boutique_sud` (
  `numero` tinyint NOT NULL,
  `Client` tinyint NOT NULL,
  `Status_commande` tinyint NOT NULL,
  `Mode de paiement` tinyint NOT NULL,
  `Paiement` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_2_stock_boutique_sud`
--

DROP TABLE IF EXISTS `v_2_stock_boutique_sud`;
/*!50001 DROP VIEW IF EXISTS `v_2_stock_boutique_sud`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_2_stock_boutique_sud` (
  `Ingrédient` tinyint NOT NULL,
  `Quantité` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_3_commandes_boutique_est`
--

DROP TABLE IF EXISTS `v_3_commandes_boutique_est`;
/*!50001 DROP VIEW IF EXISTS `v_3_commandes_boutique_est`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_3_commandes_boutique_est` (
  `numero` tinyint NOT NULL,
  `Client` tinyint NOT NULL,
  `Status_commande` tinyint NOT NULL,
  `Mode de paiement` tinyint NOT NULL,
  `Paiement` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_3_stock_boutique_est`
--

DROP TABLE IF EXISTS `v_3_stock_boutique_est`;
/*!50001 DROP VIEW IF EXISTS `v_3_stock_boutique_est`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_3_stock_boutique_est` (
  `Ingrédient` tinyint NOT NULL,
  `Quantité` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_4_commandes_boutique_ouest`
--

DROP TABLE IF EXISTS `v_4_commandes_boutique_ouest`;
/*!50001 DROP VIEW IF EXISTS `v_4_commandes_boutique_ouest`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_4_commandes_boutique_ouest` (
  `numero` tinyint NOT NULL,
  `Client` tinyint NOT NULL,
  `Status_commande` tinyint NOT NULL,
  `Mode de paiement` tinyint NOT NULL,
  `Paiement` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_4_stock_boutique_ouest`
--

DROP TABLE IF EXISTS `v_4_stock_boutique_ouest`;
/*!50001 DROP VIEW IF EXISTS `v_4_stock_boutique_ouest`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_4_stock_boutique_ouest` (
  `Ingrédient` tinyint NOT NULL,
  `Quantité` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'oc_dapython_pr6'
--

--
-- Dumping routines for database 'oc_dapython_pr6'
--
/*!50003 DROP PROCEDURE IF EXISTS `affiche_commande_composition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `affiche_commande_composition`(IN var_commande_id INT)
SELECT 
        recette_composition.ingredient_id, 
        recette_composition.quantite,
        commande.boutique_id
    FROM recette_composition, commande
    WHERE (recette_composition.recette_id, commande.id) = (
        SELECT commande_composition.recette_id,commande_composition.commande_id
        FROM commande_composition
        WHERE commande_composition.id = var_commande_id) ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `corps_commande` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `corps_commande`(IN `var_recette_id` INT)
BEGIN
	SELECT 
		commande_composition.id AS cc_id, 
		recette.nom, 
		status_composition.designation, 
		recette.prix
	FROM commande_composition
	JOIN recette ON recette.id = commande_composition.recette_id
	JOIN status_composition ON status_composition.id = commande_composition.status_id
	WHERE commande_composition.commande_id = var_recette_id
	ORDER BY recette.nom;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `entete_commande` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `entete_commande`(IN `var_recette_id` INT)
BEGIN
	SELECT 
		LEFT(commande.date, 10) AS Date, 
		CONCAT(user.prenom, " ", user.nom) AS Client, 
		status_commande.designation AS Status, 
		(SELECT SUM(recette.prix)
			FROM recette
			RIGHT JOIN commande_composition ON commande_composition.recette_id = recette.id
			WHERE commande_composition.commande_id = commande.id
		) AS prix, 
		CONCAT(paiement_type.designation, IF(paiement," OK", " ...")) AS Paiement
	FROM commande
	JOIN user ON user.id = commande.client_id
	JOIN status_commande ON status_commande.id = commande.status_id
	JOIN paiement_type ON paiement_type.id = commande.paiement_type_id
	WHERE commande.id = var_recette_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `recette_possible` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `recette_possible`(IN `var_boutique_id` INT)
BEGIN
	SELECT 
		recette.nom,
		MIN(FLOOR(stock.quantite / recette_composition.quantite)) AS qte_possible
	FROM stock
	JOIN boutique ON boutique.id = stock.boutique_id
	JOIN recette_composition ON recette_composition.ingredient_id = stock.ingredient_id
	JOIN ingredient ON ingredient.id = stock.ingredient_id
	JOIN recette ON recette.id = recette_composition.recette_id
	WHERE boutique.id = var_boutique_id GROUP BY recette_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `retire_ligne_commande_stock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `retire_ligne_commande_stock`(IN variable INT)
BEGIN
	DECLARE fin TINYINT DEFAULT 0; 
	
	DECLARE v_ingredient_id, v_quantite, v_boutique_id INT;
	DECLARE mon_curseur CURSOR FOR
		SELECT 
			recette_composition.ingredient_id, 
			recette_composition.quantite,
			commande.boutique_id
		FROM recette_composition, commande
		WHERE (recette_composition.recette_id, commande.id) = (
			SELECT commande_composition.recette_id,commande_composition.commande_id
			FROM commande_composition
			WHERE commande_composition.id = variable);
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;
	OPEN mon_curseur;
		loop_curseur: LOOP 
            IF fin = 1 THEN LEAVE loop_curseur;	END IF;     
			
			FETCH mon_curseur INTO v_ingredient_id, v_quantite, v_boutique_id;

			UPDATE stock 
			SET quantite = quantite - v_quantite 
			WHERE ingredient_id = v_ingredient_id 
			AND boutique_id = v_boutique_id;

			
		END LOOP;
	CLOSE mon_curseur;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_etat_commande` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_etat_commande`(IN var_commande_id INT)
UPDATE commande SET status_id = (
    SELECT
	CASE
		WHEN COUNT(DISTINCT status_id) > 1 THEN  2 
		WHEN status_id = 2 THEN  2 
		WHEN status_id = 3 THEN  3 
		ELSE  1 
	END AS status_id
	FROM commande_composition
	WHERE commande_id = var_commande_id
    ) WHERE id = var_commande_id ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `voir_recette` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `voir_recette`(IN var_recette_id INT)
BEGIN
    SELECT CONCAT(quantite, " ", unite, " de ", nom) AS "Liste des ingrédients de la recette" 
    FROM recette_composition 
    JOIN ingredient ON ingredient.id = recette_composition.ingredient_id 
    WHERE recette_id = var_recette_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_0_chiffre_d_affaire_journée`
--

/*!50001 DROP TABLE IF EXISTS `v_0_chiffre_d_affaire_journée`*/;
/*!50001 DROP VIEW IF EXISTS `v_0_chiffre_d_affaire_journée`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_0_chiffre_d_affaire_journée` AS select `boutique`.`id` AS `boutique`,sum(`recette`.`prix`) AS `total` from (((`recette` join `commande_composition` on((`commande_composition`.`recette_id` = `recette`.`id`))) join `commande` on((`commande`.`id` = `commande_composition`.`commande_id`))) join `boutique` on((`boutique`.`id` = `commande`.`boutique_id`))) where (`commande`.`paiement` and (cast(`commande`.`date` as date) = curdate())) group by `boutique`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_0_recettes_possible`
--

/*!50001 DROP TABLE IF EXISTS `v_0_recettes_possible`*/;
/*!50001 DROP VIEW IF EXISTS `v_0_recettes_possible`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_0_recettes_possible` AS select `boutique`.`id` AS `boutique`,`recette`.`nom` AS `nom`,min(floor((`stock`.`quantite` / `recette_composition`.`quantite`))) AS `qte_possible` from ((((`stock` join `boutique` on((`boutique`.`id` = `stock`.`boutique_id`))) join `recette_composition` on((`recette_composition`.`ingredient_id` = `stock`.`ingredient_id`))) join `ingredient` on((`ingredient`.`id` = `stock`.`ingredient_id`))) join `recette` on((`recette`.`id` = `recette_composition`.`recette_id`))) group by `boutique`.`id`,`recette_composition`.`recette_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_1_commandes_boutique_nord`
--

/*!50001 DROP TABLE IF EXISTS `v_1_commandes_boutique_nord`*/;
/*!50001 DROP VIEW IF EXISTS `v_1_commandes_boutique_nord`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_1_commandes_boutique_nord` AS select `commande`.`id` AS `numero`,concat(`user`.`prenom`,' ',`user`.`nom`) AS `Client`,`status_commande`.`designation` AS `Status_commande`,`paiement_type`.`designation` AS `Mode de paiement`,if(`commande`.`paiement`,'OK','...') AS `Paiement` from (((`commande` join `user` on((`user`.`id` = `commande`.`client_id`))) join `status_commande` on((`status_commande`.`id` = `commande`.`status_id`))) join `paiement_type` on((`paiement_type`.`id` = `commande`.`paiement_type_id`))) where (`commande`.`boutique_id` = 1) order by `commande`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_1_stock_boutique_nord`
--

/*!50001 DROP TABLE IF EXISTS `v_1_stock_boutique_nord`*/;
/*!50001 DROP VIEW IF EXISTS `v_1_stock_boutique_nord`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_1_stock_boutique_nord` AS select `ingredient`.`nom` AS `Ingrédient`,concat(`stock`.`quantite`,' ',`ingredient`.`unite`) AS `Quantité` from (`stock` join `ingredient` on((`stock`.`ingredient_id` = `ingredient`.`id`))) where (`stock`.`boutique_id` = 1) order by `ingredient`.`nom` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_2_commandes_boutique_sud`
--

/*!50001 DROP TABLE IF EXISTS `v_2_commandes_boutique_sud`*/;
/*!50001 DROP VIEW IF EXISTS `v_2_commandes_boutique_sud`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_2_commandes_boutique_sud` AS select `commande`.`id` AS `numero`,concat(`user`.`prenom`,' ',`user`.`nom`) AS `Client`,`status_commande`.`designation` AS `Status_commande`,`paiement_type`.`designation` AS `Mode de paiement`,if(`commande`.`paiement`,'OK','...') AS `Paiement` from (((`commande` join `user` on((`user`.`id` = `commande`.`client_id`))) join `status_commande` on((`status_commande`.`id` = `commande`.`status_id`))) join `paiement_type` on((`paiement_type`.`id` = `commande`.`paiement_type_id`))) where (`commande`.`boutique_id` = 2) order by `commande`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_2_stock_boutique_sud`
--

/*!50001 DROP TABLE IF EXISTS `v_2_stock_boutique_sud`*/;
/*!50001 DROP VIEW IF EXISTS `v_2_stock_boutique_sud`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_2_stock_boutique_sud` AS select `ingredient`.`nom` AS `Ingrédient`,concat(`stock`.`quantite`,' ',`ingredient`.`unite`) AS `Quantité` from (`stock` join `ingredient` on((`stock`.`ingredient_id` = `ingredient`.`id`))) where (`stock`.`boutique_id` = 2) order by `ingredient`.`nom` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_3_commandes_boutique_est`
--

/*!50001 DROP TABLE IF EXISTS `v_3_commandes_boutique_est`*/;
/*!50001 DROP VIEW IF EXISTS `v_3_commandes_boutique_est`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_3_commandes_boutique_est` AS select `commande`.`id` AS `numero`,concat(`user`.`prenom`,' ',`user`.`nom`) AS `Client`,`status_commande`.`designation` AS `Status_commande`,`paiement_type`.`designation` AS `Mode de paiement`,if(`commande`.`paiement`,'OK','...') AS `Paiement` from (((`commande` join `user` on((`user`.`id` = `commande`.`client_id`))) join `status_commande` on((`status_commande`.`id` = `commande`.`status_id`))) join `paiement_type` on((`paiement_type`.`id` = `commande`.`paiement_type_id`))) where (`commande`.`boutique_id` = 3) order by `commande`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_3_stock_boutique_est`
--

/*!50001 DROP TABLE IF EXISTS `v_3_stock_boutique_est`*/;
/*!50001 DROP VIEW IF EXISTS `v_3_stock_boutique_est`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_3_stock_boutique_est` AS select `ingredient`.`nom` AS `Ingrédient`,concat(`stock`.`quantite`,' ',`ingredient`.`unite`) AS `Quantité` from (`stock` join `ingredient` on((`stock`.`ingredient_id` = `ingredient`.`id`))) where (`stock`.`boutique_id` = 3) order by `ingredient`.`nom` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_4_commandes_boutique_ouest`
--

/*!50001 DROP TABLE IF EXISTS `v_4_commandes_boutique_ouest`*/;
/*!50001 DROP VIEW IF EXISTS `v_4_commandes_boutique_ouest`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_4_commandes_boutique_ouest` AS select `commande`.`id` AS `numero`,concat(`user`.`prenom`,' ',`user`.`nom`) AS `Client`,`status_commande`.`designation` AS `Status_commande`,`paiement_type`.`designation` AS `Mode de paiement`,if(`commande`.`paiement`,'OK','...') AS `Paiement` from (((`commande` join `user` on((`user`.`id` = `commande`.`client_id`))) join `status_commande` on((`status_commande`.`id` = `commande`.`status_id`))) join `paiement_type` on((`paiement_type`.`id` = `commande`.`paiement_type_id`))) where (`commande`.`boutique_id` = 4) order by `commande`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_4_stock_boutique_ouest`
--

/*!50001 DROP TABLE IF EXISTS `v_4_stock_boutique_ouest`*/;
/*!50001 DROP VIEW IF EXISTS `v_4_stock_boutique_ouest`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_4_stock_boutique_ouest` AS select `ingredient`.`nom` AS `Ingrédient`,concat(`stock`.`quantite`,' ',`ingredient`.`unite`) AS `Quantité` from (`stock` join `ingredient` on((`stock`.`ingredient_id` = `ingredient`.`id`))) where (`stock`.`boutique_id` = 4) order by `ingredient`.`nom` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-02-24 20:17:10
