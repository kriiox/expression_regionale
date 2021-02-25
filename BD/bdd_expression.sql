-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3308
-- Généré le :  jeu. 25 fév. 2021 à 20:05
-- Version du serveur :  5.7.24
-- Version de PHP :  7.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `bdd_expression`
--
CREATE DATABASE IF NOT EXISTS `bdd_expression` DEFAULT CHARACTER SET latin1 COLLATE latin1_bin;
USE `bdd_expression`;

DROP TABLE IF EXISTS `expression`;
DROP TABLE IF EXISTS `groupe`;
DROP TABLE IF EXISTS `region`;
DROP TABLE IF EXISTS `region_expression`;

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `ajoutExpression`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ajoutExpression` (`p_mot` VARCHAR(255), `p_numGroupe` INT, `p_numRegion` INT)  BEGIN
    DECLARE id INT;
    INSERT INTO expression (mots, num_Groupe) 
    VALUES (p_mot, p_numGroupe);
    SELECT MAX(id_Expression) INTO id FROM expression;
    INSERT INTO region_expression (num_Region, num_Expression)
    Values (p_numRegion, id);
END$$

DROP PROCEDURE IF EXISTS `listeExpressionGroupeRegion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `listeExpressionGroupeRegion` (`p_numGroupe` INT, `p_numRegion` INT)  SELECT id_expression, mots, num_Groupe, num_Region 
    FROM expression AS e INNER JOIN region_expression AS re ON e.id_Expression = re.num_Expression
    WHERE num_Groupe = p_numGroupe && num_Region = p_numRegion$$

DROP PROCEDURE IF EXISTS `listeRegionParIdExpression`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `listeRegionParIdExpression` (`p_numExpression` INT)  SELECT num_Region
	FROM region_expression
	Where num_Expression = p_numExpression$$

DROP PROCEDURE IF EXISTS `selectExpressionParGroup`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectExpressionParGroup` (`p_numGroupe` INT)  SELECT id_Expression, mots, num_Groupe, num_Region 
    FROM expression INNER JOIN region_expression ON id_Expression = num_Expression
    WHERE num_Groupe = p_numGroupe$$

DROP PROCEDURE IF EXISTS `selectExpressionParGroupEtRegion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectExpressionParGroupEtRegion` (`p_numGroupe` INT, `p_numRegion` INT)  SELECT id_Expression, mots, num_Groupe, num_Region 
    FROM expression INNER JOIN region_expression ON id_Expression = num_Expression
    WHERE num_Groupe = p_numGroupe && num_Region = p_numRegion$$

DROP PROCEDURE IF EXISTS `selectExpressionParId`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectExpressionParId` (`p_id` INT)  SELECT id_expression, mots, num_Groupe, num_Region 
    FROM expression INNER JOIN region_expression ON id_Expression = num_Expression
    WHERE id_expression = p_id$$

DROP PROCEDURE IF EXISTS `selectExpressionsByExpression`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectExpressionsByExpression` (`p_mot` VARCHAR(255))  SELECT mots FROM expression WHERE num_Groupe = ( SELECT num_Groupe FROM expression WHERE mots = p_mot LIMIT 1)$$

DROP PROCEDURE IF EXISTS `selectGroupe`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectGroupe` ()  SELECT *
    FROM groupe 
    ORDER BY mots_Ref$$

DROP PROCEDURE IF EXISTS `selectGroupeExpression`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectGroupeExpression` ()  SELECT id_expression, mots, num_Groupe, num_Region
    FROM expression INNER JOIN region_expression ON id_Expression = num_Expression
    ORDER BY num_Groupe$$

DROP PROCEDURE IF EXISTS `selectRegions`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectRegions` ()  SELECT id_Region, nom
    FROM region 
    ORDER BY nom$$

DROP PROCEDURE IF EXISTS `updateExpressionParId`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateExpressionParId` (`p_id` INT, `p_mots` VARCHAR(255), `p_numRegion` INT, `p_numGroupe` INT)  UPDATE expression 
    SET mots = p_mots, num_Groupe = p_numGroupe, num_Region = p_numRegion 
    WHERE id_Expression = p_id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `expression`
--


CREATE TABLE IF NOT EXISTS `expression` (
  `id_Expression` int(11) NOT NULL AUTO_INCREMENT,
  `mots` varchar(255) COLLATE latin1_bin NOT NULL,
  `num_Groupe` int(11) NOT NULL,
  PRIMARY KEY (`id_Expression`),
  KEY `fk_numGroup_Groupe_idGroup` (`num_Groupe`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Déchargement des données de la table `expression`
--

INSERT INTO `expression` (`id_Expression`, `mots`, `num_Groupe`) VALUES
(1, 'Serpillère', 1),
(2, 'toiles', 1),
(3, 'Wassingue', 1),
(4, 'Piéce', 1),
(5, 'Petit pain au chocolat', 2),
(6, 'Pain au chocolat', 2),
(7, 'Chocolatine', 2),
(8, 'Crayon de bois', 3),
(9, 'Crayon à papier', 3),
(10, 'Crayon gris', 3),
(11, 'Crayon de papier', 3),
(12, 'Pelle', 4),
(13, 'Ramasse-bourrier', 4),
(14, 'Pelle-à-cheni', 4),
(15, 'Pain aux raisins', 5),
(16, 'Escargot', 5),
(17, 'Kebab', 6),
(18, 'Grec', 6),
(19, 'Döner', 6),
(20, 'Barrer', 7),
(21, 'Clencher', 7),
(22, 'Fermer à clef', 7),
(23, 'Ducasse', 8),
(24, 'Fête', 8),
(25, 'Fest-noz', 8),
(26, 'Frairie', 8),
(27, 'Vogue', 8),
(28, 'Fête votive', 8),
(29, 'Galette des rois', 9),
(30, 'Gâteau des rois', 9);

-- --------------------------------------------------------

--
-- Structure de la table `groupe`
--


CREATE TABLE IF NOT EXISTS `groupe` (
  `id_Groupe` int(11) NOT NULL AUTO_INCREMENT,
  `mots_Ref` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id_Groupe`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Déchargement des données de la table `groupe`
