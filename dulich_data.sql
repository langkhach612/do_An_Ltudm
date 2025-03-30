-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: dulich_data
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin_logs`
--

DROP TABLE IF EXISTS `admin_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `admin_id` int DEFAULT NULL,
  `action` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`),
  CONSTRAINT `admin_logs_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_logs`
--

LOCK TABLES `admin_logs` WRITE;
/*!40000 ALTER TABLE `admin_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (3,'bãi biển'),(5,'danh lam thắng cảnh'),(1,'di tích lịch sử'),(4,'du lịch sinh thái'),(6,'du lịch tâm linh'),(2,'khu vui chơi giải trí');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_categories`
--

DROP TABLE IF EXISTS `location_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location_categories` (
  `location_id` int NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`location_id`,`category_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `location_categories_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `location_categories_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_categories`
--

LOCK TABLES `location_categories` WRITE;
/*!40000 ALTER TABLE `location_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `image` varchar(500) DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `province_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `province_id` (`province_id`),
  CONSTRAINT `locations_ibfk_1` FOREIGN KEY (`province_id`) REFERENCES `provinces` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'lăng chủ tịch',NULL,NULL,21.03677621,105.83470256,1,'2025-03-01 17:54:07'),(2,'chùa một cột',NULL,NULL,21.03571800,105.83362300,1,'2025-03-01 17:54:07'),(3,'hồ gươm',NULL,NULL,21.02915180,105.85230560,1,'2025-03-01 17:54:07'),(4,'tháp rùa',NULL,NULL,21.02785332,105.85225781,1,'2025-03-01 17:54:07'),(5,'đền ngọc sơn',NULL,NULL,21.03072283,105.85239019,1,'2025-03-01 17:54:07'),(6,'vườn quốc gia ba vì',NULL,NULL,21.07669410,105.37032900,1,'2025-03-01 17:54:07'),(7,'công viên nước hồ tây',NULL,NULL,21.07317277,105.81762088,1,'2025-03-01 17:54:07'),(8,'bảo tàng phòng không không quân',NULL,NULL,20.99984654,105.82930620,1,'2025-03-01 17:54:07'),(9,'vinhome ocean park',NULL,NULL,20.99559748,105.93998982,1,'2025-03-01 17:54:07'),(10,'cầu long biên',NULL,NULL,21.04307432,105.85777347,1,'2025-03-01 17:54:07'),(11,'chùa phật tích',NULL,NULL,21.09274149,106.02568425,5,'2025-03-01 17:54:07'),(12,'chùa bút tháp',NULL,NULL,21.06009629,106.02254004,5,'2025-03-01 17:54:07'),(13,'làng tranh đông hồ',NULL,NULL,21.06728991,106.07787432,5,'2025-03-01 17:54:07'),(14,'đền bà chúa kho',NULL,NULL,21.20487458,106.08562364,5,'2025-03-01 17:54:07'),(15,'làng gốm phù lãng',NULL,NULL,21.15528932,106.25365575,5,'2025-03-01 17:54:07'),(16,'thành cổ bắc ninh',NULL,NULL,21.18356410,106.05928181,5,'2025-03-01 17:54:07'),(17,'chùa dâu',NULL,NULL,21.03554000,106.04142800,5,'2025-03-01 17:54:07'),(18,'chùa tam chúc',NULL,NULL,20.55345967,105.79631767,2,'2025-03-01 17:54:07'),(19,'địa tạng phi lai tự',NULL,NULL,20.44503150,105.95198852,2,'2025-03-01 17:54:07'),(20,'ngũ động sơn',NULL,NULL,20.56551424,105.86185460,2,'2025-03-01 17:54:07'),(21,'danh thắng kẽm trống',NULL,NULL,20.37381440,105.91783200,2,'2025-03-01 17:54:07'),(22,'bát cảnh sơn',NULL,NULL,20.61632105,105.81706490,2,'2025-03-01 17:54:07'),(23,'cá kho làng vũ đại',NULL,NULL,20.47889880,106.14905480,2,'2025-03-01 17:54:07'),(24,'bãi biển đồ sơn',NULL,NULL,20.68663947,106.79510563,3,'2025-03-01 17:54:07'),(25,'đỉnh ngự lâm',NULL,NULL,20.79325400,106.99867400,3,'2025-03-01 17:54:07'),(26,'đảo hòn dấu',NULL,NULL,20.66706467,106.81581116,3,'2025-03-01 17:54:07'),(27,'hòn bút',NULL,NULL,20.79161400,107.10704400,3,'2025-03-01 17:54:07'),(28,'bảo tàng hải phòng',NULL,NULL,20.86175671,106.68270454,3,'2025-03-01 17:54:07'),(29,'tuyệt tình cốc',NULL,NULL,20.28093390,105.91180750,3,'2025-03-01 17:54:07'),(30,'vincom plaza imperia hải phòng',NULL,NULL,20.86302600,106.66163030,3,'2025-03-01 17:54:07'),(31,'chùa tháp tường long',NULL,NULL,20.71410628,106.77021575,3,'2025-03-01 17:54:07'),(32,'chùa côn sơn',NULL,NULL,21.15065000,106.38152600,4,'2025-03-01 17:54:07'),(33,'đền kiếp bạc',NULL,NULL,21.15104646,106.32757632,4,'2025-03-01 17:54:07'),(34,'chùa trăm gian',NULL,NULL,20.95046694,105.67974672,4,'2025-03-01 17:54:07'),(35,'hồ bạch đằng',NULL,NULL,20.94232180,106.33828510,4,'2025-03-01 17:54:07'),(36,'đảo cò chi lăng',NULL,NULL,20.71514791,106.22773928,4,'2025-03-01 17:54:07'),(37,'chùa thanh mai',NULL,NULL,21.21739319,106.46288090,4,'2025-03-01 17:54:07'),(38,'vịnh hạ long',NULL,NULL,20.92430300,107.12651100,6,'2025-03-01 17:54:07'),(39,'thác khe vằn',NULL,NULL,21.48586900,107.47849600,6,'2025-03-01 17:54:07'),(40,'hồ yên trung',NULL,NULL,21.05443470,106.73859152,6,'2025-03-01 17:54:07'),(41,'bãi biển trà cổ',NULL,NULL,21.47944491,108.02610001,6,'2025-03-01 17:54:07'),(42,'chùa ba vàng',NULL,NULL,21.06823040,106.76433406,6,'2025-03-01 17:54:07'),(43,'chùa yên tử',NULL,NULL,21.13735066,106.72361384,6,'2025-03-01 17:54:07'),(44,'bãi cháy',NULL,NULL,20.95194780,107.03868510,6,'2025-03-01 17:54:07'),(45,'đảo cô tô',NULL,NULL,20.99634075,107.75895691,6,'2025-03-01 17:54:07'),(46,'biển vân đồn',NULL,NULL,21.11070000,107.49030200,6,'2025-03-01 17:54:07'),(47,'vincom hạ long',NULL,NULL,20.95029384,107.08436977,6,'2025-03-01 17:54:07'),(48,'phố đi bộ trần phú',NULL,NULL,21.53150870,107.97004400,6,'2025-03-01 17:54:07'),(49,'quảng la paradise',NULL,NULL,21.09098950,106.87613780,6,'2025-03-01 17:54:07'),(50,'vườn quốc gia cúc phương',NULL,NULL,20.28542439,105.66409283,7,'2025-03-01 17:54:07'),(51,'khu du lịch tràng an',NULL,NULL,20.25262700,105.91878437,7,'2025-03-01 17:54:07'),(52,'chùa bái đính',NULL,NULL,20.27598114,105.86577649,7,'2025-03-01 17:54:07'),(53,'đền vua đinh tiên hoàng',NULL,NULL,20.28443049,105.90581924,7,'2025-03-01 17:54:07'),(54,'tam cốc- bích động',NULL,NULL,20.21613141,105.91134844,7,'2025-03-01 17:54:07'),(55,'nhà thờ đá phát diệm',NULL,NULL,20.09267388,106.07957083,7,'2025-03-01 17:54:07'),(56,'thung nắng',NULL,NULL,20.22938960,105.90712760,7,'2025-03-01 17:54:07'),(57,'đền trần Nam định',NULL,NULL,20.45562466,106.16809390,8,'2025-03-01 17:54:07'),(58,'nhà thờ hưng nghĩa',NULL,NULL,20.20996400,106.30923400,8,'2025-03-01 17:54:07'),(59,'biển thịnh long',NULL,NULL,20.03932480,106.23127983,8,'2025-03-01 17:54:07'),(60,'ruộng muối hải lý',NULL,NULL,20.12278220,106.29378980,8,'2025-03-01 17:54:07'),(61,'hồ vị xuyên',NULL,NULL,20.43130950,106.18272250,8,'2025-03-01 17:54:07'),(62,'công viên tức mạc',NULL,NULL,20.43495815,106.16980205,8,'2025-03-01 17:54:07'),(63,'bảo tàng dệt may việt nam',NULL,NULL,20.42491840,106.17008660,8,'2025-03-01 17:54:07'),(64,'chùa tháp phổ minh',NULL,NULL,20.45458530,106.16313210,8,'2025-03-01 17:54:07'),(65,'Grand World',NULL,NULL,20.95294700,105.97536500,9,'2025-03-01 17:54:07'),(66,'đền chử đồng tử',NULL,NULL,20.88074019,105.92920398,9,'2025-03-01 17:54:07'),(67,'chùa phúc lâm',NULL,NULL,20.87780000,106.12757400,9,'2025-03-01 17:54:07'),(68,'phố hiến',NULL,NULL,20.63898663,106.06015983,9,'2025-03-01 17:54:07'),(69,'hồ bán nguyệt hưng yên',NULL,NULL,20.64537516,106.05335257,9,'2025-03-01 17:54:07'),(70,'chùa hương lãng',NULL,NULL,20.96490990,106.05294371,9,'2025-03-01 17:54:07'),(71,'tam đảo',NULL,NULL,21.45565400,105.64350800,10,'2025-03-01 17:54:07'),(72,'thiền viện trúc lâm tây thiên',NULL,NULL,21.46640291,105.58570993,10,'2025-03-01 17:54:07'),(73,'hồ đại lải',NULL,NULL,21.32227707,105.70306849,10,'2025-03-01 17:54:07'),(74,'làng gốm hương canh',NULL,NULL,21.27420600,105.64726600,10,'2025-03-01 17:54:07'),(75,'tháp bình sơn',NULL,NULL,21.41963295,105.40663559,10,'2025-03-01 17:54:07'),(76,'chùa hà tiên',NULL,NULL,21.32646780,105.59919801,10,'2025-03-01 17:54:07'),(77,'vườn cò hải lựu',NULL,NULL,21.48382900,105.34825900,10,'2025-03-01 17:54:07'),(78,'bãi biển cồn đen',NULL,NULL,20.48741250,106.60384960,11,'2025-03-01 17:54:07'),(79,'chùa keo',NULL,NULL,20.36070471,106.29726404,11,'2025-03-01 17:54:07'),(80,'bãi biển đồng châu',NULL,NULL,20.38961620,106.58425594,11,'2025-03-01 17:54:07'),(81,'nhà thờ giáo xứ bác trạch',NULL,NULL,20.36515330,106.47705210,11,'2025-03-01 17:54:07'),(82,'đền tiên la',NULL,NULL,20.62479867,106.22227048,11,'2025-03-01 17:54:07'),(83,'nhà thờ chính tòa giáo phận thái bình',NULL,NULL,20.45227261,106.34438858,11,'2025-03-01 17:54:07');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nearby_locations`
