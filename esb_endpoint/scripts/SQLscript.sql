-- MySQL Script generated by MySQL Workbench
-- Thu Aug 27 14:08:20 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema esb_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `esb_db` ;

-- -----------------------------------------------------
-- Schema esb_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `esb_db` DEFAULT CHARACTER SET utf8 ;
USE `esb_db` ;

-- -----------------------------------------------------
-- Table `esb_db`.`esb_request`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `esb_db`.`esb_request` ;

CREATE TABLE IF NOT EXISTS `esb_db`.`esb_request` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sender_id` VARCHAR(45) NOT NULL,
  `dest_id` VARCHAR(45) NOT NULL,
  `message_type` VARCHAR(45) NOT NULL,
  `reference_id` VARCHAR(45) NOT NULL,
  `message_id` VARCHAR(45) NOT NULL COMMENT 'A unique ID for the message instance.',
  `received_on` DATETIME NOT NULL,
  `data_location` TEXT NULL,
  `status` VARCHAR(20) NOT NULL,
  `status_details` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `UK_sender_message` (`sender_id` ASC, `message_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esb_db`.`routes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `esb_db`.`routes` ;

CREATE TABLE IF NOT EXISTS `esb_db`.`routes` (
  `route_id` INT NOT NULL AUTO_INCREMENT,
  `sender` VARCHAR(45) NOT NULL,
  `destination` VARCHAR(45) NOT NULL,
  `message_type` VARCHAR(45) NOT NULL,
  `is_active` BIT(1) NOT NULL,
  PRIMARY KEY (`route_id`),
  UNIQUE INDEX `UK_sender_dest_msg_type` (`message_type` ASC, `destination` ASC, `sender` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esb_db`.`transform_config`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `esb_db`.`transform_config` ;

CREATE TABLE IF NOT EXISTS `esb_db`.`transform_config` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `route_id` INT NOT NULL,
  `config_key` VARCHAR(45) NOT NULL,
  `config_value` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `route_idx` (`route_id` ASC),
  UNIQUE INDEX `UK_route_config` (`route_id` ASC, `config_key` ASC),
  CONSTRAINT `route`
    FOREIGN KEY (`route_id`)
    REFERENCES `esb_db`.`routes` (`route_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `esb_db`.`transport_config`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `esb_db`.`transport_config` ;

CREATE TABLE IF NOT EXISTS `esb_db`.`transport_config` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `route_id` INT NULL,
  `config_key` VARCHAR(45) NULL,
  `config_value` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `route_idx` (`route_id` ASC),
  UNIQUE INDEX `UK_route_config` (`config_key` ASC, `route_id` ASC),
  CONSTRAINT `route`
    FOREIGN KEY (`route_id`)
    REFERENCES `esb_db`.`routes` (`route_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-----------------------------------------------------------
-- Adding data to database
-----------------------------------------------------------

INSERT INTO routes
VALUES (1,"756E2EAA-1D5B-4BC0-ACC4-4CEB669408DA","6393F82F-4687-433D-AA23-1966330381FE","CreditReport",0x01),
(2,"556E2EAA-1D5B-5BC0-BCC4-4CEB669408DA","6323D82F-4687-433D-AA23-1966330381FE","DebitReport",0x01),   
(3,"666E2EAA-1D5B-5BC0-BCC4-4CEB669408DA","8323D82F-4687-433D-AA23-1966330381FE", "DebitReport",0x01);        


INSERT INTO transform_config
VALUES (1001,1,"Json_transform","json"),
(1002,2,"Json_transform","json"),
(1003,3,"Json_transform","json");

INSERT INTO transport_config
VALUES (2001,1,"https://ifsc.razorpay.com/","HTTP"),
(2002,2,"testraavi1@gmail.com","email"),
(2003,3,"https://ifsc.razorpay.com/","HTTP");




