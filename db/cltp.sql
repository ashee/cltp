-- phpMyAdmin SQL Dump
-- version 3.2.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 24, 2010 at 01:52 PM
-- Server version: 5.1.44
-- PHP Version: 5.2.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `cltp`
--

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(80) NOT NULL,
  `firstname` varchar(200) DEFAULT NULL,
  `lastname` varchar(200) DEFAULT NULL,
  `password` char(40) NULL,
  `email` varchar(255) NOT NULL,
  `last_login` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` VALUES(1, 'Student');
INSERT INTO `roles` VALUES(2, 'Faculty');
INSERT INTO `roles` VALUES(3, 'Clerkship');
INSERT INTO `roles` VALUES(4, 'Program');
INSERT INTO `roles` VALUES(5, 'Staff');
INSERT INTO `roles` VALUES(6, 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `privileges`
--

CREATE TABLE `privileges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `role_privileges`
--

CREATE TABLE `role_privileges` (
  `role_id` int(11) NOT NULL,
  `privilege_id` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`role_id`,`privilege_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_roles`
--
INSERT INTO `user_roles` VALUES (1, 6, 1, now(), 1, now());

-- --------------------------------------------------------

--
-- Table structure for table `care_settings`
--

CREATE TABLE `care_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` char(2) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `care_settings`
--

INSERT INTO `care_settings` VALUES(1, 'OP', 'Outpatient');
INSERT INTO `care_settings` VALUES(2, 'IP', 'Inpatient');
INSERT INTO `care_settings` VALUES(3, 'ER', 'Emergency');
INSERT INTO `care_settings` VALUES(4, 'NB', 'Newborn');

-- --------------------------------------------------------

--
-- Table structure for table `clerkships`
--

CREATE TABLE `clerkships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `clerkships`
--

INSERT INTO `clerkships` VALUES(-1, 'All');
INSERT INTO `clerkships` VALUES(1, 'Pediatrics');

-- --------------------------------------------------------

--
-- Table structure for table `clinics`
--

CREATE TABLE `clinics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `care_setting` char(2) NOT NULL,
  `category` varchar(25) NOT NULL,
  `clinic_name` varchar(255) NOT NULL,
  `code` varchar(50) NOT NULL,
  `location` varchar(100) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `contact` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `care_setting` (`care_setting`),
  KEY `category` (`category`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `users`
--
INSERT INTO `users` VALUES(1, 'amitava', 'Amitava', 'Shee', null, 'amitava@umich.edu', now(), 1, now(), 1, now());

--
-- Dumping data for table `clinics`
--

INSERT INTO `clinics` VALUES(1, 'OP', 'Primary Care', 'Primary Care', 'EA', 'East Med Campus', '734-647-5670', 'Dr. Burrows');
INSERT INTO `clinics` VALUES(2, 'OP', 'Primary Care', 'Primary Care', 'BWD', 'Briarwood, Bldg #2', '734-647-9000', 'Dr. Kileny');
INSERT INTO `clinics` VALUES(3, 'OP', 'Primary Care', 'Primary Care', 'CAN', 'Canton', '734-844-5370', 'Dr. Mitchell');
INSERT INTO `clinics` VALUES(4, 'OP', 'Primary Care', 'Primary Care', 'YPSI', 'Ypsilanti', '734-484-7288', 'Dr. Joiner');
INSERT INTO `clinics` VALUES(5, 'OP', 'Primary Care', 'Primary Care', 'WA', 'West Ann Arbor', '734-998-7380', 'Dr. Ljungman');
INSERT INTO `clinics` VALUES(6, 'OP', 'Primary Care', 'Primary Care', 'SAL', 'Saline ', '734-4292302', 'Dr. Noble');
INSERT INTO `clinics` VALUES(7, 'OP', 'Primary Care', 'Primary Care', 'LIV', 'Livonia', '248-888-9000', 'Dr. Zeskind');
INSERT INTO `clinics` VALUES(8, 'OP', 'Primary Care', 'Primary Care', 'HOW', 'Howell', '517-548-1020', 'Dr. Orringer');
INSERT INTO `clinics` VALUES(9, 'OP', 'Primary Care', 'Primary Care', 'BRI', 'Brighton', '810-227-9510', 'Dr. Madison');
INSERT INTO `clinics` VALUES(10, 'OP', 'Specialty', 'Adolescent-Briarwood', 'ADOL', 'Briarwood, Bldg #2', '734-647-9000', 'Dr. Christner  ');
INSERT INTO `clinics` VALUES(11, 'OP', 'Specialty', 'Adolescent-Ypsilanti HC', 'ADOL-YHC', 'Ypsilanti', '734-484-7288', 'Dr. Christner  ');
INSERT INTO `clinics` VALUES(12, 'OP', 'Specialty', 'Behavior', 'BEH', 'TC First Floor Area D', '734-936-4220', 'Dr. Felt');
INSERT INTO `clinics` VALUES(13, 'OP', 'Specialty', 'Cardiology', 'CAR', 'Mott F1217', '734-764-5176', 'Dr. Armstrong');
INSERT INTO `clinics` VALUES(14, 'OP', 'Specialty', 'Coagulation', 'COAG', 'Cancer Ctr. B1-358 ', '734-936-6393', 'Dr. Pipe');
INSERT INTO `clinics` VALUES(15, 'OP', 'Specialty', 'Developmental', 'DEV', 'TC First Floor Area D', '734-936-6379', 'Ann Iatrow ');
INSERT INTO `clinics` VALUES(16, 'OP', 'Specialty', 'Endocrinology', 'END', 'TC First Floor Area D', '734-764-5175', 'Dr. Kasa-Vubu');
INSERT INTO `clinics` VALUES(17, 'OP', 'Specialty', 'Gastroenterology', 'GI', 'TC First Floor Area D', '734-763-9650', 'Dr. Brown');
INSERT INTO `clinics` VALUES(18, 'OP', 'Specialty', 'Gastroenterology with NP', 'GI-NP', 'Briarwood, Bldg #2', '734-763-9650', 'Nurse Practioner');
INSERT INTO `clinics` VALUES(19, 'OP', 'Specialty', 'Genetics ', 'GEN', 'TC First Floor Area D', '734-763-6767', 'Dr. Keegan');
INSERT INTO `clinics` VALUES(20, 'OP', 'Specialty', 'Hematology', 'HEM', 'Cancer Ct.r B1 Area A', '734-764-7126', 'Dr. Jasty');
INSERT INTO `clinics` VALUES(21, 'OP', 'Specialty', 'Infectious Disease', 'ID', 'TC First Floor Area D', '734-763-2440', 'Dr. Blackwood');
INSERT INTO `clinics` VALUES(22, 'OP', 'Specialty', 'Nephrology', 'NEP', 'TC First Floor Area D', '734-936-4210', 'Dr. Collins');
INSERT INTO `clinics` VALUES(23, 'OP', 'Specialty', 'Neurology', 'NEU', 'TC First Floor Area D', '734-647-3101', 'Dr. Leber');
INSERT INTO `clinics` VALUES(24, 'OP', 'Specialty', 'Physical Med & Rehab', 'PMR', '325 E. Eisenhower Pkwy', '734-936-8613', 'Dr. Nelson - (Burlington Bldg, floor 1, Ste. 100, next to Art Van/Max & Erma''s)');
INSERT INTO `clinics` VALUES(25, 'OP', 'Specialty', 'Pulmonary', 'PUL', 'TC First Floor Area D', '734-763-7545', 'Dr.  Nasr');
INSERT INTO `clinics` VALUES(26, 'OP', 'Specialty', 'Rheumatology', 'RHE', 'TC First Floor Area D', '734-615-1688', 'Dr. Adams');
INSERT INTO `clinics` VALUES(27, 'OP', 'Specialty', 'Sleep Clinic', 'SLP', 'TC First Floor Area D-green staff room', '734-936-4179', 'Dr. Hoban');
INSERT INTO `clinics` VALUES(28, 'OP', 'Specialty', 'Seminar', 'SEM', 'Ford Auditorium', '734-647-4740', 'Sara Weir  - (Weekly M3 Seminar)');
INSERT INTO `clinics` VALUES(29, 'OP', 'Specialty', 'Hematology/Oncology', 'Heme/Onc', 'Mott 7 West', '734-764-6170', 'Attending on Heme/Onc');
INSERT INTO `clinics` VALUES(30, 'NB', 'Newborn', 'Newborn', 'NB', 'University Nursery F4760', '734-764-8134', 'Attending on Newborn');
INSERT INTO `clinics` VALUES(31, 'IP', 'Inpatient', 'Inpatient', 'Gold', 'Mott 5 East & 5 West', '734-763-4387 (E)\r734-764-7102 (W)', 'Senior Resident for Gold or Silver');
INSERT INTO `clinics` VALUES(32, 'IP', 'Inpatient', 'Inpatient', 'Maize', 'Mott 6 West', '734-764-7112', 'Senior Resident for Maize');
INSERT INTO `clinics` VALUES(33, 'IP', 'Inpatient', 'Inpatient', 'Blue', 'Mott 6 West', '734-764-7112', 'Senior Resident for Blue');
INSERT INTO `clinics` VALUES(34, 'IP', 'Inpatient', 'Inpatient', 'Silver', 'Mott 5 East & 5 West', '734-763-4387 (E)\r734-764-7102 (W)', 'Senior Resident for Gold or Silver');
INSERT INTO `clinics` VALUES(35, 'IP', 'Inpatient', 'Inpatient', 'Plaid', 'TBD', 'TBD', 'TBD');
INSERT INTO `clinics` VALUES(36, 'ER', 'Emergency', 'Peds Emergency', 'ER', 'UH B1 A236', '734-763-1271', 'Dr. Sikavitsas');

-- --------------------------------------------------------

--
-- Table structure for table `dx`
--

CREATE TABLE `dx` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clerkship_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `clerkship_id` (`clerkship_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `dx`
--

INSERT INTO `dx` VALUES(1, 1, 1, 'School Difficulties/LD/ADHD');
INSERT INTO `dx` VALUES(2, 1, 1, 'Depression');
INSERT INTO `dx` VALUES(3, 1, 1, 'Developmental Delays');
INSERT INTO `dx` VALUES(4, 1, 1, 'Bulimia');
INSERT INTO `dx` VALUES(5, 1, 1, 'Anorexia Nervosa');
INSERT INTO `dx` VALUES(6, 1, 1, 'Eating Disorders NOS');
INSERT INTO `dx` VALUES(7, 1, 1, 'Anxiety');
INSERT INTO `dx` VALUES(8, 1, 1, 'PMDD');
INSERT INTO `dx` VALUES(9, 1, 1, 'Emotional/Psychological Abuse');
INSERT INTO `dx` VALUES(10, 1, 1, 'Substance Use');
INSERT INTO `dx` VALUES(11, 1, 1, 'Chronic Pain');
INSERT INTO `dx` VALUES(12, 1, 1, 'Prader-Willi Syndrome');
INSERT INTO `dx` VALUES(13, 1, 1, 'Autism');
INSERT INTO `dx` VALUES(14, 1, 1, 'Obsessive Compulsive Disorder');
INSERT INTO `dx` VALUES(15, 1, 1, 'Conversion Disorder (including non-eplieptic seizures');
INSERT INTO `dx` VALUES(16, 1, 2, 'Patent Ductus Arteriosus');
INSERT INTO `dx` VALUES(17, 1, 2, 'Ventricular Septal Defect');
INSERT INTO `dx` VALUES(18, 1, 2, 'D-Transposition of the Great Arteries');
INSERT INTO `dx` VALUES(19, 1, 2, 'Cardiomyopathy');
INSERT INTO `dx` VALUES(20, 1, 2, 'Aortic Coarctation');
INSERT INTO `dx` VALUES(21, 1, 2, 'Chest Pain');
INSERT INTO `dx` VALUES(22, 1, 2, 'Innocent Murmurs');
INSERT INTO `dx` VALUES(23, 1, 2, 'Supraventricular Tachycardia');
INSERT INTO `dx` VALUES(24, 1, 2, 'Systemic Hypertension');
INSERT INTO `dx` VALUES(25, 1, 2, 'Atrial Septal Defect');
INSERT INTO `dx` VALUES(26, 1, 2, 'Tetralogy of Fallot');
INSERT INTO `dx` VALUES(27, 1, 2, 'Atrioventricular Septal Defect');
INSERT INTO `dx` VALUES(28, 1, 2, 'Bicuspid Aortic Valve and Aortic Stenosis');
INSERT INTO `dx` VALUES(29, 1, 3, 'Pediatric Brain Tumors');
INSERT INTO `dx` VALUES(30, 1, 3, 'Bruxism');
INSERT INTO `dx` VALUES(31, 1, 3, 'Pediatric Lymphoma');
INSERT INTO `dx` VALUES(32, 1, 3, 'Allergic Rhinitis');
INSERT INTO `dx` VALUES(33, 1, 3, 'Cerebral Palsy');
INSERT INTO `dx` VALUES(34, 1, 3, 'Excessive Daytime Somnolence');
INSERT INTO `dx` VALUES(35, 1, 3, 'Fatigue');
INSERT INTO `dx` VALUES(36, 1, 3, 'Thombotic Disorders inlcuidng CVL Thrombosis');
INSERT INTO `dx` VALUES(37, 1, 3, 'Thrombocytophenia like ITP');
INSERT INTO `dx` VALUES(38, 1, 4, 'Acne');
INSERT INTO `dx` VALUES(39, 1, 4, 'Viral Exanthem');
INSERT INTO `dx` VALUES(40, 1, 4, 'Eczema');
INSERT INTO `dx` VALUES(41, 1, 4, 'Warts');
INSERT INTO `dx` VALUES(42, 1, 4, 'Atopic Dermititis');
INSERT INTO `dx` VALUES(43, 1, 4, 'Rash');
INSERT INTO `dx` VALUES(44, 1, 4, 'Contact Dermatitis');
INSERT INTO `dx` VALUES(45, 1, 5, 'Hemoptysis');
INSERT INTO `dx` VALUES(46, 1, 5, 'Sexual Abuse: By Adult Relative');
INSERT INTO `dx` VALUES(47, 1, 5, 'Medical Child Abuse (Munchausen Syndrome By Proxy)');
INSERT INTO `dx` VALUES(48, 1, 5, 'Sexual Abuse: By Another Child');
INSERT INTO `dx` VALUES(49, 1, 5, 'Physical Abuse: Bruises');
INSERT INTO `dx` VALUES(50, 1, 5, 'Physical Abuse: Burns');
INSERT INTO `dx` VALUES(51, 1, 5, 'Physical Abuse: Fractures');
INSERT INTO `dx` VALUES(52, 1, 5, 'Neglect: Drownings/Near-Drownings');
INSERT INTO `dx` VALUES(53, 1, 5, 'Neglect: Ingestions');
INSERT INTO `dx` VALUES(54, 1, 5, 'Injury');
INSERT INTO `dx` VALUES(55, 1, 5, 'Neglect: Injuries');
INSERT INTO `dx` VALUES(56, 1, 5, 'Apparent Life Threatening Event');
INSERT INTO `dx` VALUES(57, 1, 5, 'Fractures');
INSERT INTO `dx` VALUES(58, 1, 5, 'Lacerations');
INSERT INTO `dx` VALUES(59, 1, 5, 'Otalgia');
INSERT INTO `dx` VALUES(60, 1, 5, 'Limping');
INSERT INTO `dx` VALUES(61, 1, 5, 'Head Trauma');
INSERT INTO `dx` VALUES(62, 1, 5, 'Trauma:  Acute');
INSERT INTO `dx` VALUES(63, 1, 6, 'Abdominal Pain');
INSERT INTO `dx` VALUES(64, 1, 6, 'Malabsorption');
INSERT INTO `dx` VALUES(65, 1, 6, 'Diarrhea ');
INSERT INTO `dx` VALUES(66, 1, 6, 'Celiac Disease');
INSERT INTO `dx` VALUES(67, 1, 6, 'Inflammatory Bowel Disease');
INSERT INTO `dx` VALUES(68, 1, 6, 'Elevated Aminotransferases');
INSERT INTO `dx` VALUES(69, 1, 6, 'Vomiting');
INSERT INTO `dx` VALUES(70, 1, 6, 'Cholestasis');
INSERT INTO `dx` VALUES(71, 1, 6, 'Jaundice  ');
INSERT INTO `dx` VALUES(72, 1, 6, 'Gastroenteritis');
INSERT INTO `dx` VALUES(73, 1, 6, 'Jaundice of Newborn');
INSERT INTO `dx` VALUES(74, 1, 6, 'Gastroesophageal Reflux');
INSERT INTO `dx` VALUES(75, 1, 6, 'Constipation');
INSERT INTO `dx` VALUES(76, 1, 6, 'GER');
INSERT INTO `dx` VALUES(77, 1, 6, 'GI Bleeding');
INSERT INTO `dx` VALUES(78, 1, 6, 'Pancreatitis');
INSERT INTO `dx` VALUES(79, 1, 7, 'Microcephaly');
INSERT INTO `dx` VALUES(80, 1, 7, 'Obesity');
INSERT INTO `dx` VALUES(81, 1, 7, 'Macrocephaly');
INSERT INTO `dx` VALUES(82, 1, 8, 'Hereditary Spherocytosis');
INSERT INTO `dx` VALUES(83, 1, 8, 'Acute Leukemia');
INSERT INTO `dx` VALUES(84, 1, 8, 'Sickle Cell Disease');
INSERT INTO `dx` VALUES(85, 1, 8, 'Neuroblastoma');
INSERT INTO `dx` VALUES(86, 1, 8, 'Neutropenia');
INSERT INTO `dx` VALUES(87, 1, 8, 'Iron Deficiency Anemia');
INSERT INTO `dx` VALUES(88, 1, 8, 'Bleeding Disorders like Hemophilia and Von Will brand Disease');
INSERT INTO `dx` VALUES(89, 1, 8, 'Leukocyte Dysfunction');
INSERT INTO `dx` VALUES(90, 1, 8, 'Bone Marrow Failure');
INSERT INTO `dx` VALUES(91, 1, 8, 'Bone Sarcoma');
INSERT INTO `dx` VALUES(92, 1, 9, 'Well Care Newborn 0-1 month');
INSERT INTO `dx` VALUES(93, 1, 9, 'Well Care Infant 1-12 months');
INSERT INTO `dx` VALUES(94, 1, 9, 'Well Chld 1-5 Years');
INSERT INTO `dx` VALUES(95, 1, 9, 'Well Child 6-12 Years');
INSERT INTO `dx` VALUES(96, 1, 9, 'Well Chld 13-18 Years');
INSERT INTO `dx` VALUES(97, 1, 9, 'Well Young Adult 19-23 Years');
INSERT INTO `dx` VALUES(98, 1, 10, 'Vaginitis');
INSERT INTO `dx` VALUES(99, 1, 10, 'Abscess');
INSERT INTO `dx` VALUES(100, 1, 10, 'Septic Joints');
INSERT INTO `dx` VALUES(101, 1, 10, 'Sexually Transmitted Diseases');
INSERT INTO `dx` VALUES(102, 1, 10, 'Pharyngitis');
INSERT INTO `dx` VALUES(103, 1, 10, 'Viral Gastro');
INSERT INTO `dx` VALUES(104, 1, 10, 'Immunodeficiency');
INSERT INTO `dx` VALUES(105, 1, 10, 'Viral Illness');
INSERT INTO `dx` VALUES(106, 1, 10, 'Sinusitis');
INSERT INTO `dx` VALUES(107, 1, 10, 'Cellulitis');
INSERT INTO `dx` VALUES(108, 1, 10, 'Influenza');
INSERT INTO `dx` VALUES(109, 1, 10, 'Conjunctivitis');
INSERT INTO `dx` VALUES(110, 1, 10, 'Recurrent Pneumonia');
INSERT INTO `dx` VALUES(111, 1, 10, 'Toxic Synovitis');
INSERT INTO `dx` VALUES(112, 1, 10, 'Red Eye');
INSERT INTO `dx` VALUES(113, 1, 10, 'Otitis Media');
INSERT INTO `dx` VALUES(114, 1, 10, 'Lymphadenopathy');
INSERT INTO `dx` VALUES(115, 1, 10, 'Rule Out Sepsis/Presumed Sepsis in Infant ');
INSERT INTO `dx` VALUES(116, 1, 10, 'URI');
INSERT INTO `dx` VALUES(117, 1, 11, 'Partial Epilepsy');
INSERT INTO `dx` VALUES(118, 1, 11, 'Delayed Sleep Phase Syndrome');
INSERT INTO `dx` VALUES(119, 1, 11, 'Maladaptive Sleep Onset Associations');
INSERT INTO `dx` VALUES(120, 1, 11, 'Hypotonia');
INSERT INTO `dx` VALUES(121, 1, 11, 'Migraine');
INSERT INTO `dx` VALUES(122, 1, 11, 'Infantile Spasms');
INSERT INTO `dx` VALUES(123, 1, 11, 'Narcolepsy');
INSERT INTO `dx` VALUES(124, 1, 11, 'Sleep-Related Enuresis');
INSERT INTO `dx` VALUES(125, 1, 11, 'Sleep-Related Epilepsy');
INSERT INTO `dx` VALUES(126, 1, 11, 'Stroke');
INSERT INTO `dx` VALUES(127, 1, 11, 'Chronic Daily Headache');
INSERT INTO `dx` VALUES(128, 1, 11, 'Insomnia/Night Walking');
INSERT INTO `dx` VALUES(129, 1, 11, 'Syncope');
INSERT INTO `dx` VALUES(130, 1, 11, 'Insufficient Sleep');
INSERT INTO `dx` VALUES(131, 1, 11, 'Febrile Seizures');
INSERT INTO `dx` VALUES(132, 1, 11, 'Poor Sleep Hygiene');
INSERT INTO `dx` VALUES(133, 1, 11, 'Non-REM Arousal Parasomnias');
INSERT INTO `dx` VALUES(134, 1, 11, 'Generalized Epilepsy');
INSERT INTO `dx` VALUES(135, 1, 11, 'Tics/Tourette Syndrome');
INSERT INTO `dx` VALUES(136, 1, 11, 'Restless Leg Syndrome/Periodic Limb Movement Disorder');
INSERT INTO `dx` VALUES(137, 1, 11, 'Headache');
INSERT INTO `dx` VALUES(138, 1, 12, 'Failure to Thrive');
INSERT INTO `dx` VALUES(139, 1, 12, 'Dehydration');
INSERT INTO `dx` VALUES(140, 1, 13, 'Broncho Pulmonary Dysplasia');
INSERT INTO `dx` VALUES(141, 1, 13, 'Ventilator Dependent Patients');
INSERT INTO `dx` VALUES(142, 1, 13, 'Bronchomalacia');
INSERT INTO `dx` VALUES(143, 1, 13, 'Hypercarbia');
INSERT INTO `dx` VALUES(144, 1, 13, 'Hypoxia');
INSERT INTO `dx` VALUES(145, 1, 13, 'Vocal Cord Dysfunction');
INSERT INTO `dx` VALUES(146, 1, 13, 'Apnea of Infancy');
INSERT INTO `dx` VALUES(147, 1, 13, 'Apnea of Maturity');
INSERT INTO `dx` VALUES(148, 1, 13, 'Pneumonia');
INSERT INTO `dx` VALUES(149, 1, 13, 'Pneumothorax');
INSERT INTO `dx` VALUES(150, 1, 13, 'Asthma');
INSERT INTO `dx` VALUES(151, 1, 13, 'Poor CPAP Tolerance');
INSERT INTO `dx` VALUES(152, 1, 13, 'Chronic Sinusitis');
INSERT INTO `dx` VALUES(153, 1, 13, 'Post Tracheostomy Follow Up');
INSERT INTO `dx` VALUES(154, 1, 13, 'Congenital Central Hypoventilation Syndrome');
INSERT INTO `dx` VALUES(155, 1, 13, 'Pulmonary Stenosis');
INSERT INTO `dx` VALUES(156, 1, 13, 'Obstructive Sleep Apnea');
INSERT INTO `dx` VALUES(157, 1, 13, 'Laryngomalacia');
INSERT INTO `dx` VALUES(158, 1, 13, 'Obstructive Sleep Apnea/Central Apnea');
INSERT INTO `dx` VALUES(159, 1, 13, 'Croup');
INSERT INTO `dx` VALUES(160, 1, 13, 'Tracheomalacia');
INSERT INTO `dx` VALUES(161, 1, 13, 'Cystic Fibrosis');
INSERT INTO `dx` VALUES(162, 1, 13, 'Bronchial Asthma');
INSERT INTO `dx` VALUES(163, 1, 13, 'Bronchiolitis');
INSERT INTO `dx` VALUES(164, 1, 14, 'Musculoskeletal Pain');
INSERT INTO `dx` VALUES(165, 1, 14, 'Newborn Feeding Problem');
INSERT INTO `dx` VALUES(166, 1, 15, 'Other');

-- --------------------------------------------------------

--
-- Table structure for table `dx_categories`
--

CREATE TABLE `dx_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clerkship_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `clerkship_id` (`clerkship_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `dx_categories`
--

INSERT INTO `dx_categories` VALUES(1, 1, 'Behavior');
INSERT INTO `dx_categories` VALUES(2, 1, 'Cardiology');
INSERT INTO `dx_categories` VALUES(3, 1, 'Chronic Medical Problem');
INSERT INTO `dx_categories` VALUES(4, 1, 'Dermatology');
INSERT INTO `dx_categories` VALUES(5, 1, 'Emergent Clinical Problem');
INSERT INTO `dx_categories` VALUES(6, 1, 'Gastroenterology');
INSERT INTO `dx_categories` VALUES(7, 1, 'Growth');
INSERT INTO `dx_categories` VALUES(8, 1, 'H/O');
INSERT INTO `dx_categories` VALUES(9, 1, 'Health Maintenance');
INSERT INTO `dx_categories` VALUES(10, 1, 'Infectious Disease');
INSERT INTO `dx_categories` VALUES(11, 1, 'Neurology');
INSERT INTO `dx_categories` VALUES(12, 1, 'Nutrition');
INSERT INTO `dx_categories` VALUES(13, 1, 'Respiratory');
INSERT INTO `dx_categories` VALUES(14, 1, 'Unique Condition');
INSERT INTO `dx_categories` VALUES(15, 1, 'Other');

-- --------------------------------------------------------

--
-- Table structure for table `procedures`
--

CREATE TABLE `procedures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clerkship_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `clerkship_id` (`clerkship_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `procedures`
--

-- IV Placement, Arterial Blood Gas, Foley, NG Tube,  Phlebotomy (All clerkships)
-- Circumcision, Giving an Immunization, Lumbar Puncture (peds)

INSERT INTO `procedures` VALUES(NULL, -1, 'Arterial Blood Gas');
INSERT INTO `procedures` VALUES(NULL, -1, 'Foley');
INSERT INTO `procedures` VALUES(NULL, -1, 'IV Placement');
INSERT INTO `procedures` VALUES(NULL, -1, 'NG Tube');
INSERT INTO `procedures` VALUES(NULL, -1, 'Phlebotomy');

INSERT INTO `procedures` VALUES(NULL, 1, 'Circumcision');
INSERT INTO `procedures` VALUES(NULL, 1, 'Giving an Immunization');
INSERT INTO `procedures` VALUES(NULL, 1, 'Lumbar Puncture');
INSERT INTO `procedures` VALUES(5000, -1, 'Other');

-- --------------------------------------------------------

--
-- Table structure for table `encounters`
--

CREATE TABLE `encounters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clerkship_id` int(11) NOT NULL,
  `clinic_id` int(11) NOT NULL,
  `encounter_date` datetime NOT NULL,
  `patient_id` varchar(25) NOT NULL COMMENT 'not a db foreign key - just bizname of a text field',
  `age` varchar(25) NOT NULL,
  `gender` char(1) NOT NULL,
  `hx` char(1) NOT NULL COMMENT 'P = performed, O = observed, B = both',
  `px` char(1) NOT NULL COMMENT 'P = performed, O = observed, B = both',
  `notes` text,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `clerkship_id` (`clerkship_id`),
  KEY `clinic_id` (`clinic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `encounters`
--

-- --------------------------------------------------------

--
-- Table structure for table `encounter_dx`
--

CREATE TABLE `encounter_dx` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `encounter_id` int(11) NOT NULL,
  `dx_type` char(1) NOT NULL COMMENT 'P = Primary Problem, S = Secondary Problem',
  `dx_id` int(11) NOT NULL COMMENT '166 (Other) if dx not in db',
  `other` text COMMENT 'populated only if dx_id = 166 (Other)',
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `encounter_dx`
--

-- --------------------------------------------------------
--
-- Table structure for table `encounter_procedures`
--

CREATE TABLE `encounter_procedures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `encounter_id` int(11) NOT NULL,
  `procedure_id` int(11) NOT NULL COMMENT '-1 (Other) if procedure not in db',
  `other` text COMMENT 'populated only if procedure_id = -1 (Other)',
  `participation_type` char(1) NOT NULL COMMENT 'P = performed, O = observed, B = both',
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `encounter_dx`
--

-- --------------------------------------------------------

--
-- Table structure for table `resources`
--

CREATE TABLE `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sha1` char(40) NOT NULL,
  `filelocation` enum('remote','local') NOT NULL DEFAULT 'remote',
  `url` varchar(500) DEFAULT NULL,
  `score` float NOT NULL DEFAULT 0 COMMENT 'Aggregated score - updated on potentially every vote',
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX (`sha1`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


-- --------------------------------------------------------

--
-- Table structure for table `resources`
--

CREATE TABLE `resource_instances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) NOT NULL,
  `tag` varchar(50) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `title` varchar(512) NOT NULL,
  `description` text NULL,
  `filename_orig` varchar(500) DEFAULT NULL,
  `privacy` char(1) NOT NULL COMMENT 'P = Private, F = Faculty, A = All',
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


-- --------------------------------------------------------

--
-- Table structure for table `resource_votes`
--

CREATE TABLE `resource_votes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) NOT NULL,
  `vote` tinyint COMMENT '-1 downvote, 0 neutral, +1 upvote' DEFAULT 0,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


-- --------------------------------------------------------

--
-- Table structure for table `resource_discussions`
--

CREATE TABLE `resource_discussions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) NOT NULL,
  `text` text,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `compliance_requirements`
--

CREATE TABLE `compliance_requirements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clerkship_id` int(11) NOT NULL,
  `care_setting_id` int(11) NOT NULL,
  `hx_required` int(11) NOT NULL,
  `px_required` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `clerkship_id` (`clerkship_id`),
  KEY `care_setting_id` (`care_setting_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------
INSERT INTO `compliance_requirements` VALUES (NULL, 1, 1, 10, 10);
INSERT INTO `compliance_requirements` VALUES (NULL, 1, 2, 5, 5);
INSERT INTO `compliance_requirements` VALUES (NULL, 1, 3, 3, 3);
INSERT INTO `compliance_requirements` VALUES (NULL, 1, 4, 4, 4);

-- --------------------------------------------------------

--
-- Table structure for table `feedbacks`
--

CREATE TABLE `feedbacks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) NOT NULL,
  `body` text,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Constraints for dumped tables
--

--
-- Constraints for table `role_privileges`
--
ALTER TABLE `role_privileges`
  ADD CONSTRAINT `rp_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `rp_ibfk_2` FOREIGN KEY (`privilege_id`) REFERENCES `privileges` (`id`);

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `ur_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `ur_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `dx`
--
ALTER TABLE `dx`
  ADD CONSTRAINT `dx_ibfk_1` FOREIGN KEY (`clerkship_id`) REFERENCES `clerkships` (`id`),
  ADD CONSTRAINT `dx_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `dx_categories` (`id`);

--
-- Constraints for table `dx_categories`
--
ALTER TABLE `dx_categories`
  ADD CONSTRAINT `dx_categories_ibfk_1` FOREIGN KEY (`clerkship_id`) REFERENCES `clerkships` (`id`);

--
-- Constraints for table `encounters`
--
ALTER TABLE `encounters`
  ADD CONSTRAINT `encounters_ibfk_1` FOREIGN KEY (`clerkship_id`) REFERENCES `clerkships` (`id`),
  ADD CONSTRAINT `encounters_ibfk_2` FOREIGN KEY (`clinic_id`) REFERENCES `clinics` (`id`);

--
-- Constraints for table `encounter_dx`
--
ALTER TABLE `encounter_dx`
  ADD CONSTRAINT `encounter_dx_ibfk_1` FOREIGN KEY (`encounter_id`) REFERENCES `encounters` (`id`),
  ADD CONSTRAINT `encounter_dx_ibfk_2` FOREIGN KEY (`dx_id`) REFERENCES `dx` (`id`);

--
-- Constraints for table `resource_instances`
--
ALTER TABLE `resource_instances`
  ADD CONSTRAINT `resource_instances_ibfk_1` FOREIGN KEY (`resource_id`) REFERENCES `resources` (`id`);

--
-- Constraints for table `procedures`
--
ALTER TABLE `procedures`
  ADD CONSTRAINT `procedures_fk_1` FOREIGN KEY (`clerkship_id`) REFERENCES `clerkships` (`id`);

--
-- Constraints for table `procedures`
--
ALTER TABLE `encounter_procedures`
	ADD CONSTRAINT ` encounter_procedures_fk_1` FOREIGN KEY (`encounter_id`) REFERENCES `encounters` (`id`),
	ADD CONSTRAINT ` encounter_procedures_fk_2` FOREIGN KEY (`procedure_id`) REFERENCES `procedures` (`id`);