--

INSERT INTO `groupe` (`id_Groupe`, `mots_Ref`) VALUES
(1, 'Serpillère'),
(2, 'Pain au chocolat'),
(3, 'Crayon de bois'),
(4, 'Ramasse-bourrier'),
(5, 'Pain aux raisins'),
(6, 'Kebab'),
(7, 'Fermer à clef'),
(8, 'Fête'),
(9, 'Galette des rois');

-- --------------------------------------------------------

--
-- Structure de la table `region`
--


CREATE TABLE IF NOT EXISTS `region` (
  `id_Region` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id_Region`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Déchargement des données de la table `region`
--

INSERT INTO `region` (`id_Region`, `nom`) VALUES
(1, 'Hauts-de-France'),
(2, 'Normandie'),
(3, 'Bretagne'),
(4, 'Pays de la Loire'),
(5, 'Centre'),
(6, 'Ile de France'),
(7, 'Grand-Est'),
(8, 'Bourgogne Franche-Compté'),
(9, 'Nouvelle Aquitaine'),
(10, 'Auvergne-Rhône Alpes'),
(11, 'Occitanie'),
(12, 'Provence-Alpes-Cote-d-Azur'),
(13, 'Corse');

-- --------------------------------------------------------

--
-- Structure de la table `region_expression`
--


CREATE TABLE IF NOT EXISTS `region_expression` (
  `num_Region` int(11) NOT NULL,
  `num_Expression` int(11) NOT NULL,
  PRIMARY KEY (`num_Region`,`num_Expression`),
  KEY `FK_numExpression_Expression_idExpression` (`num_Expression`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Déchargement des données de la table `region_expression`
--

INSERT INTO `region_expression` (`num_Region`, `num_Expression`) VALUES
(1, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(13, 1),
(2, 2),
(12, 4),
(1, 5),
(2, 6),
(3, 6),
(4, 6),
(5, 6),
(6, 6),
(7, 6),
(8, 6),
(10, 6),
(12, 6),
(13, 6),
(9, 7),
(11, 7),
(1, 8),
(4, 8),
(2, 9),
(9, 9),
(10, 9),
(11, 9),
(13, 9),
(3, 10),
(12, 10),
(5, 11),
(6, 11),
(7, 11),
(8, 11),
(1, 12),
(2, 12),
(3, 12),
(5, 12),
(6, 12),
(7, 12),
(9, 12),
(10, 12),
(11, 12),
(12, 12),
(13, 12),
(4, 13),
(8, 14),
(1, 15),
(2, 15),
(3, 15),
(4, 15),
(5, 15),
(6, 15),
(8, 15),
(9, 15),
(10, 15),
(11, 15),
(12, 15),
(13, 15),
(7, 16),
(1, 17),
(2, 17),
(3, 17),
(4, 17),
(5, 17),
(8, 17),
(9, 17),
(10, 17),
(11, 17),
(12, 17),
(13, 17),
(6, 18),
(7, 19),
(1, 20),
(4, 20),
(2, 21),
(7, 21),
(3, 22),
(5, 22),
(6, 22),
(8, 22),
(9, 22),
(10, 22),
(11, 22),
(12, 22),
(13, 22),
(1, 23),
(2, 24),
(4, 24),
(5, 24),
(6, 24),
(7, 24),
(8, 24),
(13, 24),
(3, 25),
(9, 26),
(10, 27),
(11, 28),
(12, 28),
(1, 29),
(2, 29),
(3, 29),
(4, 29),
(5, 29),
(6, 29),
(7, 29),
(8, 29),
(10, 29),
(9, 30),
(11, 30),
(12, 30),
(13, 30);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `expression`
--
ALTER TABLE `expression`
  ADD CONSTRAINT `fk_numGroup_Groupe_idGroup` FOREIGN KEY (`num_Groupe`) REFERENCES `groupe` (`id_Groupe`);

--
-- Contraintes pour la table `region_expression`
--
ALTER TABLE `region_expression`
  ADD CONSTRAINT `FK_numExpression_Expression_idExpression` FOREIGN KEY (`num_Expression`) REFERENCES `expression` (`id_Expression`),
  ADD CONSTRAINT `FK_numRegion_Region_idREgion` FOREIGN KEY (`num_Region`) REFERENCES `region` (`id_Region`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
