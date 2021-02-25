-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 25 fév. 2021 à 19:17
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `expression`
--

DROP TABLE IF EXISTS `expression`;
CREATE TABLE IF NOT EXISTS `expression` (
  `id_Expression` int(11) NOT NULL AUTO_INCREMENT,
  `mots` varchar(255) COLLATE latin1_bin NOT NULL,
  `num_Groupe` int(11) NOT NULL,
  PRIMARY KEY (`id_Expression`),
  KEY `fk_numGroup_Groupe_idGroup` (`num_Groupe`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Déchargement des données de la table `expression`
--

INSERT INTO `expression` (`id_Expression`, `mots`, `num_Groupe`) VALUES
(1, 'Serpillère', 1),
(2, 'toiles3', 1),
(3, 'Wassingue', 1),
(4, 'Petit pain au chocolat', 2),
(5, 'Pain au chocolat', 2),
(6, 'Pain au chocolat', 2),
(7, 'Pain au chocolat', 2),
(8, 'Pain au chocolat', 2),
(9, 'Pain au chocolat', 2),
(10, 'Pain au chocolat', 2),
(11, 'Pain au chocolat', 2),
(12, 'Chocolatine', 2),
(13, 'Pain au chocolat', 2),
(14, 'Chocolatine', 2),
(15, 'Pain au chocolat', 2),
(16, 'Pain au chocolat', 2);

-- --------------------------------------------------------

--
-- Structure de la table `groupe`
--

DROP TABLE IF EXISTS `groupe`;
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

DROP TABLE IF EXISTS `region`;
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

DROP TABLE IF EXISTS `region_expression`;
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
(1, 2);

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
