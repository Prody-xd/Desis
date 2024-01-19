-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-01-2024 a las 01:22:45
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `votaciones`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarVotante` (IN `p_nombre_apellido` VARCHAR(100), IN `p_alias` VARCHAR(100), IN `p_rut` VARCHAR(20), IN `p_email` VARCHAR(100), IN `p_nombre_candidato` INT(10), IN `p_fuente_referencia` VARCHAR(50), IN `p_nombre_comuna` VARCHAR(100), IN `p_nombre_region` INT(10))   BEGIN
    DECLARE v_comuna_id INT;
    DECLARE v_region_id INT;
    DECLARE v_candidato_id INT;

    -- Buscar el id_comuna de la comuna ingresada
    SELECT id_comuna INTO v_comuna_id
    FROM Comuna
    WHERE nombre = p_nombre_comuna;

    -- Insertar en la tabla Votante y obtener el id_votante generado automáticamente
    INSERT INTO Votante (
        nombre_apellido,
        alias,
        rut,
        email,
        candidato_votado,
        fuente_referencia,
        comuna_id,
        region_id
    ) VALUES (
        p_nombre_apellido,
        p_alias,
        p_rut,
        p_email,
        p_nombre_candidato,
        p_fuente_referencia,
        v_comuna_id,
        p_nombre_region
    );

    -- Obtener el id_votante recién insertado
    SELECT LAST_INSERT_ID() AS id_votante;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `candidato`
--

CREATE TABLE `candidato` (
  `id_candidato` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `partido_politico` varchar(255) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `candidato`
--

INSERT INTO `candidato` (`id_candidato`, `nombre`, `partido_politico`, `edad`) VALUES
(1, 'María Rodríguez', 'Unión Democrática', 45),
(2, 'Carlos Gómez', 'Renovación Nacional', 50),
(3, 'Ana Flores', 'Partido Socialista', 48),
(4, 'Javier Herrera', 'Movimiento Ciudadano', 42),
(5, 'Laura Mendoza', 'Alianza Verde', 47);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comuna`
--

