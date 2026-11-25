-- =============================================================================
-- UNIVERSIDAD DISTRITAL FRANCISCO JOSE DE CALDAS
-- Proyecto de Grado: LDWS (LAN Design Workspace System)
-- Modelo para el Diseno de Redes en Entornos LAN basado en un Sistema Multinivel
-- Base de Datos Relacional: MySQL 5.7 / 8.0 / MariaDB 10.x
-- =============================================================================

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `ldwsud_base` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `ldwsud_base`;

-- -----------------------------------------------------------------------------
-- Tabla: `users`
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` char(40) NOT NULL,
  `name` varchar(120) NOT NULL,
  `email` varchar(70) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` char(1) NOT NULL DEFAULT 'Y',
  `role` varchar(30) NOT NULL DEFAULT 'Admin',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_users_username` (`username`),
  UNIQUE KEY `idx_users_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Usuarios Iniciales (Password: 'phalcon' -> sha1: 4b60098cf1121d4d8e5797282b8f75ff38da6982)
INSERT INTO `users` (`id`, `username`, `password`, `name`, `email`, `created_at`, `active`, `role`) VALUES
(1, 'admin', '4b60098cf1121d4d8e5797282b8f75ff38da6982', 'Administrador LDWS', 'admin@udistrital.edu.co', NOW(), 'Y', 'Admin'),
(2, 'demo', '4b60098cf1121d4d8e5797282b8f75ff38da6982', 'Usuario Investigador', 'demo@udistrital.edu.co', NOW(), 'Y', 'Investigador');

