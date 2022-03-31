-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema agenciaviajes
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema agenciaviajes
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `agenciaviajesNueva` DEFAULT CHARACTER SET latin1 ;
USE `agenciaviajesNueva` ;

-- -----------------------------------------------------
-- Table `agenciaviajes`.`agencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agenciaviajesNueva`.`agencia` (
  `idAgencia` INT NOT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  `telefono` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idAgencia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `agenciaviajes`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agenciaviajesNueva`.`cliente` (
  `idCliente` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `apellidos` VARCHAR(45) NULL DEFAULT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  `telefono` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `agenciaviajes`.`atiende`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agenciaviajesNueva`.`atiende` (
  `Cliente_idCliente` INT NOT NULL,
  `Agencia_idAgencia` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`Cliente_idCliente`, `Agencia_idAgencia`, `fecha`),
  INDEX `fk_Cliente_has_Agencia_Agencia1_idx` (`Agencia_idAgencia` ASC) VISIBLE,
  INDEX `fk_Cliente_has_Agencia_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_has_Agencia_Agencia1`
    FOREIGN KEY (`Agencia_idAgencia`)
    REFERENCES `agenciaviajesNueva`.`agencia` (`idAgencia`),
  CONSTRAINT `fk_Cliente_has_Agencia_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `agenciaviajesNueva`.`cliente` (`idCliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `agenciaviajes`.`hotel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agenciaviajesNueva`.`hotel` (
  `idHotel` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  `ciudad` VARCHAR(45) NULL DEFAULT NULL,
  `telefono` VARCHAR(45) NULL DEFAULT NULL,
  `numPlazas` INT NULL DEFAULT NULL,
  `Agencia_idAgencia` INT NOT NULL,
  PRIMARY KEY (`idHotel`),
  INDEX `fk_Hotel_Agencia1_idx` (`Agencia_idAgencia` ASC) VISIBLE,
  CONSTRAINT `fk_Hotel_Agencia1`
    FOREIGN KEY (`Agencia_idAgencia`)
    REFERENCES `agenciaviajesNueva`.`agencia` (`idAgencia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `agenciaviajes`.`vuelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agenciaviajesNueva`.`vuelo` (
  `idVuleo` INT NOT NULL,
  `fecha` DATETIME NULL DEFAULT NULL,
  `origen` VARCHAR(45) NULL DEFAULT NULL,
  `destino` VARCHAR(45) NULL DEFAULT NULL,
  `plazasTotal` INT NULL DEFAULT NULL,
  `plazasTurista` INT NULL DEFAULT NULL,
  `Agencia_idAgencia` INT NOT NULL,
  PRIMARY KEY (`idVuleo`),
  INDEX `fk_Vuleo_Agencia1_idx` (`Agencia_idAgencia` ASC) VISIBLE,
  CONSTRAINT `fk_Vuleo_Agencia1`
    FOREIGN KEY (`Agencia_idAgencia`)
    REFERENCES `agenciaviajesNueva`.`agencia` (`idAgencia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `agenciaviajes`.`hotel_has_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agenciaviajesNueva`.`hotel_has_cliente` (
  `hotel_idHotel` INT NOT NULL,
  `cliente_idCliente` INT NOT NULL,
  `fechaEntrada` DATETIME NOT NULL,
  `fechaSalida` DATETIME NULL,
  `regimen` VARCHAR(45) NULL,
  PRIMARY KEY (`hotel_idHotel`, `cliente_idCliente`, `fechaEntrada`),
  INDEX `fk_hotel_has_cliente_cliente1_idx` (`cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_hotel_has_cliente_hotel1_idx` (`hotel_idHotel` ASC) VISIBLE,
  CONSTRAINT `fk_hotel_has_cliente_hotel1`
    FOREIGN KEY (`hotel_idHotel`)
    REFERENCES `agenciaviajesNueva`.`hotel` (`idHotel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hotel_has_cliente_cliente1`
    FOREIGN KEY (`cliente_idCliente`)
    REFERENCES `agenciaviajesNueva`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `agenciaviajes`.`cliente_has_vuelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agenciaviajesNueva`.`cliente_has_vuelo` (
  `cliente_idCliente` INT NOT NULL,
  `vuelo_idVuleo` INT NOT NULL,
  `clase` VARCHAR(45) NULL,
  PRIMARY KEY (`cliente_idCliente`, `vuelo_idVuleo`),
  INDEX `fk_cliente_has_vuelo_vuelo1_idx` (`vuelo_idVuleo` ASC) VISIBLE,
  INDEX `fk_cliente_has_vuelo_cliente1_idx` (`cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_has_vuelo_cliente1`
    FOREIGN KEY (`cliente_idCliente`)
    REFERENCES `agenciaviajesNueva`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_has_vuelo_vuelo1`
    FOREIGN KEY (`vuelo_idVuleo`)
    REFERENCES `agenciaviajesNueva`.`vuelo` (`idVuleo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
