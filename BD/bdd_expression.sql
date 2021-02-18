-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 11 fév. 2021 à 20:57
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `ajoutExpression` (`p_mot` VARCHAR(255), `p_numGroupe` INT, `p_numRegion` INT)  INSERT INTO expression (mots, num_Groupe, num_Region) 
    VALUES (p_mot, p_numGroupe, p_numRegion)$$

DROP PROCEDURE IF EXISTS `listeExpressionGroupeRegion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `listeExpressionGroupeRegion` (`p_numGroupe` INT, `p_numRegion` INT)  SELECT id_Expression, mots, num_Groupe, num_Region 
    FROM expression 
    WHERE num_Groupe = p_numRegion && num_Region = p_numRegion$$

DROP PROCEDURE IF EXISTS `selectExpressionParGroup`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectExpressionParGroup` (`p_numGroupe` INT)  SELECT id_Expression, mots, num_Groupe, num_Region 
    FROM expression 
    WHERE num_Groupe = p_numGroupe$$

DROP PROCEDURE IF EXISTS `selectExpressionParGroupEtRegion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectExpressionParGroupEtRegion` (`p_numGroupe` INT, `p_numRegion` INT)  SELECT id_Expression, mots, num_Groupe, num_Region 
    FROM expression 
    WHERE num_Groupe = p_numGroupe && num_Region = p_numRegion$$

DROP PROCEDURE IF EXISTS `selectExpressionParId`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectExpressionParId` (`p_id` INT)  SELECT id_Expression, mots, num_Groupe, num_Region 
    FROM expression 
    WHERE id_Expression = p_id$$

DROP PROCEDURE IF EXISTS `selectGroupe`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectGroupe` ()  SELECT *
    FROM groupe 
    ORDER BY mots_Ref$$

DROP PROCEDURE IF EXISTS `selectGroupeExpression`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectGroupeExpression` ()  SELECT * 
    FROM expression 
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

DROP TABLE IF EXISTS `expression`;
CREATE TABLE IF NOT EXISTS `expression` (
  `id_Expression` int(11) NOT NULL AUTO_INCREMENT,
  `mots` varchar(255) COLLATE latin1_bin NOT NULL,
  `num_Groupe` int(11) NOT NULL,
  `num_Region` int(11) NOT NULL,
  PRIMARY KEY (`id_Expression`),
  KEY `fk_numRegion_Region_idRegion` (`num_Region`),
  KEY `fk_numGroup_Groupe_idGroup` (`num_Groupe`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Déchargement des données de la table `expression`
--

INSERT INTO `expression` (`id_Expression`, `mots`, `num_Groupe`, `num_Region`) VALUES
(1, 'Serpillère', 1, 1),
(2, 'Toile', 1, 2),
(3, 'Wassingue', 1, 3),
(4, 'Petit pain au chocolat', 2, 1),
(5, 'Pain au chocolat', 2, 2),
(6, 'Pain au chocolat', 2, 3),
(7, 'Pain au chocolat', 2, 4),
(8, 'Pain au chocolat', 2, 5),
(9, 'Pain au chocolat', 2, 6),
(10, 'Pain au chocolat', 2, 7),
(11, 'Pain au chocolat', 2, 8),
(12, 'Chocolatine', 2, 9),
(13, 'Pain au chocolat', 2, 10),
(14, 'Chocolatine', 2, 11),
(15, 'Pain au chocolat', 2, 12),
(16, 'Pain au chocolat', 2, 13);

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

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `expression`
--
ALTER TABLE `expression`
  ADD CONSTRAINT `expression_ibfk_1` FOREIGN KEY (`num_Groupe`) REFERENCES `groupe` (`id_Groupe`),
  ADD CONSTRAINT `fk_numRegion_Region_idRegion` FOREIGN KEY (`num_Region`) REFERENCES `region` (`id_Region`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
