-- MySQL Script generated by MySQL Workbench
-- Fri Jul 19 14:32:50 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Real_estate_agency
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Real_estate_agency
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Real_estate_agency` DEFAULT CHARACTER SET utf8mb4 ;
USE `Real_estate_agency` ;

-- -----------------------------------------------------
-- Table `Real_estate_agency`.`Contact_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Real_estate_agency`.`Contact_info` (
  `Contact_info_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Phone_number` BIGINT UNSIGNED NOT NULL,
  `Additional_phone` BIGINT UNSIGNED NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT ' ',
  PRIMARY KEY (`Contact_info_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Real_estate_agency`.`Passport_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Real_estate_agency`.`Passport_data` (
  `Passport_data_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Surname` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Gender` ENUM('m', 'f') NOT NULL,
  `Passpor_Number` SMALLINT(4) UNSIGNED NOT NULL,
  `Issued_by` VARCHAR(100) NOT NULL,
  `Date_of_issue` DATE NOT NULL,
  `Registration_address` VARCHAR(100) NULL DEFAULT ' ',
  PRIMARY KEY (`Passport_data_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_mysql500_ci;


-- -----------------------------------------------------
-- Table `Real_estate_agency`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Real_estate_agency`.`Users` (
  `User_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_type` ENUM('Owner', 'Buyer', 'Agent') NOT NULL DEFAULT 'Owner',
  `Passport_Data_id` INT UNSIGNED NOT NULL,
  `Contact_info_id` INT UNSIGNED NOT NULL,
  `Creation_date` DATE NOT NULL,
  PRIMARY KEY (`User_id`),
  UNIQUE INDEX `Passport_Data_id_UNIQUE` (`Passport_Data_id` ASC),
  INDEX `Contact_info_id_idx` (`Contact_info_id` ASC),
  CONSTRAINT `FK_contact_info_id`
    FOREIGN KEY (`Contact_info_id`)
    REFERENCES `Real_estate_agency`.`Contact_info` (`Contact_info_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_passport_data_id`
    FOREIGN KEY (`Passport_Data_id`)
    REFERENCES `Real_estate_agency`.`Passport_data` (`Passport_data_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Real_estate_agency`.`Object_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Real_estate_agency`.`Object_address` (
  `Object_address_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Locality` ENUM('City', 'Town', 'Station', 'Village', 'Province') NOT NULL DEFAULT 'City',
  `Name_of_the_Locality` VARCHAR(45) NOT NULL,
  `Street_name` VARCHAR(45) NOT NULL,
  `Building_number` TINYINT UNSIGNED NULL DEFAULT NULL,
  `Apartment_number` SMALLINT UNSIGNED NOT NULL,
  `Intercom_code` VARCHAR(45) NULL DEFAULT ' ',
  PRIMARY KEY (`Object_address_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Real_estate_agency`.`Object_Parameters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Real_estate_agency`.`Object_Parameters` (
  `Object_Parameters_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Construction_year` SMALLINT(4) UNSIGNED NOT NULL,
  `Floor` TINYINT UNSIGNED NOT NULL,
  `Total_floors` TINYINT UNSIGNED NOT NULL,
  `Material_of_house` ENUM('Stone', 'Wooden', 'Monolithic', 'Warm ceramics', 'Frame') NOT NULL DEFAULT 'Wooden',
  `Number_of_rooms` TINYINT UNSIGNED NOT NULL,
  `Living_area_in_sq` FLOAT NOT NULL,
  `Total_building_area_sq` FLOAT NOT NULL,
  `Balcony_available` SET('Balcony', 'Loggia', 'No') NOT NULL DEFAULT 'Balcony',
  `Bathroom_type` ENUM('Adjacent', 'Separate') NOT NULL DEFAULT 'Adjacent',
  `Number_of_Bathrooms` TINYINT UNSIGNED NOT NULL,
  `Bathtub` ENUM('Bathtub', 'Shower_cabin', 'Shower', 'Jacuzzi') NOT NULL DEFAULT 'Bathtub',
  `Furniture` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
  `Renovation` ENUM('No renovation', 'Cosmetic', 'European-quality renovation', 'Designer') NOT NULL DEFAULT 'Cosmetic',
  `Closet_and_storage` SET('No', 'Closet', 'Storage') NOT NULL DEFAULT 'No',
  `Concierge` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
  PRIMARY KEY (`Object_Parameters_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Real_estate_agency`.`Real_estate_objects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Real_estate_agency`.`Real_estate_objects` (
  `Object_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Type_of_the_property` ENUM('Apartment', 'Studio') NOT NULL DEFAULT 'Apartment',
  `Type` ENUM('For Sale', 'Sold') NOT NULL DEFAULT 'For Sale',
  `Object_address_id` INT UNSIGNED NOT NULL,
  `Object_Parameter_id` INT UNSIGNED NOT NULL,
  `Agect_id` INT UNSIGNED NOT NULL,
  `Transaction_type` SET('Alternative', 'Free', 'Mortgage') NOT NULL DEFAULT 'Free',
  `Cost_Without_Extra_Charge` BIGINT UNSIGNED NOT NULL,
  `Final_Cost` BIGINT UNSIGNED NOT NULL,
  `Encumbrances` VARCHAR(100) NULL DEFAULT ' ',
  PRIMARY KEY (`Object_id`),
  INDEX `FK_object_address_idx` (`Object_address_id` ASC),
  INDEX `FK_object_parameters_idx` (`Object_Parameter_id` ASC),
  INDEX `FK_object_agent_idx` (`Agect_id` ASC),
  CONSTRAINT `FK_object_address_id`
    FOREIGN KEY (`Object_address_id`)
    REFERENCES `Real_estate_agency`.`Object_address` (`Object_address_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_object_parameters_id`
    FOREIGN KEY (`Object_Parameter_id`)
    REFERENCES `Real_estate_agency`.`Object_Parameters` (`Object_Parameters_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_object_agent_id`
    FOREIGN KEY (`Agect_id`)
    REFERENCES `Real_estate_agency`.`Users` (`User_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Real_estate_agency`.`Object_Owners`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Real_estate_agency`.`Object_Owners` (
  `Object_id` INT UNSIGNED NOT NULL,
  `Owner_id` INT UNSIGNED NOT NULL,
  INDEX `FK_owner_idx` (`Owner_id` ASC),
  INDEX `FK_object_idx` (`Object_id` ASC),
  PRIMARY KEY (`Object_id`, `Owner_id`),
  CONSTRAINT `FK_owner_id`
    FOREIGN KEY (`Owner_id`)
    REFERENCES `Real_estate_agency`.`Users` (`User_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_object_id`
    FOREIGN KEY (`Object_id`)
    REFERENCES `Real_estate_agency`.`Real_estate_objects` (`Object_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Real_estate_agency`.`Documents_for_sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Real_estate_agency`.`Documents_for_sale` (
  `Document_Package_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Property_For_Sale_id` INT UNSIGNED NOT NULL,
  `Information_on_family_composition` ENUM('Yes', 'No', 'Not required') NOT NULL DEFAULT 'No',
  `Notarised_power_of_attorney` ENUM('Yes', 'No', 'Not required') NOT NULL DEFAULT 'Not required',
  `Written_consent_of_the_spouse` ENUM('Yes', 'No', 'Not required') NOT NULL DEFAULT 'No',
  `Title_of_ownership` ENUM('Extract from the Unified State Register of Real Estate', 'Donation Agreement', 'Purchase and Sale Agreement', 'Certificate of Inheritance') NOT NULL DEFAULT 'Purchase and Sale Agreement',
  `Title_of_ownership_number` BIGINT UNSIGNED NOT NULL,
  `Technical_certificate` ENUM('Yes', 'No') NOT NULL DEFAULT 'Yes',
  `Statement_of_personal_account` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
  `Comment` VARCHAR(100) NULL DEFAULT ' ',
  PRIMARY KEY (`Document_Package_id`),
  INDEX `FK_object_for_sale_idx` (`Property_For_Sale_id` ASC),
  CONSTRAINT `FK_id_of_object_for_sale`
    FOREIGN KEY (`Property_For_Sale_id`)
    REFERENCES `Real_estate_agency`.`Real_estate_objects` (`Object_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Real_estate_agency`.`Requests_for_viewings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Real_estate_agency`.`Requests_for_viewings` (
  `Request_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Object_id` INT UNSIGNED NOT NULL,
  `Potential_Buyer_id` INT UNSIGNED NOT NULL,
  `Agent_id` INT UNSIGNED NOT NULL,
  `View_date` DATETIME NOT NULL,
  PRIMARY KEY (`Request_id`),
  INDEX `FK_potencial_buyer_idx` (`Potential_Buyer_id` ASC),
  INDEX `FK_object_for_view_idx` (`Object_id` ASC),
  INDEX `FK_agent_for_view_idx` (`Agent_id` ASC),
  CONSTRAINT `FK_potencial_buyer_id`
    FOREIGN KEY (`Potential_Buyer_id`)
    REFERENCES `Real_estate_agency`.`Users` (`User_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_object_for_view_id`
    FOREIGN KEY (`Object_id`)
    REFERENCES `Real_estate_agency`.`Real_estate_objects` (`Object_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_id_of_agent_for_view`
    FOREIGN KEY (`Agent_id`)
    REFERENCES `Real_estate_agency`.`Users` (`User_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Real_estate_agency`.`Photo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Real_estate_agency`.`Photo` (
  `Photo_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Object_id` INT UNSIGNED NOT NULL,
  `Path_to_photo` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Photo_id`),
  UNIQUE INDEX `Path_to_photo_UNIQUE` (`Path_to_photo` ASC),
  INDEX `FK_id_of_object_in_photo_idx` (`Object_id` ASC),
  CONSTRAINT `FK_id_of_object_in_photo`
    FOREIGN KEY (`Object_id`)
    REFERENCES `Real_estate_agency`.`Real_estate_objects` (`Object_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Real_estate_agency`.`Contract_with_Agency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Real_estate_agency`.`Contract_with_Agency` (
  `ID_of_contract_with_Agency` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Client_id` INT UNSIGNED NOT NULL,
  `Contract_type` ENUM('Search for buyer', 'Search for owner') NOT NULL DEFAULT 'Search for owner',
  `Contract_number` SMALLINT UNSIGNED NOT NULL,
  `Contract_date` DATE NOT NULL,
  `Validity_date_in_months` TINYINT UNSIGNED NOT NULL,
  `Service_cost` INT UNSIGNED NOT NULL,
  `Paid` INT UNSIGNED NULL DEFAULT NULL,
  `Payment_deadline` DATE NOT NULL,
  PRIMARY KEY (`ID_of_contract_with_Agency`),
  INDEX `FK_agency_client_idx` (`Client_id` ASC),
  CONSTRAINT `FK_agency_client_id`
    FOREIGN KEY (`Client_id`)
    REFERENCES `Real_estate_agency`.`Users` (`User_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Real_estate_agency`.`Sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Real_estate_agency`.`Sales` (
  `Sales_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Object_id` INT UNSIGNED NOT NULL,
  `Buyer_id` INT UNSIGNED NOT NULL,
  `Transaction_type` ENUM('Alternative', 'Free', 'Mortgage') NOT NULL DEFAULT 'Free',
  `Transaction_date` DATE NOT NULL,
  `Contract_number` SMALLINT UNSIGNED NOT NULL,
  `Cost_of_the_object` BIGINT UNSIGNED NOT NULL,
  `Prepayment_Date` DATE NOT NULL,
  `Prepayment_amount` BIGINT UNSIGNED NULL,
  `Transaction_completed` ENUM('Yes', 'No') NOT NULL DEFAULT 'No',
  `Transaction_closing_date` DATE NULL,
  PRIMARY KEY (`Sales_id`),
  INDEX `FK_buyer_idx` (`Buyer_id` ASC),
  INDEX `FK_object_for_sale_idx` (`Object_id` ASC),
  CONSTRAINT `FK_buyer_id`
    FOREIGN KEY (`Buyer_id`)
    REFERENCES `Real_estate_agency`.`Users` (`User_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `FK_of_object_for_sale_id`
    FOREIGN KEY (`Object_id`)
    REFERENCES `Real_estate_agency`.`Real_estate_objects` (`Object_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Real_estate_agency`.`Contracts_with_agents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Real_estate_agency`.`Contracts_with_agents` (
  `Contract_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Agent_id` INT UNSIGNED NOT NULL,
  `Contact_type` ENUM('Permanent', 'Temporary') NOT NULL DEFAULT 'Permanent',
  `Contract_number` SMALLINT UNSIGNED NOT NULL,
  `Position` VARCHAR(45) NOT NULL,
  `Salary_per_transaction` MEDIUMINT UNSIGNED NOT NULL,
  `Income_tax` INT UNSIGNED NOT NULL,
  `Is_active` ENUM('Yes', 'No') NOT NULL DEFAULT 'Yes',
  `Employment_date` DATE NOT NULL,
  INDEX `FK_agent_idx` (`Agent_id` ASC),
  PRIMARY KEY (`Contract_id`),
  CONSTRAINT `FK_agent_id`
    FOREIGN KEY (`Agent_id`)
    REFERENCES `Real_estate_agency`.`Users` (`User_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
