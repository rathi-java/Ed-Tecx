-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: Ed_tecx
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
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can view permission',1,'view_permission'),(5,'Can add group',2,'add_group'),(6,'Can change group',2,'change_group'),(7,'Can delete group',2,'delete_group'),(8,'Can view group',2,'view_group'),(9,'Can add content type',3,'add_contenttype'),(10,'Can change content type',3,'change_contenttype'),(11,'Can delete content type',3,'delete_contenttype'),(12,'Can view content type',3,'view_contenttype'),(13,'Can add code submission',4,'add_codesubmission'),(14,'Can change code submission',4,'change_codesubmission'),(15,'Can delete code submission',4,'delete_codesubmission'),(16,'Can view code submission',4,'view_codesubmission'),(17,'Can add students db',5,'add_studentsdb'),(18,'Can change students db',5,'change_studentsdb'),(19,'Can delete students db',5,'delete_studentsdb'),(20,'Can view students db',5,'view_studentsdb'),(21,'Can add category',6,'add_category'),(22,'Can change category',6,'change_category'),(23,'Can delete category',6,'delete_category'),(24,'Can view category',6,'view_category'),(25,'Can add subject',7,'add_subject'),(26,'Can change subject',7,'change_subject'),(27,'Can delete subject',7,'delete_subject'),(28,'Can view subject',7,'view_subject'),(29,'Can add question',8,'add_question'),(30,'Can change question',8,'change_question'),(31,'Can delete question',8,'delete_question'),(32,'Can view question',8,'view_question'),(33,'Can add exam result',9,'add_examresult'),(34,'Can change exam result',9,'change_examresult'),(35,'Can delete exam result',9,'delete_examresult'),(36,'Can view exam result',9,'view_examresult'),(37,'Can add placement stories',10,'add_placementstories'),(38,'Can change placement stories',10,'change_placementstories'),(39,'Can delete placement stories',10,'delete_placementstories'),(40,'Can view placement stories',10,'view_placementstories'),(41,'Can add job',11,'add_job'),(42,'Can change job',11,'change_job'),(43,'Can delete job',11,'delete_job'),(44,'Can view job',11,'view_job'),(45,'Can add colleges db',12,'add_collegesdb'),(46,'Can change colleges db',12,'change_collegesdb'),(47,'Can delete colleges db',12,'delete_collegesdb'),(48,'Can view colleges db',12,'view_collegesdb'),(49,'Can add users db',13,'add_usersdb'),(50,'Can change users db',13,'change_usersdb'),(51,'Can delete users db',13,'delete_usersdb'),(52,'Can view users db',13,'view_usersdb'),(53,'Can add otpdb',14,'add_otpdb'),(54,'Can change otpdb',14,'change_otpdb'),(55,'Can delete otpdb',14,'delete_otpdb'),(56,'Can view otpdb',14,'view_otpdb'),(57,'Can add super admin db',15,'add_superadmindb'),(58,'Can change super admin db',15,'change_superadmindb'),(59,'Can delete super admin db',15,'delete_superadmindb'),(60,'Can view super admin db',15,'view_superadmindb'),(61,'Can add admin db',16,'add_admindb'),(62,'Can change admin db',16,'change_admindb'),(63,'Can delete admin db',16,'delete_admindb'),(64,'Can view admin db',16,'view_admindb'),(65,'Can add manager db',17,'add_managerdb'),(66,'Can change manager db',17,'change_managerdb'),(67,'Can delete manager db',17,'delete_managerdb'),(68,'Can view manager db',17,'view_managerdb'),(69,'Can add employee db',18,'add_employeedb'),(70,'Can change employee db',18,'change_employeedb'),(71,'Can delete employee db',18,'delete_employeedb'),(72,'Can view employee db',18,'view_employeedb'),(73,'Can add certificate',19,'add_certificate'),(74,'Can change certificate',19,'change_certificate'),(75,'Can delete certificate',19,'delete_certificate'),(76,'Can view certificate',19,'view_certificate'),(77,'Can add plan type',20,'add_plantype'),(78,'Can change plan type',20,'change_plantype'),(79,'Can delete plan type',20,'delete_plantype'),(80,'Can view plan type',20,'view_plantype'),(81,'Can add subscription plan',21,'add_subscriptionplan'),(82,'Can change subscription plan',21,'change_subscriptionplan'),(83,'Can delete subscription plan',21,'delete_subscriptionplan'),(84,'Can view subscription plan',21,'view_subscriptionplan'),(85,'Can add email address',22,'add_emailaddress'),(86,'Can change email address',22,'change_emailaddress'),(87,'Can delete email address',22,'delete_emailaddress'),(88,'Can view email address',22,'view_emailaddress'),(89,'Can add email confirmation',23,'add_emailconfirmation'),(90,'Can change email confirmation',23,'change_emailconfirmation'),(91,'Can delete email confirmation',23,'delete_emailconfirmation'),(92,'Can view email confirmation',23,'view_emailconfirmation'),(93,'Can add log entry',24,'add_logentry'),(94,'Can change log entry',24,'change_logentry'),(95,'Can delete log entry',24,'delete_logentry'),(96,'Can view log entry',24,'view_logentry'),(97,'Can add session',25,'add_session'),(98,'Can change session',25,'change_session'),(99,'Can delete session',25,'delete_session'),(100,'Can view session',25,'view_session'),(101,'Can add site',26,'add_site'),(102,'Can change site',26,'change_site'),(103,'Can delete site',26,'delete_site'),(104,'Can view site',26,'view_site'),(105,'Can add social account',27,'add_socialaccount'),(106,'Can change social account',27,'change_socialaccount'),(107,'Can delete social account',27,'delete_socialaccount'),(108,'Can view social account',27,'view_socialaccount'),(109,'Can add social application',28,'add_socialapp'),(110,'Can change social application',28,'change_socialapp'),(111,'Can delete social application',28,'delete_socialapp'),(112,'Can view social application',28,'view_socialapp'),(113,'Can add social application token',29,'add_socialtoken'),(114,'Can change social application token',29,'change_socialtoken'),(115,'Can delete social application token',29,'delete_socialtoken'),(116,'Can view social application token',29,'view_socialtoken');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2025-02-28 06:40:01.645055','1','Google oAuth',1,'[{\"added\": {}}]',28,1),(2,'2025-02-28 06:40:14.271031','2','127.0.0.1:8000',1,'[{\"added\": {}}]',26,1),(3,'2025-02-28 06:40:24.634320','1','Google oAuth',2,'[{\"changed\": {\"fields\": [\"Sites\"]}}]',28,1),(4,'2025-02-28 06:42:54.889387','2','Github',1,'[{\"added\": {}}]',28,1),(5,'2025-02-28 06:43:10.582093','2','Github',2,'[{\"changed\": {\"fields\": [\"Sites\"]}}]',28,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (22,'account','emailaddress'),(23,'account','emailconfirmation'),(24,'admin','logentry'),(16,'admin_portal','admindb'),(18,'admin_portal','employeedb'),(17,'admin_portal','managerdb'),(15,'admin_portal','superadmindb'),(2,'auth','group'),(1,'auth','permission'),(19,'certificate_management','certificate'),(4,'compiler','codesubmission'),(3,'contenttypes','contenttype'),(5,'exam_registration','studentsdb'),(6,'examportol','category'),(9,'examportol','examresult'),(8,'examportol','question'),(7,'examportol','subject'),(11,'jobportol','job'),(12,'oauth','collegesdb'),(14,'oauth','otpdb'),(13,'oauth','usersdb'),(10,'placement_stories','placementstories'),(20,'price','plantype'),(21,'price','subscriptionplan'),(25,'sessions','session'),(26,'sites','site'),(27,'socialaccount','socialaccount'),(28,'socialaccount','socialapp'),(29,'socialaccount','socialtoken');
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
INSERT INTO `django_session` VALUES ('9cso5307miv29ofgfxpgi25m4i40xqm7','.eJx9jkuOwyAQRO_COkKhscF4Ncp-zoDadBMzE38E9myi3D1YiiJlM7tWV72nuouyl5VnYvI8YboV0d9FwYk5r5gnzLKsX9cjkWGZRK9sc7ZgNBgJYJTS-nESy7b6P84pJibR_4OfhMd9G_1eOPt0dOHzN2D4rWtqQD84X5dKzVtOgzwq8pUW-b0Q3y6v7odgxDJW2rSD66h1AZ1SpFmjivHcERkdq8UiQLTGaIcmBNXaCFjvyIBNR411VfreCI8nPyliEg:1tnwEY:fsT4yI_EdmjQ7gF8O79F76BzcChitIUDfLVj1ZUXz0w','2025-03-14 09:00:38.475142');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examportol_category`
--

LOCK TABLES `examportol_category` WRITE;
/*!40000 ALTER TABLE `examportol_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `examportol_category` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examportol_examresult`
--

LOCK TABLES `examportol_examresult` WRITE;
/*!40000 ALTER TABLE `examportol_examresult` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examportol_question`
--

LOCK TABLES `examportol_question` WRITE;
/*!40000 ALTER TABLE `examportol_question` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examportol_subject`
--

LOCK TABLES `examportol_subject` WRITE;
/*!40000 ALTER TABLE `examportol_subject` DISABLE KEYS */;
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
INSERT INTO `oauth_usersdb` VALUES (1,'rathi','alpha@rathitech.me',NULL,'pbkdf2_sha256$870000$NAYzOtxdJuzVVOTqTCvJgH$O8659kygCypMWW0RhnTy21DYi/GSux0nyQls5wo9z+4=','Unknown Course','2000-01-01',NULL,'USR00001','2025-02-28 06:38:38.224465','other',NULL,NULL,1,1,1,'Unknown College'),(2,'Sameer Parmar','sameerparmar.sp@gmail.com','5852216950','pbkdf2_sha256$870000$kliFZU9fUpmxAvRIxhddBh$hEAmALvT2Q0WBXVI8O3nhMItLnDG5NkzG464zbGs6CM=','Unknown Course','2000-01-01',NULL,'USR00002','2025-02-28 07:06:04.768862','other',NULL,NULL,1,0,0,'Unknown College');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price_plantype`
--

LOCK TABLES `price_plantype` WRITE;
/*!40000 ALTER TABLE `price_plantype` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price_subscriptionplan`
--

LOCK TABLES `price_subscriptionplan` WRITE;
/*!40000 ALTER TABLE `price_subscriptionplan` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialaccount`
--

LOCK TABLES `socialaccount_socialaccount` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialaccount` DISABLE KEYS */;
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

-- Dump completed on 2025-02-28 14:35:37
