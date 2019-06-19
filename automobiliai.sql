-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 2019 m. Bir 19 d. 12:41
-- Server version: 10.1.40-MariaDB
-- PHP Version: 7.3.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `automobiliai`
--

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `automobiliai`
--

CREATE TABLE `automobiliai` (
  `id` int(10) UNSIGNED NOT NULL,
  `modelis` varchar(256) COLLATE utf8_lithuanian_ci NOT NULL,
  `galia` int(11) NOT NULL,
  `metai` int(11) NOT NULL,
  `kaina` int(11) NOT NULL,
  `klase` enum('limuzinas','sedanas') COLLATE utf8_lithuanian_ci NOT NULL,
  `id_gamintojo` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `automobiliai`
--

INSERT INTO `automobiliai` (`id`, `modelis`, `galia`, `metai`, `kaina`, `klase`, `id_gamintojo`) VALUES
(1, 'bmw e60', 0, 2001, 2000, 'sedanas', 0),
(2, 'audi A6', 0, 2001, 2500, 'sedanas', 0),
(3, 'Toyota Corolla', 0, 2001, 2200, 'sedanas', 0),
(4, 'renault megane', 0, 2005, 3400, '', 0),
(5, 'Volkswagen Golf', 0, 2003, 2670, '', 0),
(6, 'Alfa Romeo Giulia', 0, 2007, 4350, '', 0),
(7, 'Dacia Duster', 0, 2006, 5120, '', 0),
(8, 'Fiat 500L', 0, 2010, 6720, '', 0),
(9, 'HYUNDAI Coupe', 0, 2012, 8642, '', 0),
(10, 'Nissan 200 SX', 0, 2014, 10829, '', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `automobiliai`
--
ALTER TABLE `automobiliai`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_gamintojo` (`id_gamintojo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `automobiliai`
--
ALTER TABLE `automobiliai`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
