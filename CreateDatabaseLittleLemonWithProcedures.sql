-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema littlelemon
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema littlelemon
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `littlelemon` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `littlelemon` ;

-- -----------------------------------------------------
-- Table `littlelemon`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemon`.`customers` (
  `CustomerID` INT NOT NULL,
  `FullName` VARCHAR(100) NOT NULL,
  `ContactNumber` VARCHAR(20) NULL DEFAULT NULL,
  `Email` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemon`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemon`.`employees` (
  `EmployeeID` INT NOT NULL,
  `FullName` VARCHAR(100) NOT NULL,
  `ContactNumber` VARCHAR(20) NULL DEFAULT NULL,
  `Email` VARCHAR(100) NULL DEFAULT NULL,
  `Position` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemon`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemon`.`bookings` (
  `BookingID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `EmployeeID` INT NOT NULL,
  `BookingDate` DATETIME NOT NULL,
  `NumberOfGuests` INT NULL DEFAULT NULL,
  `TableNumber` INT NULL DEFAULT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `CustomerID` (`CustomerID` ASC) VISIBLE,
  INDEX `EmployeeID` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `bookings_ibfk_1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `littlelemon`.`customers` (`CustomerID`),
  CONSTRAINT `bookings_ibfk_2`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `littlelemon`.`employees` (`EmployeeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemon`.`menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemon`.`menus` (
  `MenuID` INT NOT NULL,
  `MenuName` VARCHAR(100) NOT NULL,
  `Cuisine` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`MenuID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemon`.`menuitems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemon`.`menuitems` (
  `MenuItemsID` INT NOT NULL,
  `CourseName` VARCHAR(100) NULL DEFAULT NULL,
  `StarterName` VARCHAR(100) NULL DEFAULT NULL,
  `DesertName` VARCHAR(100) NULL DEFAULT NULL,
  `MenuID` INT NOT NULL,
  PRIMARY KEY (`MenuItemsID`),
  INDEX `MenuID` (`MenuID` ASC) VISIBLE,
  CONSTRAINT `menuitems_ibfk_1`
    FOREIGN KEY (`MenuID`)
    REFERENCES `littlelemon`.`menus` (`MenuID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemon`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemon`.`orders` (
  `OrderID` INT NOT NULL,
  `BookingID` INT NOT NULL,
  `MenuID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `TotalCost` DECIMAL(10,2) NULL DEFAULT NULL,
  `Quantity` INT NOT NULL DEFAULT '1',
  PRIMARY KEY (`OrderID`),
  INDEX `BookingID` (`BookingID` ASC) VISIBLE,
  INDEX `MenuID` (`MenuID` ASC) VISIBLE,
  INDEX `CustomerID` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `orders_ibfk_1`
    FOREIGN KEY (`BookingID`)
    REFERENCES `littlelemon`.`bookings` (`BookingID`),
  CONSTRAINT `orders_ibfk_2`
    FOREIGN KEY (`MenuID`)
    REFERENCES `littlelemon`.`menus` (`MenuID`),
  CONSTRAINT `orders_ibfk_3`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `littlelemon`.`customers` (`CustomerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `littlelemon` ;

-- -----------------------------------------------------
-- procedure AddBooking
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemon`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddBooking`(
    IN p_BookingID INT,
    IN p_CustomerID INT,
    IN p_EmployeeID INT,
    IN p_BookingDate DATETIME
)
BEGIN
    INSERT INTO Bookings (BookingID, CustomerID, EmployeeID, BookingDate)
    VALUES (p_BookingID, p_CustomerID, p_EmployeeID, p_BookingDate);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CancelBooking
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemon`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CancelBooking`(
        IN p_BookingID INT
    )
BEGIN
        DELETE FROM Bookings
        WHERE BookingID = p_BookingID;
    END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GetMaxQuantity
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemon`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMaxQuantity`()
BEGIN
    SELECT MAX(quantity) AS MaxQuantity
    FROM Orders;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UpdateBooking
-- -----------------------------------------------------

DELIMITER $$
USE `littlelemon`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateBooking`(
    IN p_BookingID INT,
    IN p_BookingDate DATETIME
)
BEGIN
    UPDATE Bookings
    SET BookingDate = p_BookingDate
    WHERE BookingID = p_BookingID;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