--

DROP TABLE IF EXISTS `nearby_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nearby_locations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `location_id` int DEFAULT NULL,
  `nearby_location_id` int DEFAULT NULL,
  `distance_km` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location_id` (`location_id`),
  KEY `nearby_location_id` (`nearby_location_id`),
  CONSTRAINT `nearby_locations_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `nearby_locations_ibfk_2` FOREIGN KEY (`nearby_location_id`) REFERENCES `locations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chk_no_self_reference` CHECK ((`location_id` <> `nearby_location_id`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nearby_locations`
--

LOCK TABLES `nearby_locations` WRITE;
/*!40000 ALTER TABLE `nearby_locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `nearby_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provinces`
--

DROP TABLE IF EXISTS `provinces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provinces` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provinces`
--

LOCK TABLES `provinces` WRITE;
/*!40000 ALTER TABLE `provinces` DISABLE KEYS */;
INSERT INTO `provinces` VALUES (5,'Bắc Ninh'),(2,'Hà Nam'),(1,'Hà Nội'),(4,'Hải Dương'),(3,'Hải Phòng'),(9,'Hưng Yên'),(8,'Nam Định'),(7,'Ninh Bình'),(6,'Quảng Ninh'),(11,'Thái Bình'),(10,'Vĩnh Phúc');
/*!40000 ALTER TABLE `provinces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` enum('admin','user') DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
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

-- Dump completed on 2025-03-03 18:16:35