-- -----------------------------------------------------------------------------
-- Tabla: `empresas`
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `empresas`;
CREATE TABLE `empresas` (
  `IdEmpresa` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(150) NOT NULL,
  `Nit` varchar(50) NOT NULL,
  `Mision` text,
  `Vision` text,
  `IdUsuario` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdEmpresa`),
  KEY `fk_empresa_usuario` (`IdUsuario`),
  CONSTRAINT `fk_empresas_users` FOREIGN KEY (`IdUsuario`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `empresas` (`IdEmpresa`, `Nombre`, `Nit`, `Mision`, `Vision`, `IdUsuario`, `created_at`) VALUES
(1, 'TechCorp Telecomunicaciones SAS', '900.876.543-2', 'Proveer soluciones integrales de conectividad y servicios digitales de alta disponibilidad para el sector productivo.', 'Ser el referente regional en infraestructura de redes convergentes y ciberseguridad para el ano 2030.', 1, NOW());

-- -----------------------------------------------------------------------------
-- Tabla: `solicitudes`
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `solicitudes`;
CREATE TABLE `solicitudes` (
  `IdSolicitud` int(11) NOT NULL AUTO_INCREMENT,
  `IdEmpresa` int(11) NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `Descripcion` text NOT NULL,
  `Objetivos` text NOT NULL,
  `Observaciones` text,
  `Servicio` varchar(255) NOT NULL DEFAULT 'Datos, VoIP, Videovigilancia',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdSolicitud`),
  KEY `fk_solicitud_empresa` (`IdEmpresa`),
  CONSTRAINT `fk_solicitudes_empresas` FOREIGN KEY (`IdEmpresa`) REFERENCES `empresas` (`IdEmpresa`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `solicitudes` (`IdSolicitud`, `IdEmpresa`, `titulo`, `Descripcion`, `Objetivos`, `Observaciones`, `Servicio`, `created_at`) VALUES
(1, 1, 'Diseno Red LAN Edificio Central', 'Diseno e implementacion de cableado estructurado horizontal y vertical con segmentacion logica VLAN para 3 niveles corporativos.', 'Garantizar conectividad gigabit a 107 puestos de trabajo, telefonia IP con QoS y aislamiento de trafico de invitados.', 'Se requiere cuarto de telecomunicaciones principal (MDF) en primer piso con conexion a fibra optica externa.', 'web, bd, voip, video, correo, dhcp, dns', NOW());

-- -----------------------------------------------------------------------------
-- Tabla: `pisos`
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `pisos`;
CREATE TABLE `pisos` (
  `id_piso` int(11) NOT NULL AUTO_INCREMENT,
  `id_empresa` int(11) NOT NULL,
  `numero` int(11) NOT NULL DEFAULT 1,
  `alto` decimal(6,2) NOT NULL DEFAULT 3.00,
  `ancho` decimal(6,2) NOT NULL DEFAULT 20.00,
  `largo` decimal(6,2) NOT NULL DEFAULT 30.00,
  `equipos` int(11) NOT NULL DEFAULT 25,
  `sala` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_piso`),
  KEY `fk_piso_empresa` (`id_empresa`),
  CONSTRAINT `fk_pisos_empresas` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`IdEmpresa`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `pisos` (`id_piso`, `id_empresa`, `numero`, `alto`, `ancho`, `largo`, `equipos`, `sala`, `created_at`) VALUES
(1, 1, 1, 3.50, 25.00, 35.00, 45, 1, NOW()),
(2, 1, 2, 3.20, 25.00, 35.00, 38, 0, NOW()),
(3, 1, 3, 3.20, 25.00, 35.00, 24, 0, NOW());

-- -----------------------------------------------------------------------------
-- Tabla: `logico`
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `logico`;
CREATE TABLE `logico` (
  `id_logico` int(11) NOT NULL AUTO_INCREMENT,
  `id_solicitud` int(11) NOT NULL,
  `redundancia` tinyint(1) NOT NULL DEFAULT 1,
  `escalabilidad` varchar(100) NOT NULL DEFAULT '30%',
  `subredes` int(11) NOT NULL DEFAULT 4,
  `desc_subred` text NOT NULL,
  `scripts` tinyint(1) NOT NULL DEFAULT 1,
  `tabla_dirip` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_logico`),
  KEY `fk_logico_solicitud` (`id_solicitud`),
  CONSTRAINT `fk_logico_solicitudes` FOREIGN KEY (`id_solicitud`) REFERENCES `solicitudes` (`IdSolicitud`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `logico` (`id_logico`, `id_solicitud`, `redundancia`, `escalabilidad`, `subredes`, `desc_subred`, `scripts`, `tabla_dirip`, `created_at`) VALUES
(1, 1, 1, '35% de holgura en puertos y direcciones IP', 4, 'VLAN 10: Datos Usuarios, VLAN 20: Voz sobre IP (VoIP), VLAN 30: Servidores Corporativos, VLAN 99: Red Wi-Fi Invitados', 1, 1, NOW());

-- -----------------------------------------------------------------------------
-- Tabla: `equipos` (Inventario Calculado / Bill of Materials)
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `equipos`;
CREATE TABLE `equipos` (
  `id_equipo` int(11) NOT NULL AUTO_INCREMENT,
  `id_solicitud` int(11) NOT NULL,
  `tipo_equipo` varchar(100) NOT NULL,
  `modelo` varchar(150) NOT NULL,
  `capa_osi` int(2) NOT NULL DEFAULT 2,
  `cantidad` int(11) NOT NULL DEFAULT 1,
  `puertos` int(11) NOT NULL DEFAULT 24,
  `ubicacion` varchar(100) DEFAULT 'MDF Piso 1',
  `descripcion` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_equipo`),
  KEY `fk_equipo_solicitud` (`id_solicitud`),
  CONSTRAINT `fk_equipos_solicitudes` FOREIGN KEY (`id_solicitud`) REFERENCES `solicitudes` (`IdSolicitud`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `equipos` (`id_equipo`, `id_solicitud`, `tipo_equipo`, `modelo`, `capa_osi`, `cantidad`, `puertos`, `ubicacion`, `descripcion`, `created_at`) VALUES
(1, 1, 'Switch de Nucleo (Core)', 'Cisco Catalyst 3850-24XU Capa 3', 3, 1, 24, 'MDF Piso 1', 'Enrutamiento Inter-VLAN y agregacion de enlaces troncales 10G', NOW()),
(2, 1, 'Switch de Distribucion/Acceso', 'Cisco Catalyst 2960-X 48 GigE PoE+', 2, 2, 48, 'MDF Piso 1', 'Conexion para 45 puestos de trabajo y access points en Piso 1', NOW()),
(3, 1, 'Switch de Acceso', 'Cisco Catalyst 2960-X 48 GigE PoE+', 2, 1, 48, 'IDF Piso 2', 'Conexion para 38 puestos de trabajo y telefonia en Piso 2', NOW()),
(4, 1, 'Switch de Acceso', 'Cisco Catalyst 2960-X 24 GigE PoE+', 2, 1, 24, 'IDF Piso 3', 'Conexion para 24 puestos de trabajo en Piso 3', NOW()),
(5, 1, 'Router de Borde / Gateway', 'Cisco ISR 4331 Gigabit Security', 3, 1, 3, 'MDF Piso 1', 'Salida a Internet con firewall de inspeccion y NAT/PAT', NOW()),
(6, 1, 'Access Point Inalambrico', 'Cisco Aironet 2802i Dual Band 802.11ac', 2, 6, 2, 'Distribuidos por Piso (2 por piso)', 'Cobertura Wi-Fi corporativa y red aislada de invitados', NOW());

COMMIT;
