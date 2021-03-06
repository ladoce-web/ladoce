-- MySQL Script generated by MySQL Workbench
-- 07/13/16 23:59:56
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema BDLA12
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `BDLA12` ;

-- -----------------------------------------------------
-- Schema BDLA12
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BDLA12` DEFAULT CHARACTER SET utf8 ;
USE `BDLA12` ;

-- -----------------------------------------------------
-- Table `BDLA12`.`Persona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BDLA12`.`Persona` ;

CREATE TABLE IF NOT EXISTS `BDLA12`.`Persona` (
  `idPersona` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombres` NVARCHAR(40) NOT NULL,
  `apellidos` NVARCHAR(50) NOT NULL,
  `celular` CHAR(9) NULL,
  `DNI` CHAR(8) NOT NULL,
  `tipo` CHAR(4) NOT NULL,
  `idUsuario` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idPersona`),
  UNIQUE INDEX `DNI_UNIQUE` (`DNI` ASC),
  UNIQUE INDEX `idUsuario_UNIQUE` (`idUsuario` ASC))
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `BDLA12`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BDLA12`.`Cliente` ;

CREATE TABLE IF NOT EXISTS `BDLA12`.`Cliente` (
  `idCliente` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `estado` CHAR(4) NOT NULL,
  `Cliente_idPersona` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `idUsuario_idx` (`Cliente_idPersona` ASC),
  CONSTRAINT `Cliente_idPersona`
    FOREIGN KEY (`Cliente_idPersona`)
    REFERENCES `BDLA12`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDLA12`.`Reserva`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BDLA12`.`Reserva` ;

CREATE TABLE IF NOT EXISTS `BDLA12`.`Reserva` (
  `idReserva` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fechaCreacion` DATETIME NOT NULL,
  `fechaReserva` DATE NOT NULL,
  `estado` CHAR(4) NOT NULL,
  `total` DECIMAL(10,2) NOT NULL,
  `Reserva_idCliente` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idReserva`),
  INDEX `idCliente_idx` (`Reserva_idCliente` ASC),
  CONSTRAINT `Reserva_idCliente`
    FOREIGN KEY (`Reserva_idCliente`)
    REFERENCES `BDLA12`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDLA12`.`Departamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BDLA12`.`Departamento` ;

CREATE TABLE IF NOT EXISTS `BDLA12`.`Departamento` (
  `idDepartamento` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` NVARCHAR(45) NOT NULL,
  `estado` CHAR(4) NOT NULL,
  PRIMARY KEY (`idDepartamento`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDLA12`.`Provincia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BDLA12`.`Provincia` ;

CREATE TABLE IF NOT EXISTS `BDLA12`.`Provincia` (
  `idProvincia` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` NVARCHAR(45) NOT NULL,
  `estado` CHAR(4) NOT NULL,
  `Provincia_idDepartamento` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idProvincia`),
  INDEX `idDepartamento_idx` (`Provincia_idDepartamento` ASC),
  CONSTRAINT `Provincia_idDepartamento`
    FOREIGN KEY (`Provincia_idDepartamento`)
    REFERENCES `BDLA12`.`Departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDLA12`.`Distrito`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BDLA12`.`Distrito` ;

CREATE TABLE IF NOT EXISTS `BDLA12`.`Distrito` (
  `idDistrito` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` NVARCHAR(45) NOT NULL,
  `estado` CHAR(4) NOT NULL,
  `Distrito_idProvincia` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idDistrito`),
  INDEX `idProvincia_idx` (`Distrito_idProvincia` ASC),
  CONSTRAINT `Distrito_idProvincia`
    FOREIGN KEY (`Distrito_idProvincia`)
    REFERENCES `BDLA12`.`Provincia` (`idProvincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDLA12`.`Sede`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BDLA12`.`Sede` ;

CREATE TABLE IF NOT EXISTS `BDLA12`.`Sede` (
  `idSede` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` NVARCHAR(50) NOT NULL,
  `direccion` VARCHAR(60) NOT NULL,
  `estado` CHAR(4) NOT NULL,
  `referencia` TEXT(200) NULL,
  `idDistrito` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idSede`),
  INDEX `idDistrito_idx` (`idDistrito` ASC),
  CONSTRAINT `idDistrito`
    FOREIGN KEY (`idDistrito`)
    REFERENCES `BDLA12`.`Distrito` (`idDistrito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDLA12`.`Operador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BDLA12`.`Operador` ;

CREATE TABLE IF NOT EXISTS `BDLA12`.`Operador` (
  `idOperador` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `estado` CHAR(4) NOT NULL,
  `Operador_idPersona` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idOperador`),
  INDEX `idUsuario_idx` (`Operador_idPersona` ASC),
  CONSTRAINT `Operador_idPersona`
    FOREIGN KEY (`Operador_idPersona`)
    REFERENCES `BDLA12`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDLA12`.`Dirige`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BDLA12`.`Dirige` ;

CREATE TABLE IF NOT EXISTS `BDLA12`.`Dirige` (
  `idDirige` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `inicio` DATE NOT NULL,
  `fin` DATE NULL,
  `Dirige_idSede` INT UNSIGNED NOT NULL,
  `Dirige_idOperador` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idDirige`),
  INDEX `idSede_idx` (`Dirige_idSede` ASC),
  INDEX `idOperador_idx` (`Dirige_idOperador` ASC),
  CONSTRAINT `Dirige_idSede`
    FOREIGN KEY (`Dirige_idSede`)
    REFERENCES `BDLA12`.`Sede` (`idSede`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Dirige_idOperador`
    FOREIGN KEY (`Dirige_idOperador`)
    REFERENCES `BDLA12`.`Operador` (`idOperador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDLA12`.`Cancha`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BDLA12`.`Cancha` ;

CREATE TABLE IF NOT EXISTS `BDLA12`.`Cancha` (
  `idCancha` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `numero` INT NOT NULL,
  `estado` CHAR(4) NOT NULL,
  `Cancha_idSede` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idCancha`),
  INDEX `idSede_idx` (`Cancha_idSede` ASC),
  CONSTRAINT `Cancha_idSede`
    FOREIGN KEY (`Cancha_idSede`)
    REFERENCES `BDLA12`.`Sede` (`idSede`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDLA12`.`HistorialCancha`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BDLA12`.`HistorialCancha` ;

CREATE TABLE IF NOT EXISTS `BDLA12`.`HistorialCancha` (
  `idHistorialCancha` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `inicio` DATETIME NOT NULL,
  `fin` DATETIME NOT NULL,
  `estado` CHAR(4) NOT NULL,
  `HC_idCancha` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idHistorialCancha`),
  INDEX `idCancha_idx` (`HC_idCancha` ASC),
  CONSTRAINT `HC_idCancha`
    FOREIGN KEY (`HC_idCancha`)
    REFERENCES `BDLA12`.`Cancha` (`idCancha`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDLA12`.`Gerente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BDLA12`.`Gerente` ;

CREATE TABLE IF NOT EXISTS `BDLA12`.`Gerente` (
  `idGerente` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `estado` CHAR(4) NOT NULL,
  `Gerente_idPersona` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idGerente`),
  INDEX `idUsuario_idx` (`Gerente_idPersona` ASC),
  CONSTRAINT `Gerente_idPersona`
    FOREIGN KEY (`Gerente_idPersona`)
    REFERENCES `BDLA12`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDLA12`.`HistorialGerente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BDLA12`.`HistorialGerente` ;

CREATE TABLE IF NOT EXISTS `BDLA12`.`HistorialGerente` (
  `idHistorialGerente` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `inicio` DATE NOT NULL,
  `fin` DATE NULL,
  `HG_idGerente` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idHistorialGerente`),
  INDEX `idGerente_idx` (`HG_idGerente` ASC),
  CONSTRAINT `HG_idGerente`
    FOREIGN KEY (`HG_idGerente`)
    REFERENCES `BDLA12`.`Gerente` (`idGerente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDLA12`.`DetalleReserva`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BDLA12`.`DetalleReserva` ;

CREATE TABLE IF NOT EXISTS `BDLA12`.`DetalleReserva` (
  `idDetalleReserva` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `horaInicio` TIME NOT NULL,
  `horaFin` TIME NOT NULL,
  `subTotal` DECIMAL(10,2) NOT NULL,
  `DR_idReserva` INT UNSIGNED NOT NULL,
  `DR_idCancha` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idDetalleReserva`),
  INDEX `idReserva_idx` (`DR_idReserva` ASC),
  INDEX `DR_idCancha_idx` (`DR_idCancha` ASC),
  CONSTRAINT `DR_idReserva`
    FOREIGN KEY (`DR_idReserva`)
    REFERENCES `BDLA12`.`Reserva` (`idReserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `DR_idCancha`
    FOREIGN KEY (`DR_idCancha`)
    REFERENCES `BDLA12`.`Cancha` (`idCancha`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDLA12`.`PrecioHora`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BDLA12`.`PrecioHora` ;

CREATE TABLE IF NOT EXISTS `BDLA12`.`PrecioHora` (
  `idPrecioHora` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `diaSemana` CHAR(9) NOT NULL,
  `horaInicio` TIME NOT NULL,
  `horaFin` TIME NOT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idPrecioHora`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDLA12`.`HistorialSede`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BDLA12`.`HistorialSede` ;

CREATE TABLE IF NOT EXISTS `BDLA12`.`HistorialSede` (
  `idHistorialSede` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `inicio` DATETIME NOT NULL,
  `fin` DATETIME NOT NULL,
  `estado` CHAR(4) NOT NULL,
  `HS_idSede` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idHistorialSede`),
  INDEX `idSede_idx` (`HS_idSede` ASC),
  CONSTRAINT `HS_idSede`
    FOREIGN KEY (`HS_idSede`)
    REFERENCES `BDLA12`.`Sede` (`idSede`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDLA12`.`Parametro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BDLA12`.`Parametro` ;

CREATE TABLE IF NOT EXISTS `BDLA12`.`Parametro` (
  `codigo` CHAR(4) NOT NULL,
  `descripcionCorta` VARCHAR(20) NOT NULL,
  `descripcion` VARCHAR(70) NOT NULL,
  `valor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `BDLA12`.`Persona`
-- -----------------------------------------------------
START TRANSACTION;
USE `BDLA12`;
INSERT INTO `BDLA12`.`Persona` (`idPersona`, `nombres`, `apellidos`, `celular`, `DNI`, `tipo`, `idUsuario`) VALUES (DEFAULT, 'Administrador', 'Administrador', NULL, '75763466', '0000', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `BDLA12`.`Gerente`
-- -----------------------------------------------------
START TRANSACTION;
USE `BDLA12`;
INSERT INTO `BDLA12`.`Gerente` (`idGerente`, `estado`, `Gerente_idPersona`) VALUES (DEFAULT, '0000', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `BDLA12`.`PrecioHora`
-- -----------------------------------------------------
START TRANSACTION;
USE `BDLA12`;
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'LUNES', '6:00', '7:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'LUNES', '7:00', '8:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'LUNES', '8:00', '9:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'LUNES', '9:00', '10:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'LUNES', '10:00', '11:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'LUNES', '11:00', '12:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'LUNES', '12:00', '13:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'LUNES', '13:00', '14:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'LUNES', '14:00', '15:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'LUNES', '15:00', '16:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'LUNES', '16:00', '17:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'LUNES', '17:00', '18:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'LUNES', '18:00', '19:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'LUNES', '19:00', '20:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'LUNES', '20:00', '21:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'LUNES', '21:00', '22:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'LUNES', '22:00', '23:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'LUNES', '23:00', '0:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MARTES', '6:00', '7:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MARTES', '7:00', '8:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MARTES', '8:00', '9:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MARTES', '9:00', '10:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MARTES', '10:00', '11:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MARTES', '11:00', '12:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MARTES', '12:00', '13:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MARTES', '13:00', '14:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MARTES', '14:00', '15:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MARTES', '15:00', '16:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MARTES', '16:00', '17:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MARTES', '17:00', '18:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MARTES', '18:00', '19:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MARTES', '19:00', '20:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MARTES', '20:00', '21:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MARTES', '21:00', '22:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MARTES', '22:00', '23:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MARTES', '23:00', '0:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MIERCOLES', '6:00', '7:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MIERCOLES', '7:00', '8:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MIERCOLES', '8:00', '9:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MIERCOLES', '9:00', '10:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MIERCOLES', '10:00', '11:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MIERCOLES', '11:00', '12:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MIERCOLES', '12:00', '13:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MIERCOLES', '13:00', '14:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MIERCOLES', '14:00', '15:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MIERCOLES', '15:00', '16:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MIERCOLES', '16:00', '17:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MIERCOLES', '17:00', '18:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MIERCOLES', '18:00', '19:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MIERCOLES', '19:00', '20:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MIERCOLES', '20:00', '21:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MIERCOLES', '21:00', '22:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MIERCOLES', '22:00', '23:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'MIERCOLES', '23:00', '0:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'JUEVES', '6:00', '7:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'JUEVES', '7:00', '8:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'JUEVES', '8:00', '9:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'JUEVES', '9:00', '10:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'JUEVES', '10:00', '11:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'JUEVES', '11:00', '12:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'JUEVES', '12:00', '13:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'JUEVES', '13:00', '14:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'JUEVES', '14:00', '15:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'JUEVES', '15:00', '16:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'JUEVES', '16:00', '17:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'JUEVES', '17:00', '18:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'JUEVES', '18:00', '19:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'JUEVES', '19:00', '20:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'JUEVES', '20:00', '21:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'JUEVES', '21:00', '22:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'JUEVES', '22:00', '23:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'JUEVES', '23:00', '0:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'VIERNES', '6:00', '7:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'VIERNES', '7:00', '8:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'VIERNES', '8:00', '9:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'VIERNES', '9:00', '10:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'VIERNES', '10:00', '11:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'VIERNES', '11:00', '12:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'VIERNES', '12:00', '13:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'VIERNES', '13:00', '14:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'VIERNES', '14:00', '15:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'VIERNES', '15:00', '16:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'VIERNES', '16:00', '17:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'VIERNES', '17:00', '18:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'VIERNES', '18:00', '19:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'VIERNES', '19:00', '20:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'VIERNES', '20:00', '21:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'VIERNES', '21:00', '22:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'VIERNES', '22:00', '23:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'VIERNES', '23:00', '0:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'SABADO', '6:00', '7:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'SABADO', '7:00', '8:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'SABADO', '8:00', '9:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'SABADO', '9:00', '10:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'SABADO', '10:00', '11:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'SABADO', '11:00', '12:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'SABADO', '12:00', '13:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'SABADO', '13:00', '14:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'SABADO', '14:00', '15:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'SABADO', '15:00', '16:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'SABADO', '16:00', '17:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'SABADO', '17:00', '18:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'SABADO', '18:00', '19:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'SABADO', '19:00', '20:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'SABADO', '20:00', '21:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'SABADO', '21:00', '22:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'SABADO', '22:00', '23:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'SABADO', '23:00', '0:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'DOMINGO', '6:00', '7:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'DOMINGO', '7:00', '8:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'DOMINGO', '8:00', '9:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'DOMINGO', '9:00', '10:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'DOMINGO', '10:00', '11:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'DOMINGO', '11:00', '12:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'DOMINGO', '12:00', '13:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'DOMINGO', '13:00', '14:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'DOMINGO', '14:00', '15:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'DOMINGO', '15:00', '16:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'DOMINGO', '16:00', '17:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'DOMINGO', '17:00', '18:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'DOMINGO', '18:00', '19:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'DOMINGO', '19:00', '20:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'DOMINGO', '20:00', '21:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'DOMINGO', '21:00', '22:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'DOMINGO', '22:00', '23:00', 20.00);
INSERT INTO `BDLA12`.`PrecioHora` (`idPrecioHora`, `diaSemana`, `horaInicio`, `horaFin`, `precio`) VALUES (DEFAULT, 'DOMINGO', '23:00', '0:00', 20.00);

COMMIT;


-- -----------------------------------------------------
-- Data for table `BDLA12`.`Parametro`
-- -----------------------------------------------------
START TRANSACTION;
USE `BDLA12`;
INSERT INTO `BDLA12`.`Parametro` (`codigo`, `descripcionCorta`, `descripcion`, `valor`) VALUES ('0000', 'Habilitado', 'se le permite usar el sistema', 'HABILITADO');
INSERT INTO `BDLA12`.`Parametro` (`codigo`, `descripcionCorta`, `descripcion`, `valor`) VALUES ('0001', 'Dehabilitado', 'No se le permite usar el sistema', 'DESHABILITADO');
INSERT INTO `BDLA12`.`Parametro` (`codigo`, `descripcionCorta`, `descripcion`, `valor`) VALUES ('0002', 'En Proceso', 'La reserva esta esperando a ser exitosa', 'EN_PROCESO');
INSERT INTO `BDLA12`.`Parametro` (`codigo`, `descripcionCorta`, `descripcion`, `valor`) VALUES ('0003', 'Anulada', 'La reserva fue anulada por quien la creo', 'ANULADA');
INSERT INTO `BDLA12`.`Parametro` (`codigo`, `descripcionCorta`, `descripcion`, `valor`) VALUES ('0004', 'Fallida', 'La reserva no concluyo con exito', 'FALLIDA');
INSERT INTO `BDLA12`.`Parametro` (`codigo`, `descripcionCorta`, `descripcion`, `valor`) VALUES ('0005', 'Exitosa', 'La reserva ha concluido con exito', 'EXITOSA');
INSERT INTO `BDLA12`.`Parametro` (`codigo`, `descripcionCorta`, `descripcion`, `valor`) VALUES ('0006', 'Visitante', 'Un visitante cualquiera de la pagina web', 'VISITANTE');
INSERT INTO `BDLA12`.`Parametro` (`codigo`, `descripcionCorta`, `descripcion`, `valor`) VALUES ('0007', 'Cliente', 'Un cliente que realiza la reserva, debidamente logeado', 'CLIENTE');
INSERT INTO `BDLA12`.`Parametro` (`codigo`, `descripcionCorta`, `descripcion`, `valor`) VALUES ('0008', 'Operador', 'Un operador que Adm. una sede, debidamente logeado', 'OPERADOR');
INSERT INTO `BDLA12`.`Parametro` (`codigo`, `descripcionCorta`, `descripcion`, `valor`) VALUES ('0009', 'Gerente', 'El gerente, Adm. del sistema, debidamente logeado', 'GERENTE');

COMMIT;

