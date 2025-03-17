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
-- Table structure for table `abroad_studies_counsellingenquiry`
--

DROP TABLE IF EXISTS `abroad_studies_counsellingenquiry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abroad_studies_counsellingenquiry` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(254) NOT NULL,
  `college` varchar(200) NOT NULL,
  `referral_code` varchar(50) NOT NULL,
  `submitted_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abroad_studies_counsellingenquiry`
--

LOCK TABLES `abroad_studies_counsellingenquiry` WRITE;
/*!40000 ALTER TABLE `abroad_studies_counsellingenquiry` DISABLE KEYS */;
INSERT INTO `abroad_studies_counsellingenquiry` VALUES (4,'ss','7894561230','ss@gmail.com','ss','ss','2025-03-17 09:47:33.980058');
/*!40000 ALTER TABLE `abroad_studies_counsellingenquiry` ENABLE KEYS */;
UNLOCK TABLES;

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
  `last_login` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `admin_portal_admindb_superadmin_id_45ef5c28_fk_admin_por` (`superadmin_id`),
  CONSTRAINT `admin_portal_admindb_superadmin_id_45ef5c28_fk_admin_por` FOREIGN KEY (`superadmin_id`) REFERENCES `admin_portal_superadmindb` (`id`),
  CONSTRAINT `fk_admin_superadmin` FOREIGN KEY (`superadmin_id`) REFERENCES `admin_portal_superadmindb` (`id`) ON DELETE SET NULL
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
  `last_login` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `admin_portal_employe_manager_id_4be6b1c2_fk_admin_por` (`manager_id`),
  CONSTRAINT `admin_portal_employe_manager_id_4be6b1c2_fk_admin_por` FOREIGN KEY (`manager_id`) REFERENCES `admin_portal_managerdb` (`id`),
  CONSTRAINT `fk_employee_manager` FOREIGN KEY (`manager_id`) REFERENCES `admin_portal_managerdb` (`id`) ON DELETE SET NULL
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
  `last_login` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `admin_portal_manager_admin_id_2f19ddde_fk_admin_por` (`admin_id`),
  CONSTRAINT `admin_portal_manager_admin_id_2f19ddde_fk_admin_por` FOREIGN KEY (`admin_id`) REFERENCES `admin_portal_admindb` (`id`),
  CONSTRAINT `fk_manager_admin` FOREIGN KEY (`admin_id`) REFERENCES `admin_portal_admindb` (`id`) ON DELETE SET NULL
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
  `last_login` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_portal_superadmindb`
--

LOCK TABLES `admin_portal_superadmindb` WRITE;
/*!40000 ALTER TABLE `admin_portal_superadmindb` DISABLE KEYS */;
INSERT INTO `admin_portal_superadmindb` VALUES (1,'SAD00001','alpha','alpha@rathitech.me','0000000000','0000000001','pbkdf2_sha256$870000$5bd7rVfY0NNNo9PUucAmcJ$8qTua3wShsvO8UonlpJ23R9waRewJ5D6l6BDzcDJKXw=','321112341234','2025-03-04 11:46:27',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can view permission',1,'view_permission'),(5,'Can add group',2,'add_group'),(6,'Can change group',2,'change_group'),(7,'Can delete group',2,'delete_group'),(8,'Can view group',2,'view_group'),(9,'Can add content type',3,'add_contenttype'),(10,'Can change content type',3,'change_contenttype'),(11,'Can delete content type',3,'delete_contenttype'),(12,'Can view content type',3,'view_contenttype'),(13,'Can add code submission',4,'add_codesubmission'),(14,'Can change code submission',4,'change_codesubmission'),(15,'Can delete code submission',4,'delete_codesubmission'),(16,'Can view code submission',4,'view_codesubmission'),(17,'Can add students db',5,'add_studentsdb'),(18,'Can change students db',5,'change_studentsdb'),(19,'Can delete students db',5,'delete_studentsdb'),(20,'Can view students db',5,'view_studentsdb'),(21,'Can add category',6,'add_category'),(22,'Can change category',6,'change_category'),(23,'Can delete category',6,'delete_category'),(24,'Can view category',6,'view_category'),(25,'Can add subject',7,'add_subject'),(26,'Can change subject',7,'change_subject'),(27,'Can delete subject',7,'delete_subject'),(28,'Can view subject',7,'view_subject'),(29,'Can add question',8,'add_question'),(30,'Can change question',8,'change_question'),(31,'Can delete question',8,'delete_question'),(32,'Can view question',8,'view_question'),(33,'Can add exam result',9,'add_examresult'),(34,'Can change exam result',9,'change_examresult'),(35,'Can delete exam result',9,'delete_examresult'),(36,'Can view exam result',9,'view_examresult'),(37,'Can add placement stories',10,'add_placementstories'),(38,'Can change placement stories',10,'change_placementstories'),(39,'Can delete placement stories',10,'delete_placementstories'),(40,'Can view placement stories',10,'view_placementstories'),(41,'Can add job',11,'add_job'),(42,'Can change job',11,'change_job'),(43,'Can delete job',11,'delete_job'),(44,'Can view job',11,'view_job'),(45,'Can add colleges db',12,'add_collegesdb'),(46,'Can change colleges db',12,'change_collegesdb'),(47,'Can delete colleges db',12,'delete_collegesdb'),(48,'Can view colleges db',12,'view_collegesdb'),(49,'Can add users db',13,'add_usersdb'),(50,'Can change users db',13,'change_usersdb'),(51,'Can delete users db',13,'delete_usersdb'),(52,'Can view users db',13,'view_usersdb'),(53,'Can add otpdb',14,'add_otpdb'),(54,'Can change otpdb',14,'change_otpdb'),(55,'Can delete otpdb',14,'delete_otpdb'),(56,'Can view otpdb',14,'view_otpdb'),(57,'Can add super admin db',15,'add_superadmindb'),(58,'Can change super admin db',15,'change_superadmindb'),(59,'Can delete super admin db',15,'delete_superadmindb'),(60,'Can view super admin db',15,'view_superadmindb'),(61,'Can add admin db',16,'add_admindb'),(62,'Can change admin db',16,'change_admindb'),(63,'Can delete admin db',16,'delete_admindb'),(64,'Can view admin db',16,'view_admindb'),(65,'Can add manager db',17,'add_managerdb'),(66,'Can change manager db',17,'change_managerdb'),(67,'Can delete manager db',17,'delete_managerdb'),(68,'Can view manager db',17,'view_managerdb'),(69,'Can add employee db',18,'add_employeedb'),(70,'Can change employee db',18,'change_employeedb'),(71,'Can delete employee db',18,'delete_employeedb'),(72,'Can view employee db',18,'view_employeedb'),(73,'Can add certificate',19,'add_certificate'),(74,'Can change certificate',19,'change_certificate'),(75,'Can delete certificate',19,'delete_certificate'),(76,'Can view certificate',19,'view_certificate'),(77,'Can add plan type',20,'add_plantype'),(78,'Can change plan type',20,'change_plantype'),(79,'Can delete plan type',20,'delete_plantype'),(80,'Can view plan type',20,'view_plantype'),(81,'Can add subscription plan',21,'add_subscriptionplan'),(82,'Can change subscription plan',21,'change_subscriptionplan'),(83,'Can delete subscription plan',21,'delete_subscriptionplan'),(84,'Can view subscription plan',21,'view_subscriptionplan'),(85,'Can add email address',22,'add_emailaddress'),(86,'Can change email address',22,'change_emailaddress'),(87,'Can delete email address',22,'delete_emailaddress'),(88,'Can view email address',22,'view_emailaddress'),(89,'Can add email confirmation',23,'add_emailconfirmation'),(90,'Can change email confirmation',23,'change_emailconfirmation'),(91,'Can delete email confirmation',23,'delete_emailconfirmation'),(92,'Can view email confirmation',23,'view_emailconfirmation'),(93,'Can add log entry',24,'add_logentry'),(94,'Can change log entry',24,'change_logentry'),(95,'Can delete log entry',24,'delete_logentry'),(96,'Can view log entry',24,'view_logentry'),(97,'Can add session',25,'add_session'),(98,'Can change session',25,'change_session'),(99,'Can delete session',25,'delete_session'),(100,'Can view session',25,'view_session'),(101,'Can add site',26,'add_site'),(102,'Can change site',26,'change_site'),(103,'Can delete site',26,'delete_site'),(104,'Can view site',26,'view_site'),(105,'Can add social account',27,'add_socialaccount'),(106,'Can change social account',27,'change_socialaccount'),(107,'Can delete social account',27,'delete_socialaccount'),(108,'Can view social account',27,'view_socialaccount'),(109,'Can add social application',28,'add_socialapp'),(110,'Can change social application',28,'change_socialapp'),(111,'Can delete social application',28,'delete_socialapp'),(112,'Can view social application',28,'view_socialapp'),(113,'Can add social application token',29,'add_socialtoken'),(114,'Can change social application token',29,'change_socialtoken'),(115,'Can delete social application token',29,'delete_socialtoken'),(116,'Can view social application token',29,'view_socialtoken'),(117,'Can add exam',30,'add_exam'),(118,'Can change exam',30,'change_exam'),(119,'Can delete exam',30,'delete_exam'),(120,'Can view exam',30,'view_exam'),(121,'Can add payment transaction',31,'add_paymenttransaction'),(122,'Can change payment transaction',31,'change_paymenttransaction'),(123,'Can delete payment transaction',31,'delete_paymenttransaction'),(124,'Can view payment transaction',31,'view_paymenttransaction'),(125,'Can add category',32,'add_category'),(126,'Can change category',32,'change_category'),(127,'Can delete category',32,'delete_category'),(128,'Can view category',32,'view_category'),(129,'Can add company',33,'add_company'),(130,'Can change company',33,'change_company'),(131,'Can delete company',33,'delete_company'),(132,'Can view company',33,'view_company'),(133,'Can add job',34,'add_job'),(134,'Can change job',34,'change_job'),(135,'Can delete job',34,'delete_job'),(136,'Can view job',34,'view_job'),(137,'Can add domain',35,'add_domain'),(138,'Can change domain',35,'change_domain'),(139,'Can delete domain',35,'delete_domain'),(140,'Can view domain',35,'view_domain'),(141,'Can add job application',36,'add_jobapplication'),(142,'Can change job application',36,'change_jobapplication'),(143,'Can delete job application',36,'delete_jobapplication'),(144,'Can view job application',36,'view_jobapplication'),(145,'Can add job seeker',37,'add_jobseeker'),(146,'Can change job seeker',37,'change_jobseeker'),(147,'Can delete job seeker',37,'delete_jobseeker'),(148,'Can view job seeker',37,'view_jobseeker'),(149,'Can add job seeker experience',38,'add_jobseekerexperience'),(150,'Can change job seeker experience',38,'change_jobseekerexperience'),(151,'Can delete job seeker experience',38,'delete_jobseekerexperience'),(152,'Can view job seeker experience',38,'view_jobseekerexperience'),(153,'Can add job seeker education',39,'add_jobseekereducation'),(154,'Can change job seeker education',39,'change_jobseekereducation'),(155,'Can delete job seeker education',39,'delete_jobseekereducation'),(156,'Can view job seeker education',39,'view_jobseekereducation'),(157,'Can add internship application',40,'add_internshipapplication'),(158,'Can change internship application',40,'change_internshipapplication'),(159,'Can delete internship application',40,'delete_internshipapplication'),(160,'Can view internship application',40,'view_internshipapplication'),(161,'Can add internship category',41,'add_internshipcategory'),(162,'Can change internship category',41,'change_internshipcategory'),(163,'Can delete internship category',41,'delete_internshipcategory'),(164,'Can view internship category',41,'view_internshipcategory'),(165,'Can add internship',42,'add_internship'),(166,'Can change internship',42,'change_internship'),(167,'Can delete internship',42,'delete_internship'),(168,'Can view internship',42,'view_internship'),(169,'Can add internship seeker',43,'add_internshipseeker'),(170,'Can change internship seeker',43,'change_internshipseeker'),(171,'Can delete internship seeker',43,'delete_internshipseeker'),(172,'Can view internship seeker',43,'view_internshipseeker'),(173,'Can add internship company',44,'add_internshipcompany'),(174,'Can change internship company',44,'change_internshipcompany'),(175,'Can delete internship company',44,'delete_internshipcompany'),(176,'Can view internship company',44,'view_internshipcompany'),(177,'Can add counselling enquiry',45,'add_counsellingenquiry'),(178,'Can change counselling enquiry',45,'change_counsellingenquiry'),(179,'Can delete counselling enquiry',45,'delete_counsellingenquiry'),(180,'Can view counselling enquiry',45,'view_counsellingenquiry');
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
) ENGINE=InnoDB AUTO_INCREMENT=263 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (200,'2025-03-04 06:25:01.551029','3','basic',1,'[{\"added\": {}}]',20,4),(201,'2025-03-04 06:25:18.863630','3','basic - ₹0.00/m',1,'[{\"added\": {}}]',21,4),(202,'2025-03-04 06:30:14.669043','4','monthly',1,'[{\"added\": {}}]',20,4),(203,'2025-03-04 06:30:31.180474','4','monthly - ₹284.05/m',1,'[{\"added\": {}}]',21,4),(204,'2025-03-04 09:12:53.622024','1','PaymentTransaction object (1)',3,'',31,4),(205,'2025-03-04 09:15:58.569254','4','USR00001',2,'[{\"changed\": {\"fields\": [\"Subscription plan\"]}}]',13,4),(206,'2025-03-04 09:16:13.861441','4','USR00001',2,'[{\"changed\": {\"fields\": [\"Subscription plan\"]}}]',13,4),(207,'2025-03-04 09:21:12.114605','4','USR00001',2,'[{\"changed\": {\"fields\": [\"Subscription plan\", \"Subscription start\", \"Subscription end\"]}}]',13,4),(208,'2025-03-04 09:22:04.748515','4','monthly - ₹284.05/m',2,'[]',21,4),(209,'2025-03-04 09:22:27.521978','4','USR00001',2,'[{\"changed\": {\"fields\": [\"Subscription plan\"]}}]',13,4),(210,'2025-03-04 11:44:43.776079','1','SAD00001',1,'[{\"added\": {}}]',15,4),(211,'2025-03-04 12:30:25.628063','3','basic - ₹0.00/m',2,'[{\"changed\": {\"fields\": [\"Features\"]}}]',21,4),(212,'2025-03-04 12:32:47.505329','4','monthly - ₹284.05/m',2,'[{\"changed\": {\"fields\": [\"Features\"]}}]',21,4),(213,'2025-03-04 12:33:37.395975','3','basic - ₹0.00/m',2,'[{\"changed\": {\"fields\": [\"Features\"]}}]',21,4),(214,'2025-03-12 06:10:12.003927','6','Exam object (6)',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',30,4),(215,'2025-03-12 06:10:32.928321','5','Exam object (5)',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',30,4),(216,'2025-03-12 06:11:26.694717','4','Exam object (4)',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',30,4),(217,'2025-03-12 06:11:31.617713','3','Exam object (3)',2,'[]',30,4),(218,'2025-03-12 06:12:05.903116','2','Exam object (2)',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',30,4),(219,'2025-03-12 06:12:26.120133','1','Exam object (1)',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',30,4),(220,'2025-03-12 06:12:30.324949','1','Exam object (1)',2,'[]',30,4),(221,'2025-03-12 06:12:34.142090','6','Exam object (6)',2,'[]',30,4),(222,'2025-03-12 06:12:37.702102','5','Exam object (5)',2,'[]',30,4),(223,'2025-03-12 06:12:41.203951','4','Exam object (4)',2,'[]',30,4),(224,'2025-03-12 06:12:44.780110','2','Exam object (2)',2,'[]',30,4),(225,'2025-03-12 06:13:11.895021','3','Exam object (3)',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',30,4),(226,'2025-03-15 10:38:01.378576','3','Exam Result - USR00001 - Score: 13.333333333333334%',3,'',9,4),(227,'2025-03-15 11:09:42.961290','1','IT',1,'[{\"added\": {}}]',41,4),(228,'2025-03-15 11:10:16.360823','2','Management',1,'[{\"added\": {}}]',41,4),(229,'2025-03-15 11:10:54.742729','1','asasa',1,'[{\"added\": {}}]',44,4),(230,'2025-03-15 11:16:56.937091','5','xxxxx at asasa',1,'[{\"added\": {}}]',42,4),(231,'2025-03-15 12:41:30.695415','6','asssaa at asasa',1,'[{\"added\": {}}]',42,4),(232,'2025-03-15 12:42:07.026929','2','qwe',1,'[{\"added\": {}}]',44,4),(233,'2025-03-15 12:42:36.710578','7','sasass at qwe',1,'[{\"added\": {}}]',42,4),(234,'2025-03-15 13:14:39.158263','2','qwe',3,'',44,4),(235,'2025-03-15 13:14:39.158399','1','asasa',3,'',44,4),(236,'2025-03-15 13:24:47.223308','4','Beta Innovations',2,'[{\"changed\": {\"fields\": [\"Logo\"]}}]',44,4),(237,'2025-03-15 13:24:56.970032','3','Alpha Tech',2,'[{\"changed\": {\"fields\": [\"Logo\"]}}]',44,4),(238,'2025-03-15 13:47:38.596127','15','Nu Nexus',2,'[{\"changed\": {\"fields\": [\"Logo\"]}}]',44,4),(239,'2025-03-15 13:47:49.244738','14','Mu Microsystems',2,'[{\"changed\": {\"fields\": [\"Logo\"]}}]',44,4),(240,'2025-03-15 13:48:00.198813','13','Lambda Labs',2,'[{\"changed\": {\"fields\": [\"Logo\"]}}]',44,4),(241,'2025-03-15 13:48:12.708360','12','Kappa Konnect',2,'[{\"changed\": {\"fields\": [\"Logo\"]}}]',44,4),(242,'2025-03-15 13:48:23.190051','10','Theta Tech',2,'[{\"changed\": {\"fields\": [\"Logo\"]}}]',44,4),(243,'2025-03-15 13:48:28.296493','11','Iota Innovations',2,'[]',44,4),(244,'2025-03-15 13:48:39.104309','8','Epsilon Enterprises',2,'[{\"changed\": {\"fields\": [\"Logo\"]}}]',44,4),(245,'2025-03-15 13:51:46.835468','6','Gamma Global',2,'[{\"changed\": {\"fields\": [\"Logo\"]}}]',44,4),(246,'2025-03-15 13:52:07.905148','11','Iota Innovations',2,'[{\"changed\": {\"fields\": [\"Logo\"]}}]',44,4),(247,'2025-03-15 13:52:12.557595','10','Theta Tech',2,'[]',44,4),(248,'2025-03-15 13:52:16.624850','15','Nu Nexus',2,'[]',44,4),(249,'2025-03-15 13:52:19.723963','14','Mu Microsystems',2,'[]',44,4),(250,'2025-03-15 13:52:23.024965','13','Lambda Labs',2,'[]',44,4),(251,'2025-03-15 13:52:41.092622','9','Zeta Solutions',2,'[{\"changed\": {\"fields\": [\"Logo\"]}}]',44,4),(252,'2025-03-15 13:52:45.154122','9','Zeta Solutions',2,'[]',44,4),(253,'2025-03-15 13:52:58.228427','7','Delta Dynamics',2,'[{\"changed\": {\"fields\": [\"Logo\"]}}]',44,4),(254,'2025-03-15 15:08:18.137570','1','sameer parmar (alpha@rathitech.me)',1,'[{\"added\": {}}]',37,4),(255,'2025-03-15 15:08:42.473545','1','sasas at sasas',1,'[{\"added\": {}}]',38,4),(256,'2025-03-15 15:08:59.545445','1','ss in ssasa from sasaassa',1,'[{\"added\": {}}]',39,4),(257,'2025-03-15 15:54:42.321011','4','PaymentTransaction object (4)',3,'',31,4),(258,'2025-03-15 15:54:42.321183','3','PaymentTransaction object (3)',3,'',31,4),(259,'2025-03-15 15:54:42.321250','2','PaymentTransaction object (2)',3,'',31,4),(260,'2025-03-17 09:29:55.694991','3','saassa - ss@gmail.com',3,'',45,4),(261,'2025-03-17 09:29:55.695120','2','saassa - ss@gmail.com',3,'',45,4),(262,'2025-03-17 09:29:55.695190','1','saassa - ss@gmail.com',3,'',45,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (45,'abroad_studies','counsellingenquiry'),(22,'account','emailaddress'),(23,'account','emailconfirmation'),(24,'admin','logentry'),(16,'admin_portal','admindb'),(18,'admin_portal','employeedb'),(17,'admin_portal','managerdb'),(15,'admin_portal','superadmindb'),(2,'auth','group'),(1,'auth','permission'),(19,'certificate_management','certificate'),(4,'compiler','codesubmission'),(3,'contenttypes','contenttype'),(5,'exam_registration','studentsdb'),(6,'examportol','category'),(30,'examportol','exam'),(9,'examportol','examresult'),(8,'examportol','question'),(7,'examportol','subject'),(42,'internship_portal','internship'),(40,'internship_portal','internshipapplication'),(41,'internship_portal','internshipcategory'),(44,'internship_portal','internshipcompany'),(43,'internship_portal','internshipseeker'),(32,'job_portal','category'),(33,'job_portal','company'),(35,'job_portal','domain'),(34,'job_portal','job'),(36,'job_portal','jobapplication'),(37,'job_portal','jobseeker'),(39,'job_portal','jobseekereducation'),(38,'job_portal','jobseekerexperience'),(11,'jobportol','job'),(12,'oauth','collegesdb'),(14,'oauth','otpdb'),(31,'oauth','paymenttransaction'),(13,'oauth','usersdb'),(10,'placement_stories','placementstories'),(20,'price','plantype'),(21,'price','subscriptionplan'),(25,'sessions','session'),(26,'sites','site'),(27,'socialaccount','socialaccount'),(28,'socialaccount','socialapp'),(29,'socialaccount','socialtoken');
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
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-02-28 06:15:28.889492'),(2,'contenttypes','0002_remove_content_type_name','2025-02-28 06:15:28.962130'),(3,'auth','0001_initial','2025-02-28 06:15:29.294127'),(4,'auth','0002_alter_permission_name_max_length','2025-02-28 06:15:29.375221'),(5,'auth','0003_alter_user_email_max_length','2025-02-28 06:15:29.382866'),(6,'auth','0004_alter_user_username_opts','2025-02-28 06:15:29.389972'),(7,'auth','0005_alter_user_last_login_null','2025-02-28 06:15:29.396713'),(8,'auth','0006_require_contenttypes_0002','2025-02-28 06:15:29.400289'),(9,'auth','0007_alter_validators_add_error_messages','2025-02-28 06:15:29.405901'),(10,'auth','0008_alter_user_username_max_length','2025-02-28 06:15:29.412668'),(11,'auth','0009_alter_user_last_name_max_length','2025-02-28 06:15:29.420544'),(12,'auth','0010_alter_group_name_max_length','2025-02-28 06:15:29.434925'),(13,'auth','0011_update_proxy_permissions','2025-02-28 06:15:29.449887'),(14,'auth','0012_alter_user_first_name_max_length','2025-02-28 06:15:29.455157'),(15,'oauth','0001_initial','2025-02-28 06:15:30.056991'),(16,'account','0001_initial','2025-02-28 06:17:51.284499'),(17,'account','0002_email_max_length','2025-02-28 06:17:51.303170'),(18,'account','0003_alter_emailaddress_create_unique_verified_email','2025-02-28 06:17:51.331075'),(19,'account','0004_alter_emailaddress_drop_unique_email','2025-02-28 06:17:51.359716'),(20,'account','0005_emailaddress_idx_upper_email','2025-02-28 06:17:51.384995'),(21,'account','0006_emailaddress_lower','2025-02-28 06:17:51.406581'),(22,'account','0007_emailaddress_idx_email','2025-02-28 06:17:51.445724'),(23,'account','0008_emailaddress_unique_primary_email_fixup','2025-02-28 06:17:51.462515'),(24,'account','0009_emailaddress_unique_primary_email','2025-02-28 06:17:51.470485'),(25,'admin','0001_initial','2025-02-28 06:17:57.241819'),(26,'admin','0002_logentry_remove_auto_add','2025-02-28 06:17:57.250315'),(27,'admin','0003_logentry_add_action_flag_choices','2025-02-28 06:17:57.259109'),(28,'sessions','0001_initial','2025-02-28 06:17:57.295658'),(29,'sites','0001_initial','2025-02-28 06:17:57.318151'),(30,'sites','0002_alter_domain_unique','2025-02-28 06:17:57.335806'),(31,'socialaccount','0001_initial','2025-02-28 06:17:57.928886'),(32,'socialaccount','0002_token_max_lengths','2025-02-28 06:17:57.980921'),(33,'socialaccount','0003_extra_data_default_dict','2025-02-28 06:17:57.990551'),(34,'socialaccount','0004_app_provider_id_settings','2025-02-28 06:17:58.144217'),(35,'socialaccount','0005_socialtoken_nullable_app','2025-02-28 06:17:58.297166'),(36,'socialaccount','0006_alter_socialaccount_extra_data','2025-02-28 06:17:58.373478'),(37,'compiler','0001_initial','2025-02-28 06:22:40.350506'),(38,'examportol','0001_initial','2025-02-28 06:30:26.453782'),(39,'exam_registration','0001_initial','2025-02-28 06:33:53.527652'),(40,'placement_stories','0001_initial','2025-02-28 06:34:54.344530'),(41,'jobportol','0001_initial','2025-02-28 06:35:27.755819'),(42,'admin_portal','0001_initial','2025-02-28 06:35:48.391335'),(43,'certificate_management','0001_initial','2025-02-28 06:36:08.843992'),(44,'price','0001_initial','2025-02-28 06:36:25.775072'),(45,'oauth','0002_alter_otpdb_user_alter_usersdb_college_name','2025-02-28 06:47:51.248302'),(46,'exam_registration','0002_alter_table_changes','2025-03-03 17:01:27.645107'),(47,'exam_registration','0003_add_exam_domain_field','2025-03-03 17:06:37.027363'),(48,'exam_registration','0004_alter_studentsdb_exam_domain_and_more','2025-03-03 17:12:32.692819'),(49,'oauth','0002_alter_usersdb_subscription_plan','2025-03-04 06:23:59.230526'),(50,'oauth','0003_alter_usersdb_subscription_plan_paymenttransaction','2025-03-04 07:10:32.102241'),(51,'job_portal','0001_initial','2025-03-15 10:05:17.978218'),(52,'internship_portal','0001_initial','2025-03-15 10:22:42.417698'),(53,'abroad_studies','0001_initial','2025-03-17 09:13:30.282142');
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
INSERT INTO `django_session` VALUES ('0s8mny8rmsb3oauho4kid0dbglf1yv9h','.eJxtU8uO2zAQ-xedhUAjjWw5x977BUVh-JUmbTZGbQdYYNF_Lzn2brFAD4Yy0ojikMybe67T0t5Gd1bvlvk-ubNtOe-m1-6l_f2c1u02P9Z2XkZsn79FER9T4yUHrNmLJh8FX2h8jAE11hSxipeEOhbU6iNrLahrfMDQiHvqRVAnfAI87Euo0M8V2IH9xAN-Rn9iXQGHuKg14w76yUXACX3CHmIrsDM58DfOBJzIMwIXWEK-eDuyR8kPODYL8G0-3mcN_kp-4Aw-kTwD7pGf8ceacDfybWKBUyIGz7FGYHMG0wH3rJ_38AZxA_UgL-6RO-enFuBNLZTvcz7Uph1nz98Pg7Z56-7_bHLnphwnNDUdv8fn0vHcnavwf2fbRG9TNg_Mr1AZv6iHd6w5MzXRynwwjvQac9Mf6sp8MBPmA_3nnDbzu--1acq5TWtow0yYNtSImlJ7ekad4Nc-f2067xqpZcM0ec8ivaX-xNC8-yDZMkltmSHmj94xP7vvYvkxv-kB8ZEdZsvyyDzwjmU97PkyvHrPr2U-7_kyv9NHRsz70Oz5kz1_zIFlkrljXiw_Yrm2PDEDWsHbtntu1_bjz-nUfdrru-HX9ODB-LN7_JhPw_zYllt_YsvpOF1PX-dxun85ej8BXLv1ituhzlPs6qwXCcOlyU01VWEYB8lViQPs7RCFMnZaSrnkQft-lKbuS9EcmpxH9-cvHyX9XA:1tpRW7:hKBQEurWaTdlpHKtbUTSvdIyOXapSCt_eKJHmUsMY08','2025-03-18 12:36:59.999396'),('0wdsa6bzpyntb2jrjp29yhrtn94sz60f','eyJ1c2VyX2lkIjo0LCJyb2xlIjoidXNlciJ9:1ttPJ9:_1zOPlw02lSOkrFh6Zh7RwRL6D-JdIJAHSkR3p3-5mM','2025-03-29 11:03:59.474723'),('1e8rtdskptj7obkdxb0oifjdz39828l5','.eJxVjsEOwiAQRP-FsyGAu-3i0bvfQJaFStW0SWlPxn9Xksbodd7MyzxV4G0tYat5CWNSJwXq8JtFlnueGkg3nq6zlnlalzHqVtE7rfoyp_w4790_QeFaPmvTY3bcIwzWyODRd7kzksRiR06cc-yOQImBiAYUiDFZ30ciQOMRm_T7EV5veUk67g:1ttO7w:2U1IBa9CdMdMRK5u9vvW8aGo1wa4CIxm9fkyKuiC_Pc','2025-03-29 09:48:20.346313'),('1s2vyu750palb2fkvwuguahi5633rxk0','.eJxVj0FuhTAMRO_iNUIJiZ2YXXuNqkL5IXxQKalI6AZx9wLlL9hZ45mnmRVS9IMbnfdxmXKTssshQb1uBbw0t-Q-THnwLg9xar5D7mO7ez5W-L-hvlNgz2aopdFSsLBkSiRGVVEBP3P8Hdow75FnjM8x7N5lOAhSVFZZIqklGaGFQakIts8CzgLNksLcnE4DN-3h_FeYjocbx0Murxrl6bneqXy7zXi_UjdU71J_cB6M7Fl2SE4Hj4i6s541kxQtdaat2DCiIvRW244kahV8pY1jp5TkY9Orrdn-ABpYcxk:1tpRJf:I1vdzZDLpvYZFtVHWkLtU6Z_7M4pZ6ewejP8axNuga0','2025-03-18 12:24:07.585366'),('23gr5fqmxb3xvq7y8xrvgy9dspvoon7t','eyJ1c2VyX2lkIjo0LCJyb2xlIjoidXNlciJ9:1tu6kk:rS9tYVwIqqXtv4Mg6C56cwk1u9iMHyS2QloHR4R1Ebs','2025-03-31 09:27:22.721582'),('2ok92xnhm20vrhflpxe4wmr6pxiiox4n','.eJxVjsEOwiAQRP-FsyGAu-3i0bvfQJaFStW0SWlPxn9Xksbodd7MyzxV4G0tYat5CWNSJwXq8JtFlnueGkg3nq6zlnlalzHqVtE7rfoyp_w4790_QeFaPmvTY3bcIwzWyODRd7kzksRiR06cc-yOQImBiAYUiDFZ30ciQOMRm_T7EV5veUk67g:1ttO7D:K_tqs42-Y5tR17VhMKgmoLvUI3WyMgCpHOtng5n80Qc','2025-03-29 09:47:35.112776'),('3rl7kcfv2997fuyfi3ltcpn647wpm2sx','.eJwNyttugjAAANB_6TNdhIqob8jQOTRe2OZwWUgtZVQKhXIpSPj3-XzOACpBGOaYENHkdVjVuKYVWA5AyeT8ebL2ZWDUdvZYg-XPAAopCK2eDrj4YznQQIRrDJZ5w7kGipTQkIiIhi2VLGZUPqPfwA2qrmXUNdtE376hlqwb39l57vnL7KFy452telMvN559M8JG8dmluySBKjOq7h_wJIto_-4enbawOUYsU4fIudlptkLTpEuvCzkPYraCoXcMunsMqQ693j9g8jpJ24X4BqOmW1PDmKAZ0l-QZSATzX_H8R_rIFQ_:1tu6kZ:R_oW7Y4nVXD7yfM0Up-CNOpUO7ZRCO5wRhDz0m7py98','2025-03-31 09:27:11.388823'),('4b1bbderranmcmkhbyjjlo3dyzlcnjv8','eyJ1c2VyX2lkIjo0fQ:1tsHNy:cKsBclIIL-SgEoPvnvxvTzIZ3X4Iy9DOQNeb8p77r9E','2025-03-26 08:24:18.562515'),('57jf94nbjtbb5z8dlww3p78j08k5jhpv','.eJwNyttOgzAAANB_6TMzlPt4A6PBXQC5OIYxTVeKlDGK0MEC4d_d8zkLGDhhuMGE8Hsr0CCwoAOwF1DzG7z4LgwJi3V3GoH9vYCu54QOTwcN_2UtkECBBQZ2e28aCXRXQhHhBUUj7VnJaP-MQo4qZY4TU000bgRzABOjdr640ue1tUHNtjoiNqTHbufT_elQeuEBVdHHzmP-Nc3mIW_V15mE7yRpHFFEbq77exar-sNJw6TP5M45feJxOke5kU3WxYtuGzGRsxHwunTf5D-wStDUoKWb0FReLM1S1K32s67_Q_xTLQ:1tsecW:NmAcztZFU84WXhmdWxTELqSGNkjjp2iAcuMHMFxtlB0','2025-03-27 09:12:52.854448'),('73wp0fpjgfa1358s5nz9nyyi0c8pndq0','.eJxVTksOwiAQvQtrQ4DOQOvSvWcgDAy2aiDpZ2W8uzRpjO7eP-8lfNjW0W8Lz35K4iy0OP1qFOKDy26keyi3KmMt6zyR3CPycBd5rYmflyP7NzCGZWxto4CzQz0MhJYBOsM9KpdcjjaRCdQwYpe5MWcJAhq2qo-AFpgMtNHvR_3-AIkwO3A:1tp0Ee:8ELo3aBg7DKjprDp8uV-snw9HOidE-Q2MwUVtLW9p54','2025-03-17 07:29:08.007092'),('74rvenamj8nqhz67onl1brgnteok1mix','.eJxVjEsOgzAMBe_iNYpCaoPDsvueASV2KLSISHxWVe_eUqFKbGfmvRdsS5rbQaHBAuY8Jmh-CApow7b27d8DnlkM8kzTLvQRpns2kqd1HqLZE3PYxdyypvF6tKeDPiz9d21rSi7UhF1ppfPkq1RZUSmpYifOueAuyBqQmTsSjFFLX0dmJOuJFN4ftWM_TQ:1ttO3h:RLDuNStg0xP5E_50-SCskrTpR0NVT5HnXmELNmAAkgs','2025-03-29 09:43:57.111243'),('7gi3lfbwfh4sd2w80aa9oiq7t8a9ltos','.eJxVj8tKxjAQRt8l61KSNNOmWYpbV7oTCblM_1Z_E8wFBPHdbTB4mdUw58zHzAfRppZd14xJH54oIsjwd2aNe8HQgH824RJHF0NJhx2bMnaax7vo8XrT3X8Bu8n7uU0XQG4WEBujblthnXGmzjsGs-SOc274JKQ3Qkq5gRPWerYuVkoBdAVooT83ioEkvBy5YEKv8d28EjUNJJfqMZTvN-4fbulZ07nXBP1WMZcjhqxj8piIegQYGIWnzkss5vprEcU6aGlT731NpmGiZvr5BV_3Z4c:1tpPYe:vfxdNKBcPJawXLZTBKq_w5kiGtiMAuK8HUaTS3O5_P0','2025-03-18 10:31:28.803502'),('7h60n1ydfjr2zxszms92yfp8d3hfe6jb','eyJ1c2VyX2lkIjo0LCJyb2xlIjoidXNlciJ9:1tsf6O:giNgvPuX-S3w-eW2PMvwbAkkID-6c5lc13n9UGXhVSY','2025-03-27 09:43:44.265972'),('9cso5307miv29ofgfxpgi25m4i40xqm7','.eJx9jkuOwyAQRO_COkKhscF4Ncp-zoDadBMzE38E9myi3D1YiiJlM7tWV72nuouyl5VnYvI8YboV0d9FwYk5r5gnzLKsX9cjkWGZRK9sc7ZgNBgJYJTS-nESy7b6P84pJibR_4OfhMd9G_1eOPt0dOHzN2D4rWtqQD84X5dKzVtOgzwq8pUW-b0Q3y6v7odgxDJW2rSD66h1AZ1SpFmjivHcERkdq8UiQLTGaIcmBNXaCFjvyIBNR411VfreCI8nPyliEg:1tnwEY:fsT4yI_EdmjQ7gF8O79F76BzcChitIUDfLVj1ZUXz0w','2025-03-14 09:00:38.475142'),('cwsxc5b694x73vyecp7t386czcv1kxa7','eyJ1c2VyX2lkIjo0LCJyb2xlIjoidXNlciJ9:1ttO3m:K-tMGAt8t6Rea8PlgFIXF2Yz0sqo_qe6s9-hiyAOiKQ','2025-03-29 09:44:02.139369'),('e02s8fusotrxt8uyuctrh31oz3vwp5xo','eyJ1c2VyX2lkIjo0LCJyb2xlIjoidXNlciJ9:1ttO3q:WgM25MGsMUnwI77pflmu2cww9OMko1uoDJrIQt4AXhg','2025-03-29 09:44:06.038025'),('e91xhhjhzka69nxblzxm71fwuq2mq2px','eyJ1c2VyX2lkIjo0LCJyb2xlIjoidXNlciJ9:1ttOxp:60yT_5gX35WxWYLkYFYnn0ampqNUjFX8X5ESq8WBHgk','2025-03-29 10:41:57.136878'),('eolih2y42mtimhps4e61y5zeru8xofki','eyJ1c2VyX2lkIjo0LCJyb2xlIjoidXNlciJ9:1tsdTz:L-DjXhcvM6b4PWAXz6g2p0P9zQI70w1pfX1_vpiyKqo','2025-03-27 07:59:59.484907'),('gcxubbtgm67oeqfwgeqbhsdn0tnnrsiv','.eJxVjsFqxSAQRf9l1kNQ4ySaZff9glLEqGnS5kWqBgql_17zkJa3GLhzz53LfMOZQzKbh0kipLgHmO4WIIQvezOfZ8hli0c2MfmalDC99EyhoB4Fq0OEQo84XOslCWlEGrDnDEkhrzlOAkm_tsYSi93_e2Hi1Ej74q79mezFK2YIxp5lNX-vgoQHb7buIxwX8O_2eIudi0dJ29xdka7R3D1HH_anln0oWG1e6zUbKQg7klw4c4smPYSBOe84DUo4IYQVvVTeSqXUQk7Os-d6nJWSxDSRh59fTmtn8Q:1ttPJ3:grueUtFMlSkyQ2EH_2mFEK0i7h98lcjzlwL9DHRREeI','2025-03-29 11:03:53.208258'),('ghhxuqv9ppzmailcs8xezrdxr4s56yuk','eyJ1c2VyX2lkIjo0LCJyb2xlIjoidXNlciJ9:1tskL9:SPvYQU0a4fPBEqMHBmpkv6RDZWrQlo38_L9aZ0FE06Y','2025-03-27 15:19:19.462360'),('h2y5l8z6ecg5t5br733glulhdqakw6wk','eyJ1c2VyX2lkIjo0LCJyb2xlIjoidXNlciJ9:1ttOhN:CveTsNzudNa8ZzvTWGMPDHwDhmRl9w_bfdHm77V3sqY','2025-03-29 10:24:57.128343'),('jiebwazycesjl5sl15rhq8olapru5nnl','.eJxVjEsOgzAMBe_iNYpCaoPDsvueASV2KLSISHxWVe_eUqFKbGfmvRdsS5rbQaHBAuY8Jmh-CApow7b27d8DnlkM8kzTLvQRpns2kqd1HqLZE3PYxdyypvF6tKeDPiz9d21rSi7UhF1ppfPkq1RZUSmpYifOueAuyBqQmTsSjFFLX0dmJOuJFN4ftWM_TQ:1tu6s2:5AmgfphVT32GEVzHuN6jSqSxO009CxhRYNgLqV7P6-I','2025-03-31 09:34:54.415817'),('ldr5g3ouhg8f33z0smk926rx6qew3x0p','.eJxVjssOwiAQRf-FdUMo8mi7dO83kAGmtlohFkhMjP8uTRpTdzP3nLmZNzFQ8mRKwtXMngykJc0xs-DuGDbgbxCukboY8jpbuil0p4leosflvLt_BROkqV5zJnDUsu17KxUKceLYSaa9Hp3yloOts5SnEeumlRUgOSrWOSGVQMtFLf392DYEX_AwOWZYzLNgynMMiQyC7eRo-bLCxmvCPl8KaE8j:1tp0DB:7tJsPPVWuLhAjhWkgHkswJAhZTK6OCucUflINvLNNyo','2025-03-17 07:27:37.916784'),('lsrz3jcjafm6nogxnquizsfy47yudmox','eyJ1c2VyX2lkIjo0LCJyb2xlIjoidXNlciJ9:1tsdT4:JJZrfCHqgYWNIYT7tW6fy20Hsn1oqD4f-Td5fF_zB_A','2025-03-27 07:59:02.702254'),('mm52k3ua4fd5ka9oa3gcd52r4j7wmwho','eyJ1c2VyX2lkIjo0fQ:1tsHOD:PmJSbL7tn7T49yAVlovBY_49jY3PZm_ANzF8gVh2Cpg','2025-03-26 08:24:33.690434'),('o5pg7gcgbp235vs0i6txx4lztqfaxu2j','.eJxVUMtOxDAM_JecR1XSxnnsEXHlBDeEqrTx7haWVrSphIT4d9yl4hHlMJ6xJ-N8qDat5dyuC8_tkNVBGYW_XJf6Fx43IT-n8TRV_TSWeeiqraXa1aW6mzJfbvbefwbntJxlutaWj55MjB05trapOZD22R97l7s6dYKJmiNL5V1nE9XsdOgtOctdbcX0J6OBmvk0LIVnzi2_p1d1IKilrJnH8r3G_cOtluNlbmto31ZeyjCNSzvNmWd1eCSCDwgNogPJDYgGnuA8Yo0YESycg29gtNQaLgraKotgQF6QQWzgjCCNEOEaBAGEIAMBXpgavkYIcMKLsYez8A5RvAkU4eVNDS-kSBJHJHraM5eppMtv8uuSV2Hb0O44r3PaZPkW_fkFJ9SFKg:1tpLZ7:l9Ti-pp8vHTPQbKNA_CbbxGlfppWznZB1IG85wie_jA','2025-03-18 06:15:41.778668'),('p63ugn31q7shudoo21f38vjgx8m72kue','.eJxVjLEOgzAQQ__lZhSRcJcAY_d-A8olR6FFRAowVf33QoUqsdl-tt-wLZK7MUKrC8hpEmh_ERTQ-W0duj8Hfc3Yh5fMB4hPPz-SCmle88jqqKiTLuqeoky3s3s5GPwy7GtTovSOdNMwWUGsjNRUuuj6YCMbz7smqnrZnbOMnozYsg5IFoUNwucLvOY_zw:1tp4Rq:wiFxkFOPeA9syme6bMgBSsXindb29I6DVGxJZhJ00IE','2025-03-17 11:59:02.861207'),('s1e3iuppgbi4tdywzrmpaqdkzm3oe2jz','.eJxVjssOwiAURP-FtSE8LhRcuvcbCFwuUjU0Ke3K-O-2SWN0O2fmZF4sxHWpYe00hzGzM_Ps9JuliA9qO8j32G4Tx6kt85j4XuEH7fw6ZXpeju6foMZetzVYqyRA9sUYZaWEpME61BIQhUYppImCjEJPyhWREg6KlPalGAdDcZv0-9G_P1h_OrE:1ttO8q:xql64TqitbMh09aZAJmfLiLyaaei3WGFJ1GGHxiZZq8','2025-03-29 09:49:16.575033'),('s261cfucbmcprfx8pidy2l3r4imvz7ke','.eJxVjEsOgzAMBe_iNYpCaoPDsvueASV2KLSISHxWVe_eUqFKbGfmvRdsS5rbQaHBAuY8Jmh-CApow7b27d8DnlkM8kzTLvQRpns2kqd1HqLZE3PYxdyypvF6tKeDPiz9d21rSi7UhF1ppfPkq1RZUSmpYifOueAuyBqQmTsSjFFLX0dmJOuJFN4ftWM_TQ:1tu72r:WNtXm8Xk2X_WSDMRc68mRzDS2rFowUIZKXF7o_jZH3g','2025-03-31 09:46:05.857353'),('urj4zksqmr0dslu0m6hdxpyjucaomg9b','eyJ1c2VyX2lkIjo0LCJyb2xlIjoidXNlciJ9:1ttPGG:tUIgwwzQ5RLSWpN6PmnpTspFp39a-NfoCfc68-Vl7r8','2025-03-29 11:01:00.591076'),('wptt8hiwmbigzqd4e6x31090zqc0kvvl','.eJxVjEsOgzAMBe_iNYpCaoPDsvueASV2KLSISHxWVe_eUqFKbGfmvRdsS5rbQaHBAuY8Jmh-CApow7b27d8DnlkM8kzTLvQRpns2kqd1HqLZE3PYxdyypvF6tKeDPiz9d21rSi7UhF1ppfPkq1RZUSmpYifOueAuyBqQmTsSjFFLX0dmJOuJFN4ftWM_TQ:1ttPKJ:ABEgHEOP-978VPZRt3CgaYhEZOK0-loZfTjRU9DWHDs','2025-03-29 11:05:11.081084');
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
  `username` varchar(100) DEFAULT NULL,
  `studentId` varchar(50) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `payment` varchar(20) NOT NULL,
  `registration_code` varchar(50) NOT NULL,
  `exam_domain_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `studentId` (`studentId`),
  UNIQUE KEY `registration_code` (`registration_code`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_registration_studentsdb`
--

LOCK TABLES `exam_registration_studentsdb` WRITE;
/*!40000 ALTER TABLE `exam_registration_studentsdb` DISABLE KEYS */;
INSERT INTO `exam_registration_studentsdb` VALUES (8,'USR00001','STD00001','rathi','alpha@rathitech.me','None','INR 999.00','f7e5c883-30e',6,4),(9,'USR00001','STD00002','rathi','alpha@rathitech.me','None','INR 999.00','7fdf8de5-a95',2,4),(10,'USR00001','STD00003','rathi','alpha@rathitech.me','None','INR 999.00','21c980d5-a03',3,4),(11,'USR00004','STD00004','Sameer','sameerparmar.sps@gmail.com','1797400400','INR 999.00','6f206b9b-d17',3,7),(12,'USR00001','STD00005','rathi','alpha@rathitech.me','None','INR 999.00','3cc7de96-dd6',4,4);
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
  `price` decimal(10,2) NOT NULL DEFAULT '99.00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `exam_code` (`exam_code`),
  CONSTRAINT `examportol_exam_chk_1` CHECK ((`duration` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examportol_exam`
--

LOCK TABLES `examportol_exam` WRITE;
/*!40000 ALTER TABLE `examportol_exam` DISABLE KEYS */;
INSERT INTO `examportol_exam` VALUES (1,'buisness general math',10,'E0001',99.00),(2,'Security and Cs',10,'E0002',99.00),(3,'Devops',60,'E0003',99.00),(4,'Buisness and  management',10,'E0004',99.00),(5,'Digital Marketing',100,'E0005',99.00),(6,'Aptitute  And Devops',10,'E0006',99.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=463 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examportol_exam_questions`
--

LOCK TABLES `examportol_exam_questions` WRITE;
/*!40000 ALTER TABLE `examportol_exam_questions` DISABLE KEYS */;
INSERT INTO `examportol_exam_questions` VALUES (1,1,155),(2,1,156),(3,1,157),(4,1,163),(5,1,166),(6,1,167),(7,1,169),(8,1,170),(9,1,172),(10,1,173),(11,1,174),(12,1,176),(13,1,177),(14,1,178),(15,1,179),(16,1,180),(17,1,181),(18,1,182),(19,1,183),(20,1,184),(21,1,185),(22,1,186),(23,1,187),(24,1,188),(25,1,189),(26,1,190),(27,1,191),(28,1,192),(29,1,193),(30,1,194),(31,1,195),(32,1,196),(33,1,197),(34,1,198),(35,1,199),(36,1,200),(37,1,201),(38,1,202),(39,1,203),(40,1,204),(41,2,55),(42,2,56),(43,2,57),(44,2,58),(45,2,59),(46,2,60),(47,2,61),(48,2,62),(49,2,63),(50,2,64),(51,2,65),(52,2,66),(53,2,67),(54,2,68),(55,2,69),(56,2,70),(57,2,71),(58,2,72),(59,2,73),(60,2,74),(61,2,75),(62,2,76),(63,2,77),(64,2,78),(65,2,79),(66,2,80),(67,2,81),(68,2,82),(69,2,83),(70,2,84),(71,2,85),(72,2,86),(73,2,87),(74,2,88),(75,2,89),(76,2,90),(77,2,91),(78,2,92),(79,2,93),(80,2,94),(81,2,95),(82,2,96),(83,2,97),(84,2,98),(85,2,99),(86,2,100),(87,2,101),(88,2,102),(89,2,103),(90,2,104),(139,3,105),(140,3,106),(141,3,107),(142,3,108),(143,3,109),(144,3,110),(145,3,111),(146,3,112),(147,3,113),(148,3,114),(149,3,115),(150,3,116),(151,3,117),(152,3,118),(153,3,119),(154,3,120),(155,3,121),(156,3,122),(157,3,123),(158,3,124),(159,3,125),(160,3,126),(161,3,127),(162,3,128),(163,3,129),(164,3,130),(165,3,131),(166,3,132),(167,3,133),(168,3,134),(169,3,135),(170,3,136),(171,3,137),(172,3,138),(173,3,139),(174,3,140),(175,3,141),(176,3,142),(177,3,143),(178,3,144),(179,3,145),(180,3,146),(181,3,147),(182,3,148),(183,3,149),(184,3,150),(185,3,151),(186,3,152),(187,3,153),(188,3,154),(91,3,205),(92,3,206),(93,3,207),(94,3,208),(95,3,209),(96,3,210),(97,3,211),(98,3,212),(99,3,213),(100,3,214),(101,3,215),(102,3,216),(103,3,217),(104,3,218),(105,3,219),(106,3,220),(107,3,221),(108,3,222),(109,3,223),(110,3,224),(111,3,225),(112,3,226),(113,3,227),(114,3,228),(115,3,229),(116,3,230),(117,3,231),(118,3,232),(119,3,233),(120,3,234),(121,3,235),(122,3,236),(123,3,237),(124,3,238),(125,3,239),(126,3,240),(127,3,241),(128,3,242),(129,3,243),(130,3,244),(131,3,245),(132,3,246),(133,3,247),(134,3,248),(135,3,249),(136,3,250),(137,3,251),(138,3,252),(190,4,56),(191,4,57),(192,4,58),(193,4,59),(197,4,63),(286,4,152),(287,4,153),(337,4,203),(339,4,205),(387,4,253),(389,4,255),(429,4,295),(431,4,297),(442,4,308),(444,4,310),(448,5,55),(449,5,56),(454,5,57),(455,5,58),(456,5,59),(457,5,60),(458,5,61),(459,5,62),(460,5,63),(450,5,64),(451,5,65),(452,5,66),(453,5,67),(446,5,105),(447,5,106),(461,6,55),(462,6,105);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
-- Table structure for table `internship_portal_application`
--

DROP TABLE IF EXISTS `internship_portal_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `internship_portal_application` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `skills` longtext NOT NULL,
  `cover_letter` longtext,
  `created_at` datetime(6) NOT NULL,
  `internship_id` int NOT NULL,
  `user_id` bigint NOT NULL,
  `seeker_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `internship_portal_ap_internship_id_5866382f_fk_internshi` (`internship_id`),
  KEY `internship_portal_ap_user_id_2f548ea3_fk_oauth_use` (`user_id`),
  KEY `internship_portal_ap_seeker_id_9c01965a_fk_internshi` (`seeker_id`),
  CONSTRAINT `internship_portal_ap_internship_id_5866382f_fk_internshi` FOREIGN KEY (`internship_id`) REFERENCES `internship_portal_internship` (`internship_id`),
  CONSTRAINT `internship_portal_ap_seeker_id_9c01965a_fk_internshi` FOREIGN KEY (`seeker_id`) REFERENCES `internship_portal_seeker` (`id`),
  CONSTRAINT `internship_portal_ap_user_id_2f548ea3_fk_oauth_use` FOREIGN KEY (`user_id`) REFERENCES `oauth_usersdb` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `internship_portal_application`
--

LOCK TABLES `internship_portal_application` WRITE;
/*!40000 ALTER TABLE `internship_portal_application` DISABLE KEYS */;
/*!40000 ALTER TABLE `internship_portal_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `internship_portal_category`
--

DROP TABLE IF EXISTS `internship_portal_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `internship_portal_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `category_code` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `category_code` (`category_code`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `internship_portal_category`
--

LOCK TABLES `internship_portal_category` WRITE;
/*!40000 ALTER TABLE `internship_portal_category` DISABLE KEYS */;
INSERT INTO `internship_portal_category` VALUES (1,'IT','I0001'),(2,'Management','I0002'),(3,'Engineering','I0003'),(4,'Marketing','I0004'),(5,'Data Science','I0005'),(6,'Product Management','I0006'),(7,'Design','I0007'),(8,'Customer Support','I0008'),(9,'Operations','I0009'),(10,'Finance','I0010'),(11,'HR','I0011'),(12,'Sales','I0012');
/*!40000 ALTER TABLE `internship_portal_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `internship_portal_company`
--

DROP TABLE IF EXISTS `internship_portal_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `internship_portal_company` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` longtext NOT NULL,
  `email` varchar(254) NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `logo` varchar(100) DEFAULT NULL,
  `about` longtext NOT NULL,
  `established_year` int NOT NULL,
  `company_code` varchar(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `company_code` (`company_code`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `internship_portal_company`
--

LOCK TABLES `internship_portal_company` WRITE;
/*!40000 ALTER TABLE `internship_portal_company` DISABLE KEYS */;
INSERT INTO `internship_portal_company` VALUES (3,'Alpha Tech','123 Alpha Road, Tech City, TX','info@alphatech.com','123-456-7890','internship_company_logos/companylogo5.png','Leading solutions in AI and Robotics',2012,'IC0001','2025-03-15 13:22:46.817276','2025-03-15 13:24:56.842184'),(4,'Beta Innovations','456 Beta Blvd, Innovation Park, CA','contact@betainnovations.com','987-654-3210','internship_company_logos/companylogo_GmeYqRY.jpeg','Pioneers in renewable energy',2015,'IC0002','2025-03-15 13:22:46.831212','2025-03-15 13:24:47.189992'),(6,'Gamma Global','789 Gamma Street, Global Hub, NY','contact@gammaglobal.com','555-123-4567','internship_company_logos/companylogo4_zuPAf3k.jpeg','Innovating global connectivity solutions',2010,'IC0003','2025-03-15 13:47:05.197672','2025-03-15 13:51:46.729999'),(7,'Delta Dynamics','321 Delta Avenue, Dynamics City, FL','hello@deltadynamics.com','555-234-5678','internship_company_logos/companylogo_1XDEtsi.jpeg','Revolutionizing dynamic engineering',2013,'IC0004','2025-03-15 13:47:05.241625','2025-03-15 13:52:58.218299'),(8,'Epsilon Enterprises','654 Epsilon Road, Enterprise Bay, WA','info@epsilonenterprises.com','555-345-6789','internship_company_logos/companylogo_JlgiJiG.jpeg','Excellence in business solutions',2008,'IC0005','2025-03-15 13:47:05.259650','2025-03-15 13:48:39.094516'),(9,'Zeta Solutions','987 Zeta Blvd, Solutions City, IL','support@zetasolutions.com','555-456-7890','internship_company_logos/companylogo5_l2r4J1K.png','Delivering innovative tech solutions',2016,'IC0006','2025-03-15 13:47:05.272127','2025-03-15 13:52:45.146166'),(10,'Theta Tech','159 Theta Street, Tech Valley, MA','careers@thetatech.com','555-567-8901','internship_company_logos/companylogo3.jpeg','Empowering technology-driven futures',2011,'IC0007','2025-03-15 13:47:05.284023','2025-03-15 13:52:12.456087'),(11,'Iota Innovations','753 Iota Drive, Innovation District, CO','connect@iotainnovations.com','555-678-9012','internship_company_logos/companylogo_9qqsisB.jpeg','Cutting-edge research and development',2014,'IC0008','2025-03-15 13:47:05.296016','2025-03-15 13:52:07.894796'),(12,'Kappa Konnect','852 Kappa Lane, Connect City, TX','info@kappakonnect.com','555-789-0123','internship_company_logos/companylogo5_xTsCkR8.png','Linking talent with opportunity',2009,'IC0009','2025-03-15 13:47:05.307592','2025-03-15 13:48:12.699121'),(13,'Lambda Labs','246 Lambda Court, Labs Town, CA','research@lambdalabs.com','555-890-1234','internship_company_logos/companylogo_1dWpmPm.jpeg','Innovative lab solutions for tomorrow',2018,'IC0010','2025-03-15 13:47:05.318791','2025-03-15 13:52:23.016325'),(14,'Mu Microsystems','135 Mu Street, Micro City, NV','info@mumicrosystems.com','555-901-2345','internship_company_logos/companylogo4_gQxPLab.jpeg','Micro innovations with macro impact',2012,'IC0011','2025-03-15 13:47:05.329546','2025-03-15 13:52:19.713256'),(15,'Nu Nexus','864 Nu Blvd, Nexus Point, OR','connect@nunexus.com','555-012-3456','internship_company_logos/companylogo5_GupGtrS.png','Creating networks for future leaders',2017,'IC0012','2025-03-15 13:47:05.341896','2025-03-15 13:52:16.613263');
/*!40000 ALTER TABLE `internship_portal_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `internship_portal_internship`
--

DROP TABLE IF EXISTS `internship_portal_internship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `internship_portal_internship` (
  `internship_id` int NOT NULL AUTO_INCREMENT,
  `role` varchar(255) NOT NULL,
  `responsibilities` longtext NOT NULL,
  `duration` varchar(50) NOT NULL,
  `stipend` decimal(10,2) DEFAULT NULL,
  `required_skills` longtext NOT NULL,
  `openings` int NOT NULL,
  `internship_code` varchar(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `category_id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  PRIMARY KEY (`internship_id`),
  UNIQUE KEY `internship_code` (`internship_code`),
  KEY `internship_portal_in_category_id_ad28e29f_fk_internshi` (`category_id`),
  KEY `internship_portal_in_company_id_6294fa68_fk_internshi` (`company_id`),
  CONSTRAINT `internship_portal_in_category_id_ad28e29f_fk_internshi` FOREIGN KEY (`category_id`) REFERENCES `internship_portal_category` (`id`),
  CONSTRAINT `internship_portal_in_company_id_6294fa68_fk_internshi` FOREIGN KEY (`company_id`) REFERENCES `internship_portal_company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `internship_portal_internship`
--

LOCK TABLES `internship_portal_internship` WRITE;
/*!40000 ALTER TABLE `internship_portal_internship` DISABLE KEYS */;
INSERT INTO `internship_portal_internship` VALUES (8,'Software Intern','Develop features, fix bugs, participate in code reviews','3 Months',3000.00,'Python, JavaScript',3,'I0001','2025-03-15 13:23:07.841952','2025-03-15 13:23:07.841998',3,3),(9,'Software Intern','Develop features, fix bugs, participate in code reviews','3 Months',3000.00,'Python, JavaScript',3,'I0002','2025-03-15 13:25:12.838412','2025-03-15 13:25:12.838447',3,3),(10,'Marketing Intern','Manage social media, create content, analyze campaigns','6 Months',0.00,'SEO, Content Creation',1,'I0003','2025-03-15 13:25:12.949538','2025-03-15 13:25:12.949559',4,4),(11,'Software Intern','Develop features, fix bugs, participate in code reviews','3 Months',3000.00,'Python, JavaScript',3,'I0004','2025-03-15 13:51:13.476979','2025-03-15 13:51:13.477023',3,3),(12,'QA Intern','Test software, create test cases, report bugs','3 Months',2500.00,'Attention to detail, Testing',2,'I0005','2025-03-15 13:51:13.644370','2025-03-15 13:51:13.644405',3,3),(13,'Data Analyst Intern','Analyze data sets, create reports, support decision making','6 Months',3500.00,'SQL, Python, Data Visualization',1,'I0006','2025-03-15 13:51:13.727578','2025-03-15 13:51:13.727600',5,3),(14,'Digital Marketing Intern','Manage online campaigns, create content, analyze metrics','6 Months',2000.00,'SEO, Content Creation',2,'I0007','2025-03-15 13:51:13.785237','2025-03-15 13:51:13.785267',4,3),(15,'Product Intern','Assist in product strategy, conduct market research, plan features','3 Months',3000.00,'Communication, Market Research',1,'I0008','2025-03-15 13:51:13.845152','2025-03-15 13:51:13.845185',6,3),(16,'UI/UX Intern','Design interfaces, perform user testing, create wireframes','6 Months',2800.00,'Figma, Adobe XD',1,'I0009','2025-03-15 13:51:13.936635','2025-03-15 13:51:13.936669',7,3),(17,'Support Intern','Assist customers, manage support tickets, provide solutions','3 Months',1500.00,'Communication, Problem Solving',2,'I0010','2025-03-15 13:51:14.031672','2025-03-15 13:51:14.031705',8,3),(18,'Operations Intern','Coordinate projects, streamline processes, monitor workflows','3 Months',2200.00,'Organizational skills, MS Office',1,'I0011','2025-03-15 13:51:14.123784','2025-03-15 13:51:14.123825',9,3),(19,'Finance Intern','Assist with budgeting and financial analysis','3 Months',2500.00,'Excel, Financial Analysis',1,'I0012','2025-03-15 13:51:14.233512','2025-03-15 13:51:14.233560',10,3),(20,'HR Intern','Support recruitment and training sessions','3 Months',2000.00,'Communication, Organization',1,'I0013','2025-03-15 13:51:14.344519','2025-03-15 13:51:14.344574',11,3),(21,'Marketing Intern','Manage social media, create content, analyze campaigns','6 Months',0.00,'SEO, Content Creation',1,'I0014','2025-03-15 13:51:14.409955','2025-03-15 13:51:14.409976',4,4),(22,'Software Intern','Develop and maintain software modules','3 Months',3200.00,'Java, Spring Boot',2,'I0015','2025-03-15 13:51:14.460606','2025-03-15 13:51:14.460625',3,4),(23,'Data Science Intern','Analyze marketing data, build models, support campaigns','6 Months',3500.00,'Python, R',1,'I0016','2025-03-15 13:51:14.518574','2025-03-15 13:51:14.518607',5,4),(24,'Product Intern','Assist in product strategy and requirements gathering','3 Months',3000.00,'Research, Communication',1,'I0017','2025-03-15 13:51:14.600392','2025-03-15 13:51:14.600439',6,4),(25,'Graphic Design Intern','Design promotional materials and social media graphics','3 Months',2200.00,'Adobe Photoshop, Illustrator',1,'I0018','2025-03-15 13:51:14.672790','2025-03-15 13:51:14.672825',7,4),(26,'Sales Intern','Support sales team and engage with potential clients','3 Months',2000.00,'Communication, CRM',2,'I0019','2025-03-15 13:51:14.742650','2025-03-15 13:51:14.742670',12,4),(27,'HR Intern','Support recruitment and employee engagement initiatives','3 Months',1800.00,'People Skills, Organization',1,'I0020','2025-03-15 13:51:14.792012','2025-03-15 13:51:14.792032',11,4),(28,'Customer Service Intern','Handle customer queries and resolve issues','3 Months',1600.00,'Communication, Problem Solving',1,'I0021','2025-03-15 13:51:14.847338','2025-03-15 13:51:14.847358',8,4),(29,'Operations Intern','Assist in streamlining processes and managing logistics','3 Months',2200.00,'Analytical, MS Office',1,'I0022','2025-03-15 13:51:14.901474','2025-03-15 13:51:14.901495',9,4),(30,'Finance Intern','Assist with budgeting and financial planning','3 Months',2500.00,'Excel, Accounting',1,'I0023','2025-03-15 13:51:14.949670','2025-03-15 13:51:14.949691',10,4),(31,'Software Intern','Develop global connectivity solutions','3 Months',3100.00,'C++, Python',2,'I0024','2025-03-15 13:51:14.992929','2025-03-15 13:51:14.992949',3,6),(32,'Software Intern','Develop features, fix bugs, participate in code reviews','3 Months',3000.00,'Python, JavaScript',3,'I0025','2025-03-15 13:53:15.050857','2025-03-15 13:53:15.050906',3,3),(33,'QA Intern','Test software, create test cases, report bugs','3 Months',2500.00,'Attention to detail, Testing',2,'I0026','2025-03-15 13:53:15.155757','2025-03-15 13:53:15.155786',3,3),(34,'Data Analyst Intern','Analyze data sets, create reports, support decision making','6 Months',3500.00,'SQL, Python, Data Visualization',1,'I0027','2025-03-15 13:53:15.223365','2025-03-15 13:53:15.223390',5,3),(35,'Digital Marketing Intern','Manage online campaigns, create content, analyze metrics','6 Months',2000.00,'SEO, Content Creation',2,'I0028','2025-03-15 13:53:15.270081','2025-03-15 13:53:15.270103',4,3),(36,'Product Intern','Assist in product strategy, conduct market research, plan features','3 Months',3000.00,'Communication, Market Research',1,'I0029','2025-03-15 13:53:15.330618','2025-03-15 13:53:15.330643',6,3),(37,'UI/UX Intern','Design interfaces, perform user testing, create wireframes','6 Months',2800.00,'Figma, Adobe XD',1,'I0030','2025-03-15 13:53:15.393146','2025-03-15 13:53:15.393175',7,3),(38,'Support Intern','Assist customers, manage support tickets, provide solutions','3 Months',1500.00,'Communication, Problem Solving',2,'I0031','2025-03-15 13:53:15.444903','2025-03-15 13:53:15.444942',8,3),(39,'Operations Intern','Coordinate projects, streamline processes, monitor workflows','3 Months',2200.00,'Organizational skills, MS Office',1,'I0032','2025-03-15 13:53:15.568649','2025-03-15 13:53:15.568676',9,3),(40,'Finance Intern','Assist with budgeting and financial analysis','3 Months',2500.00,'Excel, Financial Analysis',1,'I0033','2025-03-15 13:53:15.630499','2025-03-15 13:53:15.630534',10,3),(41,'HR Intern','Support recruitment and training sessions','3 Months',2000.00,'Communication, Organization',1,'I0034','2025-03-15 13:53:15.697876','2025-03-15 13:53:15.697907',11,3),(42,'Marketing Intern','Manage social media, create content, analyze campaigns','6 Months',0.00,'SEO, Content Creation',1,'I0035','2025-03-15 13:53:15.766812','2025-03-15 13:53:15.766852',4,4),(43,'Software Intern','Develop and maintain software modules','3 Months',3200.00,'Java, Spring Boot',2,'I0036','2025-03-15 13:53:15.815161','2025-03-15 13:53:15.815182',3,4),(44,'Data Science Intern','Analyze marketing data, build models, support campaigns','6 Months',3500.00,'Python, R',1,'I0037','2025-03-15 13:53:15.858325','2025-03-15 13:53:15.858346',5,4),(45,'Product Intern','Assist in product strategy and requirements gathering','3 Months',3000.00,'Research, Communication',1,'I0038','2025-03-15 13:53:15.973317','2025-03-15 13:53:15.973341',6,4),(46,'Graphic Design Intern','Design promotional materials and social media graphics','3 Months',2200.00,'Adobe Photoshop, Illustrator',1,'I0039','2025-03-15 13:53:16.037549','2025-03-15 13:53:16.037576',7,4),(47,'Sales Intern','Support sales team and engage with potential clients','3 Months',2000.00,'Communication, CRM',2,'I0040','2025-03-15 13:53:16.091228','2025-03-15 13:53:16.091246',12,4),(48,'HR Intern','Support recruitment and employee engagement initiatives','3 Months',1800.00,'People Skills, Organization',1,'I0041','2025-03-15 13:53:16.133382','2025-03-15 13:53:16.133413',11,4),(49,'Customer Service Intern','Handle customer queries and resolve issues','3 Months',1600.00,'Communication, Problem Solving',1,'I0042','2025-03-15 13:53:16.251286','2025-03-15 13:53:16.251321',8,4),(50,'Operations Intern','Assist in streamlining processes and managing logistics','3 Months',2200.00,'Analytical, MS Office',1,'I0043','2025-03-15 13:53:16.315916','2025-03-15 13:53:16.315948',9,4),(51,'Finance Intern','Assist with budgeting and financial planning','3 Months',2500.00,'Excel, Accounting',1,'I0044','2025-03-15 13:53:16.382699','2025-03-15 13:53:16.382731',10,4),(52,'Software Intern','Develop global connectivity solutions','3 Months',3100.00,'C++, Python',2,'I0045','2025-03-15 13:53:16.437251','2025-03-15 13:53:16.437282',3,6),(53,'DevOps Intern','Maintain CI/CD pipelines and automate deployments','3 Months',3000.00,'Docker, Kubernetes',1,'I0046','2025-03-15 13:53:16.503433','2025-03-15 13:53:16.503464',3,6),(54,'Data Analyst Intern','Analyze network data and create dashboards','6 Months',3400.00,'SQL, Python',1,'I0047','2025-03-15 13:53:16.573862','2025-03-15 13:53:16.573901',5,6),(55,'Social Media Intern','Manage social platforms and create engaging content','3 Months',2000.00,'Content Creation, Communication',2,'I0048','2025-03-15 13:53:16.645422','2025-03-15 13:53:16.645442',4,6),(56,'Product Intern','Assist in product development and market research','3 Months',2900.00,'Analytical, Research',1,'I0049','2025-03-15 13:53:16.700928','2025-03-15 13:53:16.700948',6,6),(57,'UI/UX Intern','Design user interfaces and conduct usability testing','3 Months',2800.00,'Sketch, Figma',1,'I0050','2025-03-15 13:53:16.749501','2025-03-15 13:53:16.749522',7,6),(58,'Support Intern','Provide technical support and handle customer queries','3 Months',1500.00,'Communication, Problem Solving',2,'I0051','2025-03-15 13:53:16.794581','2025-03-15 13:53:16.794602',8,6),(59,'Operations Intern','Coordinate between teams and manage schedules','3 Months',2300.00,'Organization, Communication',1,'I0052','2025-03-15 13:53:16.836632','2025-03-15 13:53:16.836653',9,6),(60,'HR Intern','Assist with recruitment and onboarding','3 Months',1900.00,'People Skills, Organization',1,'I0053','2025-03-15 13:53:16.927978','2025-03-15 13:53:16.927999',11,6),(61,'Finance Intern','Support budgeting and financial forecasting','3 Months',2600.00,'Excel, Analytical',1,'I0054','2025-03-15 13:53:17.046065','2025-03-15 13:53:17.046100',10,6),(62,'Software Intern','Develop dynamic engineering software','3 Months',3200.00,'Java, C++',2,'I0055','2025-03-15 13:53:17.121468','2025-03-15 13:53:17.121503',3,7),(63,'Hardware Intern','Assist in hardware testing and design','3 Months',3000.00,'Electronics, PCB Design',1,'I0056','2025-03-15 13:53:17.193683','2025-03-15 13:53:17.193716',3,7),(64,'Data Analyst Intern','Analyze product data and prepare reports','6 Months',3300.00,'Python, SQL',1,'I0057','2025-03-15 13:53:17.266412','2025-03-15 13:53:17.266447',5,7),(65,'Digital Marketing Intern','Plan digital campaigns and manage content','3 Months',2100.00,'SEO, Analytics',2,'I0058','2025-03-15 13:53:17.326083','2025-03-15 13:53:17.326112',4,7),(66,'Product Intern','Support product planning and strategy','3 Months',3000.00,'Research, Communication',1,'I0059','2025-03-15 13:53:17.380600','2025-03-15 13:53:17.380625',6,7),(67,'Graphic Design Intern','Create design assets and support branding','3 Months',2500.00,'Adobe Illustrator, Photoshop',1,'I0060','2025-03-15 13:53:17.442851','2025-03-15 13:53:17.442871',7,7),(68,'Customer Service Intern','Handle client inquiries and resolve issues','3 Months',1700.00,'Communication, Empathy',2,'I0061','2025-03-15 13:53:17.489910','2025-03-15 13:53:17.489936',8,7),(69,'Operations Intern','Improve operational workflows and processes','3 Months',2300.00,'Process Optimization, Excel',1,'I0062','2025-03-15 13:53:17.532729','2025-03-15 13:53:17.532756',9,7),(70,'Finance Intern','Assist with financial analysis and reporting','3 Months',2500.00,'Excel, Accounting',1,'I0063','2025-03-15 13:53:17.644535','2025-03-15 13:53:17.644566',10,7),(71,'HR Intern','Support HR operations and employee relations','3 Months',2000.00,'Organization, Communication',1,'I0064','2025-03-15 13:53:17.704022','2025-03-15 13:53:17.704042',11,7),(72,'Software Intern','Develop business solutions software','3 Months',3100.00,'Python, Java',2,'I0065','2025-03-15 13:53:17.747776','2025-03-15 13:53:17.747798',3,8),(73,'Marketing Intern','Assist in developing marketing strategies','3 Months',2000.00,'SEO, Social Media',2,'I0066','2025-03-15 13:53:17.865853','2025-03-15 13:53:17.865883',4,8),(74,'Data Analyst Intern','Analyze enterprise data and generate insights','6 Months',3400.00,'SQL, Python',1,'I0067','2025-03-15 13:53:17.922143','2025-03-15 13:53:17.922167',5,8),(75,'Product Intern','Support product lifecycle management','3 Months',2900.00,'Project Management, Research',1,'I0068','2025-03-15 13:53:17.973000','2025-03-15 13:53:17.973024',6,8),(76,'UI/UX Intern','Design user interfaces for enterprise solutions','3 Months',2800.00,'Sketch, Figma',1,'I0069','2025-03-15 13:53:18.082801','2025-03-15 13:53:18.082836',7,8),(77,'Support Intern','Provide customer service support','3 Months',1600.00,'Communication, Problem Solving',2,'I0070','2025-03-15 13:53:18.154085','2025-03-15 13:53:18.154120',8,8),(78,'Operations Intern','Streamline enterprise operational processes','3 Months',2300.00,'Organizational skills, MS Office',1,'I0071','2025-03-15 13:53:18.226851','2025-03-15 13:53:18.226885',9,8),(79,'Finance Intern','Assist in financial reporting and analysis','3 Months',2500.00,'Excel, Financial Modeling',1,'I0072','2025-03-15 13:53:18.296822','2025-03-15 13:53:18.296859',10,8),(80,'HR Intern','Coordinate recruitment and onboarding','3 Months',2000.00,'Interpersonal skills, Organization',1,'I0073','2025-03-15 13:53:18.369768','2025-03-15 13:53:18.369808',11,8),(81,'Sales Intern','Support sales operations and client outreach','3 Months',2200.00,'Communication, CRM',1,'I0074','2025-03-15 13:53:18.438334','2025-03-15 13:53:18.438368',12,8),(82,'Software Intern','Develop innovative tech solutions','3 Months',3100.00,'Java, Python',2,'I0075','2025-03-15 13:53:18.516851','2025-03-15 13:53:18.516883',3,9),(83,'DevOps Intern','Maintain infrastructure and manage deployments','3 Months',3000.00,'Docker, Jenkins',1,'I0076','2025-03-15 13:53:18.574931','2025-03-15 13:53:18.574955',3,9),(84,'Data Analyst Intern','Analyze tech trends to support products','6 Months',3400.00,'SQL, R',1,'I0077','2025-03-15 13:53:18.634404','2025-03-15 13:53:18.634440',5,9),(85,'Digital Marketing Intern','Enhance digital presence and engagement','3 Months',2100.00,'SEO, Content Marketing',2,'I0078','2025-03-15 13:53:18.707647','2025-03-15 13:53:18.707693',4,9),(86,'Product Intern','Assist in product development processes','3 Months',2900.00,'Analytical skills, Research',1,'I0079','2025-03-15 13:53:18.771973','2025-03-15 13:53:18.772005',6,9),(87,'Graphic Design Intern','Create visual content for campaigns','3 Months',2500.00,'Adobe Creative Suite',1,'I0080','2025-03-15 13:53:18.842530','2025-03-15 13:53:18.842564',7,9),(88,'Support Intern','Provide prompt customer assistance','3 Months',1700.00,'Communication, Problem Solving',2,'I0081','2025-03-15 13:53:18.913551','2025-03-15 13:53:18.913574',8,9),(89,'Operations Intern','Support daily operations and process improvement','3 Months',2300.00,'Organization, MS Office',1,'I0082','2025-03-15 13:53:18.976059','2025-03-15 13:53:18.976111',9,9),(90,'Finance Intern','Assist with financial analysis tasks','3 Months',2500.00,'Excel, Accounting',1,'I0083','2025-03-15 13:53:19.046916','2025-03-15 13:53:19.046951',10,9),(91,'HR Intern','Support HR initiatives and recruitment','3 Months',2000.00,'Communication, Organization',1,'I0084','2025-03-15 13:53:19.108341','2025-03-15 13:53:19.108362',11,9),(92,'Software Intern','Develop advanced tech solutions','3 Months',3200.00,'Python, C#',2,'I0085','2025-03-15 13:53:19.167201','2025-03-15 13:53:19.167221',3,10),(93,'Mobile App Intern','Develop innovative mobile applications','3 Months',3000.00,'Java, Kotlin',1,'I0086','2025-03-15 13:53:19.203492','2025-03-15 13:53:19.203511',3,10),(94,'Data Analyst Intern','Analyze tech data and trends','6 Months',3400.00,'SQL, Python',1,'I0087','2025-03-15 13:53:19.303852','2025-03-15 13:53:19.303881',5,10),(95,'Social Media Intern','Manage social channels and content','3 Months',2100.00,'Content Creation, Analytics',2,'I0088','2025-03-15 13:53:19.370519','2025-03-15 13:53:19.370551',4,10),(96,'Product Intern','Assist with product strategy formulation','3 Months',2900.00,'Research, Communication',1,'I0089','2025-03-15 13:53:19.433408','2025-03-15 13:53:19.433440',6,10),(97,'UI/UX Intern','Design user-centric interfaces','3 Months',2800.00,'Sketch, Figma',1,'I0090','2025-03-15 13:53:19.498055','2025-03-15 13:53:19.498082',7,10),(98,'Support Intern','Assist customers with inquiries','3 Months',1700.00,'Communication, Problem Solving',2,'I0091','2025-03-15 13:53:19.563204','2025-03-15 13:53:19.563236',8,10),(99,'Operations Intern','Streamline tech operations','3 Months',2300.00,'Organization, MS Office',1,'I0092','2025-03-15 13:53:19.628189','2025-03-15 13:53:19.628222',9,10),(100,'Finance Intern','Support financial planning activities','3 Months',2500.00,'Excel, Financial Analysis',1,'I0093','2025-03-15 13:53:19.702652','2025-03-15 13:53:19.702689',10,10),(101,'HR Intern','Assist in HR processes and talent management','3 Months',2000.00,'Communication, Organization',1,'I0094','2025-03-15 13:53:19.764185','2025-03-15 13:53:19.764205',11,10),(102,'Software Intern','Develop innovative software solutions','3 Months',3100.00,'Python, Java',2,'I0095','2025-03-15 13:53:19.806179','2025-03-15 13:53:19.806204',3,11),(103,'Embedded Systems Intern','Work on firmware and embedded software','3 Months',3000.00,'C, Embedded C',1,'I0096','2025-03-15 13:53:19.915428','2025-03-15 13:53:19.915463',3,11),(104,'Data Analyst Intern','Analyze sensor data and performance metrics','6 Months',3400.00,'Python, SQL',1,'I0097','2025-03-15 13:53:19.978574','2025-03-15 13:53:19.978638',5,11),(105,'Digital Marketing Intern','Develop and execute digital campaigns','3 Months',2100.00,'SEO, Content Marketing',2,'I0098','2025-03-15 13:53:20.036729','2025-03-15 13:53:20.036763',4,11),(106,'Product Intern','Assist in managing product lifecycle','3 Months',2900.00,'Research, Analysis',1,'I0099','2025-03-15 13:53:20.107381','2025-03-15 13:53:20.107433',6,11),(107,'UI/UX Intern','Design intuitive interfaces and user flows','3 Months',2800.00,'Figma, Adobe XD',1,'I0100','2025-03-15 13:53:20.177138','2025-03-15 13:53:20.177180',7,11),(108,'Support Intern','Provide timely tech support','3 Months',1700.00,'Communication, Problem Solving',2,'I0101','2025-03-15 13:53:20.247666','2025-03-15 13:53:20.247698',8,11),(109,'Operations Intern','Optimize operational efficiency','3 Months',2300.00,'Organization, MS Office',1,'I0102','2025-03-15 13:53:20.314744','2025-03-15 13:53:20.314787',9,11),(110,'Finance Intern','Assist with budgeting and cost analysis','3 Months',2500.00,'Excel, Analytical',1,'I0103','2025-03-15 13:53:20.377502','2025-03-15 13:53:20.377524',10,11),(111,'HR Intern','Support HR functions and recruitment','3 Months',2000.00,'Organization, Communication',1,'I0104','2025-03-15 13:53:20.420645','2025-03-15 13:53:20.420665',11,11),(112,'Software Intern','Develop connectivity solutions','3 Months',3100.00,'Python, C++',2,'I0105','2025-03-15 13:53:20.541697','2025-03-15 13:53:20.541740',3,12),(113,'Network Intern','Assist in network optimization','3 Months',3000.00,'Networking, Linux',1,'I0106','2025-03-15 13:53:20.623567','2025-03-15 13:53:20.623603',3,12),(114,'Data Analyst Intern','Analyze connectivity performance data','6 Months',3400.00,'SQL, Python',1,'I0107','2025-03-15 13:53:20.692849','2025-03-15 13:53:20.692890',5,12),(115,'Social Media Intern','Manage social channels and online presence','3 Months',2100.00,'Content Creation, Communication',2,'I0108','2025-03-15 13:53:20.774240','2025-03-15 13:53:20.774282',4,12),(116,'Product Intern','Support product development and analysis','3 Months',2900.00,'Research, Analysis',1,'I0109','2025-03-15 13:53:20.856405','2025-03-15 13:53:20.856444',6,12),(117,'Graphic Design Intern','Design marketing materials and visuals','3 Months',2500.00,'Adobe Creative Suite',1,'I0110','2025-03-15 13:53:20.940494','2025-03-15 13:53:20.940539',7,12),(118,'Support Intern','Provide technical support and troubleshooting','3 Months',1700.00,'Communication, Problem Solving',2,'I0111','2025-03-15 13:53:21.030870','2025-03-15 13:53:21.030900',8,12),(119,'Operations Intern','Coordinate daily tasks and manage schedules','3 Months',2300.00,'Organization, MS Office',1,'I0112','2025-03-15 13:53:21.152763','2025-03-15 13:53:21.152789',9,12),(120,'Finance Intern','Assist with financial processes and reporting','3 Months',2500.00,'Excel, Accounting',1,'I0113','2025-03-15 13:53:21.201387','2025-03-15 13:53:21.201416',10,12),(121,'HR Intern','Support HR tasks and recruitment','3 Months',2000.00,'Communication, Organization',1,'I0114','2025-03-15 13:53:21.264962','2025-03-15 13:53:21.265002',11,12),(122,'Software Intern','Develop lab automation software','3 Months',3200.00,'Python, C++',2,'I0115','2025-03-15 13:53:21.346638','2025-03-15 13:53:21.346666',3,13),(123,'Hardware Intern','Assist in lab equipment testing','3 Months',3000.00,'Electronics, PCB Design',1,'I0116','2025-03-15 13:53:21.405961','2025-03-15 13:53:21.405985',3,13),(124,'Data Analyst Intern','Analyze lab experiment data','6 Months',3400.00,'Python, SQL',1,'I0117','2025-03-15 13:53:21.452490','2025-03-15 13:53:21.452517',5,13),(125,'Marketing Intern','Support lab marketing initiatives','3 Months',2100.00,'Content Creation, SEO',2,'I0118','2025-03-15 13:53:21.580954','2025-03-15 13:53:21.581041',4,13),(126,'Product Intern','Support lab product development','3 Months',2900.00,'Research, Communication',1,'I0119','2025-03-15 13:53:21.665398','2025-03-15 13:53:21.665436',6,13),(127,'UI/UX Intern','Design interfaces for lab software','3 Months',2800.00,'Figma, Sketch',1,'I0120','2025-03-15 13:53:21.753726','2025-03-15 13:53:21.753776',7,13),(128,'Support Intern','Provide technical support for lab users','3 Months',1700.00,'Communication, Problem Solving',2,'I0121','2025-03-15 13:53:21.839643','2025-03-15 13:53:21.839689',8,13),(129,'Operations Intern','Improve lab operational workflows','3 Months',2300.00,'Organizational skills, MS Office',1,'I0122','2025-03-15 13:53:21.909618','2025-03-15 13:53:21.909656',9,13),(130,'Finance Intern','Assist with lab financials','3 Months',2500.00,'Excel, Financial Analysis',1,'I0123','2025-03-15 13:53:21.986193','2025-03-15 13:53:21.986232',10,13),(131,'HR Intern','Support lab HR operations','3 Months',2000.00,'Communication, Organization',1,'I0124','2025-03-15 13:53:22.067893','2025-03-15 13:53:22.067935',11,13);
/*!40000 ALTER TABLE `internship_portal_internship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `internship_portal_seeker`
--

DROP TABLE IF EXISTS `internship_portal_seeker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `internship_portal_seeker` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `skills` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `internship_portal_seeker_user_id_27302ccb_fk_oauth_usersdb_id` FOREIGN KEY (`user_id`) REFERENCES `oauth_usersdb` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `internship_portal_seeker`
--

LOCK TABLES `internship_portal_seeker` WRITE;
/*!40000 ALTER TABLE `internship_portal_seeker` DISABLE KEYS */;
/*!40000 ALTER TABLE `internship_portal_seeker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobportal_category`
--

DROP TABLE IF EXISTS `jobportal_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobportal_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `category_code` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `category_code` (`category_code`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobportal_category`
--

LOCK TABLES `jobportal_category` WRITE;
/*!40000 ALTER TABLE `jobportal_category` DISABLE KEYS */;
INSERT INTO `jobportal_category` VALUES (10,'Healthcare','C0001'),(11,'IT','C0002'),(12,'Finance','C0003'),(13,'Management','C0004');
/*!40000 ALTER TABLE `jobportal_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobportal_company`
--

DROP TABLE IF EXISTS `jobportal_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobportal_company` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `email` varchar(254) NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `about` text,
  `working_employees` int NOT NULL,
  `established_year` int NOT NULL,
  `company_code` varchar(6) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `company_code` (`company_code`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobportal_company`
--

LOCK TABLES `jobportal_company` WRITE;
/*!40000 ALTER TABLE `jobportal_company` DISABLE KEYS */;
INSERT INTO `jobportal_company` VALUES (9,'TechNova Solutions','123 Innovation Way, Silicon Valley, CA 94025','info@technova.com','(650) 555-1234','company_logos/companylogo.jpeg','Leading technology solutions provider specializing in AI and cloud computing.',850,2010,'CO0001','2025-03-13 05:51:23','2025-03-13 10:14:03'),(10,'MediHealth Systems','456 Healthcare Blvd, Boston, MA 02115','contact@medihealth.org','(617) 555-9876','company_logos/companylogo2.png','Innovative healthcare technology company improving patient outcomes worldwide.',620,2008,'CO0002','2025-03-13 05:51:23','2025-03-13 10:14:11'),(11,'FinanceForward LLC','789 Wall Street, New York, NY 10005','hello@financeforward.com','(212) 555-3456','company_logos/companylogo3.jpeg','Revolutionary fintech firm specializing in blockchain and secure payments.',350,2015,'CO0003','2025-03-13 05:51:23','2025-03-13 10:14:21'),(12,'Global Management Partners','321 Corporate Plaza, Chicago, IL 60601','info@globalmanagement.co','(312) 555-7890','company_logos/companylogo4.jpeg','Premier consulting firm offering strategic management solutions.',275,2012,'CO0004','2025-03-13 05:51:23','2025-03-13 10:14:29'),(13,'DataDriven Analytics','555 Tech Avenue, Seattle, WA 98104','contact@datadriven.io','(206) 555-2468','company_logos/companylogo5.png','Data science experts transforming big data into actionable insights.',430,2014,'CO0005','2025-03-13 05:51:23','2025-03-13 10:14:37');
/*!40000 ALTER TABLE `jobportal_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobportal_domain`
--

DROP TABLE IF EXISTS `jobportal_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobportal_domain` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `domain_code` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain_code` (`domain_code`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobportal_domain`
--

LOCK TABLES `jobportal_domain` WRITE;
/*!40000 ALTER TABLE `jobportal_domain` DISABLE KEYS */;
INSERT INTO `jobportal_domain` VALUES (8,'Web Development','D0001'),(9,'Mobile Development','D0002'),(10,'Data Science','D0003'),(11,'Cloud Computing','D0004'),(12,'UI/UX Design','D0005'),(13,'Medical Research','D0006'),(14,'Nursing','D0007'),(15,'Financial Analysis','D0008'),(16,'Investment Banking','D0009'),(17,'Project Management','D0010');
/*!40000 ALTER TABLE `jobportal_domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobportal_job`
--

DROP TABLE IF EXISTS `jobportal_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobportal_job` (
  `job_id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `company_id` int NOT NULL,
  `role` varchar(255) NOT NULL,
  `responsibilities` text NOT NULL,
  `position` varchar(255) NOT NULL,
  `eligibility` text NOT NULL,
  `job_type` varchar(50) NOT NULL,
  `salary_per_annum` decimal(10,2) NOT NULL,
  `required_experience` varchar(255) NOT NULL,
  `job_description` text NOT NULL,
  `required_skills` text NOT NULL,
  `vacancy` int NOT NULL,
  `job_code` varchar(5) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`job_id`),
  UNIQUE KEY `job_code` (`job_code`),
  KEY `category_id` (`category_id`),
  KEY `company_id` (`company_id`),
  CONSTRAINT `jobportal_job_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `jobportal_category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `jobportal_job_ibfk_2` FOREIGN KEY (`company_id`) REFERENCES `jobportal_company` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobportal_job`
--

LOCK TABLES `jobportal_job` WRITE;
/*!40000 ALTER TABLE `jobportal_job` DISABLE KEYS */;
INSERT INTO `jobportal_job` VALUES (7,12,11,'Risk Assessment Manager','Managing risk management projects from conception to completion. Conducting research on financial analysis. Presenting findings to stakeholders.','Mid-level','Bachelor\'s degree in Business Administration or related field. 5+ years of experience in risk management. Proficiency in accounting software.','Full-time',66237.00,'0-1 years','This role involves working with cross-functional teams to deliver high-quality solutions. The ideal candidate will have strong analytical skills and a passion for innovation.','Financial analysis, Excel, Accounting principles, Risk assessment, Investment strategies, Financial modeling',1,'J0001','2025-03-13 05:51:23','2025-03-13 05:51:23'),(8,11,12,'Cloud Architect','Coordinating with stakeholders on software initiatives. Troubleshooting issues related to infrastructure design. Documenting processes and procedures.','Senior','Advanced degree in Information Technology or equivalent experience. Track record of success in software. Expert knowledge of CI/CD pipelines.','Part-time',190059.00,'5+ years','We\'re looking for a talented professional to join our expanding team. This role offers opportunities for growth and development in a dynamic environment.','Python, JavaScript, AWS, Docker, Kubernetes, React, SQL, NoSQL, Machine Learning',2,'J0002','2025-03-13 05:51:23','2025-03-13 05:51:23'),(9,10,10,'Medical Technician','Developing and implementing clinical solutions. Collaborating with team members on clinical procedures. Monitoring and reporting on departmental efficiency.','Manager','Master\'s degree preferred in Public Health. Demonstrated experience in clinical. Knowledge of Electronic Health Records (EHR) and industry standards.','Part-time',163559.00,'5+ years','Join our team to help drive business growth through strategic initiatives. You\'ll be responsible for developing and implementing solutions that meet customer needs.','Patient care, Medical terminology, Health records management, Clinical procedures, Healthcare compliance',3,'J0003','2025-03-13 05:51:23','2025-03-13 05:51:23'),(10,11,12,'UI/UX Designer','Analyzing database data to identify trends. Creating reports on code quality. Working with cross-functional teams to implement solutions.','Lead','Master\'s degree preferred in Computer Science. Demonstrated experience in database. Knowledge of version control systems and industry standards.','Part-time',47583.00,'5+ years','Join our team to help drive business growth through strategic initiatives. You\'ll be responsible for developing and implementing solutions that meet customer needs.','Python, JavaScript, AWS, Docker, Kubernetes, React, SQL, NoSQL, Machine Learning',6,'J0004','2025-03-13 05:51:23','2025-03-13 05:51:23'),(11,11,13,'Software Engineer','Managing database projects from conception to completion. Conducting research on infrastructure design. Presenting findings to stakeholders.','Senior','Relevant degree in Software Engineering or related discipline. Previous experience in database. Ability to work with cloud platforms.','Full-time',53070.00,'3-5 years','An exciting opportunity to be part of a company that values innovation and creativity. The successful candidate will help shape the future of our products and services.','Python, JavaScript, AWS, Docker, Kubernetes, React, SQL, NoSQL, Machine Learning',4,'J0005','2025-03-13 05:51:23','2025-03-13 05:51:23'),(12,13,13,'HR Manager','Coordinating with stakeholders on operational initiatives. Troubleshooting issues related to project planning. Documenting processes and procedures.','Junior','Degree in Business Administration with 3-5 years of experience. Strong background in operational. Familiarity with business intelligence tools.','Part-time',62370.00,'1-3 years','This position requires a detail-oriented individual who can work independently and as part of a team. You\'ll contribute to projects that have a direct impact on our business.','Leadership, Strategic planning, Team building, Project management, Business analysis, Stakeholder management',2,'J0006','2025-03-13 05:51:23','2025-03-13 05:51:23'),(13,11,13,'Cloud Architect','Coordinating with stakeholders on network initiatives. Troubleshooting issues related to security protocols. Documenting processes and procedures.','Manager','Advanced degree in Data Science or equivalent experience. Track record of success in network. Expert knowledge of programming languages.','Full-time',31452.00,'0-1 years','We\'re looking for a talented professional to join our expanding team. This role offers opportunities for growth and development in a dynamic environment.','Python, JavaScript, AWS, Docker, Kubernetes, React, SQL, NoSQL, Machine Learning',4,'J0007','2025-03-13 05:51:23','2025-03-13 05:51:23'),(14,10,9,'Medical Technician','Coordinating with stakeholders on medical research initiatives. Troubleshooting issues related to medical documentation. Documenting processes and procedures.','Mid-level','Bachelor\'s degree in Health Informatics or related field. 1-2 years of experience in medical research. Proficiency in Electronic Health Records (EHR).','Full-time',60740.00,'1-3 years','This role involves working with cross-functional teams to deliver high-quality solutions. The ideal candidate will have strong analytical skills and a passion for innovation.','Patient care, Medical terminology, Health records management, Clinical procedures, Healthcare compliance',7,'J0008','2025-03-13 05:51:23','2025-03-13 05:51:23'),(15,12,13,'Investment Banker','Analyzing accounting data to identify trends. Creating reports on budget variance. Working with cross-functional teams to implement solutions.','Senior','Relevant degree in Economics or related discipline. Previous experience in accounting. Ability to work with financial software.','Full-time',37598.00,'5+ years','This role involves working with cross-functional teams to deliver high-quality solutions. The ideal candidate will have strong analytical skills and a passion for innovation.','Financial analysis, Excel, Accounting principles, Risk assessment, Investment strategies, Financial modeling',10,'J0009','2025-03-13 05:51:23','2025-03-13 05:51:23'),(16,11,10,'Cloud Architect','Developing and implementing software solutions. Collaborating with team members on system implementation. Monitoring and reporting on code quality.','Junior','Relevant degree in Cybersecurity or related discipline. Previous experience in software. Ability to work with version control systems.','Part-time',148717.00,'5+ years','This role involves working with cross-functional teams to deliver high-quality solutions. The ideal candidate will have strong analytical skills and a passion for innovation.','Python, JavaScript, AWS, Docker, Kubernetes, React, SQL, NoSQL, Machine Learning',3,'J0010','2025-03-13 05:51:23','2025-03-13 05:51:23'),(17,11,9,'DevOps Engineer','Leading the development of software strategies. Training team members on security protocols. Ensuring compliance with industry standards.','Junior','Degree in Computer Science with 5+ years of experience. Strong background in software. Familiarity with container technologies.','Full-time',95153.00,'5+ years','We\'re looking for a talented professional to join our expanding team. This role offers opportunities for growth and development in a dynamic environment.','Python, JavaScript, AWS, Docker, Kubernetes, React, SQL, NoSQL, Machine Learning',6,'J0011','2025-03-13 05:51:23','2025-03-13 05:51:23'),(18,12,12,'Financial Analyst','Coordinating with stakeholders on accounting initiatives. Troubleshooting issues related to investment strategies. Documenting processes and procedures.','Lead','Master\'s degree preferred in Business Administration. Demonstrated experience in accounting. Knowledge of financial modeling tools and industry standards.','Part-time',103890.00,'0-1 years','An exciting opportunity to be part of a company that values innovation and creativity. The successful candidate will help shape the future of our products and services.','Financial analysis, Excel, Accounting principles, Risk assessment, Investment strategies, Financial modeling',9,'J0012','2025-03-13 05:51:23','2025-03-13 05:51:23'),(19,11,9,'Cloud Architect','Leading the development of network strategies. Training team members on code development. Ensuring compliance with industry standards.','Senior','Relevant degree in Computer Science or related discipline. Previous experience in network. Ability to work with cloud platforms.','Part-time',139571.00,'1-3 years','This position requires a detail-oriented individual who can work independently and as part of a team. You\'ll contribute to projects that have a direct impact on our business.','Python, JavaScript, AWS, Docker, Kubernetes, React, SQL, NoSQL, Machine Learning',7,'J0013','2025-03-13 05:51:23','2025-03-13 05:51:23'),(20,13,13,'Strategic Planning Lead','Leading the development of team strategies. Training team members on strategic initiatives. Ensuring compliance with industry standards.','Mid-level','Relevant degree in Organizational Leadership or related discipline. Previous experience in team. Ability to work with productivity suites.','Part-time',144080.00,'0-1 years','Join our team to help drive business growth through strategic initiatives. You\'ll be responsible for developing and implementing solutions that meet customer needs.','Leadership, Strategic planning, Team building, Project management, Business analysis, Stakeholder management',3,'J0014','2025-03-13 05:51:23','2025-03-13 05:51:23'),(21,13,9,'Business Consultant','Analyzing business process data to identify trends. Creating reports on team productivity. Working with cross-functional teams to implement solutions.','Senior','Advanced degree in Human Resources or equivalent experience. Track record of success in business process. Expert knowledge of productivity suites.','Part-time',35199.00,'5+ years','We\'re looking for a talented professional to join our expanding team. This role offers opportunities for growth and development in a dynamic environment.','Leadership, Strategic planning, Team building, Project management, Business analysis, Stakeholder management',7,'J0015','2025-03-13 05:51:23','2025-03-13 05:51:23');
/*!40000 ALTER TABLE `jobportal_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobportal_jobapplication`
--

DROP TABLE IF EXISTS `jobportal_jobapplication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobportal_jobapplication` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `skills` longtext NOT NULL,
  `expected_ctc` varchar(50) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  `job_seeker_id` bigint NOT NULL,
  `job_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `jobportal_jobapplication_user_id_68897ff6_fk_oauth_usersdb_id` (`user_id`),
  KEY `jobportal_jobapplica_job_seeker_id_ba6069ef_fk_jobportal` (`job_seeker_id`),
  KEY `fk_jobapplication_job` (`job_id`),
  CONSTRAINT `fk_jobapplication_job` FOREIGN KEY (`job_id`) REFERENCES `jobportal_job` (`job_id`),
  CONSTRAINT `jobportal_jobapplica_job_seeker_id_ba6069ef_fk_jobportal` FOREIGN KEY (`job_seeker_id`) REFERENCES `jobportal_jobseeker` (`id`),
  CONSTRAINT `jobportal_jobapplication_user_id_68897ff6_fk_oauth_usersdb_id` FOREIGN KEY (`user_id`) REFERENCES `oauth_usersdb` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobportal_jobapplication`
--

LOCK TABLES `jobportal_jobapplication` WRITE;
/*!40000 ALTER TABLE `jobportal_jobapplication` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobportal_jobapplication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobportal_jobseeker`
--

DROP TABLE IF EXISTS `jobportal_jobseeker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobportal_jobseeker` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `skills` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `jobportal_jobseeker_user_id_1aead756_fk_oauth_usersdb_id` FOREIGN KEY (`user_id`) REFERENCES `oauth_usersdb` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobportal_jobseeker`
--

LOCK TABLES `jobportal_jobseeker` WRITE;
/*!40000 ALTER TABLE `jobportal_jobseeker` DISABLE KEYS */;
INSERT INTO `jobportal_jobseeker` VALUES (1,'sameer','parmar','987897987','dds,s,s,sd,sd,sd,ds,','2025-03-15 15:08:18.132716','2025-03-15 15:08:18.132767',4);
/*!40000 ALTER TABLE `jobportal_jobseeker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobportal_jobseeker_education`
--

DROP TABLE IF EXISTS `jobportal_jobseeker_education`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobportal_jobseeker_education` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `degree` varchar(255) NOT NULL,
  `specialization` varchar(255) DEFAULT NULL,
  `institution` varchar(255) NOT NULL,
  `passing_year` varchar(4) NOT NULL,
  `score` varchar(50) DEFAULT NULL,
  `job_seeker_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobportal_jobseeker__job_seeker_id_1832f936_fk_jobportal` (`job_seeker_id`),
  CONSTRAINT `jobportal_jobseeker__job_seeker_id_1832f936_fk_jobportal` FOREIGN KEY (`job_seeker_id`) REFERENCES `jobportal_jobseeker` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobportal_jobseeker_education`
--

LOCK TABLES `jobportal_jobseeker_education` WRITE;
/*!40000 ALTER TABLE `jobportal_jobseeker_education` DISABLE KEYS */;
INSERT INTO `jobportal_jobseeker_education` VALUES (1,'ss','ssasa','sasaassa','2122','222',1);
/*!40000 ALTER TABLE `jobportal_jobseeker_education` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobportal_jobseeker_experience`
--

DROP TABLE IF EXISTS `jobportal_jobseeker_experience`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobportal_jobseeker_experience` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `company` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `description` longtext,
  `achievements` longtext,
  `job_seeker_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobportal_jobseeker__job_seeker_id_376aa4d5_fk_jobportal` (`job_seeker_id`),
  CONSTRAINT `jobportal_jobseeker__job_seeker_id_376aa4d5_fk_jobportal` FOREIGN KEY (`job_seeker_id`) REFERENCES `jobportal_jobseeker` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobportal_jobseeker_experience`
--

LOCK TABLES `jobportal_jobseeker_experience` WRITE;
/*!40000 ALTER TABLE `jobportal_jobseeker_experience` DISABLE KEYS */;
INSERT INTO `jobportal_jobseeker_experience` VALUES (1,'sasas','sasas','2025-03-15','2025-03-15','ssasa','sassa,s,s,s,s,',1);
/*!40000 ALTER TABLE `jobportal_jobseeker_experience` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_collegesdb`
--

LOCK TABLES `oauth_collegesdb` WRITE;
/*!40000 ALTER TABLE `oauth_collegesdb` DISABLE KEYS */;
INSERT INTO `oauth_collegesdb` VALUES (1,'Aligarh Muslim University','Aligarh'),(2,'Banaras Hindu University','Varanasi'),(3,'University of Delhi','Delhi'),(4,'Jawaharlal Nehru University','New Delhi'),(5,'Jamia Millia Islamia','New Delhi'),(6,'Visva-Bharati University','Santiniketan'),(7,'University of Hyderabad','Hyderabad'),(8,'Pondicherry University','Puducherry'),(9,'North-Eastern Hill University','Shillong'),(10,'Tezpur University','Tezpur'),(11,'University of Calcutta','Kolkata'),(12,'University of Madras','Chennai'),(13,'University of Mumbai','Mumbai'),(14,'Osmania University','Hyderabad'),(15,'Panjab University','Chandigarh'),(16,'Savitribai Phule Pune University','Pune'),(17,'University of Rajasthan','Jaipur'),(18,'Andhra University','Visakhapatnam'),(19,'Karnatak University','Dharwad'),(20,'University of Kerala','Thiruvananthapuram'),(21,'Indian Institute of Science','Bengaluru'),(22,'Tata Institute of Social Sciences','Mumbai'),(23,'Birla Institute of Technology and Science','Pilani'),(24,'Manipal Academy of Higher Education','Manipal'),(25,'Symbiosis International University','Pune'),(26,'Vellore Institute of Technology','Vellore'),(27,'SRM Institute of Science and Technology','Chennai'),(28,'Amrita Vishwa Vidyapeetham','Coimbatore'),(29,'Jamia Hamdard','New Delhi'),(30,'Sathyabama Institute of Science and Technology','Chennai'),(31,'Amity University','Noida'),(32,'Lovely Professional University','Phagwara'),(33,'Christ University','Bengaluru'),(34,'Ashoka University','Sonepat'),(35,'Azim Premji University','Bengaluru'),(36,'OP Jindal Global University','Sonepat'),(37,'Shiv Nadar University','Greater Noida'),(38,'Kalinga Institute of Industrial Technology','Bhubaneswar'),(39,'Bennett University','Greater Noida'),(40,'NMIMS University','Mumbai'),(41,'Indian Institute of Technology Bombay','Mumbai'),(42,'Indian Institute of Technology Delhi','New Delhi'),(43,'Indian Institute of Technology Madras','Chennai'),(44,'Indian Institute of Technology Kanpur','Kanpur'),(45,'Indian Institute of Technology Kharagpur','Kharagpur'),(46,'Indian Institute of Technology Roorkee','Roorkee'),(47,'Indian Institute of Technology Guwahati','Guwahati'),(48,'Indian Institute of Technology Hyderabad','Hyderabad'),(49,'National Institute of Technology Trichy','Tiruchirappalli'),(50,'National Institute of Technology Surathkal','Mangalore'),(51,'St. Stephen\'s College','Delhi'),(52,'Miranda House','Delhi'),(53,'Hindu College','Delhi'),(54,'Presidency College','Chennai'),(55,'Loyola College','Chennai'),(56,'Fergusson College','Pune'),(57,'St. Xavier\'s College','Mumbai'),(58,'Madras Christian College','Chennai'),(59,'Christ College','Bengaluru'),(60,'Lady Shri Ram College for Women','New Delhi'),(61,'Indian Statistical Institute','Kolkata'),(62,'Tata Institute of Fundamental Research','Mumbai'),(63,'Indian Institute of Management Ahmedabad','Ahmedabad'),(64,'Indian Institute of Management Bangalore','Bengaluru'),(65,'Indian Institute of Management Calcutta','Kolkata'),(66,'All India Institute of Medical Sciences','New Delhi'),(67,'Postgraduate Institute of Medical Education and Research','Chandigarh'),(68,'National Law School of India University','Bengaluru'),(69,'NALSAR University of Law','Hyderabad'),(70,'National Institute of Fashion Technology','New Delhi'),(71,'Sri Venkateswara University','Tirupati'),(72,'Acharya Nagarjuna University','Guntur'),(73,'Jawaharlal Nehru Technological University','Kakinada'),(74,'Dr. NTR University of Health Sciences','Vijayawada'),(75,'Rajiv Gandhi University','Itanagar'),(76,'North Eastern Regional Institute of Science and Technology (NERIST)','Nirjuli'),(77,'Gauhati University','Guwahati'),(78,'Dibrugarh University','Dibrugarh'),(79,'Assam University','Silchar'),(80,'Cotton University','Guwahati'),(81,'Patna University','Patna'),(82,'Magadh University','Bodh Gaya'),(83,'Lalit Narayan Mithila University','Darbhanga'),(84,'Bhupendra Narayan Mandal University','Madhepura'),(85,'Aryabhatta Knowledge University','Patna'),(86,'Pandit Ravishankar Shukla University','Raipur'),(87,'Guru Ghasidas Vishwavidyalaya','Bilaspur'),(88,'Indira Gandhi Krishi Vishwavidyalaya','Raipur'),(89,'Chhattisgarh Swami Vivekanand Technical University','Bhilai'),(90,'Hidayatullah National Law University','Raipur'),(91,'Goa University','Taleigao Plateau'),(92,'National Institute of Technology Goa','Farmagudi'),(93,'Goa Institute of Management','Sanquelim'),(94,'Maharaja Sayajirao University of Baroda','Vadodara'),(95,'Sardar Vallabhbhai National Institute of Technology','Surat'),(96,'Gujarat University','Ahmedabad'),(97,'Pandit Deendayal Energy University','Gandhinagar'),(98,'Nirma University','Ahmedabad'),(99,'Kurukshetra University','Kurukshetra'),(100,'Maharshi Dayanand University','Rohtak'),(101,'J.C. Bose University of Science and Technology','Faridabad'),(102,'Guru Jambheshwar University of Science and Technology','Hisar'),(103,'Chaudhary Charan Singh Haryana Agricultural University','Hisar'),(104,'Deenbandhu Chhotu Ram University of Science and Technology','Murthal'),(105,'Himachal Pradesh University','Shimla'),(106,'Dr. Yashwant Singh Parmar University of Horticulture and Forestry','Solan'),(107,'Jaypee University of Information Technology','Solan'),(108,'National Institute of Technology Hamirpur','Hamirpur'),(109,'Chaudhary Sarwan Kumar Himachal Pradesh Krishi Vishvavidyalaya','Palampur'),(110,'Ranchi University','Ranchi'),(111,'Birla Institute of Technology','Mesra'),(112,'Vinoba Bhave University','Hazaribagh'),(113,'Sido Kanhu Murmu University','Dumka'),(114,'National University of Study and Research in Law','Ranchi'),(115,'University of Mysore','Mysuru'),(116,'Visvesvaraya Technological University','Belagavi'),(117,'Karnataka University','Dharwad'),(118,'Mangalore University','Mangaluru'),(119,'Kuvempu University','Shivamogga'),(120,'Cochin University of Science and Technology','Kochi'),(121,'Mahatma Gandhi University','Kottayam'),(122,'University of Calicut','Malappuram'),(123,'Kerala Agricultural University','Thrissur'),(124,'National Institute of Technology Calicut','Kozhikode'),(125,'Jiwaji University','Gwalior'),(126,'Devi Ahilya Vishwavidyalaya','Indore'),(127,'Barkatullah University','Bhopal'),(128,'Rani Durgavati Vishwavidyalaya','Jabalpur'),(129,'Madhya Pradesh Bhoj Open University','Bhopal'),(130,'Shivaji University','Kolhapur'),(131,'Dr. Babasaheb Ambedkar Marathwada University','Aurangabad'),(132,'Swami Ramanand Teerth Marathwada University','Nanded'),(133,'Chaudhary Bansi Lal University','Bhiwani'),(134,'Chaudhary Ranbir Singh University','Jind'),(135,'Dr. B.R. Ambedkar National Law University','Sonipat'),(136,'Pandit Bhagwat Dayal Sharma University of Health Sciences','Rohtak'),(137,'Indira Gandhi University','Rewari'),(138,'Al-Falah University','Faridabad'),(139,'Apeejay Stya University','Gurugram'),(140,'BML Munjal University','Gurugram'),(141,'GD Goenka University','Gurugram'),(142,'IILM University','Gurugram'),(143,'K.R. Mangalam University','Gurugram'),(144,'The NorthCap University','Gurugram'),(145,'Shree Guru Gobind Singh Tricentenary University','Gurugram'),(146,'Starex University','Gurugram'),(147,'Sushant University','Gurugram'),(148,'Om Sterling Global University','Hisar'),(149,'Jagan Nath University','Bahadurgarh'),(150,'PDM University','Bahadurgarh'),(151,'Sanskaram University','Jhajjar'),(152,'NIILM University','Kaithal'),(153,'MVN University','Palwal'),(154,'Geeta University','Panipat'),(155,'Baba Mast Nath University','Rohtak'),(156,'Rishihood University','Sonipat'),(157,'SRM University','Sonipat'),(158,'Acharya Narendra Dev College','Delhi'),(159,'Aditi Mahavidyalaya','Delhi'),(160,'Ahilya Bai College of Nursing','Delhi'),(161,'Aryabhatta College','Delhi'),(162,'Atma Ram Sanatan Dharma College','Delhi'),(163,'Bhagini Nivedita College','Delhi'),(164,'Bharati College','Delhi'),(165,'Bhaskaracharya College of Applied Sciences','Delhi'),(166,'Bhim Rao Ambedkar College','Delhi'),(167,'Deen Dayal Upadhyaya College','Delhi'),(168,'Delhi College of Arts and Commerce','Delhi'),(169,'Delhi Institute of Pharmaceutical Sciences and Research','Delhi'),(170,'Deshbandhu College','Delhi'),(171,'Dyal Singh College','Delhi'),(172,'Gargi College','Delhi'),(173,'Janki Devi Memorial College','Delhi'),(174,'Jesus and Mary College','Delhi'),(175,'Kalindi College','Delhi'),(176,'Kamala Nehru College','Delhi'),(177,'Keshav Mahavidyalaya','Delhi'),(178,'Lakshmibai College','Delhi'),(179,'Maharaja Agrasen College','Delhi'),(180,'Maharshi Valmiki College of Education','Delhi'),(181,'Maitreyi College','Delhi'),(182,'Mata Sundri College for Women','Delhi'),(183,'Motilal Nehru College','Delhi'),(184,'P.G.D.A.V. College','Delhi'),(185,'Rajdhani College','Delhi'),(186,'Rajkumari Amrit Kaur College of Nursing','Delhi'),(187,'Ram Lal Anand College','Delhi'),(188,'Ramanujan College','Delhi'),(189,'Satyawati College','Delhi'),(190,'Shaheed Bhagat Singh College','Delhi'),(191,'Shri Guru Gobind Singh College of Commerce','Delhi'),(192,'Shri Guru Nanak Dev Khalsa College','Delhi'),(193,'Shri Guru Tegh Bahadur Khalsa College','Delhi'),(194,'Shyam Lal College','Delhi'),(195,'Shyama Prasad Mukherji College','Delhi'),(196,'Vivekananda College','Delhi');
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
/*!40000 ALTER TABLE `oauth_otpdb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_paymenttransaction`
--

DROP TABLE IF EXISTS `oauth_paymenttransaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_paymenttransaction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` varchar(100) NOT NULL,
  `payment_id` varchar(100) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(10) NOT NULL,
  `status` varchar(50) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `subscription_plan_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `exam_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_paymenttransac_subscription_plan_id_213c470f_fk_price_sub` (`subscription_plan_id`),
  KEY `oauth_paymenttransaction_user_id_96f38971_fk_oauth_usersdb_id` (`user_id`),
  KEY `oauth_paymenttransaction_exam_id_fk` (`exam_id`),
  CONSTRAINT `oauth_paymenttransac_subscription_plan_id_213c470f_fk_price_sub` FOREIGN KEY (`subscription_plan_id`) REFERENCES `price_subscriptionplan` (`id`),
  CONSTRAINT `oauth_paymenttransaction_exam_id_fk` FOREIGN KEY (`exam_id`) REFERENCES `examportol_exam` (`id`) ON DELETE SET NULL,
  CONSTRAINT `oauth_paymenttransaction_user_id_96f38971_fk_oauth_usersdb_id` FOREIGN KEY (`user_id`) REFERENCES `oauth_usersdb` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_paymenttransaction`
--

LOCK TABLES `oauth_paymenttransaction` WRITE;
/*!40000 ALTER TABLE `oauth_paymenttransaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_paymenttransaction` ENABLE KEYS */;
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
  `subscription_plan_id` bigint DEFAULT NULL,
  `subscription_start` datetime DEFAULT NULL,
  `subscription_end` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone_number` (`phone_number`),
  KEY `fk_subscription_plan` (`subscription_plan_id`),
  CONSTRAINT `oauth_usersdb_subscription_plan_id_b02c7315_fk_price_sub` FOREIGN KEY (`subscription_plan_id`) REFERENCES `price_subscriptionplan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_usersdb`
--

LOCK TABLES `oauth_usersdb` WRITE;
/*!40000 ALTER TABLE `oauth_usersdb` DISABLE KEYS */;
INSERT INTO `oauth_usersdb` VALUES (4,'rathi','alpha@rathitech.me',NULL,'pbkdf2_sha256$870000$ZnX5fKuyjCTJhdg7onDPyA$mHVW5alXUbcU8LPh+hKABIz91t1BZ35LNqQvzqsDPEU=','Unknown Course','2000-01-01',NULL,'USR00001','2025-03-17 09:46:05.849546','other',NULL,NULL,1,1,1,'Unknown College',4,'2025-03-04 10:31:23','2025-04-03 10:31:23'),(5,'Sameer Parmar','sameerparmar.sp@gmail.com','0788628920','','Unknown Course','2000-01-01',NULL,'USR00002','2025-03-04 09:38:46.028912','other','114100297514272700577',NULL,1,0,0,'Unknown College',4,'2025-03-04 09:47:40','2025-04-03 09:47:40'),(6,'Sameer Parmar','sameer-parmar@github.placeholder','5726063422','','Unknown Course','2000-01-01',NULL,'USR00003','2025-03-12 05:40:05.072745','other',NULL,'85328386',1,0,0,'Unknown College',NULL,NULL,NULL),(7,'Sameer','sameerparmar.sps@gmail.com','1797400400','','Unknown Course','2000-01-01',NULL,'USR00004','2025-03-04 12:21:07.581003','other','102838661416704075136',NULL,1,0,0,'Unknown College',4,'2025-03-04 12:23:01','2025-04-03 12:23:01'),(8,'Sameer Parmar','aasasss@s.com','09882471285','pbkdf2_sha256$870000$Q4gGdxtJI3aQlZ5XZOJZXj$CfJV0pssNDhK37IYQB2BKcYLfAG4bN8KVbEfBNGGsr4=','Unknown Course','1221-11-11','','USR00005',NULL,'other',NULL,NULL,1,0,0,'Karnatak University',NULL,NULL,NULL),(9,'sam','ss@gmail.com',NULL,'pbkdf2_sha256$870000$8pg9B0GmpidBzKrT4Y6Q3u$H+0kXmmDV+0ns3KCIMPYhOK9e+keah+kSY27/WSQ0iU=','Unknown Course','2000-01-01',NULL,'USR00006','2025-03-15 09:49:16.545835','other',NULL,NULL,1,1,1,'Unknown College',NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price_plantype`
--

LOCK TABLES `price_plantype` WRITE;
/*!40000 ALTER TABLE `price_plantype` DISABLE KEYS */;
INSERT INTO `price_plantype` VALUES (3,'basic','basic'),(4,'monthly','monthly');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price_subscriptionplan`
--

LOCK TABLES `price_subscriptionplan` WRITE;
/*!40000 ALTER TABLE `price_subscriptionplan` DISABLE KEYS */;
INSERT INTO `price_subscriptionplan` VALUES (3,0.00,1,'{\"Compiler one time\": \"Compiler one time\", \"Cannot attend Practice Questions\": \"Cannot attend Practice Questions\", \"Limited access to Study material\": \"Limited access to Study material\", \"Explore and apply to jobs/Internships\": \"Explore and apply to jobs/Internships\", \"Basic profile visibility to recruiters\": \"Basic profile visibility to recruiters\"}',1,0.00,3),(4,299.00,1,'{\"Study material access\": \"Study material access\", \"Limited Compiler access\": \"Limited Compiler access\", \"Good Visibility to recruiters\": \"Good Visibility to recruiters\", \"Limited Access to Practice Questions\": \"Limited Access to Practice Questions\", \"Give exam and become eligible for shortlisting\": \"Give exam and become eligible for shortlisting\"}',1,5.00,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialaccount`
--

LOCK TABLES `socialaccount_socialaccount` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialaccount` DISABLE KEYS */;
INSERT INTO `socialaccount_socialaccount` VALUES (3,'google','102838661416704075136','2025-03-04 12:21:07.563006','2025-03-04 12:21:07.563032','{\"aud\": \"260573975109-31a4bo03gs4scr5fa53brmfj4uu5m3ku.apps.googleusercontent.com\", \"azp\": \"260573975109-31a4bo03gs4scr5fa53brmfj4uu5m3ku.apps.googleusercontent.com\", \"exp\": 1741094461, \"iat\": 1741090861, \"iss\": \"https://accounts.google.com\", \"sub\": \"102838661416704075136\", \"name\": \"Sameer\", \"email\": \"sameerparmar.sps@gmail.com\", \"at_hash\": \"UMXOMXw9QU4H8H0ZwiluoA\", \"picture\": \"https://lh3.googleusercontent.com/a/ACg8ocJAzdTBMHjWKi_-VoBy5eV-zSjTuvcSLrv77TAuemkmCIcH3g=s96-c\", \"given_name\": \"Sameer\", \"email_verified\": true}',7);
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

-- Dump completed on 2025-03-17 15:18:30
