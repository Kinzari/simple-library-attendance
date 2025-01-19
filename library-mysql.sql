-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 19, 2025 at 04:51 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `library-mysql`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` int(11) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `family_name` varchar(50) NOT NULL,
  `suffix` varchar(10) DEFAULT NULL,
  `year_level` varchar(20) NOT NULL,
  `course` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `check_in_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`id`, `student_id`, `first_name`, `middle_name`, `family_name`, `suffix`, `year_level`, `course`, `date`, `check_in_time`) VALUES
(1, '02-2223-05976', 'Jerimiah', NULL, 'Espartero', NULL, '3rd Year', 'College of Information Technology', '2025-01-19', '23:29:48');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` varchar(20) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `family_name` varchar(50) NOT NULL,
  `suffix` varchar(10) DEFAULT NULL,
  `year_level` varchar(20) NOT NULL,
  `course` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `first_name`, `middle_name`, `family_name`, `suffix`, `year_level`, `course`) VALUES
('02-0000-00000', 'Test', NULL, 'Student', NULL, '1', 'College of Allied Health Sciences'),
('02-1516-01541', 'Vince Julio', 'Tangcongco', 'Tillo', NULL, '2', 'College of Education'),
('02-1920-10455', 'Rasidin', NULL, 'Ansao', NULL, '3', 'College of Engineering and Architecture'),
('02-2-1920-02724', 'Charlie Gin', 'Absin', 'Pimentel', NULL, '2', 'College of Engineering and Architecture'),
('02-2021-00143', 'James', NULL, 'Antipuesto', NULL, '3', 'College of Management and Accountancy'),
('02-2021-00344', 'Kristopher', 'Viado', 'Dichos', NULL, '3', 'College of Management and Accountancy'),
('02-2021-01409', 'Mar Louis', NULL, 'Pimentel', 'Go', '2', 'College of Engineering and Architecture'),
('02-2223-01741', 'Rudgel', 'Sales', 'Tagaan', NULL, '3', 'College of Engineering and Architecture'),
('02-2223-01945', 'Laurenz', NULL, 'Anchez', NULL, '3', 'College of Education'),
('02-2223-03206', 'Van Morre', 'Acaylar', 'Guangco', NULL, '3', 'College of Allied Health Sciences'),
('02-2223-05976', 'Jerimiah', NULL, 'Espartero', NULL, '3', 'College of Information Technology'),
('02-2223-10440', 'Andrei', 'P', 'Gopher', 'G', '3', 'College of Management and Accountancy'),
('02-2425-012345', 'Arc', NULL, 'CBT', NULL, '2', 'School of Criminology and Criminal Justice'),
('02-2425-12345', 'Pitok', 'Kulas', 'Batalota', NULL, '3', 'College of Engineering and Architecture');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
