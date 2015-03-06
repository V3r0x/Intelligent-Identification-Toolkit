-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2+deb7u1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Erstellungszeit: 06. Mrz 2015 um 10:42
-- Server Version: 5.5.41
-- PHP-Version: 5.4.36-0+deb7u3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Datenbank: `products_db`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `parent_child`
--

CREATE TABLE IF NOT EXISTS `parent_child` (
  `link_parent` varchar(500) NOT NULL DEFAULT '',
  `link_child` varchar(500) NOT NULL DEFAULT '',
  PRIMARY KEY (`link_parent`,`link_child`),
  KEY `link_child` (`link_child`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `parent_child`
--

INSERT INTO `parent_child` (`link_parent`, `link_child`) VALUES
('doorhandle', 'doorhandleclipfornotes'),
('car', 'doorrenault'),
('vacuumcleaner', 'nozzle'),
('car', 'tire400'),
('vacuumcleaner', 'vacuumcleanerbag'),
('vacuumcleanerfilter', 'vacuumcleanerbag'),
('vacuumcleaner', 'vacuumcleanerfilter');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `products`
--

CREATE TABLE IF NOT EXISTS `products` (
  `ProductName` varchar(500) NOT NULL,
  `Creator` varchar(500) NOT NULL,
  `PublishDate` date NOT NULL,
  `Description` text NOT NULL,
  `Link` varchar(500) NOT NULL,
  `Image` longtext NOT NULL,
  `Instructions` text NOT NULL,
  `Files` text NOT NULL,
  `URI` text NOT NULL,
  `License` varchar(500) NOT NULL,
  `Tags` text NOT NULL,
  PRIMARY KEY (`Link`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `products`
--

INSERT INTO `products` (`ProductName`, `Creator`, `PublishDate`, `Description`, `Link`, `Image`, `Instructions`, `Files`, `URI`, `License`, `Tags`) VALUES
('Car', 'Hari', '2015-03-23', 'The car can drive very fast.', 'car', '/img/IMG_car.jpg', 'instruction for Car', '/sketches/FILE_car.3d', '/img/QR_car.jpg', 'License Carmanufacturer', 'Car, Vehicle'),
('Door Handle', 'hoeken', '2008-11-08', 'This is a replacement door handle. If your door handle falls off, or you simply dont like it, then you can easily make your own replacement, instead of buying one!\r\n\r\nThis door handle was designed by Adrian Bowyer.\r\n\r\nhttp://www.thingiverse.com/thing:50', 'doorhandle', '/img/IMG_doorhandle.jpg', 'Print it on your RepRap, and attach it to your door handle post.', '/sketches/FILE_doorhandle.stl', '/img/QR_doorhandle.jpg', 'GNU - GPL ', 'door, handle, replacement, spare, useful'),
('Door handle clib for notes', 'dominic434', '2015-01-18', 'Optional: Upload a black&white inverted image (44x26) of any logo that you want to put on the clip. (See example image in the gallery)', 'doorhandleclipfornotes', '/img/IMG_doorhandleclipfornotes.jpg', 'none', '/sketches/FILE_doorhandleclipfornotes.scad', '/img/QR_doorhandleclipfornotes.jpg', 'Creative Commons - Attribution - Share Alike', 'clib, customizer, door, handle, notes'),
('Door Renault', 'Renault', '2015-03-11', 'Renault Door is this', 'doorrenault', '/img/IMG_doorrenault.jpg', 'dont open while driving', 'filesfordoor.3d', '/img/QR_doorrenault.jpg', 'Door License', 'door, vehicle'),
('Spare Part Nozzle', '17b', '2014-11-20', 'This is a nozzle i created for my vacuumcleaner. It will fit on a standard vacuumcleaner tube with 34mm diameter. http://www.thingiverse.com/thing:556035', 'nozzle', '/img/IMG_nozzle.jpg', 'The nozzle was designed in ViaCad7.', '/sketches/FILE_Vacuumcleaner_filter.zip', '/img/QR_nozzle.jpg', ' Creative Commons - Attribution - Share Alike', 'Nozzle, Vacuumcleaner, Cleaning, Household'),
('Tire 400', 'Continental', '2015-03-09', 'The tire goes very fast. But don''t go too fast!', 'tire400', '/img/IMG_tire400.jpg', 'dont drive over 200kmh', 'tirefilesfake.fake', '/img/QR_tire400.jpg', 'none', 'tire, car, street, vehicle'),
('Vacuumcleaner', 'Max', '2015-03-02', 'mostly sucks', 'vacuumcleaner', '/img/IMG_vacuumcleaner.jpg', 'This is a product that can break easily, so here you can find some 3d skteches to fix it. See in the Children Category what is available.', 'filesforvaccumcleaner.cad', '/img/QR_vacuumcleaner.jpg', 'Creative Commons v.1.1', 'vaccum, household, cleaning'),
('Vacuum Cleaner Bag', 'Armin', '2015-03-10', 'Vacuum Cleaner Bag', 'vacuumcleanerbag', '/img/IMG_vacuumcleanerbag.jpg', 'put it in the Vacuumcleaner', 'filesforvacuumclenaerbag.sketch', '/img/QR_vacuumcleanerbag.jpg', 'WTFPL (Do What The Fuck You Want License)', 'Vacuumcleaner, Household, Cleaner Bag, Cleaning'),
('Vacuumcleaner filter', 'AlpinerBergen', '2014-02-23', 'This is a filter for a vacuum cleaner. Since I designed and printed it for a friend of mine, unfortunately I do not know for what brand or type vacuum cleaner this replacement part is.\r\n\r\nTo be printed with 10% fill, 2 shells, 0,2mm filament layer height, without raft or supports. http://www.thingiverse.com/thing:256378', 'vacuumcleanerfilter', '/img/IMG_vacuumcleanerfilter.jpg', 'Drawn with Blender \r\nhttp://www.blender.org', '/sketches/FILE_Vacuumcleaner_filter.zip', '/img/QR_vacuumcleanerfilter.jpg', 'Creative Commons - Attribution - Share Alike', 'ceaner, filter, vacuum');

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `parent_child`
--
ALTER TABLE `parent_child`
  ADD CONSTRAINT `parent_child_ibfk_1` FOREIGN KEY (`link_parent`) REFERENCES `products` (`Link`),
  ADD CONSTRAINT `parent_child_ibfk_2` FOREIGN KEY (`link_child`) REFERENCES `products` (`Link`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
