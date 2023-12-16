-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-12-2023 a las 04:23:29
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `manzanas_cuidado`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `establecimiento`
--

CREATE TABLE `establecimiento` (
  `id_establecimiento` int(6) NOT NULL,
  `nombre_establecimiento` varchar(30) DEFAULT NULL,
  `direccion_establecimiento` varchar(30) DEFAULT NULL,
  `nombre_responsable` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `manzanas`
--

CREATE TABLE `manzanas` (
  `id_manzana` int(6) NOT NULL,
  `nombre_manzana` varchar(30) DEFAULT NULL,
  `localidad_manzana` varchar(30) DEFAULT NULL,
  `direccion_manzana` varchar(30) DEFAULT NULL,
  `id_establecimiento` int(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `manzanas_servicios`
--

CREATE TABLE `manzanas_servicios` (
  `id_manzana` int(11) NOT NULL,
  `id_servicio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `id_servicio` int(6) NOT NULL,
  `tipo_servicio` varchar(30) DEFAULT NULL,
  `categoria_servicio` varchar(30) DEFAULT NULL,
  `descripcion_servicio` varchar(528) DEFAULT NULL,
  `id_usuario` int(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(6) NOT NULL,
  `tipo_documento` varchar(20) DEFAULT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `apellidos` varchar(50) DEFAULT NULL,
  `telefono` int(10) DEFAULT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `ciudad` varchar(30) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `id_visita` int(6) DEFAULT NULL,
  `numero_documento` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `visitas`
--

CREATE TABLE `visitas` (
  `id_visita` int(6) NOT NULL,
  `manzana_visita` varchar(50) DEFAULT NULL,
  `fecha_hora_visita` datetime DEFAULT NULL,
  `servicio_solicitado` varchar(30) DEFAULT NULL,
  `fecha_visita` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `establecimiento`
--
ALTER TABLE `establecimiento`
  ADD PRIMARY KEY (`id_establecimiento`);

--
-- Indices de la tabla `manzanas`
--
ALTER TABLE `manzanas`
  ADD PRIMARY KEY (`id_manzana`),
  ADD KEY `pk_id1` (`id_establecimiento`);

--
-- Indices de la tabla `manzanas_servicios`
--
ALTER TABLE `manzanas_servicios`
  ADD PRIMARY KEY (`id_manzana`,`id_servicio`),
  ADD KEY `id_servicio` (`id_servicio`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id_servicio`),
  ADD KEY `pk_id2` (`id_usuario`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `pk_id3` (`id_visita`);

--
-- Indices de la tabla `visitas`
--
ALTER TABLE `visitas`
  ADD PRIMARY KEY (`id_visita`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `establecimiento`
--
ALTER TABLE `establecimiento`
  MODIFY `id_establecimiento` int(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `manzanas`
--
ALTER TABLE `manzanas`
  MODIFY `id_manzana` int(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id_servicio` int(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `visitas`
--
ALTER TABLE `visitas`
  MODIFY `id_visita` int(6) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `manzanas`
--
ALTER TABLE `manzanas`
  ADD CONSTRAINT `pk_id1` FOREIGN KEY (`id_establecimiento`) REFERENCES `establecimiento` (`id_establecimiento`);

--
-- Filtros para la tabla `manzanas_servicios`
--
ALTER TABLE `manzanas_servicios`
  ADD CONSTRAINT `manzanas_servicios_ibfk_1` FOREIGN KEY (`id_manzana`) REFERENCES `manzanas` (`id_manzana`),
  ADD CONSTRAINT `manzanas_servicios_ibfk_2` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id_servicio`);

--
-- Filtros para la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD CONSTRAINT `pk_id2` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `pk_id3` FOREIGN KEY (`id_visita`) REFERENCES `visitas` (`id_visita`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
