SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database : `airbnb`
--

-- --------------------------------------------------------
DROP TABLE IF EXISTS MHNYMA;
DROP TABLE IF EXISTS BOOKING;
DROP TABLE IF EXISTS DIATHETEI;
DROP TABLE IF EXISTS DIAMONH;
DROP TABLE IF EXISTS KRITIKH;
DROP TABLE IF EXISTS KATALYMA;
DROP TABLE IF EXISTS XRHSTHS;


CREATE TABLE `XRHSTHS` (
  `account_number` int(3) NOT NULL,
  `onoma` varchar(30) NOT NULL,
  `proskalei` int(3) DEFAULT NULL,
  `kinhto` varchar(14) NOT NULL,
  `email` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `XRHSTHS` (`account_number`, `onoma`, `proskalei`, `kinhto`, `email`) VALUES
(0, '1GIANNOPOULOS', 2,  '00301111111111',  '1giannopoulos@airbnb.com'),
(1, '2GIANNOPOULOS', NULL, '00302222222222', '2giannopoulos@airbnb.com'),
(2, '3GIANNOPOULOS', 5,  '00303333333333',  '3giannopoulos@airbnb.com'),
(3, '4GIANNOPOULOS', NULL, '00304444444444', '4giannopoulos@airbnb.com'),
(4, '5GIANNOPOULOS', NULL, '00305555555555', '5giannopoulos@airbnb.com'),
(5, '6GIANNOPOULOS', NULL, '00306666666666', '6giannopoulos@airbnb.com');



CREATE TABLE `MHNYMA` (
  `msg_ID` int(3) NOT NULL,
  `sender` int(3) NOT NULL,
  `receiver` int(3) NOT NULL,
  `msg_text` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `MHNYMA` (`msg_ID`, `sender`, `receiver`, `msg_text`) VALUES
(0, 0, 1, 'GEIA SOU GIANNOPOULE 2'),
(1, 1, 0, 'GEIA SOU KAI SENA GIANNOPOULE 1');



CREATE TABLE `BOOKING` (
  `home_ID` int(3) NOT NULL,
  `enoikiasths` int(3) NOT NULL,
  `enoikos` int(3) NOT NULL,
  `stay_ID` int(3) NOT NULL,
  `review_ID` int(3) DEFAULT NULL,
  `booking_date` datetime NOT NULL,
  `stay_date_arrive` datetime NOT NULL,
  `stay_date_leave` datetime NOT NULL,
  `timh_diamonhs` float(24) NOT NULL,
  `plhrwthike` binary NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `BOOKING` (`home_ID`, `enoikiasths`, `enoikos`, `stay_ID`, `review_ID`, `booking_date` ,`stay_date_arrive`, `stay_date_leave`, `timh_diamonhs`, `plhrwthike`) VALUES
(1, 0, 1, 0, 0, '2019-12-24 00:00:00',  '2019-12-31 00:00:00', '2020-01-01 00:00:00', 75.0, 1),
(5, 4, 5, 2, 1, '2019-12-26 00:00:00',  '2020-01-02 00:00:00', '2020-01-03 00:00:00', 40.0, 1);



CREATE TABLE `KATALYMA` (
  `owner_account` int(3) NOT NULL,
  `home_ID` int(3) NOT NULL,
  `arxikh_timh_ana_mera` float(24) NOT NULL,
  `xwra` varchar(30) NOT NULL,
  `polh` varchar(30) NOT NULL,
  `odos` varchar(30) NOT NULL,
  `arithmos` int(3) NOT NULL,
  `tax_kwd` int(11) NOT NULL,
  `onomasia` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `KATALYMA` (`owner_account`, `home_ID`, `arxikh_timh_ana_mera`, `xwra`, `polh`, `odos` ,`arithmos`, `tax_kwd`, `onomasia`) VALUES
(0, 0, 75.0, 'France', 'Paris', 'Eiffel St', '1', '12345', 'Sweet Little Room near St Martin Canal'),
(0, 1, 105.0, 'France', 'Paris', 'Farmer St', '2', '12345', 'Sweet Little Room near Eiffel Tower'),
(2, 2, 60.0, 'USA', 'New York', 'Baker St', '13', '54321', 'LARGE SUNNY ROOM 15 MIN to NYC !'),
(4, 3, 60.0, 'USA', 'Washington', 'White House St', '21', '54321', 'LARGE SUNNY ROOM!'),
(4, 4, 60.0, 'USA', 'Florida', 'Beach St', '31', '54321', 'LARGE ROOM !'),
(4, 5, 60.0, 'USA', 'Los Angeles', 'Stars St', '14', '54321', 'SUNNY ROOM !');



-- CREATE TABLE `EIKONA` (
  -- `owner_account` int(3) NOT NULL,
  -- `home_ID` int(3) NOT NULL,
  -- `img` blob NOT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- INSERT INTO `EIKONA` (`img`) 
-- SELECT BulkColumn 
-- FROM Openrowset( Bulk 'C:\Users\dimit\Desktop\databases\project\db.png', Single_Blob) as img;


CREATE TABLE `DIATHETEI` (
  `owner_account` int(3) NOT NULL,
  `stay_ID` int(3) NOT NULL,
  `diathesimes_hm_arxh` datetime NOT NULL,
  `diathesimes_hm_telos` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `DIATHETEI` (`owner_account`, `stay_ID`, `diathesimes_hm_arxh`, `diathesimes_hm_telos`) VALUES
(0, 0, '2019-12-20 00:00:00', '2020-01-15 00:00:00'),
(2, 1, '2019-12-15 00:00:00', '2020-01-15 00:00:00'),
(4, 2, '2019-12-27 00:00:00', '2020-01-15 00:00:00');



CREATE TABLE `DIAMONH` (
  `owner_account` int(3) NOT NULL,
  `stay_ID` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `DIAMONH` (`owner_account`, `stay_ID`) VALUES
(0, 0),
(2, 1),
(4, 2);



CREATE TABLE `KRITIKH` (
  `review_ID` int(3) NOT NULL,
  `reviewer` int(3) NOT NULL,
  `reviewed_home` int(3) NOT NULL,
  `review_text` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `KRITIKH` (`review_ID`, `reviewer`, `reviewed_home`, `review_text`) VALUES
(0, 1, 1, 'AMAZING HOUSE WE HAD A BLAST GIANNOPOULE 2!'),
(1, 5, 5, 'AWFUL HOUSE WE HAD A TERRIBLE STAY GIANNOPOULE 6!');

--
-- Index 
--

ALTER TABLE `XRHSTHS`
  ADD PRIMARY KEY (`account_number`),
  ADD KEY `XRHSTHS_fk1` (`proskalei`);
  
ALTER TABLE `MHNYMA`
  ADD PRIMARY KEY (`msg_ID`, `sender`),
  ADD KEY `MHNYMA_fk1` (`sender`), 
  ADD KEY `MHNYMA_fk2` (`receiver`);
  
ALTER TABLE `BOOKING`
  ADD PRIMARY KEY (`home_ID`, `enoikiasths`, `enoikos`, `stay_ID`, `review_ID`),
  ADD KEY `BOOKING_fk1` (`enoikiasths`), 
  ADD KEY `BOOKING_fk2` (`enoikos`),
  ADD KEY `BOOKING_fk3` (`home_ID`), 
  ADD KEY `BOOKING_fk4` (`stay_ID`),
  ADD KEY `BOOKING_fk5` (`review_ID`);

ALTER TABLE `KATALYMA`
  ADD PRIMARY KEY (`home_ID`),
  ADD KEY `KATALYMA_fk1` (`owner_account`);
  
ALTER TABLE `DIATHETEI`
  ADD PRIMARY KEY (`owner_account`, `stay_ID`),
  ADD KEY `DIATHETEI_fk1` (`owner_account`), 
  ADD KEY `DIATHETEI_fk2` (`stay_ID`);
  
ALTER TABLE `DIAMONH`
  ADD PRIMARY KEY (`stay_ID`, `owner_account`),
  ADD KEY `DIAMONH_fk1` (`owner_account`);
  
ALTER TABLE `KRITIKH`
  ADD PRIMARY KEY (`review_ID`),
  ADD KEY `KRITIKH_fk1` (`reviewer`), 
  ADD KEY `KRITIKH_fk2` (`reviewed_home`);

--
-- AUTO_INCREMENT 
--

ALTER TABLE `XRHSTHS`
  MODIFY `account_number` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
  
ALTER TABLE `MHNYMA`
  MODIFY `msg_ID` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
  
ALTER TABLE `KATALYMA`
  MODIFY `home_ID` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
  
ALTER TABLE `DIAMONH`
  MODIFY `stay_ID` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
  
ALTER TABLE `KRITIKH`
  MODIFY `review_ID` int(3) AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- PERIORISMOI
--

ALTER TABLE `XRHSTHS`
  ADD CONSTRAINT `XRHSTHS_fk1` FOREIGN KEY (`proskalei`) REFERENCES `XRHSTHS` (`account_number`);
  
ALTER TABLE `MHNYMA`
  ADD CONSTRAINT `MHNYMA_fk1` FOREIGN KEY (`sender`) REFERENCES `XRHSTHS` (`account_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `MHNYMA_fk2` FOREIGN KEY (`receiver`) REFERENCES `XRHSTHS` (`account_number`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `BOOKING`
  ADD CONSTRAINT `BOOKING_fk1` FOREIGN KEY (`enoikiasths`) REFERENCES `XRHSTHS` (`account_number`),
  ADD CONSTRAINT `BOOKING_fk2` FOREIGN KEY (`enoikos`) REFERENCES `XRHSTHS` (`account_number`),
  ADD CONSTRAINT `BOOKING_fk3` FOREIGN KEY (`home_ID`) REFERENCES `KATALYMA` (`home_ID`),
  ADD CONSTRAINT `BOOKING_fk4` FOREIGN KEY (`stay_ID`) REFERENCES `DIAMONH` (`stay_ID`),
  ADD CONSTRAINT `BOOKING_fk5` FOREIGN KEY (`review_ID`) REFERENCES `KRITIKH` (`review_ID`);
  
ALTER TABLE `KATALYMA`
  ADD CONSTRAINT `KATALYMA_fk1` FOREIGN KEY (`owner_account`) REFERENCES `XRHSTHS` (`account_number`);
  
ALTER TABLE `DIATHETEI`
  ADD CONSTRAINT `DIATHETEI_fk1` FOREIGN KEY (`owner_account`) REFERENCES `XRHSTHS` (`account_number`),
  ADD CONSTRAINT `DIATHETEI_fk2` FOREIGN KEY (`stay_ID`) REFERENCES `DIAMONH` (`stay_ID`);

ALTER TABLE `DIAMONH`
  ADD CONSTRAINT `DIAMONH_fk1` FOREIGN KEY (`owner_account`) REFERENCES `XRHSTHS` (`account_number`);
  
ALTER TABLE `KRITIKH`
  ADD CONSTRAINT `KRITIKH_fk1` FOREIGN KEY (`reviewer`) REFERENCES `XRHSTHS` (`account_number`),
  ADD CONSTRAINT `KRITIKH_fk2` FOREIGN KEY (`reviewed_home`) REFERENCES `KATALYMA` (`home_ID`);

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

