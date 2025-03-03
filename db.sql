-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: ed_tecx
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `account_emailaddress`
--

DROP TABLE IF EXISTS `account_emailaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_emailaddress` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_emailaddress_user_id_email_987c8728_uniq` (`user_id`,`email`),
  KEY `account_emailaddress_email_03be32b2` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailaddress`
--

LOCK TABLES `account_emailaddress` WRITE;
/*!40000 ALTER TABLE `account_emailaddress` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_emailaddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_emailconfirmation`
--

DROP TABLE IF EXISTS `account_emailconfirmation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_emailconfirmation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `sent` datetime(6) DEFAULT NULL,
  `key` varchar(64) NOT NULL,
  `email_address_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailconfirmation`
--

LOCK TABLES `account_emailconfirmation` WRITE;
/*!40000 ALTER TABLE `account_emailconfirmation` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_emailconfirmation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_portal_admindb`
--

DROP TABLE IF EXISTS `admin_portal_admindb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_portal_admindb` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(10) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `alt_phone_number` varchar(15) NOT NULL,
  `password` varchar(128) NOT NULL,
  `aadhar_number` varchar(50) DEFAULT NULL,
  `superadmin_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `admin_portal_admindb_superadmin_id_45ef5c28_fk_admin_por` (`superadmin_id`),
  CONSTRAINT `admin_portal_admindb_superadmin_id_45ef5c28_fk_admin_por` FOREIGN KEY (`superadmin_id`) REFERENCES `admin_portal_superadmindb` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_portal_admindb`
--

LOCK TABLES `admin_portal_admindb` WRITE;
/*!40000 ALTER TABLE `admin_portal_admindb` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_portal_admindb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_portal_employeedb`
--

DROP TABLE IF EXISTS `admin_portal_employeedb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_portal_employeedb` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(10) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `alt_phone_number` varchar(15) NOT NULL,
  `password` varchar(128) NOT NULL,
  `aadhar_number` varchar(50) DEFAULT NULL,
  `manager_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `admin_portal_employe_manager_id_4be6b1c2_fk_admin_por` (`manager_id`),
  CONSTRAINT `admin_portal_employe_manager_id_4be6b1c2_fk_admin_por` FOREIGN KEY (`manager_id`) REFERENCES `admin_portal_managerdb` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_portal_employeedb`
--

LOCK TABLES `admin_portal_employeedb` WRITE;
/*!40000 ALTER TABLE `admin_portal_employeedb` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_portal_employeedb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_portal_managerdb`
--

DROP TABLE IF EXISTS `admin_portal_managerdb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_portal_managerdb` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(10) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `alt_phone_number` varchar(15) NOT NULL,
  `password` varchar(128) NOT NULL,
  `aadhar_number` varchar(50) DEFAULT NULL,
  `admin_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `admin_portal_manager_admin_id_2f19ddde_fk_admin_por` (`admin_id`),
  CONSTRAINT `admin_portal_manager_admin_id_2f19ddde_fk_admin_por` FOREIGN KEY (`admin_id`) REFERENCES `admin_portal_admindb` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_portal_managerdb`
--

LOCK TABLES `admin_portal_managerdb` WRITE;
/*!40000 ALTER TABLE `admin_portal_managerdb` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_portal_managerdb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_portal_superadmindb`
--

DROP TABLE IF EXISTS `admin_portal_superadmindb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_portal_superadmindb` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(10) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `alt_phone_number` varchar(15) NOT NULL,
  `password` varchar(128) NOT NULL,
  `aadhar_number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_portal_superadmindb`
--

LOCK TABLES `admin_portal_superadmindb` WRITE;
/*!40000 ALTER TABLE `admin_portal_superadmindb` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_portal_superadmindb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can view permission',1,'view_permission'),(5,'Can add group',2,'add_group'),(6,'Can change group',2,'change_group'),(7,'Can delete group',2,'delete_group'),(8,'Can view group',2,'view_group'),(9,'Can add content type',3,'add_contenttype'),(10,'Can change content type',3,'change_contenttype'),(11,'Can delete content type',3,'delete_contenttype'),(12,'Can view content type',3,'view_contenttype'),(13,'Can add code submission',4,'add_codesubmission'),(14,'Can change code submission',4,'change_codesubmission'),(15,'Can delete code submission',4,'delete_codesubmission'),(16,'Can view code submission',4,'view_codesubmission'),(17,'Can add students db',5,'add_studentsdb'),(18,'Can change students db',5,'change_studentsdb'),(19,'Can delete students db',5,'delete_studentsdb'),(20,'Can view students db',5,'view_studentsdb'),(21,'Can add category',6,'add_category'),(22,'Can change category',6,'change_category'),(23,'Can delete category',6,'delete_category'),(24,'Can view category',6,'view_category'),(25,'Can add subject',7,'add_subject'),(26,'Can change subject',7,'change_subject'),(27,'Can delete subject',7,'delete_subject'),(28,'Can view subject',7,'view_subject'),(29,'Can add question',8,'add_question'),(30,'Can change question',8,'change_question'),(31,'Can delete question',8,'delete_question'),(32,'Can view question',8,'view_question'),(33,'Can add exam result',9,'add_examresult'),(34,'Can change exam result',9,'change_examresult'),(35,'Can delete exam result',9,'delete_examresult'),(36,'Can view exam result',9,'view_examresult'),(37,'Can add placement stories',10,'add_placementstories'),(38,'Can change placement stories',10,'change_placementstories'),(39,'Can delete placement stories',10,'delete_placementstories'),(40,'Can view placement stories',10,'view_placementstories'),(41,'Can add job',11,'add_job'),(42,'Can change job',11,'change_job'),(43,'Can delete job',11,'delete_job'),(44,'Can view job',11,'view_job'),(45,'Can add colleges db',12,'add_collegesdb'),(46,'Can change colleges db',12,'change_collegesdb'),(47,'Can delete colleges db',12,'delete_collegesdb'),(48,'Can view colleges db',12,'view_collegesdb'),(49,'Can add users db',13,'add_usersdb'),(50,'Can change users db',13,'change_usersdb'),(51,'Can delete users db',13,'delete_usersdb'),(52,'Can view users db',13,'view_usersdb'),(53,'Can add otpdb',14,'add_otpdb'),(54,'Can change otpdb',14,'change_otpdb'),(55,'Can delete otpdb',14,'delete_otpdb'),(56,'Can view otpdb',14,'view_otpdb'),(57,'Can add super admin db',15,'add_superadmindb'),(58,'Can change super admin db',15,'change_superadmindb'),(59,'Can delete super admin db',15,'delete_superadmindb'),(60,'Can view super admin db',15,'view_superadmindb'),(61,'Can add admin db',16,'add_admindb'),(62,'Can change admin db',16,'change_admindb'),(63,'Can delete admin db',16,'delete_admindb'),(64,'Can view admin db',16,'view_admindb'),(65,'Can add manager db',17,'add_managerdb'),(66,'Can change manager db',17,'change_managerdb'),(67,'Can delete manager db',17,'delete_managerdb'),(68,'Can view manager db',17,'view_managerdb'),(69,'Can add employee db',18,'add_employeedb'),(70,'Can change employee db',18,'change_employeedb'),(71,'Can delete employee db',18,'delete_employeedb'),(72,'Can view employee db',18,'view_employeedb'),(73,'Can add certificate',19,'add_certificate'),(74,'Can change certificate',19,'change_certificate'),(75,'Can delete certificate',19,'delete_certificate'),(76,'Can view certificate',19,'view_certificate'),(77,'Can add plan type',20,'add_plantype'),(78,'Can change plan type',20,'change_plantype'),(79,'Can delete plan type',20,'delete_plantype'),(80,'Can view plan type',20,'view_plantype'),(81,'Can add subscription plan',21,'add_subscriptionplan'),(82,'Can change subscription plan',21,'change_subscriptionplan'),(83,'Can delete subscription plan',21,'delete_subscriptionplan'),(84,'Can view subscription plan',21,'view_subscriptionplan'),(85,'Can add email address',22,'add_emailaddress'),(86,'Can change email address',22,'change_emailaddress'),(87,'Can delete email address',22,'delete_emailaddress'),(88,'Can view email address',22,'view_emailaddress'),(89,'Can add email confirmation',23,'add_emailconfirmation'),(90,'Can change email confirmation',23,'change_emailconfirmation'),(91,'Can delete email confirmation',23,'delete_emailconfirmation'),(92,'Can view email confirmation',23,'view_emailconfirmation'),(93,'Can add log entry',24,'add_logentry'),(94,'Can change log entry',24,'change_logentry'),(95,'Can delete log entry',24,'delete_logentry'),(96,'Can view log entry',24,'view_logentry'),(97,'Can add session',25,'add_session'),(98,'Can change session',25,'change_session'),(99,'Can delete session',25,'delete_session'),(100,'Can view session',25,'view_session'),(101,'Can add site',26,'add_site'),(102,'Can change site',26,'change_site'),(103,'Can delete site',26,'delete_site'),(104,'Can view site',26,'view_site'),(105,'Can add social account',27,'add_socialaccount'),(106,'Can change social account',27,'change_socialaccount'),(107,'Can delete social account',27,'delete_socialaccount'),(108,'Can view social account',27,'view_socialaccount'),(109,'Can add social application',28,'add_socialapp'),(110,'Can change social application',28,'change_socialapp'),(111,'Can delete social application',28,'delete_socialapp'),(112,'Can view social application',28,'view_socialapp'),(113,'Can add social application token',29,'add_socialtoken'),(114,'Can change social application token',29,'change_socialtoken'),(115,'Can delete social application token',29,'delete_socialtoken'),(116,'Can view social application token',29,'view_socialtoken'),(117,'Can add exam',30,'add_exam'),(118,'Can change exam',30,'change_exam'),(119,'Can delete exam',30,'delete_exam'),(120,'Can view exam',30,'view_exam');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificate_management_certificate`
--

DROP TABLE IF EXISTS `certificate_management_certificate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `certificate_management_certificate` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `father_name` varchar(255) NOT NULL,
  `certified_for` longtext NOT NULL,
  `unique_id` varchar(25) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `exam_result_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_id` (`unique_id`),
  KEY `certificate_manageme_exam_result_id_6b6d39fd_fk_examporto` (`exam_result_id`),
  CONSTRAINT `certificate_manageme_exam_result_id_6b6d39fd_fk_examporto` FOREIGN KEY (`exam_result_id`) REFERENCES `examportol_examresult` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificate_management_certificate`
--

LOCK TABLES `certificate_management_certificate` WRITE;
/*!40000 ALTER TABLE `certificate_management_certificate` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificate_management_certificate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compiler_codesubmission`
--

DROP TABLE IF EXISTS `compiler_codesubmission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compiler_codesubmission` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `language` varchar(20) NOT NULL,
  `code` longtext NOT NULL,
  `input_data` longtext NOT NULL,
  `output` longtext,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compiler_codesubmission`
--

LOCK TABLES `compiler_codesubmission` WRITE;
/*!40000 ALTER TABLE `compiler_codesubmission` DISABLE KEYS */;
/*!40000 ALTER TABLE `compiler_codesubmission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_oauth_usersdb_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_oauth_usersdb_id` FOREIGN KEY (`user_id`) REFERENCES `oauth_usersdb` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2025-02-28 06:40:01.645055','1','Google oAuth',1,'[{\"added\": {}}]',28,1),(2,'2025-02-28 06:40:14.271031','2','127.0.0.1:8000',1,'[{\"added\": {}}]',26,1),(3,'2025-02-28 06:40:24.634320','1','Google oAuth',2,'[{\"changed\": {\"fields\": [\"Sites\"]}}]',28,1),(4,'2025-02-28 06:42:54.889387','2','Github',1,'[{\"added\": {}}]',28,1),(5,'2025-02-28 06:43:10.582093','2','Github',2,'[{\"changed\": {\"fields\": [\"Sites\"]}}]',28,1),(6,'2025-03-03 05:50:08.330367','1','monthly',1,'[{\"added\": {}}]',20,1),(7,'2025-03-03 05:50:33.750032','2','basic',1,'[{\"added\": {}}]',20,1),(8,'2025-03-03 05:51:29.358633','1','basic - ₹0.00/m',1,'[{\"added\": {}}]',21,1),(9,'2025-03-03 05:51:52.534351','2','monthly - ₹269.10/m',1,'[{\"added\": {}}]',21,1),(10,'2025-03-03 06:05:22.403153','1','IT',1,'[{\"added\": {}}]',6,1),(11,'2025-03-03 06:05:43.344485','2','MANAGEMENT',1,'[{\"added\": {}}]',6,1),(12,'2025-03-03 06:05:58.076043','1','Aptitute',1,'[{\"added\": {}}]',7,1),(13,'2025-03-03 06:06:31.457926','2','Human resource',1,'[{\"added\": {}}]',7,1),(14,'2025-03-03 06:07:19.366649','3','SQL',1,'[{\"added\": {}}]',7,1),(15,'2025-03-03 06:40:21.447114','54','What is the purpose of Google Tag Manager?',3,'',8,1),(16,'2025-03-03 06:40:21.447159','53','Which of the following is an example of outbound marketing?',3,'',8,1),(17,'2025-03-03 06:40:21.447175','52','What does CTA stand for in digital marketing?',3,'',8,1),(18,'2025-03-03 06:40:21.447187','51','Which platform is best for video marketing?',3,'',8,1),(19,'2025-03-03 06:40:21.447198','50','What is a drip campaign?',3,'',8,1),(20,'2025-03-03 06:40:21.447208','49','What is UTM tracking used for?',3,'',8,1),(21,'2025-03-03 06:40:21.447219','48','What is the purpose of the Google My Business tool?',3,'',8,1),(22,'2025-03-03 06:40:21.447228','47','What is domain authority (DA) used for?',3,'',8,1),(23,'2025-03-03 06:40:21.447238','46','What is programmatic advertising?',3,'',8,1),(24,'2025-03-03 06:40:21.447248','45','What is the purpose of a robots.txt file?',3,'',8,1),(25,'2025-03-03 06:40:21.447258','44','What is anchor text in SEO?',3,'',8,1),(26,'2025-03-03 06:40:21.447268','43','What is the main purpose of a landing page?',3,'',8,1),(27,'2025-03-03 06:40:21.447278','42','What is the purpose of Google Search Console?',3,'',8,1),(28,'2025-03-03 06:40:21.447287','41','What is a featured snippet?',3,'',8,1),(29,'2025-03-03 06:40:21.447296','40','Which of the following is a black-hat SEO technique?',3,'',8,1),(30,'2025-03-03 06:40:21.447306','39','What does SERP stand for?',3,'',8,1),(31,'2025-03-03 06:40:21.447316','38','What is AMP (Accelerated Mobile Pages)?',3,'',8,1),(32,'2025-03-03 06:40:21.447326','37','What is the ideal keyword density for SEO?',3,'',8,1),(33,'2025-03-03 06:40:21.447335','36','Which of these affects email deliverability the most?',3,'',8,1),(34,'2025-03-03 06:40:21.447344','35','The skyscraper technique in SEO is used to:',3,'',8,1),(35,'2025-03-03 06:40:21.447354','34','Which of these is not a factor in Google’s ranking algorithm?',3,'',8,1),(36,'2025-03-03 06:40:21.447363','33','What does remarketing mean?',3,'',8,1),(37,'2025-03-03 06:40:21.447372','32','What is customer lifetime value (CLV)?',3,'',8,1),(38,'2025-03-03 06:40:21.447382','31','What does a canonical tag help with?',3,'',8,1),(39,'2025-03-03 06:40:21.447392','30','What is latent semantic indexing (LSI) in SEO?',3,'',8,1),(40,'2025-03-03 06:40:21.447402','29','What does Google Analytics help with?',3,'',8,1),(41,'2025-03-03 06:40:21.447412','28','What is the ideal length of a meta description for SEO?',3,'',8,1),(42,'2025-03-03 06:40:21.447422','27','Which email marketing metric indicates how many people clicked on a link?',3,'',8,1),(43,'2025-03-03 06:40:21.447432','26','What is the purpose of a call-to-action (CTA)?',3,'',8,1),(44,'2025-03-03 06:40:21.447441','25','Which one is a white-hat SEO technique?',3,'',8,1),(45,'2025-03-03 06:40:21.447451','24','What is a bounce rate?',3,'',8,1),(46,'2025-03-03 06:40:21.447461','23','A/B testing is used to:',3,'',8,1),(47,'2025-03-03 06:40:21.447476','22','What does DA stand for in SEO?',3,'',8,1),(48,'2025-03-03 06:40:21.447492','21','Which social media platform is best for influencer marketing?',3,'',8,1),(49,'2025-03-03 06:40:21.447510','20','Which algorithm does Google use to rank websites?',3,'',8,1),(50,'2025-03-03 06:40:21.447526','19','Which of the following is an example of content marketing?',3,'',8,1),(51,'2025-03-03 06:40:21.447543','18','The term impressions in digital marketing refers to:',3,'',8,1),(52,'2025-03-03 06:40:21.447559','17','Which of the following is an on-page SEO factor?',3,'',8,1),(53,'2025-03-03 06:40:21.447575','16','Google Ads mainly operates on which model?',3,'',8,1),(54,'2025-03-03 06:40:21.447593','15','What is a lead in digital marketing?',3,'',8,1),(55,'2025-03-03 06:40:21.447610','14','Which one is a key metric for email marketing success?',3,'',8,1),(56,'2025-03-03 06:40:21.447627','13','What does ROI stand for in digital marketing?',3,'',8,1),(57,'2025-03-03 06:40:21.447644','12','Which of the following is an example of social media marketing?',3,'',8,1),(58,'2025-03-03 06:40:21.447661','11','What is the full form of CPC in digital marketing?',3,'',8,1),(59,'2025-03-03 06:40:21.447688','10','Which company owns YouTube?',3,'',8,1),(60,'2025-03-03 06:40:21.447705','9','What is PPC in digital marketing?',3,'',8,1),(61,'2025-03-03 06:40:21.447722','8','Which platform is best suited for B2B marketing?',3,'',8,1),(62,'2025-03-03 06:40:21.447739','7','What does SEO stand for?',3,'',8,1),(63,'2025-03-03 06:40:21.447757','6','Which of the following is NOT a digital marketing channel?',3,'',8,1),(64,'2025-03-03 06:40:21.447782','5','What is the primary goal of digital marketing?',3,'',8,1),(65,'2025-03-03 06:40:21.447800','4','What is the capital of France?',3,'',8,1),(66,'2025-03-03 06:40:21.447845','3','What is 2 + 2?',3,'',8,1),(67,'2025-03-03 06:40:21.447869','2','What is the powerhouse of a cell?',3,'',8,1),(68,'2025-03-03 06:40:21.447895','1','What is the speed of light?',3,'',8,1),(69,'2025-03-03 06:40:46.581505','4','Digital Marketing',1,'[{\"added\": {}}]',7,1),(70,'2025-03-03 06:41:12.186159','5','Operation Handling',1,'[{\"added\": {}}]',7,1),(71,'2025-03-03 06:41:14.396154','5','Operation Handling',2,'[]',7,1),(72,'2025-03-03 06:41:42.876673','6','Entrepreneurship',1,'[{\"added\": {}}]',7,1),(73,'2025-03-03 07:19:36.385607','7','DevOps',1,'[{\"added\": {}}]',7,1),(74,'2025-03-03 07:23:03.727547','8','Cyber Security',1,'[{\"added\": {}}]',7,1),(75,'2025-03-03 07:25:59.025528','9','Sales',1,'[{\"added\": {}}]',7,1),(76,'2025-03-03 07:28:52.464142','9','Sales',3,'',7,1),(77,'2025-03-03 07:29:07.767432','411','What does a sales pipeline represent?',3,'',8,1),(78,'2025-03-03 07:29:07.767463','410','Which of these is a key advantage of using CRM software?',3,'',8,1),(79,'2025-03-03 07:29:07.767475','409','What is the first step in building rapport?',3,'',8,1),(80,'2025-03-03 07:29:07.767485','408','What is SPIN selling?',3,'',8,1),(81,'2025-03-03 07:29:07.767494','407','Which of the following is a warm lead?',3,'',8,1),(82,'2025-03-03 07:29:07.767504','406','What is the best way to qualify a lead?',3,'',8,1),(83,'2025-03-03 07:29:07.767513','405','Which metric measures a salesperson\'s efficiency?',3,'',8,1),(84,'2025-03-03 07:29:07.767523','404','What is the primary goal of a follow-up?',3,'',8,1),(85,'2025-03-03 07:29:07.767532','403','What is the best approach to handling sales objections?',3,'',8,1),(86,'2025-03-03 07:29:07.767543','402','Which of these is an example of a closing technique?',3,'',8,1),(87,'2025-03-03 07:29:07.767555','401','What is a unique selling proposition (USP)?',3,'',8,1),(88,'2025-03-03 07:29:07.767567','400','Which of these best defines value-based selling?',3,'',8,1),(89,'2025-03-03 07:29:07.767579','399','What is the term for a potential customer in sales?',3,'',8,1),(90,'2025-03-03 07:29:07.767590','398','Which sales stage involves addressing client concerns?',3,'',8,1),(91,'2025-03-03 07:29:07.767602','397','What is the main advantage of consultative selling?',3,'',8,1),(92,'2025-03-03 07:29:07.767614','396','What does CRM stand for in sales?',3,'',8,1),(93,'2025-03-03 07:29:07.767626','395','Which step comes first in the sales process?',3,'',8,1),(94,'2025-03-03 07:29:07.767639','394','What is cross-selling?',3,'',8,1),(95,'2025-03-03 07:29:07.767650','393','Which of these is a key trait of a successful salesperson?',3,'',8,1),(96,'2025-03-03 07:29:07.767662','392','What is the primary goal of a sales pitch?',3,'',8,1),(97,'2025-03-03 07:29:07.767674','391','Which of the following is a characteristic of an effective sales proposal?',3,'',8,1),(98,'2025-03-03 07:29:07.767686','390','What is a critical element of a successful sales pitch?',3,'',8,1),(99,'2025-03-03 07:29:07.767698','389','Which of the following is a common closing question?',3,'',8,1),(100,'2025-03-03 07:29:07.767709','388','What is the \'feel-felt-found\' technique used for?',3,'',8,1),(101,'2025-03-03 07:29:07.767721','387','How can a salesperson effectively use storytelling in a sales pitch?',3,'',8,1),(102,'2025-03-03 07:29:07.767733','386','In sales, what does the term \'objection handling\' refer to?',3,'',8,1),(103,'2025-03-03 07:29:07.767745','385','Which of the following is an example of anchoring in sales?',3,'',8,1),(104,'2025-03-03 07:29:07.767757','384','What is the best way to deal with a difficult customer during a negotiation?',3,'',8,1),(105,'2025-03-03 07:29:07.767769','383','Which negotiation tactic involves offering something extra to close the deal?',3,'',8,1),(106,'2025-03-03 07:29:07.767781','382','Which of the following is an effective way to build rapport with a potential client?',3,'',8,1),(107,'2025-03-03 07:29:07.767793','381','Which sales forecasting method relies on historical data?',3,'',8,1),(108,'2025-03-03 07:29:07.767804','380','What does the term ‘win rate’ mean in sales?',3,'',8,1),(109,'2025-03-03 07:29:07.767816','379','Which factor contributes the most to customer lifetime value (CLV)?',3,'',8,1),(110,'2025-03-03 07:29:07.767828','378','What is a key performance indicator (KPI) for inside sales teams?',3,'',8,1),(111,'2025-03-03 07:29:07.767839','377','How is sales velocity calculated?',3,'',8,1),(112,'2025-03-03 07:29:07.767850','376','Which metric helps in evaluating the long-term value of a customer?',3,'',8,1),(113,'2025-03-03 07:29:07.767862','375','If a company has a high customer acquisition cost (CAC), what should it focus on improving?',3,'',8,1),(114,'2025-03-03 07:29:07.767873','374','What does \'Churn Rate\' measure in sales?',3,'',8,1),(115,'2025-03-03 07:29:07.767884','373','Which formula is used to calculate the conversion rate?',3,'',8,1),(116,'2025-03-03 07:29:07.767895','372','What is the primary metric used to measure a salesperson’s performance?',3,'',8,1),(117,'2025-03-03 07:29:07.767907','371','Which of the following best defines consultative selling?',3,'',8,1),(118,'2025-03-03 07:29:07.767920','370','What is a common mistake salespeople make when handling objections?',3,'',8,1),(119,'2025-03-03 07:29:07.767932','369','Which metric is used to measure the effectiveness of a sales campaign?',3,'',8,1),(120,'2025-03-03 07:29:07.767943','368','A company that focuses on retaining customers rather than acquiring new ones is emphasizing what type of sales strategy?',3,'',8,1),(121,'2025-03-03 07:29:07.767955','367','What is the best way to handle a price objection from a potential customer?',3,'',8,1),(122,'2025-03-03 07:29:07.767967','366','Which of the following is an example of an upselling strategy?',3,'',8,1),(123,'2025-03-03 07:29:07.767978','365','What does BANT stand for in sales qualification?',3,'',8,1),(124,'2025-03-03 07:29:07.767990','364','Which sales methodology focuses on solving customer problems rather than just selling a product?',3,'',8,1),(125,'2025-03-03 07:29:07.768002','363','What is the primary purpose of a sales funnel?',3,'',8,1),(126,'2025-03-03 07:29:07.768013','362','Which of the following is the most effective closing technique in sales?',3,'',8,1),(127,'2025-03-03 07:29:07.768025','361','What does a sales pipeline represent?',3,'',8,1),(128,'2025-03-03 07:29:07.768035','360','Which of these is a key advantage of using CRM software?',3,'',8,1),(129,'2025-03-03 07:29:07.768046','359','What is the first step in building rapport?',3,'',8,1),(130,'2025-03-03 07:29:07.768057','358','What is SPIN selling?',3,'',8,1),(131,'2025-03-03 07:29:07.768069','357','Which of the following is a warm lead?',3,'',8,1),(132,'2025-03-03 07:29:07.768080','356','What is the best way to qualify a lead?',3,'',8,1),(133,'2025-03-03 07:29:07.768091','355','Which metric measures a salesperson\'s efficiency?',3,'',8,1),(134,'2025-03-03 07:29:07.768103','354','What is the primary goal of a follow-up?',3,'',8,1),(135,'2025-03-03 07:29:07.768114','353','What is the best approach to handling sales objections?',3,'',8,1),(136,'2025-03-03 07:29:07.768124','352','Which of these is an example of a closing technique?',3,'',8,1),(137,'2025-03-03 07:29:07.768135','351','What is a unique selling proposition (USP)?',3,'',8,1),(138,'2025-03-03 07:29:07.768146','350','Which of these best defines value-based selling?',3,'',8,1),(139,'2025-03-03 07:29:07.768157','349','What is the term for a potential customer in sales?',3,'',8,1),(140,'2025-03-03 07:29:07.768167','348','Which sales stage involves addressing client concerns?',3,'',8,1),(141,'2025-03-03 07:29:07.768178','347','What is the main advantage of consultative selling?',3,'',8,1),(142,'2025-03-03 07:29:07.768190','346','What does CRM stand for in sales?',3,'',8,1),(143,'2025-03-03 07:29:07.768200','345','Which step comes first in the sales process?',3,'',8,1),(144,'2025-03-03 07:29:07.768211','344','What is cross-selling?',3,'',8,1),(145,'2025-03-03 07:29:07.768222','343','Which of these is a key trait of a successful salesperson?',3,'',8,1),(146,'2025-03-03 07:29:07.768234','342','What is the primary goal of a sales pitch?',3,'',8,1),(147,'2025-03-03 07:29:07.768245','341','Which of the following is a characteristic of an effective sales proposal?',3,'',8,1),(148,'2025-03-03 07:29:07.768256','340','What is a critical element of a successful sales pitch?',3,'',8,1),(149,'2025-03-03 07:29:07.768267','339','Which of the following is a common closing question?',3,'',8,1),(150,'2025-03-03 07:29:07.768278','338','What is the \'feel-felt-found\' technique used for?',3,'',8,1),(151,'2025-03-03 07:29:07.768289','337','How can a salesperson effectively use storytelling in a sales pitch?',3,'',8,1),(152,'2025-03-03 07:29:07.768300','336','In sales, what does the term \'objection handling\' refer to?',3,'',8,1),(153,'2025-03-03 07:29:07.768310','335','Which of the following is an example of anchoring in sales?',3,'',8,1),(154,'2025-03-03 07:29:07.768322','334','What is the best way to deal with a difficult customer during a negotiation?',3,'',8,1),(155,'2025-03-03 07:29:07.768333','333','Which negotiation tactic involves offering something extra to close the deal?',3,'',8,1),(156,'2025-03-03 07:29:07.768527','332','Which of the following is an effective way to build rapport with a potential client?',3,'',8,1),(157,'2025-03-03 07:29:07.768571','331','Which sales forecasting method relies on historical data?',3,'',8,1),(158,'2025-03-03 07:29:07.768600','330','What does the term ‘win rate’ mean in sales?',3,'',8,1),(159,'2025-03-03 07:29:07.768626','329','Which factor contributes the most to customer lifetime value (CLV)?',3,'',8,1),(160,'2025-03-03 07:29:07.768650','328','What is a key performance indicator (KPI) for inside sales teams?',3,'',8,1),(161,'2025-03-03 07:29:07.768674','327','How is sales velocity calculated?',3,'',8,1),(162,'2025-03-03 07:29:07.768700','326','Which metric helps in evaluating the long-term value of a customer?',3,'',8,1),(163,'2025-03-03 07:29:07.768725','325','If a company has a high customer acquisition cost (CAC), what should it focus on improving?',3,'',8,1),(164,'2025-03-03 07:29:07.768752','324','What does \'Churn Rate\' measure in sales?',3,'',8,1),(165,'2025-03-03 07:29:07.768791','323','Which formula is used to calculate the conversion rate?',3,'',8,1),(166,'2025-03-03 07:29:07.768829','322','What is the primary metric used to measure a salesperson’s performance?',3,'',8,1),(167,'2025-03-03 07:29:07.768867','321','Which of the following best defines consultative selling?',3,'',8,1),(168,'2025-03-03 07:29:07.768905','320','What is a common mistake salespeople make when handling objections?',3,'',8,1),(169,'2025-03-03 07:29:07.768943','319','Which metric is used to measure the effectiveness of a sales campaign?',3,'',8,1),(170,'2025-03-03 07:29:07.768984','318','A company that focuses on retaining customers rather than acquiring new ones is emphasizing what type of sales strategy?',3,'',8,1),(171,'2025-03-03 07:29:07.769021','317','What is the best way to handle a price objection from a potential customer?',3,'',8,1),(172,'2025-03-03 07:29:07.769058','316','Which of the following is an example of an upselling strategy?',3,'',8,1),(173,'2025-03-03 07:29:07.769096','315','What does BANT stand for in sales qualification?',3,'',8,1),(174,'2025-03-03 07:29:07.769134','314','Which sales methodology focuses on solving customer problems rather than just selling a product?',3,'',8,1),(175,'2025-03-03 07:29:07.769172','313','What is the primary purpose of a sales funnel?',3,'',8,1),(176,'2025-03-03 07:29:07.769210','312','Which of the following is the most effective closing technique in sales?',3,'',8,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (22,'account','emailaddress'),(23,'account','emailconfirmation'),(24,'admin','logentry'),(16,'admin_portal','admindb'),(18,'admin_portal','employeedb'),(17,'admin_portal','managerdb'),(15,'admin_portal','superadmindb'),(2,'auth','group'),(1,'auth','permission'),(19,'certificate_management','certificate'),(4,'compiler','codesubmission'),(3,'contenttypes','contenttype'),(5,'exam_registration','studentsdb'),(6,'examportol','category'),(30,'examportol','exam'),(9,'examportol','examresult'),(8,'examportol','question'),(7,'examportol','subject'),(11,'jobportol','job'),(12,'oauth','collegesdb'),(14,'oauth','otpdb'),(13,'oauth','usersdb'),(10,'placement_stories','placementstories'),(20,'price','plantype'),(21,'price','subscriptionplan'),(25,'sessions','session'),(26,'sites','site'),(27,'socialaccount','socialaccount'),(28,'socialaccount','socialapp'),(29,'socialaccount','socialtoken');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-02-28 06:15:28.889492'),(2,'contenttypes','0002_remove_content_type_name','2025-02-28 06:15:28.962130'),(3,'auth','0001_initial','2025-02-28 06:15:29.294127'),(4,'auth','0002_alter_permission_name_max_length','2025-02-28 06:15:29.375221'),(5,'auth','0003_alter_user_email_max_length','2025-02-28 06:15:29.382866'),(6,'auth','0004_alter_user_username_opts','2025-02-28 06:15:29.389972'),(7,'auth','0005_alter_user_last_login_null','2025-02-28 06:15:29.396713'),(8,'auth','0006_require_contenttypes_0002','2025-02-28 06:15:29.400289'),(9,'auth','0007_alter_validators_add_error_messages','2025-02-28 06:15:29.405901'),(10,'auth','0008_alter_user_username_max_length','2025-02-28 06:15:29.412668'),(11,'auth','0009_alter_user_last_name_max_length','2025-02-28 06:15:29.420544'),(12,'auth','0010_alter_group_name_max_length','2025-02-28 06:15:29.434925'),(13,'auth','0011_update_proxy_permissions','2025-02-28 06:15:29.449887'),(14,'auth','0012_alter_user_first_name_max_length','2025-02-28 06:15:29.455157'),(15,'oauth','0001_initial','2025-02-28 06:15:30.056991'),(16,'account','0001_initial','2025-02-28 06:17:51.284499'),(17,'account','0002_email_max_length','2025-02-28 06:17:51.303170'),(18,'account','0003_alter_emailaddress_create_unique_verified_email','2025-02-28 06:17:51.331075'),(19,'account','0004_alter_emailaddress_drop_unique_email','2025-02-28 06:17:51.359716'),(20,'account','0005_emailaddress_idx_upper_email','2025-02-28 06:17:51.384995'),(21,'account','0006_emailaddress_lower','2025-02-28 06:17:51.406581'),(22,'account','0007_emailaddress_idx_email','2025-02-28 06:17:51.445724'),(23,'account','0008_emailaddress_unique_primary_email_fixup','2025-02-28 06:17:51.462515'),(24,'account','0009_emailaddress_unique_primary_email','2025-02-28 06:17:51.470485'),(25,'admin','0001_initial','2025-02-28 06:17:57.241819'),(26,'admin','0002_logentry_remove_auto_add','2025-02-28 06:17:57.250315'),(27,'admin','0003_logentry_add_action_flag_choices','2025-02-28 06:17:57.259109'),(28,'sessions','0001_initial','2025-02-28 06:17:57.295658'),(29,'sites','0001_initial','2025-02-28 06:17:57.318151'),(30,'sites','0002_alter_domain_unique','2025-02-28 06:17:57.335806'),(31,'socialaccount','0001_initial','2025-02-28 06:17:57.928886'),(32,'socialaccount','0002_token_max_lengths','2025-02-28 06:17:57.980921'),(33,'socialaccount','0003_extra_data_default_dict','2025-02-28 06:17:57.990551'),(34,'socialaccount','0004_app_provider_id_settings','2025-02-28 06:17:58.144217'),(35,'socialaccount','0005_socialtoken_nullable_app','2025-02-28 06:17:58.297166'),(36,'socialaccount','0006_alter_socialaccount_extra_data','2025-02-28 06:17:58.373478'),(37,'compiler','0001_initial','2025-02-28 06:22:40.350506'),(38,'examportol','0001_initial','2025-02-28 06:30:26.453782'),(39,'exam_registration','0001_initial','2025-02-28 06:33:53.527652'),(40,'placement_stories','0001_initial','2025-02-28 06:34:54.344530'),(41,'jobportol','0001_initial','2025-02-28 06:35:27.755819'),(42,'admin_portal','0001_initial','2025-02-28 06:35:48.391335'),(43,'certificate_management','0001_initial','2025-02-28 06:36:08.843992'),(44,'price','0001_initial','2025-02-28 06:36:25.775072'),(45,'oauth','0002_alter_otpdb_user_alter_usersdb_college_name','2025-02-28 06:47:51.248302');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('73wp0fpjgfa1358s5nz9nyyi0c8pndq0','.eJxVTksOwiAQvQtrQ4DOQOvSvWcgDAy2aiDpZ2W8uzRpjO7eP-8lfNjW0W8Lz35K4iy0OP1qFOKDy26keyi3KmMt6zyR3CPycBd5rYmflyP7NzCGZWxto4CzQz0MhJYBOsM9KpdcjjaRCdQwYpe5MWcJAhq2qo-AFpgMtNHvR_3-AIkwO3A:1tp0Ee:8ELo3aBg7DKjprDp8uV-snw9HOidE-Q2MwUVtLW9p54','2025-03-17 07:29:08.007092'),('9cso5307miv29ofgfxpgi25m4i40xqm7','.eJx9jkuOwyAQRO_COkKhscF4Ncp-zoDadBMzE38E9myi3D1YiiJlM7tWV72nuouyl5VnYvI8YboV0d9FwYk5r5gnzLKsX9cjkWGZRK9sc7ZgNBgJYJTS-nESy7b6P84pJibR_4OfhMd9G_1eOPt0dOHzN2D4rWtqQD84X5dKzVtOgzwq8pUW-b0Q3y6v7odgxDJW2rSD66h1AZ1SpFmjivHcERkdq8UiQLTGaIcmBNXaCFjvyIBNR411VfreCI8nPyliEg:1tnwEY:fsT4yI_EdmjQ7gF8O79F76BzcChitIUDfLVj1ZUXz0w','2025-03-14 09:00:38.475142'),('ldr5g3ouhg8f33z0smk926rx6qew3x0p','.eJxVjssOwiAQRf-FdUMo8mi7dO83kAGmtlohFkhMjP8uTRpTdzP3nLmZNzFQ8mRKwtXMngykJc0xs-DuGDbgbxCukboY8jpbuil0p4leosflvLt_BROkqV5zJnDUsu17KxUKceLYSaa9Hp3yloOts5SnEeumlRUgOSrWOSGVQMtFLf392DYEX_AwOWZYzLNgynMMiQyC7eRo-bLCxmvCPl8KaE8j:1tp0DB:7tJsPPVWuLhAjhWkgHkswJAhZTK6OCucUflINvLNNyo','2025-03-17 07:27:37.916784');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_site` (
  `id` int NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com'),(2,'127.0.0.1:8000','localhost.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_registration_studentsdb`
--

DROP TABLE IF EXISTS `exam_registration_studentsdb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_registration_studentsdb` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `studentId` varchar(50) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `payment` varchar(20) NOT NULL,
  `registration_code` varchar(50) NOT NULL,
  `domain_id` bigint DEFAULT NULL,
  `subject_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `studentId` (`studentId`),
  UNIQUE KEY `registration_code` (`registration_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_registration_studentsdb`
--

LOCK TABLES `exam_registration_studentsdb` WRITE;
/*!40000 ALTER TABLE `exam_registration_studentsdb` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_registration_studentsdb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examportol_category`
--

DROP TABLE IF EXISTS `examportol_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `examportol_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category_code` varchar(10) DEFAULT NULL,
  `category_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_code` (`category_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examportol_category`
--

LOCK TABLES `examportol_category` WRITE;
/*!40000 ALTER TABLE `examportol_category` DISABLE KEYS */;
INSERT INTO `examportol_category` VALUES (1,'C0001','IT'),(2,'C0002','MANAGEMENT');
/*!40000 ALTER TABLE `examportol_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examportol_exam`
--

DROP TABLE IF EXISTS `examportol_exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `examportol_exam` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `duration` int unsigned NOT NULL,
  `exam_code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `exam_code` (`exam_code`),
  CONSTRAINT `examportol_exam_chk_1` CHECK ((`duration` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examportol_exam`
--

LOCK TABLES `examportol_exam` WRITE;
/*!40000 ALTER TABLE `examportol_exam` DISABLE KEYS */;
INSERT INTO `examportol_exam` VALUES (1,'This exam is for Entrepreneureship',10,'E0001');
/*!40000 ALTER TABLE `examportol_exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examportol_exam_questions`
--

DROP TABLE IF EXISTS `examportol_exam_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `examportol_exam_questions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `exam_id` bigint NOT NULL,
  `question_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `examportol_exam_questions_exam_id_question_id_93915db6_uniq` (`exam_id`,`question_id`),
  KEY `examportol_exam_ques_question_id_71c3a88c_fk_examporto` (`question_id`),
  CONSTRAINT `examportol_exam_ques_question_id_71c3a88c_fk_examporto` FOREIGN KEY (`question_id`) REFERENCES `examportol_question` (`id`),
  CONSTRAINT `examportol_exam_questions_exam_id_a3947a6d_fk_examportol_exam_id` FOREIGN KEY (`exam_id`) REFERENCES `examportol_exam` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examportol_exam_questions`
--

LOCK TABLES `examportol_exam_questions` WRITE;
/*!40000 ALTER TABLE `examportol_exam_questions` DISABLE KEYS */;
INSERT INTO `examportol_exam_questions` VALUES (1,1,155),(2,1,156),(3,1,157),(4,1,163),(5,1,166),(6,1,167),(7,1,169),(8,1,170),(9,1,172),(10,1,173),(11,1,174),(12,1,176),(13,1,177),(14,1,178),(15,1,179),(16,1,180),(17,1,181),(18,1,182),(19,1,183),(20,1,184),(21,1,185),(22,1,186),(23,1,187),(24,1,188),(25,1,189),(26,1,190),(27,1,191),(28,1,192),(29,1,193),(30,1,194),(31,1,195),(32,1,196),(33,1,197),(34,1,198),(35,1,199),(36,1,200),(37,1,201),(38,1,202),(39,1,203),(40,1,204);
/*!40000 ALTER TABLE `examportol_exam_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examportol_examresult`
--

DROP TABLE IF EXISTS `examportol_examresult`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `examportol_examresult` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `session_id` char(32) DEFAULT NULL,
  `total_questions` int NOT NULL,
  `correct_answers` int NOT NULL,
  `score` double NOT NULL,
  `submitted_answers` json DEFAULT NULL,
  `submitted_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `examportol_examresult_user_id_f752a149_fk_oauth_usersdb_id` (`user_id`),
  CONSTRAINT `examportol_examresult_user_id_f752a149_fk_oauth_usersdb_id` FOREIGN KEY (`user_id`) REFERENCES `oauth_usersdb` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examportol_examresult`
--

LOCK TABLES `examportol_examresult` WRITE;
/*!40000 ALTER TABLE `examportol_examresult` DISABLE KEYS */;
INSERT INTO `examportol_examresult` VALUES (1,'f10263dc7b3a40aa8f8ac969c4391bef',40,1,2.5,'{\"178\": {\"correct\": \"option_A\", \"selected\": \"option_A\"}, \"191\": {\"correct\": \"option_D\", \"selected\": \"option_C\"}, \"196\": {\"correct\": \"option_D\", \"selected\": \"option_B\"}}','2025-03-03 07:06:47.552293',1);
/*!40000 ALTER TABLE `examportol_examresult` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examportol_question`
--

DROP TABLE IF EXISTS `examportol_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `examportol_question` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `question_code` varchar(20) DEFAULT NULL,
  `question_text` longtext NOT NULL,
  `answers` json DEFAULT NULL,
  `question_subject_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `question_code` (`question_code`),
  KEY `examportol_question_question_subject_id_18dcf644_fk_examporto` (`question_subject_id`),
  CONSTRAINT `examportol_question_question_subject_id_18dcf644_fk_examporto` FOREIGN KEY (`question_subject_id`) REFERENCES `examportol_subject` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=412 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examportol_question`
--

LOCK TABLES `examportol_question` WRITE;
/*!40000 ALTER TABLE `examportol_question` DISABLE KEYS */;
INSERT INTO `examportol_question` VALUES (55,'C0002-S0003-Q0001','What is the primary goal of digital marketing?','{\"option_A\": {\"text\": \"Increase newspaper sales\", \"is_correct\": false}, \"option_B\": {\"text\": \"Promote products/services online\", \"is_correct\": true}, \"option_C\": {\"text\": \"Reduce social media usage\", \"is_correct\": false}, \"option_D\": {\"text\": \"Eliminate traditional marketing\", \"is_correct\": false}}',4),(56,'C0002-S0003-Q0002','Which of the following is NOT a digital marketing channel?','{\"option_A\": {\"text\": \"Email marketing\", \"is_correct\": false}, \"option_B\": {\"text\": \"Print advertisements\", \"is_correct\": true}, \"option_C\": {\"text\": \"Social media\", \"is_correct\": false}, \"option_D\": {\"text\": \"Search engine optimization (SEO)\", \"is_correct\": false}}',4),(57,'C0002-S0003-Q0003','What does SEO stand for?','{\"option_A\": {\"text\": \"Social Engagement Optimization\", \"is_correct\": false}, \"option_B\": {\"text\": \"Search Engine Optimization\", \"is_correct\": true}, \"option_C\": {\"text\": \"Site Experience Online\", \"is_correct\": false}, \"option_D\": {\"text\": \"Sales and Ecommerce Operations\", \"is_correct\": false}}',4),(58,'C0002-S0003-Q0004','Which platform is best suited for B2B marketing?','{\"option_A\": {\"text\": \"Instagram\", \"is_correct\": false}, \"option_B\": {\"text\": \"TikTok\", \"is_correct\": false}, \"option_C\": {\"text\": \"LinkedIn\", \"is_correct\": true}, \"option_D\": {\"text\": \"Snapchat\", \"is_correct\": false}}',4),(59,'C0002-S0003-Q0005','What is PPC in digital marketing?','{\"option_A\": {\"text\": \"Pay Per Click\", \"is_correct\": true}, \"option_B\": {\"text\": \"Paid Product Campaign\", \"is_correct\": false}, \"option_C\": {\"text\": \"Public Promotion Cost\", \"is_correct\": false}, \"option_D\": {\"text\": \"Product Price Campaign\", \"is_correct\": false}}',4),(60,'C0002-S0003-Q0006','Which company owns YouTube?','{\"option_A\": {\"text\": \"Facebook\", \"is_correct\": false}, \"option_B\": {\"text\": \"Apple\", \"is_correct\": false}, \"option_C\": {\"text\": \"Google\", \"is_correct\": true}, \"option_D\": {\"text\": \"Microsoft\", \"is_correct\": false}}',4),(61,'C0002-S0003-Q0007','What is the full form of CPC in digital marketing?','{\"option_A\": {\"text\": \"Cost Per Click\", \"is_correct\": true}, \"option_B\": {\"text\": \"Customer Product Campaign\", \"is_correct\": false}, \"option_C\": {\"text\": \"Content Promotion Cost\", \"is_correct\": false}, \"option_D\": {\"text\": \"Click Promotion Campaign\", \"is_correct\": false}}',4),(62,'C0002-S0003-Q0008','Which of the following is an example of social media marketing?','{\"option_A\": {\"text\": \"Running a Facebook ad\", \"is_correct\": true}, \"option_B\": {\"text\": \"Sending an SMS\", \"is_correct\": false}, \"option_C\": {\"text\": \"Placing an ad in a magazine\", \"is_correct\": false}, \"option_D\": {\"text\": \"Distributing pamphlets\", \"is_correct\": false}}',4),(63,'C0002-S0003-Q0009','What does ROI stand for in digital marketing?','{\"option_A\": {\"text\": \"Return on Investment\", \"is_correct\": true}, \"option_B\": {\"text\": \"Rate of Interest\", \"is_correct\": false}, \"option_C\": {\"text\": \"Revenue on Internet\", \"is_correct\": false}, \"option_D\": {\"text\": \"Result of Input\", \"is_correct\": false}}',4),(64,'C0002-S0003-Q0010','Which one is a key metric for email marketing success?','{\"option_A\": {\"text\": \"Number of Facebook likes\", \"is_correct\": false}, \"option_B\": {\"text\": \"Open rate\", \"is_correct\": true}, \"option_C\": {\"text\": \"Number of YouTube subscribers\", \"is_correct\": false}, \"option_D\": {\"text\": \"Twitter followers\", \"is_correct\": false}}',4),(65,'C0002-S0003-Q0011','What is a lead in digital marketing?','{\"option_A\": {\"text\": \"A person interested in a product/service\", \"is_correct\": true}, \"option_B\": {\"text\": \"A competitor in the market\", \"is_correct\": false}, \"option_C\": {\"text\": \"A viral social media post\", \"is_correct\": false}, \"option_D\": {\"text\": \"A keyword with high search volume\", \"is_correct\": false}}',4),(66,'C0002-S0003-Q0012','Google Ads mainly operates on which model?','{\"option_A\": {\"text\": \"Cost Per Impression (CPM)\", \"is_correct\": false}, \"option_B\": {\"text\": \"Pay Per Click (PPC)\", \"is_correct\": true}, \"option_C\": {\"text\": \"Cost Per Acquisition (CPA)\", \"is_correct\": false}, \"option_D\": {\"text\": \"Search Engine Results Model\", \"is_correct\": false}}',4),(67,'C0002-S0003-Q0013','Which of the following is an on-page SEO factor?','{\"option_A\": {\"text\": \"Number of backlinks\", \"is_correct\": false}, \"option_B\": {\"text\": \"Social media shares\", \"is_correct\": false}, \"option_C\": {\"text\": \"Keyword usage in content\", \"is_correct\": true}, \"option_D\": {\"text\": \"Email marketing strategy\", \"is_correct\": false}}',4),(68,'C0002-S0003-Q0014','The term impressions in digital marketing refers to:','{\"option_A\": {\"text\": \"Number of people who clicked an ad\", \"is_correct\": false}, \"option_B\": {\"text\": \"Number of times an ad is displayed\", \"is_correct\": true}, \"option_C\": {\"text\": \"Total ad spend\", \"is_correct\": false}, \"option_D\": {\"text\": \"Number of conversions from an ad\", \"is_correct\": false}}',4),(69,'C0002-S0003-Q0015','Which of the following is an example of content marketing?','{\"option_A\": {\"text\": \"A banner ad on a website\", \"is_correct\": false}, \"option_B\": {\"text\": \"A blog post explaining industry trends\", \"is_correct\": true}, \"option_C\": {\"text\": \"A PPC campaign\", \"is_correct\": false}, \"option_D\": {\"text\": \"A cold email campaign\", \"is_correct\": false}}',4),(70,'C0002-S0003-Q0016','Which algorithm does Google use to rank websites?','{\"option_A\": {\"text\": \"Hummingbird\", \"is_correct\": false}, \"option_B\": {\"text\": \"Penguin\", \"is_correct\": false}, \"option_C\": {\"text\": \"Panda\", \"is_correct\": false}, \"option_D\": {\"text\": \"All of the above\", \"is_correct\": true}}',4),(71,'C0002-S0003-Q0017','Which social media platform is best for influencer marketing?','{\"option_A\": {\"text\": \"Twitter\", \"is_correct\": false}, \"option_B\": {\"text\": \"Instagram\", \"is_correct\": true}, \"option_C\": {\"text\": \"LinkedIn\", \"is_correct\": false}, \"option_D\": {\"text\": \"Telegram\", \"is_correct\": false}}',4),(72,'C0002-S0003-Q0018','What does DA stand for in SEO?','{\"option_A\": {\"text\": \"Domain Authority\", \"is_correct\": true}, \"option_B\": {\"text\": \"Digital Advertising\", \"is_correct\": false}, \"option_C\": {\"text\": \"Direct Advertisement\", \"is_correct\": false}, \"option_D\": {\"text\": \"Data Analysis\", \"is_correct\": false}}',4),(73,'C0002-S0003-Q0019','A/B testing is used to:','{\"option_A\": {\"text\": \"Compare two versions of a webpage or ad\", \"is_correct\": true}, \"option_B\": {\"text\": \"Improve email marketing campaigns\", \"is_correct\": false}, \"option_C\": {\"text\": \"Track social media trends\", \"is_correct\": false}, \"option_D\": {\"text\": \"Increase website bounce rates\", \"is_correct\": false}}',4),(74,'C0002-S0003-Q0020','What is a bounce rate?','{\"option_A\": {\"text\": \"Percentage of visitors who leave without engaging further\", \"is_correct\": true}, \"option_B\": {\"text\": \"Number of website clicks\", \"is_correct\": false}, \"option_C\": {\"text\": \"Social media engagement metric\", \"is_correct\": false}, \"option_D\": {\"text\": \"Number of backlinks\", \"is_correct\": false}}',4),(75,'C0002-S0003-Q0021','Which one is a white-hat SEO technique?','{\"option_A\": {\"text\": \"Buying backlinks\", \"is_correct\": false}, \"option_B\": {\"text\": \"Using proper meta tags\", \"is_correct\": true}, \"option_C\": {\"text\": \"Cloaking\", \"is_correct\": false}, \"option_D\": {\"text\": \"Keyword stuffing\", \"is_correct\": false}}',4),(76,'C0002-S0003-Q0022','What is the purpose of a call-to-action (CTA)?','{\"option_A\": {\"text\": \"Encourage users to take a specific action\", \"is_correct\": true}, \"option_B\": {\"text\": \"Generate website traffic\", \"is_correct\": false}, \"option_C\": {\"text\": \"Reduce bounce rate\", \"is_correct\": false}, \"option_D\": {\"text\": \"Improve keyword ranking\", \"is_correct\": false}}',4),(77,'C0002-S0003-Q0023','Which email marketing metric indicates how many people clicked on a link?','{\"option_A\": {\"text\": \"Open rate\", \"is_correct\": false}, \"option_B\": {\"text\": \"Click-through rate (CTR)\", \"is_correct\": true}, \"option_C\": {\"text\": \"Bounce rate\", \"is_correct\": false}, \"option_D\": {\"text\": \"Unsubscribe rate\", \"is_correct\": false}}',4),(78,'C0002-S0003-Q0024','What is the ideal length of a meta description for SEO?','{\"option_A\": {\"text\": \"10-20 characters\", \"is_correct\": false}, \"option_B\": {\"text\": \"30-60 characters\", \"is_correct\": false}, \"option_C\": {\"text\": \"150-160 characters\", \"is_correct\": true}, \"option_D\": {\"text\": \"300-400 characters\", \"is_correct\": false}}',4),(79,'C0002-S0003-Q0025','What does Google Analytics help with?','{\"option_A\": {\"text\": \"Tracking website performance\", \"is_correct\": true}, \"option_B\": {\"text\": \"Running Facebook ads\", \"is_correct\": false}, \"option_C\": {\"text\": \"Creating SEO reports\", \"is_correct\": false}, \"option_D\": {\"text\": \"Automating emails\", \"is_correct\": false}}',4),(80,'C0002-S0003-Q0026','What is latent semantic indexing (LSI) in SEO?','{\"option_A\": {\"text\": \"A Google algorithm for indexing pages\", \"is_correct\": false}, \"option_B\": {\"text\": \"A method to find related keywords\", \"is_correct\": true}, \"option_C\": {\"text\": \"A backlink-building strategy\", \"is_correct\": false}, \"option_D\": {\"text\": \"A type of PPC advertising\", \"is_correct\": false}}',4),(81,'C0002-S0003-Q0027','What does a canonical tag help with?','{\"option_A\": {\"text\": \"Avoiding duplicate content issues\", \"is_correct\": true}, \"option_B\": {\"text\": \"Increasing keyword density\", \"is_correct\": false}, \"option_C\": {\"text\": \"Enhancing PPC ad quality\", \"is_correct\": false}, \"option_D\": {\"text\": \"Tracking social media engagement\", \"is_correct\": false}}',4),(82,'C0002-S0003-Q0028','What is customer lifetime value (CLV)?','{\"option_A\": {\"text\": \"The total revenue a customer generates over time\", \"is_correct\": true}, \"option_B\": {\"text\": \"The total website visits of a customer\", \"is_correct\": false}, \"option_C\": {\"text\": \"The total number of purchases in a month\", \"is_correct\": false}, \"option_D\": {\"text\": \"The amount spent on digital marketing campaigns\", \"is_correct\": false}}',4),(83,'C0002-S0003-Q0029','What does remarketing mean?','{\"option_A\": {\"text\": \"Redesign SEO campaign\", \"is_correct\": false}, \"option_B\": {\"text\": \"Marketing through social media only\", \"is_correct\": false}, \"option_C\": {\"text\": \"Creating new products for the same market\", \"is_correct\": false}, \"option_D\": {\"text\": \"Retargeting users who visited a website but didn’t convert\", \"is_correct\": true}}',4),(84,'C0002-S0003-Q0030','Which of these is not a factor in Google’s ranking algorithm?','{\"option_A\": {\"text\": \"Number of Facebook shares\", \"is_correct\": true}, \"option_B\": {\"text\": \"Page load speed\", \"is_correct\": false}, \"option_C\": {\"text\": \"Mobile-friendliness\", \"is_correct\": false}, \"option_D\": {\"text\": \"Quality of backlinks\", \"is_correct\": false}}',4),(85,'C0002-S0003-Q0031','The skyscraper technique in SEO is used to:','{\"option_A\": {\"text\": \"Build high-quality backlinks\", \"is_correct\": true}, \"option_B\": {\"text\": \"Improve social media presence\", \"is_correct\": false}, \"option_C\": {\"text\": \"Increase paid ad reach\", \"is_correct\": false}, \"option_D\": {\"text\": \"Reduce website bounce rate\", \"is_correct\": false}}',4),(86,'C0002-S0003-Q0032','Which of these affects email deliverability the most?','{\"option_A\": {\"text\": \"A/B testing\", \"is_correct\": false}, \"option_B\": {\"text\": \"High CTR\", \"is_correct\": false}, \"option_C\": {\"text\": \"Unverified email lists\", \"is_correct\": true}, \"option_D\": {\"text\": \"Using multiple CTAs\", \"is_correct\": false}}',4),(87,'C0002-S0003-Q0033','What is the ideal keyword density for SEO?','{\"option_A\": {\"text\": \"1-2%\", \"is_correct\": true}, \"option_B\": {\"text\": \"5-10%\", \"is_correct\": false}, \"option_C\": {\"text\": \"20-25%\", \"is_correct\": false}, \"option_D\": {\"text\": \"No limit\", \"is_correct\": false}}',4),(88,'C0002-S0003-Q0034','What is AMP (Accelerated Mobile Pages)?','{\"option_A\": {\"text\": \"A Google project to speed up mobile pages\", \"is_correct\": true}, \"option_B\": {\"text\": \"A social media marketing tool\", \"is_correct\": false}, \"option_C\": {\"text\": \"A PPC bidding strategy\", \"is_correct\": false}, \"option_D\": {\"text\": \"A type of backlink\", \"is_correct\": false}}',4),(89,'C0002-S0003-Q0035','What does SERP stand for?','{\"option_A\": {\"text\": \"Search Engine Results Page\", \"is_correct\": true}, \"option_B\": {\"text\": \"Social Engagement Rating Performance\", \"is_correct\": false}, \"option_C\": {\"text\": \"Sales and Ecommerce Revenue Platform\", \"is_correct\": false}, \"option_D\": {\"text\": \"Search Engine Ranking Process\", \"is_correct\": false}}',4),(90,'C0002-S0003-Q0036','Which of the following is a black-hat SEO technique?','{\"option_A\": {\"text\": \"Cloaking\", \"is_correct\": true}, \"option_B\": {\"text\": \"Internal linking\", \"is_correct\": false}, \"option_C\": {\"text\": \"Optimizing page speed\", \"is_correct\": false}, \"option_D\": {\"text\": \"Writing high-quality content\", \"is_correct\": false}}',4),(91,'C0002-S0003-Q0037','What is a featured snippet?','{\"option_A\": {\"text\": \"A type of email marketing technique\", \"is_correct\": false}, \"option_B\": {\"text\": \"A method for running PPC ads\", \"is_correct\": false}, \"option_C\": {\"text\": \"A highlighted result at the top of Google’s search page\", \"is_correct\": true}, \"option_D\": {\"text\": \"A keyword used in blog posts\", \"is_correct\": false}}',4),(92,'C0002-S0003-Q0038','What is the purpose of Google Search Console?','{\"option_A\": {\"text\": \"Monitor website performance in search results\", \"is_correct\": true}, \"option_B\": {\"text\": \"Track social media engagement\", \"is_correct\": false}, \"option_C\": {\"text\": \"Create and run Google Ads campaigns\", \"is_correct\": false}, \"option_D\": {\"text\": \"Manage email marketing campaigns\", \"is_correct\": false}}',4),(93,'C0002-S0003-Q0039','What is the main purpose of a landing page?','{\"option_A\": {\"text\": \"Increase social media engagement\", \"is_correct\": false}, \"option_B\": {\"text\": \"Convert visitors into leads or customers\", \"is_correct\": true}, \"option_C\": {\"text\": \"Rank higher in search engines\", \"is_correct\": false}, \"option_D\": {\"text\": \"Build backlinks\", \"is_correct\": false}}',4),(94,'C0002-S0003-Q0040','What is anchor text in SEO?','{\"option_A\": {\"text\": \"The title of a blog post\", \"is_correct\": false}, \"option_B\": {\"text\": \"A PPC campaign keyword\", \"is_correct\": false}, \"option_C\": {\"text\": \"Clickable text in a hyperlink\", \"is_correct\": true}, \"option_D\": {\"text\": \"A social media post\", \"is_correct\": false}}',4),(95,'C0002-S0003-Q0041','What is the purpose of a robots.txt file?','{\"option_A\": {\"text\": \"Rank a website higher in search engines\", \"is_correct\": false}, \"option_B\": {\"text\": \"Increase social media engagement\", \"is_correct\": false}, \"option_C\": {\"text\": \"Improve email marketing open rates\", \"is_correct\": false}, \"option_D\": {\"text\": \"Tell search engines which pages to crawl\", \"is_correct\": true}}',4),(96,'C0002-S0003-Q0042','What is programmatic advertising?','{\"option_A\": {\"text\": \"Automated buying and selling of online ads\", \"is_correct\": true}, \"option_B\": {\"text\": \"Using influencers for brand promotion\", \"is_correct\": false}, \"option_C\": {\"text\": \"Writing high-quality blog content\", \"is_correct\": false}, \"option_D\": {\"text\": \"Creating email marketing templates\", \"is_correct\": false}}',4),(97,'C0002-S0003-Q0043','What is domain authority (DA) used for?','{\"option_A\": {\"text\": \"Increasing social media followers\", \"is_correct\": false}, \"option_B\": {\"text\": \"Running PPC ads\", \"is_correct\": false}, \"option_C\": {\"text\": \"Measuring website credibility and ranking potential\", \"is_correct\": true}, \"option_D\": {\"text\": \"Sending automated email campaigns\", \"is_correct\": false}}',4),(98,'C0002-S0003-Q0044','What is the purpose of the Google My Business tool?','{\"option_A\": {\"text\": \"Create PPC campaigns\", \"is_correct\": false}, \"option_B\": {\"text\": \"Improve email open rates\", \"is_correct\": false}, \"option_C\": {\"text\": \"Automate website content\", \"is_correct\": false}, \"option_D\": {\"text\": \"Manage local business listings\", \"is_correct\": true}}',4),(99,'C0002-S0003-Q0045','What is UTM tracking used for?','{\"option_A\": {\"text\": \"Tracking website traffic from marketing campaigns\", \"is_correct\": true}, \"option_B\": {\"text\": \"Increasing search engine ranking\", \"is_correct\": false}, \"option_C\": {\"text\": \"Running PPC ads\", \"is_correct\": false}, \"option_D\": {\"text\": \"Enhancing social media presence\", \"is_correct\": false}}',4),(100,'C0002-S0003-Q0046','What is a drip campaign?','{\"option_A\": {\"text\": \"A type of SEO strategy\", \"is_correct\": false}, \"option_B\": {\"text\": \"A series of automated emails sent over time\", \"is_correct\": true}, \"option_C\": {\"text\": \"A PPC ad format\", \"is_correct\": false}, \"option_D\": {\"text\": \"A keyword research tool\", \"is_correct\": false}}',4),(101,'C0002-S0003-Q0047','Which platform is best for video marketing?','{\"option_A\": {\"text\": \"LinkedIn\", \"is_correct\": false}, \"option_B\": {\"text\": \"Twitter\", \"is_correct\": false}, \"option_C\": {\"text\": \"YouTube\", \"is_correct\": true}, \"option_D\": {\"text\": \"Pinterest\", \"is_correct\": false}}',4),(102,'C0002-S0003-Q0048','What does CTA stand for in digital marketing?','{\"option_A\": {\"text\": \"Call To Action\", \"is_correct\": true}, \"option_B\": {\"text\": \"Click Through Analysis\", \"is_correct\": false}, \"option_C\": {\"text\": \"Customer Target Advertising\", \"is_correct\": false}, \"option_D\": {\"text\": \"Content Tracking Algorithm\", \"is_correct\": false}}',4),(103,'C0002-S0003-Q0049','Which of the following is an example of outbound marketing?','{\"option_A\": {\"text\": \"Blogging\", \"is_correct\": false}, \"option_B\": {\"text\": \"Cold calling\", \"is_correct\": true}, \"option_C\": {\"text\": \"SEO optimization\", \"is_correct\": false}, \"option_D\": {\"text\": \"Social media engagement\", \"is_correct\": false}}',4),(104,'C0002-S0003-Q0050','What is the purpose of Google Tag Manager?','{\"option_A\": {\"text\": \"Running PPC ads\", \"is_correct\": false}, \"option_B\": {\"text\": \"Creating meta descriptions\", \"is_correct\": false}, \"option_C\": {\"text\": \"Managing tracking codes without modifying website code\", \"is_correct\": true}, \"option_D\": {\"text\": \"Writing content for SEO\", \"is_correct\": false}}',4),(105,'C0002-S0001-Q0001','What is the next number in the series: 2, 4, 6, 8, ___?','{\"option_A\": {\"text\": \"9\", \"is_correct\": false}, \"option_B\": {\"text\": \"10\", \"is_correct\": true}, \"option_C\": {\"text\": \"11\", \"is_correct\": false}, \"option_D\": {\"text\": \"12\", \"is_correct\": false}}',1),(106,'C0002-S0001-Q0002','Which word is the odd one out?','{\"option_A\": {\"text\": \"Apple\", \"is_correct\": false}, \"option_B\": {\"text\": \"Banana\", \"is_correct\": false}, \"option_C\": {\"text\": \"Orange\", \"is_correct\": false}, \"option_D\": {\"text\": \"Carrot\", \"is_correct\": true}}',1),(107,'C0002-S0001-Q0003','If all cats are dogs and all dogs are birds, then all cats are birds. This statement is:','{\"option_A\": {\"text\": \"TRUE\", \"is_correct\": true}, \"option_B\": {\"text\": \"FALSE\", \"is_correct\": false}, \"option_C\": {\"text\": \"Partially true\", \"is_correct\": false}, \"option_D\": {\"text\": \"Cannot be determined\", \"is_correct\": false}}',1),(108,'C0002-S0001-Q0004','What is 25% of 200?','{\"option_A\": {\"text\": \"25\", \"is_correct\": false}, \"option_B\": {\"text\": \"50\", \"is_correct\": true}, \"option_C\": {\"text\": \"75\", \"is_correct\": false}, \"option_D\": {\"text\": \"100\", \"is_correct\": false}}',1),(109,'C0002-S0001-Q0005','Which of the following is a prime number?','{\"option_A\": {\"text\": \"4\", \"is_correct\": false}, \"option_B\": {\"text\": \"6\", \"is_correct\": false}, \"option_C\": {\"text\": \"7\", \"is_correct\": true}, \"option_D\": {\"text\": \"8\", \"is_correct\": false}}',1),(110,'C0002-S0001-Q0006','What is the synonym of \"Happy\"?','{\"option_A\": {\"text\": \"Joyful\", \"is_correct\": true}, \"option_B\": {\"text\": \"Sad\", \"is_correct\": false}, \"option_C\": {\"text\": \"Angry\", \"is_correct\": false}, \"option_D\": {\"text\": \"Tired\", \"is_correct\": false}}',1),(111,'C0002-S0001-Q0007','What is the antonym of \"Brave\"?','{\"option_A\": {\"text\": \"Bold\", \"is_correct\": false}, \"option_B\": {\"text\": \"Cowardly\", \"is_correct\": true}, \"option_C\": {\"text\": \"Strong\", \"is_correct\": false}, \"option_D\": {\"text\": \"Fearless\", \"is_correct\": false}}',1),(112,'C0002-S0001-Q0008','If today is Monday, what day will it be after 10 days?','{\"option_A\": {\"text\": \"Monday\", \"is_correct\": false}, \"option_B\": {\"text\": \"Tuesday\", \"is_correct\": false}, \"option_C\": {\"text\": \"Thursday\", \"is_correct\": true}, \"option_D\": {\"text\": \"Sunday\", \"is_correct\": false}}',1),(113,'C0002-S0001-Q0009','What is the smallest two-digit number?','{\"option_A\": {\"text\": \"10\", \"is_correct\": true}, \"option_B\": {\"text\": \"11\", \"is_correct\": false}, \"option_C\": {\"text\": \"99\", \"is_correct\": false}, \"option_D\": {\"text\": \"100\", \"is_correct\": false}}',1),(114,'C0002-S0001-Q0010','Which of the following is a vowel?','{\"option_A\": {\"text\": \"B\", \"is_correct\": false}, \"option_B\": {\"text\": \"E\", \"is_correct\": true}, \"option_C\": {\"text\": \"F\", \"is_correct\": false}, \"option_D\": {\"text\": \"G\", \"is_correct\": false}}',1),(115,'C0002-S0001-Q0011','What is the plural of \"Child\"?','{\"option_A\": {\"text\": \"Childs\", \"is_correct\": false}, \"option_B\": {\"text\": \"Childes\", \"is_correct\": false}, \"option_C\": {\"text\": \"Children\", \"is_correct\": true}, \"option_D\": {\"text\": \"Childies\", \"is_correct\": false}}',1),(116,'C0002-S0001-Q0012','What is the square root of 64?','{\"option_A\": {\"text\": \"6\", \"is_correct\": false}, \"option_B\": {\"text\": \"8\", \"is_correct\": true}, \"option_C\": {\"text\": \"10\", \"is_correct\": false}, \"option_D\": {\"text\": \"12\", \"is_correct\": false}}',1),(117,'C0002-S0001-Q0013','What is the next letter in the series: A, C, E, G, ___?','{\"option_A\": {\"text\": \"H\", \"is_correct\": false}, \"option_B\": {\"text\": \"I\", \"is_correct\": false}, \"option_C\": {\"text\": \"J\", \"is_correct\": false}, \"option_D\": {\"text\": \"K\", \"is_correct\": true}}',1),(118,'C0002-S0001-Q0014','What is 12 × 5?','{\"option_A\": {\"text\": \"50\", \"is_correct\": false}, \"option_B\": {\"text\": \"55\", \"is_correct\": false}, \"option_C\": {\"text\": \"60\", \"is_correct\": true}, \"option_D\": {\"text\": \"65\", \"is_correct\": false}}',1),(119,'C0002-S0001-Q0015','Which of the following is a mammal?','{\"option_A\": {\"text\": \"Whale\", \"is_correct\": true}, \"option_B\": {\"text\": \"Shark\", \"is_correct\": false}, \"option_C\": {\"text\": \"Frog\", \"is_correct\": false}, \"option_D\": {\"text\": \"Snake\", \"is_correct\": false}}',1),(120,'C0002-S0001-Q0016','What is the next number in the series: 3, 6, 9, 12, ___?','{\"option_A\": {\"text\": \"13\", \"is_correct\": false}, \"option_B\": {\"text\": \"15\", \"is_correct\": true}, \"option_C\": {\"text\": \"16\", \"is_correct\": false}, \"option_D\": {\"text\": \"18\", \"is_correct\": false}}',1),(121,'C0002-S0001-Q0017','If the code for CAT is 3120, what is the code for DOG?','{\"option_A\": {\"text\": \"4157\", \"is_correct\": false}, \"option_B\": {\"text\": \"5147\", \"is_correct\": false}, \"option_C\": {\"text\": \"4158\", \"is_correct\": true}, \"option_D\": {\"text\": \"5148\", \"is_correct\": false}}',1),(122,'C0002-S0001-Q0018','What is the missing number in the series: 5, 10, 15, ___, 25?','{\"option_A\": {\"text\": \"18\", \"is_correct\": false}, \"option_B\": {\"text\": \"20\", \"is_correct\": true}, \"option_C\": {\"text\": \"22\", \"is_correct\": false}, \"option_D\": {\"text\": \"24\", \"is_correct\": false}}',1),(123,'C0002-S0001-Q0019','What is the value of 3² + 4²?','{\"option_A\": {\"text\": \"5\", \"is_correct\": false}, \"option_B\": {\"text\": \"12\", \"is_correct\": false}, \"option_C\": {\"text\": \"25\", \"is_correct\": true}, \"option_D\": {\"text\": \"49\", \"is_correct\": false}}',1),(124,'C0002-S0001-Q0020','Which of the following is the largest fraction?','{\"option_A\": {\"text\": \"02-Jan\", \"is_correct\": false}, \"option_B\": {\"text\": \"03-Jan\", \"is_correct\": false}, \"option_C\": {\"text\": \"04-Jan\", \"is_correct\": false}, \"option_D\": {\"text\": \"05-Jan\", \"is_correct\": true}}',1),(125,'C0002-S0001-Q0021','What is the next letter in the series: B, D, F, H, ___?','{\"option_A\": {\"text\": \"J\", \"is_correct\": true}, \"option_B\": {\"text\": \"K\", \"is_correct\": false}, \"option_C\": {\"text\": \"L\", \"is_correct\": false}, \"option_D\": {\"text\": \"M\", \"is_correct\": false}}',1),(126,'C0002-S0001-Q0022','What is the sum of the angles in a triangle?','{\"option_A\": {\"text\": \"90°\", \"is_correct\": false}, \"option_B\": {\"text\": \"180°\", \"is_correct\": true}, \"option_C\": {\"text\": \"270°\", \"is_correct\": false}, \"option_D\": {\"text\": \"360°\", \"is_correct\": false}}',1),(127,'C0002-S0001-Q0023','What is the cube of 3?','{\"option_A\": {\"text\": \"6\", \"is_correct\": false}, \"option_B\": {\"text\": \"9\", \"is_correct\": false}, \"option_C\": {\"text\": \"27\", \"is_correct\": true}, \"option_D\": {\"text\": \"81\", \"is_correct\": false}}',1),(128,'C0002-S0001-Q0024','What is the next number in the series: 1, 4, 9, 16, ___?','{\"option_A\": {\"text\": \"20\", \"is_correct\": false}, \"option_B\": {\"text\": \"22\", \"is_correct\": false}, \"option_C\": {\"text\": \"24\", \"is_correct\": false}, \"option_D\": {\"text\": \"25\", \"is_correct\": true}}',1),(129,'C0002-S0001-Q0025','What is the value of 15% of 300?','{\"option_A\": {\"text\": \"30\", \"is_correct\": false}, \"option_B\": {\"text\": \"45\", \"is_correct\": true}, \"option_C\": {\"text\": \"60\", \"is_correct\": false}, \"option_D\": {\"text\": \"75\", \"is_correct\": false}}',1),(130,'C0002-S0001-Q0026','What is the next letter in the series: Z, X, V, T, ___?','{\"option_A\": {\"text\": \"R\", \"is_correct\": true}, \"option_B\": {\"text\": \"S\", \"is_correct\": false}, \"option_C\": {\"text\": \"Q\", \"is_correct\": false}, \"option_D\": {\"text\": \"P\", \"is_correct\": false}}',1),(131,'C0002-S0001-Q0027','What is the missing number in the series: 2, 4, 8, ___, 32?','{\"option_A\": {\"text\": \"12\", \"is_correct\": false}, \"option_B\": {\"text\": \"14\", \"is_correct\": false}, \"option_C\": {\"text\": \"16\", \"is_correct\": true}, \"option_D\": {\"text\": \"18\", \"is_correct\": false}}',1),(132,'C0002-S0001-Q0028','What is the value of 7 × 8 + 4?','{\"option_A\": {\"text\": \"56\", \"is_correct\": false}, \"option_B\": {\"text\": \"60\", \"is_correct\": true}, \"option_C\": {\"text\": \"64\", \"is_correct\": false}, \"option_D\": {\"text\": \"68\", \"is_correct\": false}}',1),(133,'C0002-S0001-Q0029','What is the next number in the series: 10, 20, 30, 40, ___?','{\"option_A\": {\"text\": \"45\", \"is_correct\": false}, \"option_B\": {\"text\": \"48\", \"is_correct\": false}, \"option_C\": {\"text\": \"50\", \"is_correct\": false}, \"option_D\": {\"text\": \"50\", \"is_correct\": true}}',1),(134,'C0002-S0001-Q0030','What is the value of 12 ÷ 3 × 4?','{\"option_A\": {\"text\": \"1\", \"is_correct\": false}, \"option_B\": {\"text\": \"4\", \"is_correct\": false}, \"option_C\": {\"text\": \"16\", \"is_correct\": true}, \"option_D\": {\"text\": \"24\", \"is_correct\": false}}',1),(135,'C0002-S0001-Q0031','What is the next number in the series: 1, 3, 6, 10, ___?','{\"option_A\": {\"text\": \"12\", \"is_correct\": false}, \"option_B\": {\"text\": \"15\", \"is_correct\": true}, \"option_C\": {\"text\": \"18\", \"is_correct\": false}, \"option_D\": {\"text\": \"20\", \"is_correct\": false}}',1),(136,'C0002-S0001-Q0032','What is the value of 5! (5 factorial)?','{\"option_A\": {\"text\": \"10\", \"is_correct\": false}, \"option_B\": {\"text\": \"20\", \"is_correct\": false}, \"option_C\": {\"text\": \"120\", \"is_correct\": true}, \"option_D\": {\"text\": \"240\", \"is_correct\": false}}',1),(137,'C0002-S0001-Q0033','What is the next letter in the series: A, D, G, J, ___?','{\"option_A\": {\"text\": \"K\", \"is_correct\": false}, \"option_B\": {\"text\": \"L\", \"is_correct\": false}, \"option_C\": {\"text\": \"M\", \"is_correct\": false}, \"option_D\": {\"text\": \"N\", \"is_correct\": true}}',1),(138,'C0002-S0001-Q0034','What is the missing number in the series: 1, 8, 27, ___, 125?','{\"option_A\": {\"text\": \"36\", \"is_correct\": false}, \"option_B\": {\"text\": \"64\", \"is_correct\": true}, \"option_C\": {\"text\": \"81\", \"is_correct\": false}, \"option_D\": {\"text\": \"100\", \"is_correct\": false}}',1),(139,'C0002-S0001-Q0035','What is the value of 2³ + 3²?','{\"option_A\": {\"text\": \"17\", \"is_correct\": true}, \"option_B\": {\"text\": \"19\", \"is_correct\": false}, \"option_C\": {\"text\": \"21\", \"is_correct\": false}, \"option_D\": {\"text\": \"23\", \"is_correct\": false}}',1),(140,'C0002-S0001-Q0036','What is the next number in the series: 2, 5, 10, 17, ___?','{\"option_A\": {\"text\": \"22\", \"is_correct\": false}, \"option_B\": {\"text\": \"24\", \"is_correct\": false}, \"option_C\": {\"text\": \"26\", \"is_correct\": true}, \"option_D\": {\"text\": \"28\", \"is_correct\": false}}',1),(141,'C0002-S0001-Q0037','What is the value of 100 ÷ (25 - 5)?','{\"option_A\": {\"text\": \"2\", \"is_correct\": false}, \"option_B\": {\"text\": \"5\", \"is_correct\": true}, \"option_C\": {\"text\": \"10\", \"is_correct\": false}, \"option_D\": {\"text\": \"20\", \"is_correct\": false}}',1),(142,'C0002-S0001-Q0038','What is the next letter in the series: C, F, I, L, ___?','{\"option_A\": {\"text\": \"O\", \"is_correct\": true}, \"option_B\": {\"text\": \"P\", \"is_correct\": false}, \"option_C\": {\"text\": \"Q\", \"is_correct\": false}, \"option_D\": {\"text\": \"R\", \"is_correct\": false}}',1),(143,'C0002-S0001-Q0039','What is the missing number in the series: 3, 9, 27, ___, 243?','{\"option_A\": {\"text\": \"54\", \"is_correct\": false}, \"option_B\": {\"text\": \"72\", \"is_correct\": false}, \"option_C\": {\"text\": \"81\", \"is_correct\": true}, \"option_D\": {\"text\": \"108\", \"is_correct\": false}}',1),(144,'C0002-S0001-Q0040','What is the value of 4³ - 3²?','{\"option_A\": {\"text\": \"55\", \"is_correct\": false}, \"option_B\": {\"text\": \"57\", \"is_correct\": true}, \"option_C\": {\"text\": \"59\", \"is_correct\": false}, \"option_D\": {\"text\": \"61\", \"is_correct\": false}}',1),(145,'C0002-S0001-Q0041','What is the next number in the series: 1, 2, 4, 7, ___?','{\"option_A\": {\"text\": \"9\", \"is_correct\": false}, \"option_B\": {\"text\": \"10\", \"is_correct\": false}, \"option_C\": {\"text\": \"11\", \"is_correct\": false}, \"option_D\": {\"text\": \"12\", \"is_correct\": true}}',1),(146,'C0002-S0001-Q0042','What is the value of 8 × (6 + 4) ÷ 2?','{\"option_A\": {\"text\": \"20\", \"is_correct\": false}, \"option_B\": {\"text\": \"30\", \"is_correct\": false}, \"option_C\": {\"text\": \"40\", \"is_correct\": true}, \"option_D\": {\"text\": \"50\", \"is_correct\": false}}',1),(147,'C0002-S0001-Q0043','What is the next letter in the series: B, E, H, K, ___?','{\"option_A\": {\"text\": \"N\", \"is_correct\": true}, \"option_B\": {\"text\": \"O\", \"is_correct\": false}, \"option_C\": {\"text\": \"P\", \"is_correct\": false}, \"option_D\": {\"text\": \"Q\", \"is_correct\": false}}',1),(148,'C0002-S0001-Q0044','What is the missing number in the series: 5, 10, 20, ___, 80?','{\"option_A\": {\"text\": \"30\", \"is_correct\": false}, \"option_B\": {\"text\": \"40\", \"is_correct\": true}, \"option_C\": {\"text\": \"50\", \"is_correct\": false}, \"option_D\": {\"text\": \"60\", \"is_correct\": false}}',1),(149,'C0002-S0001-Q0045','What is the value of 12 × (15 - 5) ÷ 10?','{\"option_A\": {\"text\": \"10\", \"is_correct\": false}, \"option_B\": {\"text\": \"12\", \"is_correct\": false}, \"option_C\": {\"text\": \"12\", \"is_correct\": true}, \"option_D\": {\"text\": \"14\", \"is_correct\": false}}',1),(150,'C0002-S0001-Q0046','What is the next number in the series: 1, 4, 9, 16, 25, ___?','{\"option_A\": {\"text\": \"30\", \"is_correct\": false}, \"option_B\": {\"text\": \"32\", \"is_correct\": false}, \"option_C\": {\"text\": \"36\", \"is_correct\": false}, \"option_D\": {\"text\": \"36\", \"is_correct\": true}}',1),(151,'C0002-S0001-Q0047','What is the value of 6² + 8²?','{\"option_A\": {\"text\": \"80\", \"is_correct\": false}, \"option_B\": {\"text\": \"100\", \"is_correct\": true}, \"option_C\": {\"text\": \"120\", \"is_correct\": false}, \"option_D\": {\"text\": \"140\", \"is_correct\": false}}',1),(152,'C0002-S0001-Q0048','What is the next letter in the series: D, G, J, M, ___?','{\"option_A\": {\"text\": \"P\", \"is_correct\": true}, \"option_B\": {\"text\": \"Q\", \"is_correct\": false}, \"option_C\": {\"text\": \"R\", \"is_correct\": false}, \"option_D\": {\"text\": \"S\", \"is_correct\": false}}',1),(153,'C0002-S0001-Q0049','What is the missing number in the series: 2, 6, 12, 20, ___, 42?','{\"option_A\": {\"text\": \"24\", \"is_correct\": false}, \"option_B\": {\"text\": \"28\", \"is_correct\": false}, \"option_C\": {\"text\": \"30\", \"is_correct\": true}, \"option_D\": {\"text\": \"32\", \"is_correct\": false}}',1),(154,'C0002-S0001-Q0050','What is the value of 9 × (7 - 3) ÷ 6?','{\"option_A\": {\"text\": \"4\", \"is_correct\": false}, \"option_B\": {\"text\": \"6\", \"is_correct\": true}, \"option_C\": {\"text\": \"8\", \"is_correct\": false}, \"option_D\": {\"text\": \"10\", \"is_correct\": false}}',1),(155,'C0002-S0005-Q0001','What is the primary goal of entrepreneurship?','{\"option_A\": {\"text\": \"To avoid risks\", \"is_correct\": false}, \"option_B\": {\"text\": \"To create value and solve problems\", \"is_correct\": true}, \"option_C\": {\"text\": \"To work for others\", \"is_correct\": false}, \"option_D\": {\"text\": \"To follow traditional career paths\", \"is_correct\": false}}',6),(156,'C0002-S0005-Q0002','Which of the following is a key characteristic of an entrepreneur?','{\"option_A\": {\"text\": \"Fear of failure\", \"is_correct\": false}, \"option_B\": {\"text\": \"Avoidance of innovation\", \"is_correct\": false}, \"option_C\": {\"text\": \"Risk-taking ability\", \"is_correct\": true}, \"option_D\": {\"text\": \"Dependence on others\", \"is_correct\": false}}',6),(157,'C0002-S0005-Q0003','What is a business plan?','{\"option_A\": {\"text\": \"A document outlining business goals and strategies\", \"is_correct\": true}, \"option_B\": {\"text\": \"A financial statement\", \"is_correct\": false}, \"option_C\": {\"text\": \"A marketing campaign\", \"is_correct\": false}, \"option_D\": {\"text\": \"A list of employees\", \"is_correct\": false}}',6),(158,'C0002-S0005-Q0004','What does MVP stand for in entrepreneurship?','{\"option_A\": {\"text\": \"Most Valuable Player\", \"is_correct\": false}, \"option_B\": {\"text\": \"Minimum Viable Product\", \"is_correct\": true}, \"option_C\": {\"text\": \"Maximum Value Proposition\", \"is_correct\": false}, \"option_D\": {\"text\": \"Minimum Viable Profit\", \"is_correct\": false}}',6),(159,'C0002-S0005-Q0005','Which of the following is NOT a type of entrepreneurship?','{\"option_A\": {\"text\": \"Small business entrepreneurship\", \"is_correct\": false}, \"option_B\": {\"text\": \"Scalable startup entrepreneurship\", \"is_correct\": false}, \"option_C\": {\"text\": \"Social entrepreneurship\", \"is_correct\": false}, \"option_D\": {\"text\": \"Corporate employment\", \"is_correct\": true}}',6),(160,'C0002-S0005-Q0006','What is the first step in starting a business?','{\"option_A\": {\"text\": \"Identifying a business idea\", \"is_correct\": true}, \"option_B\": {\"text\": \"Hiring employees\", \"is_correct\": false}, \"option_C\": {\"text\": \"Securing funding\", \"is_correct\": false}, \"option_D\": {\"text\": \"Creating a website\", \"is_correct\": false}}',6),(161,'C0002-S0005-Q0007','What is bootstrapping in entrepreneurship?','{\"option_A\": {\"text\": \"Borrowing money from banks\", \"is_correct\": false}, \"option_B\": {\"text\": \"Raising funds from investors\", \"is_correct\": false}, \"option_C\": {\"text\": \"Self-funding the business\", \"is_correct\": true}, \"option_D\": {\"text\": \"Selling equity to stakeholders\", \"is_correct\": false}}',6),(162,'C0002-S0005-Q0008','Which of the following is an example of a revenue model?','{\"option_A\": {\"text\": \"Social media marketing\", \"is_correct\": false}, \"option_B\": {\"text\": \"Subscription-based pricing\", \"is_correct\": true}, \"option_C\": {\"text\": \"Customer feedback\", \"is_correct\": false}, \"option_D\": {\"text\": \"Employee training\", \"is_correct\": false}}',6),(163,'C0002-S0005-Q0009','What is a target market?','{\"option_A\": {\"text\": \"A specific group of customers a business aims to serve\", \"is_correct\": true}, \"option_B\": {\"text\": \"A list of competitors\", \"is_correct\": false}, \"option_C\": {\"text\": \"A financial goal\", \"is_correct\": false}, \"option_D\": {\"text\": \"A marketing strategy\", \"is_correct\": false}}',6),(164,'C0002-S0005-Q0010','What is the purpose of a SWOT analysis?','{\"option_A\": {\"text\": \"To calculate profits\", \"is_correct\": false}, \"option_B\": {\"text\": \"To hire employees\", \"is_correct\": false}, \"option_C\": {\"text\": \"To design products\", \"is_correct\": false}, \"option_D\": {\"text\": \"To assess strengths, weaknesses, opportunities, and threats\", \"is_correct\": true}}',6),(165,'C0002-S0005-Q0011','Which of the following is a source of funding for startups?','{\"option_A\": {\"text\": \"Customer complaints\", \"is_correct\": false}, \"option_B\": {\"text\": \"Employee salaries\", \"is_correct\": false}, \"option_C\": {\"text\": \"Venture capital\", \"is_correct\": true}, \"option_D\": {\"text\": \"Office supplies\", \"is_correct\": false}}',6),(166,'C0002-S0005-Q0012','What is the role of innovation in entrepreneurship?','{\"option_A\": {\"text\": \"To avoid risks\", \"is_correct\": false}, \"option_B\": {\"text\": \"To create new solutions and improve existing ones\", \"is_correct\": true}, \"option_C\": {\"text\": \"To follow traditional methods\", \"is_correct\": false}, \"option_D\": {\"text\": \"To reduce profits\", \"is_correct\": false}}',6),(167,'C0002-S0005-Q0013','What is a pitch deck?','{\"option_A\": {\"text\": \"A presentation to investors about a business idea\", \"is_correct\": true}, \"option_B\": {\"text\": \"A financial report\", \"is_correct\": false}, \"option_C\": {\"text\": \"A marketing plan\", \"is_correct\": false}, \"option_D\": {\"text\": \"A list of employees\", \"is_correct\": false}}',6),(168,'C0002-S0005-Q0014','What is the break-even point?','{\"option_A\": {\"text\": \"The point where a business starts making a profit\", \"is_correct\": false}, \"option_B\": {\"text\": \"The point where a business shuts down\", \"is_correct\": false}, \"option_C\": {\"text\": \"The point where revenue equals costs\", \"is_correct\": true}, \"option_D\": {\"text\": \"The point where a business expands\", \"is_correct\": false}}',6),(169,'C0002-S0005-Q0015','What is the importance of market research?','{\"option_A\": {\"text\": \"To avoid competition\", \"is_correct\": false}, \"option_B\": {\"text\": \"To increase costs\", \"is_correct\": false}, \"option_C\": {\"text\": \"To ignore customer needs\", \"is_correct\": false}, \"option_D\": {\"text\": \"To understand customer preferences and market trends\", \"is_correct\": true}}',6),(170,'C0002-S0005-Q0016','Which of the following is a legal structure for a business?','{\"option_A\": {\"text\": \"Marketing plan\", \"is_correct\": false}, \"option_B\": {\"text\": \"Limited Liability Company (LLC)\", \"is_correct\": true}, \"option_C\": {\"text\": \"Customer feedback\", \"is_correct\": false}, \"option_D\": {\"text\": \"Employee handbook\", \"is_correct\": false}}',6),(171,'C0002-S0005-Q0017','What is the role of a mentor in entrepreneurship?','{\"option_A\": {\"text\": \"To provide guidance and advice\", \"is_correct\": true}, \"option_B\": {\"text\": \"To fund the business\", \"is_correct\": false}, \"option_C\": {\"text\": \"To manage daily operations\", \"is_correct\": false}, \"option_D\": {\"text\": \"To handle customer complaints\", \"is_correct\": false}}',6),(172,'C0002-S0005-Q0018','What is crowdfunding?','{\"option_A\": {\"text\": \"Borrowing money from banks\", \"is_correct\": false}, \"option_B\": {\"text\": \"Selling equity to investors\", \"is_correct\": false}, \"option_C\": {\"text\": \"Raising small amounts of money from many people\", \"is_correct\": true}, \"option_D\": {\"text\": \"Taking a loan from family\", \"is_correct\": false}}',6),(173,'C0002-S0005-Q0019','What is the difference between a startup and a small business?','{\"option_A\": {\"text\": \"Startups avoid risks\", \"is_correct\": false}, \"option_B\": {\"text\": \"Small businesses focus on rapid growth\", \"is_correct\": false}, \"option_C\": {\"text\": \"Startups have no revenue\", \"is_correct\": false}, \"option_D\": {\"text\": \"Startups aim for rapid growth and scalability\", \"is_correct\": true}}',6),(174,'C0002-S0005-Q0020','What is a unique selling proposition (USP)?','{\"option_A\": {\"text\": \"A feature that makes a product stand out from competitors\", \"is_correct\": true}, \"option_B\": {\"text\": \"A financial statement\", \"is_correct\": false}, \"option_C\": {\"text\": \"A marketing strategy\", \"is_correct\": false}, \"option_D\": {\"text\": \"A list of employees\", \"is_correct\": false}}',6),(175,'C0002-S0005-Q0021','What is the importance of networking in entrepreneurship?','{\"option_A\": {\"text\": \"To avoid competition\", \"is_correct\": false}, \"option_B\": {\"text\": \"To build relationships and gain opportunities\", \"is_correct\": true}, \"option_C\": {\"text\": \"To reduce costs\", \"is_correct\": false}, \"option_D\": {\"text\": \"To ignore market trends\", \"is_correct\": false}}',6),(176,'C0002-S0005-Q0022','What is the role of technology in modern entrepreneurship?','{\"option_A\": {\"text\": \"To increase costs\", \"is_correct\": false}, \"option_B\": {\"text\": \"To avoid innovation\", \"is_correct\": false}, \"option_C\": {\"text\": \"To improve efficiency and reach\", \"is_correct\": true}, \"option_D\": {\"text\": \"To reduce customer engagement\", \"is_correct\": false}}',6),(177,'C0002-S0005-Q0023','What is the meaning of \"scalability\" in business?','{\"option_A\": {\"text\": \"The ability to reduce costs\", \"is_correct\": false}, \"option_B\": {\"text\": \"The ability to avoid risks\", \"is_correct\": false}, \"option_C\": {\"text\": \"The ability to hire more employees\", \"is_correct\": false}, \"option_D\": {\"text\": \"The ability to grow without being hindered by resources\", \"is_correct\": true}}',6),(178,'C0002-S0005-Q0024','What is the purpose of a feasibility study?','{\"option_A\": {\"text\": \"To assess the viability of a business idea\", \"is_correct\": true}, \"option_B\": {\"text\": \"To create a marketing plan\", \"is_correct\": false}, \"option_C\": {\"text\": \"To hire employees\", \"is_correct\": false}, \"option_D\": {\"text\": \"To calculate profits\", \"is_correct\": false}}',6),(179,'C0002-S0005-Q0025','What is the difference between revenue and profit?','{\"option_A\": {\"text\": \"Revenue is the total income, while profit is the income after expenses\", \"is_correct\": false}, \"option_B\": {\"text\": \"Revenue is the income after expenses, while profit is the total income\", \"is_correct\": true}, \"option_C\": {\"text\": \"Revenue and profit are the same\", \"is_correct\": false}, \"option_D\": {\"text\": \"Revenue is a cost, while profit is income\", \"is_correct\": false}}',6),(180,'C0002-S0005-Q0026','What is the role of customer feedback in entrepreneurship?','{\"option_A\": {\"text\": \"To ignore customer needs\", \"is_correct\": false}, \"option_B\": {\"text\": \"To increase costs\", \"is_correct\": false}, \"option_C\": {\"text\": \"To improve products and services\", \"is_correct\": true}, \"option_D\": {\"text\": \"To reduce innovation\", \"is_correct\": false}}',6),(181,'C0002-S0005-Q0027','What is a competitive advantage?','{\"option_A\": {\"text\": \"A factor that makes a business better than its competitors\", \"is_correct\": true}, \"option_B\": {\"text\": \"A financial statement\", \"is_correct\": false}, \"option_C\": {\"text\": \"A marketing strategy\", \"is_correct\": false}, \"option_D\": {\"text\": \"A list of employees\", \"is_correct\": false}}',6),(182,'C0002-S0005-Q0028','What is the importance of branding in business?','{\"option_A\": {\"text\": \"To reduce costs\", \"is_correct\": false}, \"option_B\": {\"text\": \"To avoid competition\", \"is_correct\": false}, \"option_C\": {\"text\": \"To ignore customer needs\", \"is_correct\": false}, \"option_D\": {\"text\": \"To create a unique identity and build trust\", \"is_correct\": true}}',6),(183,'C0002-S0005-Q0029','What is the role of social media in entrepreneurship?','{\"option_A\": {\"text\": \"To avoid customer engagement\", \"is_correct\": false}, \"option_B\": {\"text\": \"To promote products and engage with customers\", \"is_correct\": true}, \"option_C\": {\"text\": \"To reduce innovation\", \"is_correct\": false}, \"option_D\": {\"text\": \"To increase costs\", \"is_correct\": false}}',6),(184,'C0002-S0005-Q0030','What is the meaning of \"pivot\" in entrepreneurship?','{\"option_A\": {\"text\": \"To avoid risks\", \"is_correct\": false}, \"option_B\": {\"text\": \"To stick to the original plan\", \"is_correct\": false}, \"option_C\": {\"text\": \"To change the business strategy\", \"is_correct\": true}, \"option_D\": {\"text\": \"To shut down the business\", \"is_correct\": false}}',6),(185,'C0002-S0005-Q0031','What is the importance of financial planning in entrepreneurship?','{\"option_A\": {\"text\": \"To manage resources and achieve goals\", \"is_correct\": true}, \"option_B\": {\"text\": \"To ignore costs\", \"is_correct\": false}, \"option_C\": {\"text\": \"To avoid profits\", \"is_correct\": false}, \"option_D\": {\"text\": \"To reduce innovation\", \"is_correct\": false}}',6),(186,'C0002-S0005-Q0032','What is the role of a business incubator?','{\"option_A\": {\"text\": \"To provide funding only\", \"is_correct\": false}, \"option_B\": {\"text\": \"To support startups with resources and mentorship\", \"is_correct\": true}, \"option_C\": {\"text\": \"To manage daily operations\", \"is_correct\": false}, \"option_D\": {\"text\": \"To handle customer complaints\", \"is_correct\": false}}',6),(187,'C0002-S0005-Q0033','What is the difference between a leader and a manager?','{\"option_A\": {\"text\": \"A leader avoids risks, while a manager takes risks\", \"is_correct\": false}, \"option_B\": {\"text\": \"A leader focuses on tasks, while a manager focuses on people\", \"is_correct\": false}, \"option_C\": {\"text\": \"A leader and a manager are the same\", \"is_correct\": false}, \"option_D\": {\"text\": \"A leader inspires, while a manager organizes\", \"is_correct\": true}}',6),(188,'C0002-S0005-Q0034','What is the importance of a mission statement?','{\"option_A\": {\"text\": \"To define the purpose and goals of a business\", \"is_correct\": true}, \"option_B\": {\"text\": \"To list employees\", \"is_correct\": false}, \"option_C\": {\"text\": \"To calculate profits\", \"is_correct\": false}, \"option_D\": {\"text\": \"To ignore customer needs\", \"is_correct\": false}}',6),(189,'C0002-S0005-Q0035','What is the role of intellectual property in entrepreneurship?','{\"option_A\": {\"text\": \"To avoid innovation\", \"is_correct\": false}, \"option_B\": {\"text\": \"To increase costs\", \"is_correct\": false}, \"option_C\": {\"text\": \"To protect ideas and inventions\", \"is_correct\": true}, \"option_D\": {\"text\": \"To reduce profits\", \"is_correct\": false}}',6),(190,'C0002-S0005-Q0036','What is the meaning of \"disruption\" in business?','{\"option_A\": {\"text\": \"To follow traditional methods\", \"is_correct\": false}, \"option_B\": {\"text\": \"To introduce innovations that change the market\", \"is_correct\": true}, \"option_C\": {\"text\": \"To avoid risks\", \"is_correct\": false}, \"option_D\": {\"text\": \"To reduce profits\", \"is_correct\": false}}',6),(191,'C0002-S0005-Q0037','What is the importance of teamwork in entrepreneurship?','{\"option_A\": {\"text\": \"To avoid collaboration\", \"is_correct\": false}, \"option_B\": {\"text\": \"To increase costs\", \"is_correct\": false}, \"option_C\": {\"text\": \"To ignore ideas\", \"is_correct\": false}, \"option_D\": {\"text\": \"To achieve common goals and foster innovation\", \"is_correct\": true}}',6),(192,'C0002-S0005-Q0038','What is the role of ethics in entrepreneurship?','{\"option_A\": {\"text\": \"To build trust and maintain a good reputation\", \"is_correct\": true}, \"option_B\": {\"text\": \"To ignore customer needs\", \"is_correct\": false}, \"option_C\": {\"text\": \"To increase costs\", \"is_correct\": false}, \"option_D\": {\"text\": \"To reduce innovation\", \"is_correct\": false}}',6),(193,'C0002-S0005-Q0039','What is the meaning of \"cash flow\" in business?','{\"option_A\": {\"text\": \"The total revenue of a business\", \"is_correct\": false}, \"option_B\": {\"text\": \"The total profit of a business\", \"is_correct\": false}, \"option_C\": {\"text\": \"The movement of money in and out of a business\", \"is_correct\": true}, \"option_D\": {\"text\": \"The total costs of a business\", \"is_correct\": false}}',6),(194,'C0002-S0005-Q0040','What is the importance of adaptability in entrepreneurship?','{\"option_A\": {\"text\": \"To avoid changes\", \"is_correct\": false}, \"option_B\": {\"text\": \"To respond to market changes and challenges\", \"is_correct\": true}, \"option_C\": {\"text\": \"To ignore customer needs\", \"is_correct\": false}, \"option_D\": {\"text\": \"To reduce innovation\", \"is_correct\": false}}',6),(195,'C0002-S0005-Q0041','What is the role of a business model canvas?','{\"option_A\": {\"text\": \"To visualize and plan a business model\", \"is_correct\": true}, \"option_B\": {\"text\": \"To calculate profits\", \"is_correct\": false}, \"option_C\": {\"text\": \"To hire employees\", \"is_correct\": false}, \"option_D\": {\"text\": \"To ignore market trends\", \"is_correct\": false}}',6),(196,'C0002-S0005-Q0042','What is the meaning of \"valuation\" in startups?','{\"option_A\": {\"text\": \"The total costs of a business\", \"is_correct\": false}, \"option_B\": {\"text\": \"The total revenue of a business\", \"is_correct\": false}, \"option_C\": {\"text\": \"The total profit of a business\", \"is_correct\": false}, \"option_D\": {\"text\": \"The estimated worth of a business\", \"is_correct\": true}}',6),(197,'C0002-S0005-Q0043','What is the importance of customer retention?','{\"option_A\": {\"text\": \"To ignore customer needs\", \"is_correct\": false}, \"option_B\": {\"text\": \"To increase costs\", \"is_correct\": false}, \"option_C\": {\"text\": \"To build long-term relationships and increase revenue\", \"is_correct\": true}, \"option_D\": {\"text\": \"To reduce innovation\", \"is_correct\": false}}',6),(198,'C0002-S0005-Q0044','What is the role of a prototype in product development?','{\"option_A\": {\"text\": \"To test and refine a product idea\", \"is_correct\": true}, \"option_B\": {\"text\": \"To calculate profits\", \"is_correct\": false}, \"option_C\": {\"text\": \"To hire employees\", \"is_correct\": false}, \"option_D\": {\"text\": \"To ignore customer feedback\", \"is_correct\": false}}',6),(199,'C0002-S0005-Q0045','What is the meaning of \"ROI\" in business?','{\"option_A\": {\"text\": \"Return on Innovation\", \"is_correct\": false}, \"option_B\": {\"text\": \"Return on Investment\", \"is_correct\": true}, \"option_C\": {\"text\": \"Return on Income\", \"is_correct\": false}, \"option_D\": {\"text\": \"Return on Interest\", \"is_correct\": false}}',6),(200,'C0002-S0005-Q0046','What is the importance of time management in entrepreneurship?','{\"option_A\": {\"text\": \"To avoid tasks\", \"is_correct\": false}, \"option_B\": {\"text\": \"To increase costs\", \"is_correct\": false}, \"option_C\": {\"text\": \"To ignore deadlines\", \"is_correct\": false}, \"option_D\": {\"text\": \"To prioritize tasks and achieve goals\", \"is_correct\": true}}',6),(201,'C0002-S0005-Q0047','What is the role of a stakeholder in a business?','{\"option_A\": {\"text\": \"A person or group with an interest in the business\", \"is_correct\": true}, \"option_B\": {\"text\": \"A competitor\", \"is_correct\": false}, \"option_C\": {\"text\": \"A customer only\", \"is_correct\": false}, \"option_D\": {\"text\": \"An employee only\", \"is_correct\": false}}',6),(202,'C0002-S0005-Q0048','What is the meaning of \"burn rate\" in startups?','{\"option_A\": {\"text\": \"The rate of customer acquisition\", \"is_correct\": false}, \"option_B\": {\"text\": \"The rate of profit generation\", \"is_correct\": false}, \"option_C\": {\"text\": \"The rate at which a company spends money\", \"is_correct\": true}, \"option_D\": {\"text\": \"The rate of employee turnover\", \"is_correct\": false}}',6),(203,'C0002-S0005-Q0049','What is the importance of a competitive analysis?','{\"option_A\": {\"text\": \"To ignore competitors\", \"is_correct\": false}, \"option_B\": {\"text\": \"To understand competitors and identify opportunities\", \"is_correct\": true}, \"option_C\": {\"text\": \"To increase costs\", \"is_correct\": false}, \"option_D\": {\"text\": \"To reduce innovation\", \"is_correct\": false}}',6),(204,'C0002-S0005-Q0050','What is the role of a vision statement in business?','{\"option_A\": {\"text\": \"To outline the long-term goals and aspirations of a business\", \"is_correct\": true}, \"option_B\": {\"text\": \"To list employees\", \"is_correct\": false}, \"option_C\": {\"text\": \"To calculate profits\", \"is_correct\": false}, \"option_D\": {\"text\": \"To ignore customer needs\", \"is_correct\": false}}',6),(205,'C0001-S0002-Q0001','What is the primary goal of DevOps?','{\"option_A\": {\"text\": \"Increased security\", \"is_correct\": false}, \"option_B\": {\"text\": \"Faster software delivery\", \"is_correct\": false}, \"option_C\": {\"text\": \"Better documentation\", \"is_correct\": true}, \"option_D\": {\"text\": \"Lower development costs\", \"is_correct\": false}}',7),(206,'C0001-S0002-Q0002','Which tool is commonly used for configuration management in DevOps?','{\"option_A\": {\"text\": \"Jenkins\", \"is_correct\": false}, \"option_B\": {\"text\": \"Kubernetes\", \"is_correct\": true}, \"option_C\": {\"text\": \"Ansible\", \"is_correct\": false}, \"option_D\": {\"text\": \"Docker\", \"is_correct\": false}}',7),(207,'C0001-S0002-Q0003','What is CI/CD in DevOps?','{\"option_A\": {\"text\": \"Code Isolation & Continuous Deployment\", \"is_correct\": true}, \"option_B\": {\"text\": \"Centralized Integration & Continuous Deployment\", \"is_correct\": false}, \"option_C\": {\"text\": \"Code Integration & Centralized Development\", \"is_correct\": false}, \"option_D\": {\"text\": \"Continuous Integration & Continuous Deployment\", \"is_correct\": false}}',7),(208,'C0001-S0002-Q0004','Which version control system is most commonly used in DevOps?','{\"option_A\": {\"text\": \"Mercurial\", \"is_correct\": false}, \"option_B\": {\"text\": \"SVN\", \"is_correct\": true}, \"option_C\": {\"text\": \"Perforce\", \"is_correct\": false}, \"option_D\": {\"text\": \"Git\", \"is_correct\": false}}',7),(209,'C0001-S0002-Q0005','Which tool is used for container orchestration?','{\"option_A\": {\"text\": \"Jenkins\", \"is_correct\": true}, \"option_B\": {\"text\": \"Terraform\", \"is_correct\": false}, \"option_C\": {\"text\": \"Kubernetes\", \"is_correct\": false}, \"option_D\": {\"text\": \"Docker\", \"is_correct\": false}}',7),(210,'C0001-S0002-Q0006','What is the main purpose of Infrastructure as Code (IaC)?','{\"option_A\": {\"text\": \"Automate testing\", \"is_correct\": false}, \"option_B\": {\"text\": \"Monitor applications\", \"is_correct\": false}, \"option_C\": {\"text\": \"Automate infrastructure provisioning\", \"is_correct\": true}, \"option_D\": {\"text\": \"Manage security policies\", \"is_correct\": false}}',7),(211,'C0001-S0002-Q0007','Which tool is mainly used for continuous integration?','{\"option_A\": {\"text\": \"Docker\", \"is_correct\": true}, \"option_B\": {\"text\": \"Ansible\", \"is_correct\": false}, \"option_C\": {\"text\": \"Jenkins\", \"is_correct\": false}, \"option_D\": {\"text\": \"Terraform\", \"is_correct\": false}}',7),(212,'C0001-S0002-Q0008','What does \'Blue-Green Deployment\' refer to?','{\"option_A\": {\"text\": \"CI/CD pipeline\", \"is_correct\": false}, \"option_B\": {\"text\": \"Zero-downtime deployment strategy\", \"is_correct\": false}, \"option_C\": {\"text\": \"Testing framework\", \"is_correct\": true}, \"option_D\": {\"text\": \"Network partitioning method\", \"is_correct\": false}}',7),(213,'C0001-S0002-Q0009','Which cloud platform provides a DevOps service called \'Azure DevOps\'?','{\"option_A\": {\"text\": \"AWS\", \"is_correct\": false}, \"option_B\": {\"text\": \"IBM Cloud\", \"is_correct\": false}, \"option_C\": {\"text\": \"Google Cloud\", \"is_correct\": false}, \"option_D\": {\"text\": \"Microsoft Azure\", \"is_correct\": true}}',7),(214,'C0001-S0002-Q0010','What is a \'pod\' in Kubernetes?','{\"option_A\": {\"text\": \"A type of server\", \"is_correct\": true}, \"option_B\": {\"text\": \"A group of one or more containers\", \"is_correct\": false}, \"option_C\": {\"text\": \"A database cluster\", \"is_correct\": false}, \"option_D\": {\"text\": \"A monitoring tool\", \"is_correct\": false}}',7),(215,'C0001-S0002-Q0011','Which tool is used for infrastructure as code (IaC)?','{\"option_A\": {\"text\": \"Jenkins\", \"is_correct\": false}, \"option_B\": {\"text\": \"Docker\", \"is_correct\": false}, \"option_C\": {\"text\": \"Terraform\", \"is_correct\": true}, \"option_D\": {\"text\": \"Git\", \"is_correct\": false}}',7),(216,'C0001-S0002-Q0012','What is the main purpose of Helm in Kubernetes?','{\"option_A\": {\"text\": \"Package management\", \"is_correct\": true}, \"option_B\": {\"text\": \"Load balancing\", \"is_correct\": false}, \"option_C\": {\"text\": \"Monitoring\", \"is_correct\": false}, \"option_D\": {\"text\": \"Security enforcement\", \"is_correct\": false}}',7),(217,'C0001-S0002-Q0013','Which command is used to create a new branch in Git?','{\"option_A\": {\"text\": \"git branch new_branch\", \"is_correct\": false}, \"option_B\": {\"text\": \"git new-branch\", \"is_correct\": false}, \"option_C\": {\"text\": \"git checkout new_branch\", \"is_correct\": false}, \"option_D\": {\"text\": \"git checkout -b new_branch\", \"is_correct\": true}}',7),(218,'C0001-S0002-Q0014','Which of the following is a popular log management tool in DevOps?','{\"option_A\": {\"text\": \"Docker\", \"is_correct\": false}, \"option_B\": {\"text\": \"ELK Stack\", \"is_correct\": true}, \"option_C\": {\"text\": \"Kubernetes\", \"is_correct\": false}, \"option_D\": {\"text\": \"Jenkins\", \"is_correct\": false}}',7),(219,'C0001-S0002-Q0015','Which cloud platform provides Elastic Beanstalk for deployment?','{\"option_A\": {\"text\": \"AWS\", \"is_correct\": true}, \"option_B\": {\"text\": \"Azure\", \"is_correct\": false}, \"option_C\": {\"text\": \"Google Cloud\", \"is_correct\": false}, \"option_D\": {\"text\": \"IBM Cloud\", \"is_correct\": false}}',7),(220,'C0001-S0002-Q0016','What is the primary function of a service mesh in Kubernetes?','{\"option_A\": {\"text\": \"Load balancing\", \"is_correct\": false}, \"option_B\": {\"text\": \"Storage management\", \"is_correct\": false}, \"option_C\": {\"text\": \"Traffic control and security\", \"is_correct\": true}, \"option_D\": {\"text\": \"CI/CD pipeline automation\", \"is_correct\": false}}',7),(221,'C0001-S0002-Q0017','In a CI/CD pipeline, what does \'Continuous Integration\' primarily refer to?','{\"option_A\": {\"text\": \"Automatic deployment\", \"is_correct\": false}, \"option_B\": {\"text\": \"Frequent merging of code changes\", \"is_correct\": true}, \"option_C\": {\"text\": \"Automated infrastructure provisioning\", \"is_correct\": false}, \"option_D\": {\"text\": \"Code review automation\", \"is_correct\": false}}',7),(222,'C0001-S0002-Q0018','Which tool is commonly used for container runtime?','{\"option_A\": {\"text\": \"Jenkins\", \"is_correct\": false}, \"option_B\": {\"text\": \"Terraform\", \"is_correct\": false}, \"option_C\": {\"text\": \"Ansible\", \"is_correct\": false}, \"option_D\": {\"text\": \"Docker\", \"is_correct\": true}}',7),(223,'C0001-S0002-Q0019','Which of the following is NOT a DevOps practice?','{\"option_A\": {\"text\": \"Infrastructure as Code\", \"is_correct\": false}, \"option_B\": {\"text\": \"Monitoring and Logging\", \"is_correct\": false}, \"option_C\": {\"text\": \"Manual software deployment\", \"is_correct\": true}, \"option_D\": {\"text\": \"Continuous Integration\", \"is_correct\": false}}',7),(224,'C0001-S0002-Q0020','Which Kubernetes object is responsible for managing containerized applications?','{\"option_A\": {\"text\": \"ConfigMap\", \"is_correct\": false}, \"option_B\": {\"text\": \"Pod\", \"is_correct\": true}, \"option_C\": {\"text\": \"Ingress\", \"is_correct\": false}, \"option_D\": {\"text\": \"Namespace\", \"is_correct\": false}}',7),(225,'C0001-S0002-Q0021','Which tool is used for security scanning of container images?','{\"option_A\": {\"text\": \"Prometheus\", \"is_correct\": false}, \"option_B\": {\"text\": \"Terraform\", \"is_correct\": false}, \"option_C\": {\"text\": \"ELK Stack\", \"is_correct\": false}, \"option_D\": {\"text\": \"Trivy\", \"is_correct\": true}}',7),(226,'C0001-S0002-Q0022','Which component in Kubernetes assigns a stable network identity to pods?','{\"option_A\": {\"text\": \"Deployment\", \"is_correct\": false}, \"option_B\": {\"text\": \"Service\", \"is_correct\": false}, \"option_C\": {\"text\": \"Ingress\", \"is_correct\": true}, \"option_D\": {\"text\": \"ReplicaSet\", \"is_correct\": false}}',7),(227,'C0001-S0002-Q0023','What is the purpose of a \'sidecar\' container in Kubernetes?','{\"option_A\": {\"text\": \"Supporting the main container\", \"is_correct\": true}, \"option_B\": {\"text\": \"Handling database queries\", \"is_correct\": false}, \"option_C\": {\"text\": \"Managing pod storage\", \"is_correct\": false}, \"option_D\": {\"text\": \"Security hardening\", \"is_correct\": false}}',7),(228,'C0001-S0002-Q0024','Which of the following is a key principle of GitOps?','{\"option_A\": {\"text\": \"Manually deploying code\", \"is_correct\": false}, \"option_B\": {\"text\": \"Declarative infrastructure management\", \"is_correct\": true}, \"option_C\": {\"text\": \"Using only Git for deployment\", \"is_correct\": false}, \"option_D\": {\"text\": \"CI/CD pipelines\", \"is_correct\": false}}',7),(229,'C0001-S0002-Q0025','What does Canary Deployment help with?','{\"option_A\": {\"text\": \"Full application rollback\", \"is_correct\": false}, \"option_B\": {\"text\": \"Version control\", \"is_correct\": false}, \"option_C\": {\"text\": \"Gradual release to reduce risks\", \"is_correct\": true}, \"option_D\": {\"text\": \"Cluster management\", \"is_correct\": false}}',7),(230,'C0001-S0002-Q0026','What is the function of Prometheus in DevOps?','{\"option_A\": {\"text\": \"Monitoring and alerting\", \"is_correct\": true}, \"option_B\": {\"text\": \"CI/CD automation\", \"is_correct\": false}, \"option_C\": {\"text\": \"Infrastructure as code\", \"is_correct\": false}, \"option_D\": {\"text\": \"Container runtime\", \"is_correct\": false}}',7),(231,'C0001-S0002-Q0027','Which component in Kubernetes schedules workloads on nodes?','{\"option_A\": {\"text\": \"Controller Manager\", \"is_correct\": false}, \"option_B\": {\"text\": \"Kube-Scheduler\", \"is_correct\": true}, \"option_C\": {\"text\": \"Kube-Proxy\", \"is_correct\": false}, \"option_D\": {\"text\": \"Pod Autoscaler\", \"is_correct\": false}}',7),(232,'C0001-S0002-Q0028','Which tool is used for automating cloud infrastructure provisioning?','{\"option_A\": {\"text\": \"Docker\", \"is_correct\": false}, \"option_B\": {\"text\": \"Kubernetes\", \"is_correct\": false}, \"option_C\": {\"text\": \"Jenkins\", \"is_correct\": false}, \"option_D\": {\"text\": \"Terraform\", \"is_correct\": true}}',7),(233,'C0001-S0002-Q0029','What does the ‘docker-compose up’ command do?','{\"option_A\": {\"text\": \"Stops all running containers\", \"is_correct\": false}, \"option_B\": {\"text\": \"Lists all running containers\", \"is_correct\": false}, \"option_C\": {\"text\": \"Starts and runs all defined services\", \"is_correct\": true}, \"option_D\": {\"text\": \"Deletes all containers\", \"is_correct\": false}}',7),(234,'C0001-S0002-Q0030','What is the primary function of a Reverse Proxy in DevOps?','{\"option_A\": {\"text\": \"Load balancing\", \"is_correct\": false}, \"option_B\": {\"text\": \"Security enforcement\", \"is_correct\": false}, \"option_C\": {\"text\": \"Traffic routing\", \"is_correct\": true}, \"option_D\": {\"text\": \"Database management\", \"is_correct\": false}}',7),(235,'C0001-S0002-Q0031','Which of the following is a popular CI/CD tool?','{\"option_A\": {\"text\": \"Terraform\", \"is_correct\": false}, \"option_B\": {\"text\": \"Docker\", \"is_correct\": false}, \"option_C\": {\"text\": \"Kubernetes\", \"is_correct\": false}, \"option_D\": {\"text\": \"Jenkins\", \"is_correct\": true}}',7),(236,'C0001-S0002-Q0032','What does \'Infrastructure as Code\' (IaC) mean?','{\"option_A\": {\"text\": \"Manually configuring infrastructure\", \"is_correct\": false}, \"option_B\": {\"text\": \"Managing infrastructure using code\", \"is_correct\": true}, \"option_C\": {\"text\": \"Using containers for infrastructure\", \"is_correct\": false}, \"option_D\": {\"text\": \"Automating CI/CD pipelines\", \"is_correct\": false}}',7),(237,'C0001-S0002-Q0033','Which of the following is NOT a cloud service model?','{\"option_A\": {\"text\": \"DaaS\", \"is_correct\": true}, \"option_B\": {\"text\": \"IaaS\", \"is_correct\": false}, \"option_C\": {\"text\": \"PaaS\", \"is_correct\": false}, \"option_D\": {\"text\": \"SaaS\", \"is_correct\": false}}',7),(238,'C0001-S0002-Q0034','Which Kubernetes component is responsible for maintaining the desired state of objects?','{\"option_A\": {\"text\": \"Kubelet\", \"is_correct\": false}, \"option_B\": {\"text\": \"Scheduler\", \"is_correct\": false}, \"option_C\": {\"text\": \"Controller Manager\", \"is_correct\": true}, \"option_D\": {\"text\": \"Kube-Proxy\", \"is_correct\": false}}',7),(239,'C0001-S0002-Q0035','What does a Blue-Green Deployment strategy help prevent?','{\"option_A\": {\"text\": \"Security breaches\", \"is_correct\": false}, \"option_B\": {\"text\": \"Downtime during deployment\", \"is_correct\": true}, \"option_C\": {\"text\": \"Infrastructure failures\", \"is_correct\": false}, \"option_D\": {\"text\": \"Data corruption\", \"is_correct\": false}}',7),(240,'C0001-S0002-Q0036','Which of the following is a configuration management tool?','{\"option_A\": {\"text\": \"Docker\", \"is_correct\": false}, \"option_B\": {\"text\": \"Terraform\", \"is_correct\": false}, \"option_C\": {\"text\": \"Kubernetes\", \"is_correct\": false}, \"option_D\": {\"text\": \"Ansible\", \"is_correct\": true}}',7),(241,'C0001-S0002-Q0037','Which tool is widely used for monitoring Kubernetes clusters?','{\"option_A\": {\"text\": \"Prometheus\", \"is_correct\": true}, \"option_B\": {\"text\": \"Jenkins\", \"is_correct\": false}, \"option_C\": {\"text\": \"ELK Stack\", \"is_correct\": false}, \"option_D\": {\"text\": \"Grafana\", \"is_correct\": false}}',7),(242,'C0001-S0002-Q0038','What is the main purpose of an Artifact Repository in DevOps?','{\"option_A\": {\"text\": \"Logging and monitoring\", \"is_correct\": false}, \"option_B\": {\"text\": \"Orchestrating containers\", \"is_correct\": false}, \"option_C\": {\"text\": \"Storing and managing build artifacts\", \"is_correct\": true}, \"option_D\": {\"text\": \"Automating security policies\", \"is_correct\": false}}',7),(243,'C0001-S0002-Q0039','What is the default storage driver for Docker on Linux?','{\"option_A\": {\"text\": \"AUFS\", \"is_correct\": false}, \"option_B\": {\"text\": \"Btrfs\", \"is_correct\": false}, \"option_C\": {\"text\": \"OverlayFS\", \"is_correct\": false}, \"option_D\": {\"text\": \"Overlay2\", \"is_correct\": true}}',7),(244,'C0001-S0002-Q0040','Which Kubernetes object is used to configure secrets?','{\"option_A\": {\"text\": \"ConfigMap\", \"is_correct\": false}, \"option_B\": {\"text\": \"Secret\", \"is_correct\": true}, \"option_C\": {\"text\": \"Ingress\", \"is_correct\": false}, \"option_D\": {\"text\": \"Service\", \"is_correct\": false}}',7),(245,'C0001-S0002-Q0041','In Git, what does \'git rebase\' do?','{\"option_A\": {\"text\": \"Moves a branch to a new base commit\", \"is_correct\": true}, \"option_B\": {\"text\": \"Deletes commit history\", \"is_correct\": false}, \"option_C\": {\"text\": \"Creates a new branch\", \"is_correct\": false}, \"option_D\": {\"text\": \"Merges changes without conflicts\", \"is_correct\": false}}',7),(246,'C0001-S0002-Q0042','Which of the following is NOT a key principle of Site Reliability Engineering (SRE)?','{\"option_A\": {\"text\": \"Automation\", \"is_correct\": false}, \"option_B\": {\"text\": \"Monitoring\", \"is_correct\": false}, \"option_C\": {\"text\": \"Manual interventions\", \"is_correct\": true}, \"option_D\": {\"text\": \"Error Budgets\", \"is_correct\": false}}',7),(247,'C0001-S0002-Q0043','What is the main purpose of Canary Deployments?','{\"option_A\": {\"text\": \"Scaling applications\", \"is_correct\": false}, \"option_B\": {\"text\": \"Automated rollback\", \"is_correct\": false}, \"option_C\": {\"text\": \"Traffic routing\", \"is_correct\": false}, \"option_D\": {\"text\": \"Gradual release to a subset of users\", \"is_correct\": true}}',7),(248,'C0001-S0002-Q0044','Which command is used to delete a pod in Kubernetes?','{\"option_A\": {\"text\": \"kubectl delete pod <pod-name>\", \"is_correct\": true}, \"option_B\": {\"text\": \"kubectl remove pod <pod-name>\", \"is_correct\": false}, \"option_C\": {\"text\": \"kubectl destroy pod <pod-name>\", \"is_correct\": false}, \"option_D\": {\"text\": \"kubectl erase pod <pod-name>\", \"is_correct\": false}}',7),(249,'C0001-S0002-Q0045','What is the primary role of a Load Balancer?','{\"option_A\": {\"text\": \"Handling database transactions\", \"is_correct\": false}, \"option_B\": {\"text\": \"Deploying applications\", \"is_correct\": false}, \"option_C\": {\"text\": \"Distributing traffic evenly across servers\", \"is_correct\": true}, \"option_D\": {\"text\": \"Managing CI/CD pipelines\", \"is_correct\": false}}',7),(250,'C0001-S0002-Q0046','What does GitHub Actions primarily help with?','{\"option_A\": {\"text\": \"Cloud storage\", \"is_correct\": false}, \"option_B\": {\"text\": \"Automating workflows and CI/CD\", \"is_correct\": true}, \"option_C\": {\"text\": \"Managing containers\", \"is_correct\": false}, \"option_D\": {\"text\": \"Running Kubernetes clusters\", \"is_correct\": false}}',7),(251,'C0001-S0002-Q0047','Which AWS service provides managed Kubernetes?','{\"option_A\": {\"text\": \"Lambda\", \"is_correct\": false}, \"option_B\": {\"text\": \"S3\", \"is_correct\": false}, \"option_C\": {\"text\": \"EC2\", \"is_correct\": false}, \"option_D\": {\"text\": \"EKS\", \"is_correct\": true}}',7),(252,'C0001-S0002-Q0048','What does \'kubectl get pods\' command do?','{\"option_A\": {\"text\": \"Lists all running pods\", \"is_correct\": true}, \"option_B\": {\"text\": \"Deletes all pods\", \"is_correct\": false}, \"option_C\": {\"text\": \"Scales a pod\", \"is_correct\": false}, \"option_D\": {\"text\": \"Creates a new pod\", \"is_correct\": false}}',7),(253,'C0001-S0003-Q0001','What does \'cybersecurity\' primarily aim to protect?','{\"option_A\": {\"text\": \"Cars\", \"is_correct\": false}, \"option_B\": {\"text\": \"Computers and networks\", \"is_correct\": true}, \"option_C\": {\"text\": \"Furniture\", \"is_correct\": false}, \"option_D\": {\"text\": \"Food\", \"is_correct\": false}}',8),(254,'C0001-S0003-Q0002','What is a strong password?','{\"option_A\": {\"text\": \"12345678\", \"is_correct\": false}, \"option_B\": {\"text\": \"Your name\", \"is_correct\": false}, \"option_C\": {\"text\": \"A mix of uppercase, lowercase, numbers, and symbols\", \"is_correct\": true}, \"option_D\": {\"text\": \"Only alphabets\", \"is_correct\": false}}',8),(255,'C0001-S0003-Q0003','What does \'phishing\' mean in cybersecurity?','{\"option_A\": {\"text\": \"A type of fish\", \"is_correct\": false}, \"option_B\": {\"text\": \"A method to catch hackers\", \"is_correct\": false}, \"option_C\": {\"text\": \"Fraudulent attempts to obtain sensitive information\", \"is_correct\": true}, \"option_D\": {\"text\": \"Sending messages in code\", \"is_correct\": false}}',8),(256,'C0001-S0003-Q0004','Which of the following is NOT a cyber threat?','{\"option_A\": {\"text\": \"Virus\", \"is_correct\": false}, \"option_B\": {\"text\": \"Trojan\", \"is_correct\": false}, \"option_C\": {\"text\": \"Firewall\", \"is_correct\": true}, \"option_D\": {\"text\": \"Ransomware\", \"is_correct\": false}}',8),(257,'C0001-S0003-Q0005','Which organization sets global security standards for the internet?','{\"option_A\": {\"text\": \"WHO\", \"is_correct\": false}, \"option_B\": {\"text\": \"ISO\", \"is_correct\": true}, \"option_C\": {\"text\": \"FIFA\", \"is_correct\": false}, \"option_D\": {\"text\": \"NASA\", \"is_correct\": false}}',8),(258,'C0001-S0003-Q0006','Which of the following is an example of two-factor authentication?','{\"option_A\": {\"text\": \"Password only\", \"is_correct\": false}, \"option_B\": {\"text\": \"Username and password\", \"is_correct\": false}, \"option_C\": {\"text\": \"Password + OTP on mobile\", \"is_correct\": true}, \"option_D\": {\"text\": \"Only fingerprint\", \"is_correct\": false}}',8),(259,'C0001-S0003-Q0007','What is the purpose of a firewall?','{\"option_A\": {\"text\": \"To clean the computer\", \"is_correct\": false}, \"option_B\": {\"text\": \"To block unauthorized access\", \"is_correct\": true}, \"option_C\": {\"text\": \"To increase internet speed\", \"is_correct\": false}, \"option_D\": {\"text\": \"To store passwords\", \"is_correct\": false}}',8),(260,'C0001-S0003-Q0008','Which type of attack locks files and demands payment to unlock them?','{\"option_A\": {\"text\": \"Phishing\", \"is_correct\": false}, \"option_B\": {\"text\": \"Ransomware\", \"is_correct\": true}, \"option_C\": {\"text\": \"DDoS\", \"is_correct\": false}, \"option_D\": {\"text\": \"Spyware\", \"is_correct\": false}}',8),(261,'C0001-S0003-Q0009','What should you do when receiving a suspicious email?','{\"option_A\": {\"text\": \"Open it immediately\", \"is_correct\": false}, \"option_B\": {\"text\": \"Click all links\", \"is_correct\": false}, \"option_C\": {\"text\": \"Delete it or report as spam\", \"is_correct\": true}, \"option_D\": {\"text\": \"Reply with personal information\", \"is_correct\": false}}',8),(262,'C0001-S0003-Q0010','Which of the following is an example of social engineering?','{\"option_A\": {\"text\": \"Guessing passwords\", \"is_correct\": false}, \"option_B\": {\"text\": \"Tricking people into revealing passwords\", \"is_correct\": true}, \"option_C\": {\"text\": \"Sending spam emails\", \"is_correct\": false}, \"option_D\": {\"text\": \"Stealing credit card numbers online\", \"is_correct\": false}}',8),(263,'C0001-S0003-Q0011','What does VPN stand for?','{\"option_A\": {\"text\": \"Virtual Private Network\", \"is_correct\": true}, \"option_B\": {\"text\": \"Virtual Personal Node\", \"is_correct\": false}, \"option_C\": {\"text\": \"Verified Protected Network\", \"is_correct\": false}, \"option_D\": {\"text\": \"Virus Protection Node\", \"is_correct\": false}}',8),(264,'C0001-S0003-Q0012','Which of these is a secure way to store passwords?','{\"option_A\": {\"text\": \"Writing on paper\", \"is_correct\": false}, \"option_B\": {\"text\": \"Saving in browser\", \"is_correct\": false}, \"option_C\": {\"text\": \"Using a password manager\", \"is_correct\": true}, \"option_D\": {\"text\": \"Sending them via email\", \"is_correct\": false}}',8),(265,'C0001-S0003-Q0013','Which protocol is used to secure websites?','{\"option_A\": {\"text\": \"HTTP\", \"is_correct\": false}, \"option_B\": {\"text\": \"HTTPS\", \"is_correct\": true}, \"option_C\": {\"text\": \"FTP\", \"is_correct\": false}, \"option_D\": {\"text\": \"SMTP\", \"is_correct\": false}}',8),(266,'C0001-S0003-Q0014','What does an antivirus software do?','{\"option_A\": {\"text\": \"Speeds up the computer\", \"is_correct\": false}, \"option_B\": {\"text\": \"Removes or blocks malicious software\", \"is_correct\": true}, \"option_C\": {\"text\": \"Prevents overheating\", \"is_correct\": false}, \"option_D\": {\"text\": \"Repairs hardware\", \"is_correct\": false}}',8),(267,'C0001-S0003-Q0015','Which type of malware can replicate itself?','{\"option_A\": {\"text\": \"Worm\", \"is_correct\": true}, \"option_B\": {\"text\": \"Spyware\", \"is_correct\": false}, \"option_C\": {\"text\": \"Adware\", \"is_correct\": false}, \"option_D\": {\"text\": \"Trojan\", \"is_correct\": false}}',8),(268,'C0001-S0003-Q0016','What does \'DDoS\' stand for?','{\"option_A\": {\"text\": \"Dynamic Data on Security\", \"is_correct\": false}, \"option_B\": {\"text\": \"Distributed Denial of Service\", \"is_correct\": true}, \"option_C\": {\"text\": \"Double Defense of Security\", \"is_correct\": false}, \"option_D\": {\"text\": \"Digital Data on Server\", \"is_correct\": false}}',8),(269,'C0001-S0003-Q0017','What is a Zero-Day attack?','{\"option_A\": {\"text\": \"An attack on zero software\", \"is_correct\": false}, \"option_B\": {\"text\": \"An attack before the software vendor provides a fix\", \"is_correct\": true}, \"option_C\": {\"text\": \"An attack after software update\", \"is_correct\": false}, \"option_D\": {\"text\": \"An attack on outdated systems\", \"is_correct\": false}}',8),(270,'C0001-S0003-Q0018','Which is an example of biometric authentication?','{\"option_A\": {\"text\": \"Password\", \"is_correct\": false}, \"option_B\": {\"text\": \"Fingerprint scan\", \"is_correct\": true}, \"option_C\": {\"text\": \"CAPTCHA\", \"is_correct\": false}, \"option_D\": {\"text\": \"Security question\", \"is_correct\": false}}',8),(271,'C0001-S0003-Q0019','What does SQL Injection target?','{\"option_A\": {\"text\": \"Web applications\' databases\", \"is_correct\": true}, \"option_B\": {\"text\": \"Operating systems\", \"is_correct\": false}, \"option_C\": {\"text\": \"Network routers\", \"is_correct\": false}, \"option_D\": {\"text\": \"Mobile apps\", \"is_correct\": false}}',8),(272,'C0001-S0003-Q0020','What is the main purpose of penetration testing?','{\"option_A\": {\"text\": \"To test website speed\", \"is_correct\": false}, \"option_B\": {\"text\": \"To find and fix security vulnerabilities\", \"is_correct\": true}, \"option_C\": {\"text\": \"To update antivirus software\", \"is_correct\": false}, \"option_D\": {\"text\": \"To remove unnecessary files\", \"is_correct\": false}}',8),(273,'C0001-S0003-Q0021','Which of these is a type of cybercrime?','{\"option_A\": {\"text\": \"Online shopping\", \"is_correct\": false}, \"option_B\": {\"text\": \"Hacking\", \"is_correct\": true}, \"option_C\": {\"text\": \"Blogging\", \"is_correct\": false}, \"option_D\": {\"text\": \"Software installation\", \"is_correct\": false}}',8),(274,'C0001-S0003-Q0022','Which of the following is a strong encryption algorithm?','{\"option_A\": {\"text\": \"RSA\", \"is_correct\": true}, \"option_B\": {\"text\": \"ROT13\", \"is_correct\": false}, \"option_C\": {\"text\": \"Base64\", \"is_correct\": false}, \"option_D\": {\"text\": \"MD5\", \"is_correct\": false}}',8),(275,'C0001-S0003-Q0023','Which law protects digital privacy in the EU?','{\"option_A\": {\"text\": \"GDPR\", \"is_correct\": true}, \"option_B\": {\"text\": \"PCI DSS\", \"is_correct\": false}, \"option_C\": {\"text\": \"HIPAA\", \"is_correct\": false}, \"option_D\": {\"text\": \"CCPA\", \"is_correct\": false}}',8),(276,'C0001-S0003-Q0024','What is a honeypot in cybersecurity?','{\"option_A\": {\"text\": \"A tool to store passwords\", \"is_correct\": false}, \"option_B\": {\"text\": \"A decoy system to attract hackers\", \"is_correct\": true}, \"option_C\": {\"text\": \"A virus scanner\", \"is_correct\": false}, \"option_D\": {\"text\": \"A password manager\", \"is_correct\": false}}',8),(277,'C0001-S0003-Q0025','Which of the following can help prevent brute force attacks?','{\"option_A\": {\"text\": \"Simple passwords\", \"is_correct\": false}, \"option_B\": {\"text\": \"Password length of 6 characters\", \"is_correct\": false}, \"option_C\": {\"text\": \"Account lockout policies\", \"is_correct\": true}, \"option_D\": {\"text\": \"Turning off the firewall\", \"is_correct\": false}}',8),(278,'C0001-S0003-Q0026','Which attack intercepts communication between two parties?','{\"option_A\": {\"text\": \"Phishing\", \"is_correct\": false}, \"option_B\": {\"text\": \"Man-in-the-Middle (MITM) attack\", \"is_correct\": true}, \"option_C\": {\"text\": \"SQL Injection\", \"is_correct\": false}, \"option_D\": {\"text\": \"Brute force\", \"is_correct\": false}}',8),(279,'C0001-S0003-Q0027','Which of these is an example of a cyber-physical attack?','{\"option_A\": {\"text\": \"Ransomware\", \"is_correct\": false}, \"option_B\": {\"text\": \"Hacking a power grid\", \"is_correct\": true}, \"option_C\": {\"text\": \"Phishing\", \"is_correct\": false}, \"option_D\": {\"text\": \"Spamming\", \"is_correct\": false}}',8),(280,'C0001-S0003-Q0028','Which type of attack uses fake Wi-Fi networks?','{\"option_A\": {\"text\": \"Evil Twin attack\", \"is_correct\": true}, \"option_B\": {\"text\": \"Man-in-the-Middle\", \"is_correct\": false}, \"option_C\": {\"text\": \"SQL Injection\", \"is_correct\": false}, \"option_D\": {\"text\": \"Spam attack\", \"is_correct\": false}}',8),(281,'C0001-S0003-Q0029','What is the first step in an incident response plan?','{\"option_A\": {\"text\": \"Eradication\", \"is_correct\": false}, \"option_B\": {\"text\": \"Containment\", \"is_correct\": false}, \"option_C\": {\"text\": \"Identification\", \"is_correct\": true}, \"option_D\": {\"text\": \"Recovery\", \"is_correct\": false}}',8),(282,'C0001-S0003-Q0030','Which of these is NOT a cyber threat?','{\"option_A\": {\"text\": \"Trojan horse\", \"is_correct\": false}, \"option_B\": {\"text\": \"Spyware\", \"is_correct\": false}, \"option_C\": {\"text\": \"Firewall\", \"is_correct\": true}, \"option_D\": {\"text\": \"Ransomware\", \"is_correct\": false}}',8),(283,'C0001-S0003-Q0031','Which type of malware disguises itself as legitimate software?','{\"option_A\": {\"text\": \"Spyware\", \"is_correct\": false}, \"option_B\": {\"text\": \"Ransomware\", \"is_correct\": false}, \"option_C\": {\"text\": \"Worm\", \"is_correct\": false}, \"option_D\": {\"text\": \"Trojan\", \"is_correct\": true}}',8),(284,'C0001-S0003-Q0032','What is the purpose of ethical hacking?','{\"option_A\": {\"text\": \"To test website performance\", \"is_correct\": false}, \"option_B\": {\"text\": \"To identify and fix security vulnerabilities\", \"is_correct\": true}, \"option_C\": {\"text\": \"To create viruses\", \"is_correct\": false}, \"option_D\": {\"text\": \"To install malware on systems\", \"is_correct\": false}}',8),(285,'C0001-S0003-Q0033','Which encryption method uses two keys: a public key and a private key?','{\"option_A\": {\"text\": \"Asymmetric encryption\", \"is_correct\": true}, \"option_B\": {\"text\": \"Symmetric encryption\", \"is_correct\": false}, \"option_C\": {\"text\": \"Digital Signature\", \"is_correct\": false}, \"option_D\": {\"text\": \"One-time pad encryption\", \"is_correct\": false}}',8),(286,'C0001-S0003-Q0034','What is the function of an Intrusion Detection System (IDS)?','{\"option_A\": {\"text\": \"To prevent unauthorized access\", \"is_correct\": false}, \"option_B\": {\"text\": \"To detect unauthorized access\", \"is_correct\": true}, \"option_C\": {\"text\": \"To recover from cyberattacks\", \"is_correct\": false}, \"option_D\": {\"text\": \"To block all network traffic\", \"is_correct\": false}}',8),(287,'C0001-S0003-Q0035','What is steganography in cybersecurity?','{\"option_A\": {\"text\": \"Hiding messages within images\", \"is_correct\": true}, \"option_B\": {\"text\": \"Using passwords with encryption\", \"is_correct\": false}, \"option_C\": {\"text\": \"Encrypting messages\", \"is_correct\": false}, \"option_D\": {\"text\": \"Cracking passwords\", \"is_correct\": false}}',8),(288,'C0001-S0003-Q0036','Which security model is based on least privilege and need-to-know principles?','{\"option_A\": {\"text\": \"Public Key Infrastructure\", \"is_correct\": false}, \"option_B\": {\"text\": \"Bell-LaPadula Model\", \"is_correct\": false}, \"option_C\": {\"text\": \"Zero Trust Model\", \"is_correct\": true}, \"option_D\": {\"text\": \"Biometric Authentication\", \"is_correct\": false}}',8),(289,'C0001-S0003-Q0037','Which of the following is a characteristic of Advanced Persistent Threats (APTs)?','{\"option_A\": {\"text\": \"Short-lived cyber threats\", \"is_correct\": false}, \"option_B\": {\"text\": \"Targeted and persistent attacks\", \"is_correct\": false}, \"option_C\": {\"text\": \"Low-level security threats\", \"is_correct\": true}, \"option_D\": {\"text\": \"Common in small cyber crimes\", \"is_correct\": false}}',8),(290,'C0001-S0003-Q0038','Which attack exploits vulnerabilities in memory management?','{\"option_A\": {\"text\": \"DDoS attack\", \"is_correct\": true}, \"option_B\": {\"text\": \"SQL Injection\", \"is_correct\": false}, \"option_C\": {\"text\": \"Man-in-the-Middle attack\", \"is_correct\": false}, \"option_D\": {\"text\": \"Cross-site scripting (XSS)\", \"is_correct\": false}}',8),(291,'C0001-S0003-Q0039','What is the main goal of a buffer overflow attack?','{\"option_A\": {\"text\": \"To prevent phishing\", \"is_correct\": true}, \"option_B\": {\"text\": \"To crash the system\", \"is_correct\": false}, \"option_C\": {\"text\": \"To steal personal data\", \"is_correct\": false}, \"option_D\": {\"text\": \"To make software more efficient\", \"is_correct\": false}}',8),(292,'C0001-S0003-Q0040','What is the primary risk of using outdated software?','{\"option_A\": {\"text\": \"Better user experience\", \"is_correct\": false}, \"option_B\": {\"text\": \"Increased system performance\", \"is_correct\": true}, \"option_C\": {\"text\": \"Protection from hackers\", \"is_correct\": false}, \"option_D\": {\"text\": \"Better firewall security\", \"is_correct\": false}}',8),(293,'C0001-S0003-Q0041','What is the purpose of a botnet?','{\"option_A\": {\"text\": \"To increase network security\", \"is_correct\": false}, \"option_B\": {\"text\": \"DDoS attack coordination\", \"is_correct\": false}, \"option_C\": {\"text\": \"To prevent phishing emails\", \"is_correct\": true}, \"option_D\": {\"text\": \"To create a peer-to-peer network\", \"is_correct\": false}}',8),(294,'C0001-S0003-Q0042','What is cryptojacking?','{\"option_A\": {\"text\": \"Unauthorized cryptocurrency mining\", \"is_correct\": true}, \"option_B\": {\"text\": \"Using IoT devices to mine crypto\", \"is_correct\": false}, \"option_C\": {\"text\": \"A type of phishing attack\", \"is_correct\": false}, \"option_D\": {\"text\": \"Spamming users with crypto ads\", \"is_correct\": false}}',8),(295,'C0001-S0003-Q0043','Which protocol is used for secure email communication?','{\"option_A\": {\"text\": \"IMAP\", \"is_correct\": false}, \"option_B\": {\"text\": \"SMTP\", \"is_correct\": true}, \"option_C\": {\"text\": \"POP3\", \"is_correct\": false}, \"option_D\": {\"text\": \"HTTPS\", \"is_correct\": false}}',8),(296,'C0001-S0003-Q0044','What is a side-channel attack?','{\"option_A\": {\"text\": \"A method to exploit browser vulnerabilities\", \"is_correct\": false}, \"option_B\": {\"text\": \"An attack that exploits indirect data access\", \"is_correct\": false}, \"option_C\": {\"text\": \"An attack that modifies email headers\", \"is_correct\": true}, \"option_D\": {\"text\": \"An attack using AI to generate responses\", \"is_correct\": false}}',8),(297,'C0001-S0003-Q0045','Which of these is NOT a principle of information security?','{\"option_A\": {\"text\": \"Authentication\", \"is_correct\": false}, \"option_B\": {\"text\": \"Non-repudiation\", \"is_correct\": false}, \"option_C\": {\"text\": \"Encryption\", \"is_correct\": false}, \"option_D\": {\"text\": \"Hashing\", \"is_correct\": true}}',8),(298,'C0001-S0003-Q0046','What does the CIA Triad stand for in cybersecurity?','{\"option_A\": {\"text\": \"Confidentiality, Integrity, Availability\", \"is_correct\": false}, \"option_B\": {\"text\": \"Connectivity, Intelligence, Accessibility\", \"is_correct\": true}, \"option_C\": {\"text\": \"Detection, Prevention, Response\", \"is_correct\": false}, \"option_D\": {\"text\": \"Authorization, Encryption, Backup\", \"is_correct\": false}}',8),(299,'C0001-S0003-Q0047','Which security mechanism prevents replay attacks?','{\"option_A\": {\"text\": \"Use of firewalls\", \"is_correct\": false}, \"option_B\": {\"text\": \"Use of one-time passwords\", \"is_correct\": false}, \"option_C\": {\"text\": \"Timestamping\", \"is_correct\": true}, \"option_D\": {\"text\": \"Random number generation\", \"is_correct\": false}}',8),(300,'C0001-S0003-Q0048','What is the purpose of multi-factor authentication (MFA)?','{\"option_A\": {\"text\": \"To encrypt data\", \"is_correct\": true}, \"option_B\": {\"text\": \"To verify user identity\", \"is_correct\": false}, \"option_C\": {\"text\": \"To bypass authentication\", \"is_correct\": false}, \"option_D\": {\"text\": \"To replace password security\", \"is_correct\": false}}',8),(301,'C0001-S0003-Q0049','Which cybersecurity framework is widely used by organizations?','{\"option_A\": {\"text\": \"GDPR\", \"is_correct\": false}, \"option_B\": {\"text\": \"NIST\", \"is_correct\": true}, \"option_C\": {\"text\": \"ISO 27001\", \"is_correct\": false}, \"option_D\": {\"text\": \"COBIT\", \"is_correct\": false}}',8),(302,'C0001-S0003-Q0050','What is the role of a Security Information and Event Management (SIEM) system?','{\"option_A\": {\"text\": \"To monitor only physical security threats\", \"is_correct\": false}, \"option_B\": {\"text\": \"To track security incidents and logs\", \"is_correct\": false}, \"option_C\": {\"text\": \"To analyze and respond to security threats\", \"is_correct\": true}, \"option_D\": {\"text\": \"To strengthen firewall security\", \"is_correct\": false}}',8),(303,'C0001-S0003-Q0051','What is a watering hole attack?','{\"option_A\": {\"text\": \"An attack on water resources\", \"is_correct\": true}, \"option_B\": {\"text\": \"Targeting users on social media\", \"is_correct\": false}, \"option_C\": {\"text\": \"Infecting users via a popular website\", \"is_correct\": false}, \"option_D\": {\"text\": \"An attack targeting cloud databases\", \"is_correct\": false}}',8),(304,'C0001-S0003-Q0052','What type of malware records keystrokes?','{\"option_A\": {\"text\": \"Trojan\", \"is_correct\": false}, \"option_B\": {\"text\": \"Keylogger\", \"is_correct\": true}, \"option_C\": {\"text\": \"Spyware\", \"is_correct\": false}, \"option_D\": {\"text\": \"Adware\", \"is_correct\": false}}',8),(305,'C0001-S0003-Q0053','What is the main function of a sandbox in cybersecurity?','{\"option_A\": {\"text\": \"To destroy a computer\", \"is_correct\": false}, \"option_B\": {\"text\": \"To install viruses\", \"is_correct\": false}, \"option_C\": {\"text\": \"To analyze suspicious programs\", \"is_correct\": false}, \"option_D\": {\"text\": \"To bypass firewalls\", \"is_correct\": true}}',8),(306,'C0001-S0003-Q0054','Which attack manipulates users into divulging confidential information?','{\"option_A\": {\"text\": \"Brute force attack\", \"is_correct\": false}, \"option_B\": {\"text\": \"Man-in-the-Middle attack\", \"is_correct\": false}, \"option_C\": {\"text\": \"Phishing\", \"is_correct\": true}, \"option_D\": {\"text\": \"Social Engineering\", \"is_correct\": false}}',8),(307,'C0001-S0003-Q0055','What is a polymorphic virus?','{\"option_A\": {\"text\": \"A virus that deletes itself\", \"is_correct\": false}, \"option_B\": {\"text\": \"A virus that constantly changes its code\", \"is_correct\": true}, \"option_C\": {\"text\": \"A virus that can change its form\", \"is_correct\": false}, \"option_D\": {\"text\": \"A virus that steals credentials\", \"is_correct\": false}}',8),(308,'C0001-S0003-Q0056','Which of these is an example of a supply chain attack?','{\"option_A\": {\"text\": \"Phishing attack via email\", \"is_correct\": true}, \"option_B\": {\"text\": \"Tampering with software updates\", \"is_correct\": false}, \"option_C\": {\"text\": \"Intercepting supply chain communications\", \"is_correct\": false}, \"option_D\": {\"text\": \"Hacking a cloud service provider\", \"is_correct\": false}}',8),(309,'C0001-S0003-Q0057','What is the primary goal of a rootkit?','{\"option_A\": {\"text\": \"To enhance security\", \"is_correct\": false}, \"option_B\": {\"text\": \"To remove malware\", \"is_correct\": false}, \"option_C\": {\"text\": \"To hide unauthorized access\", \"is_correct\": true}, \"option_D\": {\"text\": \"To remove encryption\", \"is_correct\": false}}',8),(310,'C0001-S0003-Q0058','What does a digital signature ensure?','{\"option_A\": {\"text\": \"Provides confidentiality only\", \"is_correct\": false}, \"option_B\": {\"text\": \"Ensures message integrity and authentication\", \"is_correct\": false}, \"option_C\": {\"text\": \"Provides anonymity\", \"is_correct\": false}, \"option_D\": {\"text\": \"Ensures availability of a message\", \"is_correct\": true}}',8),(311,'C0001-S0003-Q0059','Which attack targets Wi-Fi networks by guessing WPA keys?','{\"option_A\": {\"text\": \"Brute force attack\", \"is_correct\": false}, \"option_B\": {\"text\": \"MITM attack\", \"is_correct\": true}, \"option_C\": {\"text\": \"Rogue AP attack\", \"is_correct\": false}, \"option_D\": {\"text\": \"DNS spoofing\", \"is_correct\": false}}',8);
/*!40000 ALTER TABLE `examportol_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examportol_subject`
--

DROP TABLE IF EXISTS `examportol_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `examportol_subject` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `subject_code` varchar(15) DEFAULT NULL,
  `subject_name` varchar(255) NOT NULL,
  `subject_category_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subject_code` (`subject_code`),
  KEY `examportol_subject_subject_category_id_f1c6afe2_fk_examporto` (`subject_category_id`),
  CONSTRAINT `examportol_subject_subject_category_id_f1c6afe2_fk_examporto` FOREIGN KEY (`subject_category_id`) REFERENCES `examportol_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examportol_subject`
--

LOCK TABLES `examportol_subject` WRITE;
/*!40000 ALTER TABLE `examportol_subject` DISABLE KEYS */;
INSERT INTO `examportol_subject` VALUES (1,'C0002-S0001','Aptitute',2),(2,'C0002-S0002','Human resource',2),(3,'C0001-S0001','SQL',1),(4,'C0002-S0003','Digital Marketing',2),(5,'C0002-S0004','Operation Handling',2),(6,'C0002-S0005','Entrepreneurship',2),(7,'C0001-S0002','DevOps',1),(8,'C0001-S0003','Cyber Security',1);
/*!40000 ALTER TABLE `examportol_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobportol_job`
--

DROP TABLE IF EXISTS `jobportol_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobportol_job` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `company_logo` varchar(100) NOT NULL,
  `profile` varchar(255) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `location_state` varchar(100) NOT NULL,
  `location_city` varchar(100) NOT NULL,
  `min_experience` int NOT NULL,
  `max_experience` int NOT NULL,
  `package_min` double NOT NULL,
  `package_max` double NOT NULL,
  `employment_types` json NOT NULL,
  `about_job` longtext NOT NULL,
  `job_id` varchar(10) NOT NULL,
  `qualification` longtext NOT NULL,
  `posted_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `job_id` (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobportol_job`
--

LOCK TABLES `jobportol_job` WRITE;
/*!40000 ALTER TABLE `jobportol_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobportol_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_collegesdb`
--

DROP TABLE IF EXISTS `oauth_collegesdb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_collegesdb` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `college_name` varchar(255) NOT NULL,
  `college_location` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_collegesdb`
--

LOCK TABLES `oauth_collegesdb` WRITE;
/*!40000 ALTER TABLE `oauth_collegesdb` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_collegesdb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_otpdb`
--

DROP TABLE IF EXISTS `oauth_otpdb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_otpdb` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `otp_count` int NOT NULL,
  `otp` int DEFAULT NULL,
  `timestamp` datetime(6) NOT NULL,
  `status` int NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `oauth_otpdb_user_id_44bf7dcf_uniq` (`user_id`),
  CONSTRAINT `oauth_otpdb_user_id_44bf7dcf_fk_oauth_usersdb_id` FOREIGN KEY (`user_id`) REFERENCES `oauth_usersdb` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_otpdb`
--

LOCK TABLES `oauth_otpdb` WRITE;
/*!40000 ALTER TABLE `oauth_otpdb` DISABLE KEYS */;
INSERT INTO `oauth_otpdb` VALUES (1,3,889763,'2025-02-28 07:05:26.229988',1,2);
/*!40000 ALTER TABLE `oauth_otpdb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_usersdb`
--

DROP TABLE IF EXISTS `oauth_usersdb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_usersdb` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `course` varchar(255) NOT NULL,
  `dob` date NOT NULL,
  `referral_code` varchar(50) DEFAULT NULL,
  `username` varchar(10) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `google_id` varchar(255) DEFAULT NULL,
  `github_id` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `college_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone_number` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_usersdb`
--

LOCK TABLES `oauth_usersdb` WRITE;
/*!40000 ALTER TABLE `oauth_usersdb` DISABLE KEYS */;
INSERT INTO `oauth_usersdb` VALUES (1,'rathi','alpha@rathitech.me',NULL,'pbkdf2_sha256$870000$NAYzOtxdJuzVVOTqTCvJgH$O8659kygCypMWW0RhnTy21DYi/GSux0nyQls5wo9z+4=','Unknown Course','2000-01-01',NULL,'USR00001','2025-03-03 07:15:33.252008','other',NULL,NULL,1,1,1,'Unknown College'),(2,'Sameer Parmar','sameerparmar.sp@gmail.com','5852216950','pbkdf2_sha256$870000$kliFZU9fUpmxAvRIxhddBh$hEAmALvT2Q0WBXVI8O3nhMItLnDG5NkzG464zbGs6CM=','Unknown Course','2000-01-01',NULL,'USR00002','2025-03-03 05:48:14.357526','other',NULL,NULL,1,0,0,'Unknown College');
/*!40000 ALTER TABLE `oauth_usersdb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_usersdb_groups`
--

DROP TABLE IF EXISTS `oauth_usersdb_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_usersdb_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `usersdb_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `oauth_usersdb_groups_usersdb_id_group_id_d4e39df8_uniq` (`usersdb_id`,`group_id`),
  KEY `oauth_usersdb_groups_group_id_a8f55087_fk_auth_group_id` (`group_id`),
  CONSTRAINT `oauth_usersdb_groups_group_id_a8f55087_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `oauth_usersdb_groups_usersdb_id_16c44729_fk_oauth_usersdb_id` FOREIGN KEY (`usersdb_id`) REFERENCES `oauth_usersdb` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_usersdb_groups`
--

LOCK TABLES `oauth_usersdb_groups` WRITE;
/*!40000 ALTER TABLE `oauth_usersdb_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_usersdb_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_usersdb_user_permissions`
--

DROP TABLE IF EXISTS `oauth_usersdb_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_usersdb_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `usersdb_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `oauth_usersdb_user_permi_usersdb_id_permission_id_745f0138_uniq` (`usersdb_id`,`permission_id`),
  KEY `oauth_usersdb_user_p_permission_id_67c9016e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `oauth_usersdb_user_p_permission_id_67c9016e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `oauth_usersdb_user_p_usersdb_id_e610ce0c_fk_oauth_use` FOREIGN KEY (`usersdb_id`) REFERENCES `oauth_usersdb` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_usersdb_user_permissions`
--

LOCK TABLES `oauth_usersdb_user_permissions` WRITE;
/*!40000 ALTER TABLE `oauth_usersdb_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_usersdb_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `placement_stories_placementstories`
--

DROP TABLE IF EXISTS `placement_stories_placementstories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `placement_stories_placementstories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `user_profile_pic` varchar(100) DEFAULT NULL,
  `hand_written_review` varchar(100) DEFAULT NULL,
  `company_name` varchar(100) NOT NULL,
  `designation` varchar(100) NOT NULL,
  `package` int NOT NULL,
  `batch` varchar(100) NOT NULL,
  `degree` varchar(100) NOT NULL,
  `branch` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `placement_stories_placementstories`
--

LOCK TABLES `placement_stories_placementstories` WRITE;
/*!40000 ALTER TABLE `placement_stories_placementstories` DISABLE KEYS */;
/*!40000 ALTER TABLE `placement_stories_placementstories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `price_plantype`
--

DROP TABLE IF EXISTS `price_plantype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `price_plantype` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `display_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price_plantype`
--

LOCK TABLES `price_plantype` WRITE;
/*!40000 ALTER TABLE `price_plantype` DISABLE KEYS */;
INSERT INTO `price_plantype` VALUES (1,'montlhy','monthly'),(2,'basic','basic');
/*!40000 ALTER TABLE `price_plantype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `price_subscriptionplan`
--

DROP TABLE IF EXISTS `price_subscriptionplan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `price_subscriptionplan` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `price` decimal(10,2) NOT NULL,
  `duration_in_months` int NOT NULL,
  `features` json NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `discount` decimal(5,2) NOT NULL,
  `plan_type_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `price_subscriptionpl_plan_type_id_5cef54a8_fk_price_pla` (`plan_type_id`),
  CONSTRAINT `price_subscriptionpl_plan_type_id_5cef54a8_fk_price_pla` FOREIGN KEY (`plan_type_id`) REFERENCES `price_plantype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price_subscriptionplan`
--

LOCK TABLES `price_subscriptionplan` WRITE;
/*!40000 ALTER TABLE `price_subscriptionplan` DISABLE KEYS */;
INSERT INTO `price_subscriptionplan` VALUES (1,0.00,1,'{\"jobs\": \"Explore and apply to jobs/Internships\", \"study\": \"Limited access to Study material\", \"compiler\": \"Compiler one time\", \"practice\": \"Cannot attend Practice Questions\", \"visibility\": \"Basic profile visibility to recruiters\"}',1,0.00,2),(2,299.00,1,'{\"jobs\": \"Explore and apply to jobs/Internships\", \"study\": \"Limited access to Study material\", \"compiler\": \"Compiler tentime\", \"practice\": \"Cannot attend Practice Questions\", \"visibility\": \"Basic profile visibility to recruiters\"}',1,10.00,1);
/*!40000 ALTER TABLE `price_subscriptionplan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialaccount`
--

DROP TABLE IF EXISTS `socialaccount_socialaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialaccount` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider` varchar(200) NOT NULL,
  `uid` varchar(191) NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `extra_data` json NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialaccount_provider_uid_fc810c6e_uniq` (`provider`,`uid`),
  KEY `socialaccount_socialaccount_user_id_8146e70c_fk_oauth_usersdb_id` (`user_id`),
  CONSTRAINT `socialaccount_socialaccount_user_id_8146e70c_fk_oauth_usersdb_id` FOREIGN KEY (`user_id`) REFERENCES `oauth_usersdb` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialaccount`
--

LOCK TABLES `socialaccount_socialaccount` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialaccount` DISABLE KEYS */;
INSERT INTO `socialaccount_socialaccount` VALUES (1,'Google','114100297514272700577','2025-03-03 05:48:14.311342','2025-03-03 05:48:14.311356','{\"aud\": \"95136928080-r4ugkbf8cj0gc24n6khok0npd1qfpfne.apps.googleusercontent.com\", \"azp\": \"95136928080-r4ugkbf8cj0gc24n6khok0npd1qfpfne.apps.googleusercontent.com\", \"exp\": 1740984486, \"iat\": 1740980886, \"iss\": \"https://accounts.google.com\", \"sub\": \"114100297514272700577\", \"name\": \"Sameer Parmar\", \"email\": \"sameerparmar.sp@gmail.com\", \"at_hash\": \"ht5SvGWanNaqyoKQmh8X1w\", \"picture\": \"https://lh3.googleusercontent.com/a/ACg8ocIc4HfUVSqevZhAVNMX5tBxYXwVWdUv0zSEfij5UYcT4NxhnxmGcA=s96-c\", \"given_name\": \"Sameer\", \"family_name\": \"Parmar\", \"email_verified\": true}',2);
/*!40000 ALTER TABLE `socialaccount_socialaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialapp`
--

DROP TABLE IF EXISTS `socialaccount_socialapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialapp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) NOT NULL,
  `name` varchar(40) NOT NULL,
  `client_id` varchar(191) NOT NULL,
  `secret` varchar(191) NOT NULL,
  `key` varchar(191) NOT NULL,
  `provider_id` varchar(200) NOT NULL,
  `settings` json NOT NULL DEFAULT (_utf8mb3'{}'),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialapp`
--

LOCK TABLES `socialaccount_socialapp` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialapp` DISABLE KEYS */;
INSERT INTO `socialaccount_socialapp` VALUES (1,'google','Google oAuth','95136928080-r4ugkbf8cj0gc24n6khok0npd1qfpfne.apps.googleusercontent.com','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','','Google','{}'),(2,'github','Github','Ov23lipOZxF0RmLtECYl','d9f437035cf6a11ef9d4648dcc0fba9ff918ed59','','Github','{}');
/*!40000 ALTER TABLE `socialaccount_socialapp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialapp_sites`
--

DROP TABLE IF EXISTS `socialaccount_socialapp_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialapp_sites` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `socialapp_id` int NOT NULL,
  `site_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialapp_sites_socialapp_id_site_id_71a9a768_uniq` (`socialapp_id`,`site_id`),
  KEY `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` (`site_id`),
  CONSTRAINT `socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc` FOREIGN KEY (`socialapp_id`) REFERENCES `socialaccount_socialapp` (`id`),
  CONSTRAINT `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialapp_sites`
--

LOCK TABLES `socialaccount_socialapp_sites` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialapp_sites` DISABLE KEYS */;
INSERT INTO `socialaccount_socialapp_sites` VALUES (1,1,1),(2,1,2),(3,2,1),(4,2,2);
/*!40000 ALTER TABLE `socialaccount_socialapp_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialtoken`
--

DROP TABLE IF EXISTS `socialaccount_socialtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialtoken` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` longtext NOT NULL,
  `token_secret` longtext NOT NULL,
  `expires_at` datetime(6) DEFAULT NULL,
  `account_id` int NOT NULL,
  `app_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq` (`app_id`,`account_id`),
  KEY `socialaccount_social_account_id_951f210e_fk_socialacc` (`account_id`),
  CONSTRAINT `socialaccount_social_account_id_951f210e_fk_socialacc` FOREIGN KEY (`account_id`) REFERENCES `socialaccount_socialaccount` (`id`),
  CONSTRAINT `socialaccount_social_app_id_636a42d7_fk_socialacc` FOREIGN KEY (`app_id`) REFERENCES `socialaccount_socialapp` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialtoken`
--

LOCK TABLES `socialaccount_socialtoken` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialtoken` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-03 13:03:34