CREATE TABLE `comuna` (
  `id_comuna` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `region_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comuna`
--

INSERT INTO `comuna` (`id_comuna`, `nombre`, `region_id`) VALUES
(1, 'Arica', 1),
(2, 'Putre', 1),
(3, 'Iquique', 2),
(4, 'Alto Hospicio', 2),
(5, 'Pozo Almonte', 2),
(6, 'Camiña', 2),
(7, 'Colchane', 2),
(8, 'Huara', 2),
(9, 'Pica', 2),
(10, 'Antofagasta', 3),
(11, 'Mejillones', 3),
(12, 'Sierra Gorda', 3),
(13, 'Taltal', 3),
(14, 'Calama', 3),
(15, 'Ollagüe', 3),
(16, 'San Pedro de Atacama', 3),
(17, 'Tocopilla', 3),
(18, 'María Elena', 3),
(19, 'Copiapó', 4),
(20, 'Caldera', 4),
(21, 'Tierra Amarilla', 4),
(22, 'Chañaral', 4),
(23, 'Diego de Almagro', 4),
(24, 'Vallenar', 4),
(25, 'Alto del Carmen', 4),
(26, 'Freirina', 4),
(27, 'Huasco', 4),
(28, 'La Serena', 5),
(29, 'Coquimbo', 5),
(30, 'Andacollo', 5),
(31, 'La Higuera', 5),
(32, 'Paihuano', 5),
(33, 'Vicuña', 5),
(34, 'Illapel', 5),
(35, 'Canela', 5),
(36, 'Los Vilos', 5),
(37, 'Salamanca', 5),
(38, 'Ovalle', 5),
(39, 'Combarbalá', 5),
(40, 'Monte Patria', 5),
(41, 'Punitaqui', 5),
(42, 'Río Hurtado', 5),
(43, 'Valparaíso', 6),
(44, 'Casablanca', 6),
(45, 'Concón', 6),
(46, 'Juan Fernández', 6),
(47, 'Puchuncaví', 6),
(48, 'Quintero', 6),
(49, 'Viña del Mar', 6),
(50, 'Isla de Pascua', 6),
(51, 'Los Andes', 6),
(52, 'Calle Larga', 6),
(53, 'Rinconada', 6),
(54, 'San Esteban', 6),
(55, 'La Ligua', 6),
(56, 'Cabildo', 6),
(57, 'Papudo', 6),
(58, 'Petorca', 6),
(59, 'Zapallar', 6),
(60, 'Quillota', 6),
(61, 'Calera', 6),
(62, 'Hijuelas', 6),
(63, 'La Cruz', 6),
(64, 'Nogales', 6),
(65, 'San Antonio', 6),
(66, 'Algarrobo', 6),
(67, 'Cartagena', 6),
(68, 'El Quisco', 6),
(69, 'El Tabo', 6),
(70, 'Santo Domingo', 6),
(71, 'Santiago', 7),
(72, 'Cerrillos', 7),
(73, 'Cerro Navia', 7),
(74, 'Conchalí', 7),
(75, 'El Bosque', 7),
(76, 'Estación Central', 7),
(77, 'Huechuraba', 7),
(78, 'Independencia', 7),
(79, 'La Cisterna', 7),
(80, 'La Florida', 7),
(81, 'La Granja', 7),
(82, 'La Pintana', 7),
(83, 'La Reina', 7),
(84, 'Las Condes', 7),
(85, 'Lo Barnechea', 7),
(86, 'Lo Espejo', 7),
(87, 'Lo Prado', 7),
(88, 'Macul', 7),
(89, 'Maipú', 7),
(90, 'Ñuñoa', 7),
(91, 'Padre Hurtado', 7),
(92, 'Paine', 7),
(93, 'Pedro Aguirre Cerda', 7),
(94, 'Peñalolén', 7),
(95, 'Providencia', 7),
(96, 'Pudahuel', 7),
(97, 'Puente Alto', 7),
(98, 'Quilicura', 7),
(99, 'Quinta Normal', 7),
(100, 'Recoleta', 7),
(101, 'Renca', 7),
(102, 'San Bernardo', 7),
(103, 'San Joaquín', 7),
(104, 'San José de Maipo', 7),
(105, 'San Miguel', 7),
(106, 'San Pedro', 7),
(107, 'San Ramón', 7),
(108, 'Talagante', 7),
(109, 'Tiltil', 7),
(110, 'Vitacura', 7),
(111, 'Buin', 7),
(112, 'Calera de Tango', 7),
(113, 'Colina', 7),
(114, 'Isla de Maipo', 7),
(115, 'Lampa', 7),
(116, 'Melipilla', 7),
(117, 'Pirque', 7),
(118, 'Pudahuel', 7),
(119, 'Quilicura', 7),
(120, 'Recoleta', 7),
(121, 'San Bernardo', 7),
(122, 'Talagante', 7),
(123, 'Rancagua', 8),
(124, 'Codegua', 8),
(125, 'Coinco', 8),
(126, 'Coltauco', 8),
(127, 'Doñihue', 8),
(128, 'Graneros', 8),
(129, 'Las Cabras', 8),
(130, 'Machalí', 8),
(131, 'Malloa', 8),
(132, 'Mostazal', 8),
(133, 'Olivar', 8),
(134, 'Peumo', 8),
(135, 'Pichidegua', 8),
(136, 'Quinta de Tilcoco', 8),
(137, 'Rengo', 8),
(138, 'Requínoa', 8),
(139, 'San Vicente', 8),
(140, 'Pichilemu', 8),
(141, 'La Estrella', 8),
(142, 'Litueche', 8),
(143, 'Marchigüe', 8),
(144, 'Navidad', 8),
(145, 'Paredones', 8),
(146, 'San Fernando', 8),
(147, 'Chépica', 8),
(148, 'Chimbarongo', 8),
(149, 'Lolol', 8),
(150, 'Nancagua', 8),
(151, 'Palmilla', 8),
(152, 'Peralillo', 8),
(153, 'Placilla', 8),
(154, 'Pumanque', 8),
(155, 'Santa Cruz', 8),
(156, 'Talca', 9),
(157, 'Constitución', 9),
(158, 'Curepto', 9),
(159, 'Empedrado', 9),
(160, 'Maule', 9),
(161, 'Pelarco', 9),
(162, 'Pencahue', 9),
(163, 'Río Claro', 9),
(164, 'San Clemente', 9),
(165, 'San Rafael', 9),
(166, 'Cauquenes', 9),
(167, 'Chanco', 9),
(168, 'Pelluhue', 9),
(169, 'Curicó', 9),
(170, 'Hualañé', 9),
(171, 'Licantén', 9),
(172, 'Molina', 9),
(173, 'Rauco', 9),
(174, 'Romeral', 9),
(175, 'Sagrada Familia', 9),
(176, 'Teno', 9),
(177, 'Vichuquén', 9),
(178, 'Linares', 9),
(179, 'Colbún', 9),
(180, 'Longaví', 9),
(181, 'Parral', 9),
(182, 'Retiro', 9),
(183, 'San Javier', 9),
(184, 'Villa Alegre', 9),
(185, 'Yerbas Buenas', 9),
(186, 'Chillán', 10),
(187, 'Bulnes', 10),
(188, 'Cobquecura', 10),
(189, 'Coelemu', 10),
(190, 'Coihueco', 10),
(191, 'Chillán Viejo', 10),
(192, 'El Carmen', 10),
(193, 'Ninhue', 10),
(194, 'Ñiquén', 10),
(195, 'Pemuco', 10),
(196, 'Pinto', 10),
(197, 'Portezuelo', 10),
(198, 'Quillón', 10),
(199, 'Quirihue', 10),
(200, 'Ránquil', 10),
(201, 'San Carlos', 10),
(202, 'San Fabián', 10),
(203, 'San Ignacio', 10),
(204, 'San Nicolás', 10),
(205, 'Treguaco', 10),
(206, 'Yungay', 10),
(207, 'Concepción', 11),
(208, 'Coronel', 11),
(209, 'Chiguayante', 11),
(210, 'Florida', 11),
(211, 'Hualqui', 11),
(212, 'Lota', 11),
(213, 'Penco', 11),
(214, 'San Pedro de la Paz', 11),
(215, 'Santa Juana', 11),
(216, 'Talcahuano', 11),
(217, 'Tomé', 11),
(218, 'Hualpén', 11),
(219, 'Lebu', 11),
(220, 'Arauco', 11),
(221, 'Cañete', 11),
(222, 'Contulmo', 11),
(223, 'Curanilahue', 11),
(224, 'Los Álamos', 11),
(225, 'Tirúa', 11),
(226, 'Chillán', 11),
(227, 'Bulnes', 11),
(228, 'Cobquecura', 11),
(229, 'Coelemu', 11),
(230, 'Coihueco', 11),
(231, 'Chillán Viejo', 11),
(232, 'El Carmen', 11),
(233, 'Ninhue', 11),
(234, 'Ñiquén', 11),
(235, 'Pemuco', 11),
(236, 'Pinto', 11),
(237, 'Portezuelo', 11),
(238, 'Quillón', 11),
(239, 'Quirihue', 11),
(240, 'Ránquil', 11),
(241, 'San Carlos', 11),
(242, 'San Fabián', 11),
(243, 'San Ignacio', 11),
(244, 'San Nicolás', 11),
(245, 'Treguaco', 11),
(246, 'Yungay', 11),
(247, 'Temuco', 12),
(248, 'Carahue', 12),
(249, 'Cunco', 12),
(250, 'Curarrehue', 12),
(251, 'Freire', 12),
(252, 'Galvarino', 12),
(253, 'Gorbea', 12),
(254, 'Lautaro', 12),
(255, 'Loncoche', 12),
(256, 'Melipeuco', 12),
(257, 'Nueva Imperial', 12),
(258, 'Padre Las Casas', 12),
(259, 'Perquenco', 12),
(260, 'Pitrufquén', 12),
(261, 'Pucón', 12),
(262, 'Saavedra', 12),
(263, 'Teodoro Schmidt', 12),
(264, 'Toltén', 12),
(265, 'Vilcún', 12),
(266, 'Villarrica', 12),
(267, 'Cholchol', 12),
(268, 'Angol', 12),
(269, 'Collipulli', 12),
(270, 'Curacautín', 12),
(271, 'Ercilla', 12),
(272, 'Lonquimay', 12),
(273, 'Los Sauces', 12),
(274, 'Lumaco', 12),
(275, 'Purén', 12),
(276, 'Renaico', 12),
(277, 'Traiguén', 12),
(278, 'Victoria', 12),
(279, 'Valdivia', 13),
(280, 'Corral', 13),
(281, 'Lanco', 13),
(282, 'Los Lagos', 13),
(283, 'Máfil', 13),
(284, 'Mariquina', 13),
(285, 'Paillaco', 13),
(286, 'Panguipulli', 13),
(287, 'La Unión', 13),
(288, 'Futrono', 13),
(289, 'Lago Ranco', 13),
(290, 'Río Bueno', 13),
(291, 'Puerto Montt', 14),
(292, 'Calbuco', 14),
(293, 'Cochamó', 14),
(294, 'Fresia', 14),
(295, 'Frutillar', 14),
(296, 'Los Muermos', 14),
(297, 'Llanquihue', 14),
(298, 'Maullín', 14),
(299, 'Puerto Varas', 14),
(300, 'Castro', 14),
(301, 'Ancud', 14),
(302, 'Chonchi', 14),
(303, 'Curaco de Vélez', 14),
(304, 'Dalcahue', 14),
(305, 'Puqueldón', 14),
(306, 'Queilén', 14),
(307, 'Quellón', 14),
(308, 'Quemchi', 14),
(309, 'Quinchao', 14),
(310, 'Osorno', 14),
(311, 'Puerto Octay', 14),
(312, 'Purranque', 14),
(313, 'Puyehue', 14),
(314, 'Río Negro', 14),
(315, 'San Juan de la Costa', 14),
(316, 'San Pablo', 14),
(317, 'Chaitén', 14),
(318, 'Futaleufú', 14),
(319, 'Hualaihué', 14),
(320, 'Palena', 14),
(321, 'Coihaique', 15),
(322, 'Lago Verde', 15),
(323, 'Aysén', 15),
(324, 'Cisnes', 15),
(325, 'Guaitecas', 15),
(326, 'Chile Chico', 15),
(327, 'Río Ibáñez', 15),
(328, 'Punta Arenas', 16),
(329, 'Laguna Blanca', 16),
(330, 'Río Verde', 16),
(331, 'San Gregorio', 16),
(332, 'Cabo de Hornos', 16),
(333, 'Antártica', 16);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `region`
--

CREATE TABLE `region` (
  `region_id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `region`
--

INSERT INTO `region` (`region_id`, `nombre`) VALUES
(1, 'Región de Arica y Parinacota'),
(2, 'Región de Tarapacá'),
(3, 'Región de Antofagasta'),
(4, 'Región de Atacama'),
(5, 'Región de Coquimbo'),
(6, 'Región de Valparaíso'),
(7, 'Región Metropolitana de Santiago'),
(8, 'Región del Libertador General Bernardo O\'Higgins'),
(9, 'Región del Maule'),
(10, 'Región de Ñuble'),
(11, 'Región del Biobío'),
(12, 'Región de La Araucanía'),
(13, 'Región de Los Ríos'),
(14, 'Región de Los Lagos'),
(15, 'Región de Aysén del General Carlos Ibáñez del Campo'),
(16, 'Región de Magallanes y de la Antártica Chilena');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `votante`
--

CREATE TABLE `votante` (
  `id_votante` int(11) NOT NULL,
  `nombre_apellido` varchar(100) NOT NULL,
  `alias` varchar(100) DEFAULT NULL,
  `rut` varchar(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `candidato_votado` int(11) DEFAULT NULL,
  `fuente_referencia` varchar(50) DEFAULT NULL,
  `comuna_id` int(11) DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `votante`
--

INSERT INTO `votante` (`id_votante`, `nombre_apellido`, `alias`, `rut`, `email`, `candidato_votado`, `fuente_referencia`, `comuna_id`, `region_id`) VALUES
(4, 'Diego Santana', 'YoelDiego', '123456789', 'email@email.com', 3, 'web', 3, 2),
(6, 'Ignacio Salinas', 'N4ch1t0', '13485930-K', 'prody.graff1402@gmail.com', NULL, 'TV, Redes', NULL, NULL),
(7, 'Ignacio Salinas', 'N4ch1t0', '20914160-4', 'diego@duocuc.cl', NULL, 'TV', NULL, NULL),
(9, 'Diego Santana', 'Pr0dyS', '9141823-1', 'diego@duocuc.cl', NULL, 'TV, Amigo', NULL, NULL),
(11, 'Diego Santana', 'aa', '123656789', 'diego.weed1402@gmail.com', 5, 'Web', 74, 7),
(14, 'Diego Santana', 'Pr0dyS', '20969522-7', 'diego@duocuc.cl', 3, 'TV, Redes', 72, 7);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `candidato`
--
ALTER TABLE `candidato`
  ADD PRIMARY KEY (`id_candidato`);

--
-- Indices de la tabla `comuna`
--
ALTER TABLE `comuna`
  ADD PRIMARY KEY (`id_comuna`),
  ADD KEY `region_id` (`region_id`);

--
-- Indices de la tabla `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`region_id`);

--
-- Indices de la tabla `votante`
--
ALTER TABLE `votante`
  ADD PRIMARY KEY (`id_votante`),
  ADD UNIQUE KEY `rut` (`rut`),
  ADD KEY `comuna_id` (`comuna_id`),
  ADD KEY `region_id` (`region_id`),
  ADD KEY `candidato_votado` (`candidato_votado`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `candidato`
--
ALTER TABLE `candidato`
  MODIFY `id_candidato` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `comuna`
--
ALTER TABLE `comuna`
  MODIFY `id_comuna` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=334;

--
-- AUTO_INCREMENT de la tabla `region`
--
ALTER TABLE `region`
  MODIFY `region_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `votante`
--
ALTER TABLE `votante`
  MODIFY `id_votante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comuna`
--
ALTER TABLE `comuna`
  ADD CONSTRAINT `comuna_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `region` (`region_id`);

--
-- Filtros para la tabla `votante`
--
ALTER TABLE `votante`
  ADD CONSTRAINT `votante_ibfk_1` FOREIGN KEY (`comuna_id`) REFERENCES `comuna` (`id_comuna`),
  ADD CONSTRAINT `votante_ibfk_2` FOREIGN KEY (`region_id`) REFERENCES `region` (`region_id`),
  ADD CONSTRAINT `votante_ibfk_3` FOREIGN KEY (`candidato_votado`) REFERENCES `candidato` (`id_candidato`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
