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
  `action` text NOT NULL,
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
  `name` varchar(255) NOT NULL,
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
INSERT INTO `location_categories` VALUES (1,1),(2,1),(3,1),(4,1),(8,1),(11,1),(12,1),(14,1),(16,1),(17,1),(19,1),(20,1),(28,1),(31,1),(32,1),(33,1),(34,1),(37,1),(43,1),(53,1),(55,1),(57,1),(58,1),(63,1),(64,1),(66,1),(68,1),(70,1),(74,1),(75,1),(76,1),(79,1),(82,1),(3,2),(7,2),(8,2),(9,2),(30,2),(38,2),(39,2),(41,2),(44,2),(46,2),(47,2),(48,2),(49,2),(51,2),(59,2),(61,2),(62,2),(65,2),(69,2),(71,2),(78,2),(80,2),(24,3),(26,3),(38,3),(41,3),(44,3),(46,3),(59,3),(60,3),(78,3),(80,3),(6,4),(13,4),(15,4),(20,4),(21,4),(22,4),(23,4),(26,4),(27,4),(29,4),(35,4),(36,4),(38,4),(39,4),(40,4),(44,4),(46,4),(49,4),(50,4),(51,4),(54,4),(56,4),(60,4),(61,4),(62,4),(69,4),(71,4),(73,4),(74,4),(77,4),(1,5),(2,5),(3,5),(4,5),(5,5),(21,5),(22,5),(25,5),(27,5),(29,5),(32,5),(33,5),(35,5),(36,5),(38,5),(43,5),(51,5),(52,5),(54,5),(56,5),(64,5),(67,5),(72,5),(75,5),(77,5),(79,5),(2,6),(5,6),(11,6),(12,6),(14,6),(17,6),(18,6),(19,6),(20,6),(31,6),(32,6),(33,6),(34,6),(37,6),(42,6),(43,6),(52,6),(53,6),(55,6),(57,6),(58,6),(64,6),(66,6),(67,6),(70,6),(72,6),(76,6),(79,6),(81,6),(82,6),(83,6);
/*!40000 ALTER TABLE `location_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_images`
--

DROP TABLE IF EXISTS `location_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `location_id` int DEFAULT NULL,
  `image_url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `location_id` (`location_id`),
  CONSTRAINT `location_images_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_images`
--

LOCK TABLES `location_images` WRITE;
/*!40000 ALTER TABLE `location_images` DISABLE KEYS */;
INSERT INTO `location_images` VALUES (1,3,'https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/07/anh-ho-guom-2.jpg.webp'),(2,3,'https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/07/anh-ho-guom-3.jpg.webp'),(3,2,'https://statics.vinpearl.com/chua-mot-cot-0_1685367087.jpg'),(4,2,'https://statics.vinpearl.com/chua-mot-cot-4_1685367335.jpg'),(5,1,'https://tophanoiaz.com/wp-content/uploads/2024/02/hinh-anh-lang-bac_18.jpg'),(6,1,'https://tophanoiaz.com/wp-content/uploads/2024/02/hinh-anh-lang-bac_17.jpg'),(7,5,'https://tophanoiaz.com/wp-content/uploads/2024/02/hinh-anh-lang-bac_18.jpg'),(8,5,'https://tophanoiaz.com/wp-content/uploads/2024/02/hinh-anh-lang-bac_17.jpg');
/*!40000 ALTER TABLE `location_images` ENABLE KEYS */;
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
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `province_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `province_id` (`province_id`),
  CONSTRAINT `locations_ibfk_1` FOREIGN KEY (`province_id`) REFERENCES `provinces` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'lăng chủ tịch',NULL,21.03677621,105.83470256,1,'2025-03-01 17:54:07'),(2,'chùa một cột',NULL,21.03571800,105.83362300,1,'2025-03-01 17:54:07'),(3,'hồ gươm',NULL,21.02915180,105.85230560,1,'2025-03-01 17:54:07'),(4,'tháp rùa',NULL,21.02785332,105.85225781,1,'2025-03-01 17:54:07'),(5,'đền ngọc sơn',NULL,21.03072283,105.85239019,1,'2025-03-01 17:54:07'),(6,'vườn quốc gia ba vì',NULL,21.07669410,105.37032900,1,'2025-03-01 17:54:07'),(7,'công viên nước hồ tây',NULL,21.07317277,105.81762088,1,'2025-03-01 17:54:07'),(8,'bảo tàng phòng không không quân',NULL,20.99984654,105.82930620,1,'2025-03-01 17:54:07'),(9,'vinhome ocean park',NULL,20.99559748,105.93998982,1,'2025-03-01 17:54:07'),(11,'chùa phật tích',NULL,21.09274149,106.02568425,5,'2025-03-01 17:54:07'),(12,'chùa bút tháp',NULL,21.06009629,106.02254004,5,'2025-03-01 17:54:07'),(13,'làng tranh đông hồ',NULL,21.06728991,106.07787432,5,'2025-03-01 17:54:07'),(14,'đền bà chúa kho',NULL,21.20487458,106.08562364,5,'2025-03-01 17:54:07'),(15,'làng gốm phù lãng',NULL,21.15528932,106.25365575,5,'2025-03-01 17:54:07'),(16,'thành cổ bắc ninh',NULL,21.18356410,106.05928181,5,'2025-03-01 17:54:07'),(17,'chùa dâu',NULL,21.03554000,106.04142800,5,'2025-03-01 17:54:07'),(18,'chùa tam chúc',NULL,20.55345967,105.79631767,2,'2025-03-01 17:54:07'),(19,'địa tạng phi lai tự',NULL,20.44503150,105.95198852,2,'2025-03-01 17:54:07'),(20,'ngũ động sơn',NULL,20.56551424,105.86185460,2,'2025-03-01 17:54:07'),(21,'danh thắng kẽm trống',NULL,20.37381440,105.91783200,2,'2025-03-01 17:54:07'),(22,'bát cảnh sơn',NULL,20.61632105,105.81706490,2,'2025-03-01 17:54:07'),(23,'cá kho làng vũ đại',NULL,20.47889880,106.14905480,2,'2025-03-01 17:54:07'),(24,'bãi biển đồ sơn',NULL,20.68663947,106.79510563,3,'2025-03-01 17:54:07'),(25,'đỉnh ngự lâm',NULL,20.79325400,106.99867400,3,'2025-03-01 17:54:07'),(26,'đảo hòn dấu',NULL,20.66706467,106.81581116,3,'2025-03-01 17:54:07'),(27,'hòn bút',NULL,20.79161400,107.10704400,3,'2025-03-01 17:54:07'),(28,'bảo tàng hải phòng',NULL,20.86175671,106.68270454,3,'2025-03-01 17:54:07'),(29,'tuyệt tình cốc',NULL,20.28093390,105.91180750,3,'2025-03-01 17:54:07'),(30,'vincom plaza imperia hải phòng',NULL,20.86302600,106.66163030,3,'2025-03-01 17:54:07'),(31,'chùa tháp tường long',NULL,20.71410628,106.77021575,3,'2025-03-01 17:54:07'),(32,'chùa côn sơn',NULL,21.15065000,106.38152600,4,'2025-03-01 17:54:07'),(33,'đền kiếp bạc',NULL,21.15104646,106.32757632,4,'2025-03-01 17:54:07'),(34,'chùa trăm gian',NULL,20.95046694,105.67974672,4,'2025-03-01 17:54:07'),(35,'hồ bạch đằng',NULL,20.94232180,106.33828510,4,'2025-03-01 17:54:07'),(36,'đảo cò chi lăng',NULL,20.71514791,106.22773928,4,'2025-03-01 17:54:07'),(37,'chùa thanh mai',NULL,21.21739319,106.46288090,4,'2025-03-01 17:54:07'),(38,'vịnh hạ long',NULL,20.92430300,107.12651100,6,'2025-03-01 17:54:07'),(39,'thác khe vằn',NULL,21.48586900,107.47849600,6,'2025-03-01 17:54:07'),(40,'hồ yên trung',NULL,21.05443470,106.73859152,6,'2025-03-01 17:54:07'),(41,'bãi biển trà cổ',NULL,21.47944491,108.02610001,6,'2025-03-01 17:54:07'),(42,'chùa ba vàng',NULL,21.06823040,106.76433406,6,'2025-03-01 17:54:07'),(43,'chùa yên tử',NULL,21.13735066,106.72361384,6,'2025-03-01 17:54:07'),(44,'bãi cháy',NULL,20.95194780,107.03868510,6,'2025-03-01 17:54:07'),(46,'biển vân đồn',NULL,21.11070000,107.49030200,6,'2025-03-01 17:54:07'),(47,'vincom hạ long',NULL,20.95029384,107.08436977,6,'2025-03-01 17:54:07'),(48,'phố đi bộ trần phú',NULL,21.53150870,107.97004400,6,'2025-03-01 17:54:07'),(49,'quảng la paradise',NULL,21.09098950,106.87613780,6,'2025-03-01 17:54:07'),(50,'vườn quốc gia cúc phương',NULL,20.28542439,105.66409283,7,'2025-03-01 17:54:07'),(51,'khu du lịch tràng an',NULL,20.25262700,105.91878437,7,'2025-03-01 17:54:07'),(52,'chùa bái đính',NULL,20.27598114,105.86577649,7,'2025-03-01 17:54:07'),(53,'đền vua đinh tiên hoàng',NULL,20.28443049,105.90581924,7,'2025-03-01 17:54:07'),(54,'tam cốc- bích động',NULL,20.21613141,105.91134844,7,'2025-03-01 17:54:07'),(55,'nhà thờ đá phát diệm',NULL,20.09267388,106.07957083,7,'2025-03-01 17:54:07'),(56,'thung nắng',NULL,20.22938960,105.90712760,7,'2025-03-01 17:54:07'),(57,'đền trần Nam định',NULL,20.45562466,106.16809390,8,'2025-03-01 17:54:07'),(58,'nhà thờ hưng nghĩa',NULL,20.20996400,106.30923400,8,'2025-03-01 17:54:07'),(59,'biển thịnh long',NULL,20.03932480,106.23127983,8,'2025-03-01 17:54:07'),(60,'ruộng muối hải lý',NULL,20.12278220,106.29378980,8,'2025-03-01 17:54:07'),(61,'hồ vị xuyên',NULL,20.43130950,106.18272250,8,'2025-03-01 17:54:07'),(62,'công viên tức mạc',NULL,20.43495815,106.16980205,8,'2025-03-01 17:54:07'),(63,'bảo tàng dệt may việt nam',NULL,20.42491840,106.17008660,8,'2025-03-01 17:54:07'),(64,'chùa tháp phổ minh',NULL,20.45458530,106.16313210,8,'2025-03-01 17:54:07'),(65,'Grand World',NULL,20.95294700,105.97536500,9,'2025-03-01 17:54:07'),(66,'đền chử đồng tử',NULL,20.88074019,105.92920398,9,'2025-03-01 17:54:07'),(67,'chùa phúc lâm',NULL,20.87780000,106.12757400,9,'2025-03-01 17:54:07'),(68,'phố hiến',NULL,20.63898663,106.06015983,9,'2025-03-01 17:54:07'),(69,'hồ bán nguyệt hưng yên',NULL,20.64537516,106.05335257,9,'2025-03-01 17:54:07'),(70,'chùa hương lãng',NULL,20.96490990,106.05294371,9,'2025-03-01 17:54:07'),(71,'tam đảo',NULL,21.45565400,105.64350800,10,'2025-03-01 17:54:07'),(72,'thiền viện trúc lâm tây thiên',NULL,21.46640291,105.58570993,10,'2025-03-01 17:54:07'),(73,'hồ đại lải',NULL,21.32227707,105.70306849,10,'2025-03-01 17:54:07'),(74,'làng gốm hương canh',NULL,21.27420600,105.64726600,10,'2025-03-01 17:54:07'),(75,'tháp bình sơn',NULL,21.41963295,105.40663559,10,'2025-03-01 17:54:07'),(76,'chùa hà tiên',NULL,21.32646780,105.59919801,10,'2025-03-01 17:54:07'),(77,'vườn cò hải lựu',NULL,21.48382900,105.34825900,10,'2025-03-01 17:54:07'),(78,'bãi biển cồn đen',NULL,20.48741250,106.60384960,11,'2025-03-01 17:54:07'),(79,'chùa keo',NULL,20.36070471,106.29726404,11,'2025-03-01 17:54:07'),(80,'bãi biển đồng châu','một bãi biển đẹp với nhiều điểm checkin ấn tượng',20.38961620,106.58425594,11,'2025-03-01 17:54:07'),(81,'nhà thờ giáo xứ bác trạch',NULL,20.36515330,106.47705210,11,'2025-03-01 17:54:07'),(82,'đền tiên la',NULL,20.62479867,106.22227048,11,'2025-03-01 17:54:07'),(83,'nhà thờ chính tòa giáo phận thái bình',NULL,20.45227261,106.34438858,11,'2025-03-01 17:54:07');
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
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `location_id` (`location_id`),
  KEY `nearby_location_id` (`nearby_location_id`),
  CONSTRAINT `nearby_locations_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `nearby_locations_ibfk_2` FOREIGN KEY (`nearby_location_id`) REFERENCES `locations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chk_no_self_reference` CHECK ((`location_id` <> `nearby_location_id`))
) ENGINE=InnoDB AUTO_INCREMENT=205 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nearby_locations`
--

LOCK TABLES `nearby_locations` WRITE;
/*!40000 ALTER TABLE `nearby_locations` DISABLE KEYS */;
INSERT INTO `nearby_locations` VALUES (1,1,2,0.44,'2025-03-20 10:23:19'),(2,1,3,3.40,'2025-03-20 10:23:19'),(3,1,4,2.94,'2025-03-20 10:23:19'),(4,1,5,3.83,'2025-03-20 10:23:19'),(5,1,7,6.14,'2025-03-20 10:23:19'),(6,1,8,4.89,'2025-03-20 10:23:19'),(7,1,9,14.59,'2025-03-20 10:23:19'),(10,2,3,3.68,'2025-03-20 10:23:19'),(11,2,4,3.21,'2025-03-20 10:23:19'),(12,2,5,4.10,'2025-03-20 10:23:19'),(13,2,7,6.61,'2025-03-20 10:23:19'),(14,2,8,5.06,'2025-03-20 10:23:19'),(15,2,9,14.87,'2025-03-20 10:23:19'),(19,3,4,0.16,'2025-03-20 10:23:19'),(20,3,5,1.29,'2025-03-20 10:23:19'),(21,3,7,7.94,'2025-03-20 10:23:19'),(22,3,8,5.79,'2025-03-20 10:23:19'),(23,3,9,14.61,'2025-03-20 10:23:19'),(28,4,5,1.13,'2025-03-20 10:23:19'),(29,4,7,7.77,'2025-03-20 10:23:19'),(30,4,8,5.63,'2025-03-20 10:23:19'),(31,4,9,14.44,'2025-03-20 10:23:19'),(37,5,7,7.05,'2025-03-20 10:23:19'),(38,5,8,6.29,'2025-03-20 10:23:19'),(39,5,9,12.59,'2025-03-20 10:23:19'),(46,7,8,11.40,'2025-03-20 10:23:19'),(47,7,9,17.41,'2025-03-20 10:23:19'),(55,8,9,15.09,'2025-03-20 10:23:19'),(73,11,12,7.39,'2025-03-20 10:23:19'),(74,11,13,8.47,'2025-03-20 10:23:19'),(75,11,14,18.42,'2025-03-20 10:23:19'),(76,11,16,14.65,'2025-03-20 10:23:19'),(77,11,17,10.12,'2025-03-20 10:23:19'),(79,12,13,6.98,'2025-03-20 10:23:19'),(80,12,17,4.34,'2025-03-20 10:23:19'),(83,13,14,19.75,'2025-03-20 10:23:19'),(84,13,16,15.98,'2025-03-20 10:23:19'),(85,13,17,9.79,'2025-03-20 10:23:19'),(88,14,16,4.69,'2025-03-20 10:23:19'),(95,18,20,10.23,'2025-03-20 10:23:19'),(96,18,22,12.49,'2025-03-20 10:23:19'),(97,19,21,15.14,'2025-03-20 10:23:19'),(99,20,22,11.18,'2025-03-20 10:23:19'),(103,24,26,2.60,'2025-03-20 10:23:19'),(104,24,31,6.21,'2025-03-20 10:23:19'),(105,25,27,13.39,'2025-03-20 10:23:19'),(107,26,31,8.81,'2025-03-20 10:23:19'),(109,28,30,2.41,'2025-03-20 10:23:19'),(113,32,33,8.61,'2025-03-20 10:23:19'),(115,38,44,12.78,'2025-03-20 10:23:19'),(116,38,47,5.34,'2025-03-20 10:23:19'),(117,40,42,8.42,'2025-03-20 10:23:19'),(118,40,43,13.30,'2025-03-20 10:23:19'),(119,41,48,10.25,'2025-03-20 10:23:19'),(123,44,47,8.13,'2025-03-20 10:23:19'),(127,51,52,12.12,'2025-03-20 10:23:19'),(128,51,53,4.73,'2025-03-20 10:23:19'),(129,51,54,13.71,'2025-03-20 10:23:19'),(130,51,56,12.97,'2025-03-20 10:23:19'),(132,52,53,9.64,'2025-03-20 10:23:19'),(135,53,54,19.30,'2025-03-20 10:23:19'),(136,53,56,18.57,'2025-03-20 10:23:19'),(139,54,56,2.62,'2025-03-20 10:23:19'),(143,57,61,4.13,'2025-03-20 10:23:19'),(144,57,62,3.75,'2025-03-20 10:23:19'),(145,57,63,4.51,'2025-03-20 10:23:19'),(146,57,64,0.70,'2025-03-20 10:23:19'),(147,58,60,13.30,'2025-03-20 10:23:19'),(148,59,60,13.69,'2025-03-20 10:23:19'),(152,61,62,1.99,'2025-03-20 10:23:19'),(153,61,63,1.71,'2025-03-20 10:23:19'),(154,61,64,4.08,'2025-03-20 10:23:19'),(157,62,63,1.42,'2025-03-20 10:23:19'),(158,62,64,3.94,'2025-03-20 10:23:19'),(162,63,64,4.38,'2025-03-20 10:23:19'),(167,65,66,14.43,'2025-03-20 10:23:19'),(168,65,70,13.15,'2025-03-20 10:23:19'),(170,68,69,1.18,'2025-03-20 10:23:19'),(173,72,76,19.50,'2025-03-20 10:23:19'),(174,73,74,10.23,'2025-03-20 10:23:19'),(175,73,76,14.08,'2025-03-20 10:23:19'),(177,74,76,9.59,'2025-03-20 10:23:19'),(178,75,77,13.70,'2025-03-20 10:23:19'),(183,79,83,14.84,'2025-03-20 10:23:19'),(184,80,81,14.90,'2025-03-20 10:23:19');
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
  `name` varchar(255) NOT NULL,
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
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` varchar(255) NOT NULL,
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

-- Dump completed on 2025-04-01 20:30:22
